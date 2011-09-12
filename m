From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Sep 2011 09:56:58 +0000
Subject: [lm-sensors] [PATCH 3/5] watchdog_dev: Add support for dynamically
Message-Id: <1315821420-16205-4-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Hans de Goede <hdegoede@redhat.com>

If a driver's watchdog_device struct is part of a dynamically allocated
struct (which it often will be), merely locking the module is not enough,
even with a drivers module locked, the driver can be unbound from the device,
examples:
1) The root user can unbind it through sysfd
2) The i2c bus master driver being unloaded for an i2c watchdog

I will gladly admit that these are corner cases, but we still need to handle
them correctly.

The fix for this consists of 2 parts:
1) Add ref / unref operations, so that the driver can refcount the struct
   holding the watchdog_device struct and delay freeing it until any
   open filehandles referring to it are closed
2) Most driver operations will do IO on the device and the driver should not
   do any IO on the device after it has been unbound. Rather then letting each
   driver deal with this internally, it is better to ensure at the watchdog
   core level that no operations (other then unref) will get called after
   the driver has called watchdog_unregister_device(). This actually is the
   bulk of this patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |   26 +++-
 drivers/watchdog/watchdog_dev.c                |  186 +++++++++++++++++++-----
 include/linux/watchdog.h                       |    8 +
 3 files changed, 185 insertions(+), 35 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 4f7c894..1d3f020 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -1,6 +1,6 @@
 The Linux WatchDog Timer Driver Core kernel API.
 =======================-Last reviewed: 22-Jul-2011
+Last reviewed: 10-Sep-2011
 
 Wim Van Sebroeck <wim@iguana.be>
 
@@ -41,6 +41,7 @@ The watchdog device structure looks like this:
 struct watchdog_device {
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
+	struct mutex lock;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
@@ -53,6 +54,7 @@ It contains following fields:
 * info: a pointer to a watchdog_info structure. This structure gives some
   additional information about the watchdog timer itself. (Like it's unique name)
 * ops: a pointer to the list of watchdog operations that the watchdog supports.
+* lock: Mutex for WatchDog Timer Driver Core internal use only.
 * timeout: the watchdog timer's timeout value (in seconds).
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
 * max_timeout: the watchdog timer's maximum timeout value (in seconds).
@@ -74,6 +76,8 @@ struct watchdog_ops {
 	int (*start)(struct watchdog_device *);
 	int (*stop)(struct watchdog_device *);
 	/* optional operations */
+	void (*ref)(struct watchdog_device *);
+	void (*unref)(struct watchdog_device *);
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
@@ -84,6 +88,21 @@ It is important that you first define the module owner of the watchdog timer
 driver's operations. This module owner will be used to lock the module when
 the watchdog is active. (This to avoid a system crash when you unload the
 module and /dev/watchdog is still open).
+
+If the watchdog_device struct is dynamically allocated, just locking the module
+is not enough and a driver also needs to define the ref and unref operations to
+ensure the structure holding the watchdog_device does not go away.
+
+The simplest (and usually sufficient) implementation of this is to:
+1) Add a kref struct to the same structure which is holding the watchdog_device
+2) Define a release callback for the kref which frees the struct holding both
+3) Call kref_init on this kref *before* calling watchdog_register_device()
+4) Define a ref operation calling kref_get on this kref
+5) Define a unref operation calling kref_put on this kref
+6) When it is time to cleanup:
+ * Do not kfree() the struct holding both, the last kref_put will do this!
+ * *After* calling watchdog_unregister_device() call kref_put on the kref
+
 Some operations are mandatory and some are optional. The mandatory operations
 are:
 * start: this is a pointer to the routine that starts the watchdog timer
@@ -141,6 +160,11 @@ bit-operations. The status bits that are defined are:
   (This bit should only be used by the WatchDog Timer Driver Core).
 * WDOG_NO_WAY_OUT: this bit stores the nowayout setting for the watchdog.
   If this bit is set then the watchdog timer will not be able to stop.
+* WDOG_UNREGISTERED: this bit gets set by the WatchDog Timer Driver Core
+  after calling watchdog_unregister_device, and then checked before calling
+  any watchdog_ops, so that you can be sure that no operations (other then
+  unref) will get called after unregister, even if userspace still holds a
+  reference to /dev/watchdog
 
 Note: The WatchDog Timer Driver Core supports the magic close feature and
 the nowayout feature. To use the magic close feature you must set the
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6483327..15dc3df 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -98,13 +98,24 @@ static struct miscdevice watchdog_miscdev[MAX_WATCHDOGS] = { {
 
 static int watchdog_ping(struct watchdog_device *wddev)
 {
-	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
-		if (wddev->ops->ping)
-			return wddev->ops->ping(wddev);  /* ping the watchdog */
-		else
-			return wddev->ops->start(wddev); /* restart watchdog */
+	int ret;
+
+	if (!test_bit(WDOG_ACTIVE, &wddev->status))
+		return 0;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		ret = -ENODEV;
+		goto leave;
 	}
-	return 0;
+
+	if (wddev->ops->ping)
+		ret = wddev->ops->ping(wddev);  /* ping the watchdog */
+	else
+		ret = wddev->ops->start(wddev); /* restart watchdog */
+leave:
+	mutex_unlock(&wddev->lock);
+	return ret;
 }
 
 /*
@@ -118,16 +129,23 @@ static int watchdog_ping(struct watchdog_device *wddev)
 
 static int watchdog_start(struct watchdog_device *wddev)
 {
-	int err;
+	int ret;
 
-	if (!test_bit(WDOG_ACTIVE, &wddev->status)) {
-		err = wddev->ops->start(wddev);
-		if (err < 0)
-			return err;
+	if (test_bit(WDOG_ACTIVE, &wddev->status))
+		return 0;
 
-		set_bit(WDOG_ACTIVE, &wddev->status);
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		ret = -ENODEV;
+		goto leave;
 	}
-	return 0;
+
+	ret = wddev->ops->start(wddev);
+	if (ret = 0)
+		set_bit(WDOG_ACTIVE, &wddev->status);
+leave:
+	mutex_unlock(&wddev->lock);
+	return ret;
 }
 
 /*
@@ -142,22 +160,116 @@ static int watchdog_start(struct watchdog_device *wddev)
 
 static int watchdog_stop(struct watchdog_device *wddev)
 {
-	int err = -EBUSY;
+	int ret;
+
+	if (!test_bit(WDOG_ACTIVE, &wddev->status))
+		return 0;
 
 	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
 		pr_info("%s: nowayout prevents watchdog to be stopped!\n",
 							wddev->info->identity);
-		return err;
+		return -EBUSY;
 	}
 
-	if (test_bit(WDOG_ACTIVE, &wddev->status)) {
-		err = wddev->ops->stop(wddev);
-		if (err < 0)
-			return err;
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		ret = -ENODEV;
+		goto leave;
+	}
 
+	ret = wddev->ops->stop(wddev);
+	if (ret = 0)
 		clear_bit(WDOG_ACTIVE, &wddev->status);
+leave:
+	mutex_unlock(&wddev->lock);
+	return ret;
+}
+
+/*
+ *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
+ *	@wddev: the watchdog device to do the ioctl on
+ *	@cmd: watchdog command
+ *	@arg: argument pointer
+ */
+
+static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
+					unsigned long arg)
+{
+	int ret;
+
+	if (!wddev->ops->ioctl)
+		return -ENOIOCTLCMD;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		ret = -ENODEV;
+		goto leave;
 	}
-	return 0;
+
+	ret = wddev->ops->ioctl(wddev, cmd, arg);
+leave:
+	mutex_unlock(&wddev->lock);
+	return ret;
+}
+
+/*
+ *	watchdog_get_status: get the watchdog status
+ *	@wddev: the watchdog device to get the status from
+ */
+
+static int watchdog_get_status(struct watchdog_device *wddev,
+					unsigned int *status)
+{
+	int ret = 0;
+
+	*status = 0;
+	if (!wddev->ops->status)
+		return 0;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	*status = wddev->ops->status(wddev);
+leave:
+	mutex_unlock(&wddev->lock);
+	return ret;
+}
+
+/*
+ *	watchdog_set_timeout: set the watchdog timer timeout
+ *	@wddev: the watchdog device to set the timeout for
+ *	@timeout: timeout to set in seconds
+ *	@arg: argument pointer
+ */
+
+static int watchdog_set_timeout(struct watchdog_device *wddev,
+					unsigned int timeout)
+{
+	int ret;
+
+	if ((wddev->ops->set_timeout = NULL) ||
+	    !(wddev->info->options & WDIOF_SETTIMEOUT))
+		return -EOPNOTSUPP;
+
+	if ((wddev->max_timeout != 0) &&
+	    (timeout < wddev->min_timeout || timeout > wddev->max_timeout))
+		return -EINVAL;
+
+	mutex_lock(&wddev->lock);
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		ret = -ENODEV;
+		goto leave;
+	}
+
+	ret = wddev->ops->set_timeout(wddev, timeout);
+	if (ret = 0)
+		wddev->timeout = timeout;
+leave:
+	mutex_unlock(&wddev->lock);
+	return ret;
 }
 
 /*
@@ -221,18 +333,18 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 	unsigned int val;
 	int err;
 
-	if (wdd->ops->ioctl) {
-		err = wdd->ops->ioctl(wdd, cmd, arg);
-		if (err != -ENOIOCTLCMD)
-			return err;
-	}
+	err = watchdog_ioctl_op(wdd, cmd, arg);
+	if (err != -ENOIOCTLCMD)
+		return err;
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		return copy_to_user(argp, wdd->info,
 			sizeof(struct watchdog_info)) ? -EFAULT : 0;
 	case WDIOC_GETSTATUS:
-		val = wdd->ops->status ? wdd->ops->status(wdd) : 0;
+		err = watchdog_get_status(wdd, &val);
+		if (err)
+			return err;
 		return put_user(val, p);
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(wdd->bootstatus, p);
@@ -256,18 +368,11 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		watchdog_ping(wdd);
 		return 0;
 	case WDIOC_SETTIMEOUT:
-		if ((wdd->ops->set_timeout = NULL) ||
-		    !(wdd->info->options & WDIOF_SETTIMEOUT))
-			return -EOPNOTSUPP;
 		if (get_user(val, p))
 			return -EFAULT;
-		if ((wdd->max_timeout != 0) &&
-		    (val < wdd->min_timeout || val > wdd->max_timeout))
-				return -EINVAL;
-		err = wdd->ops->set_timeout(wdd, val);
+		err = watchdog_set_timeout(wdd, val);
 		if (err < 0)
 			return err;
-		wdd->timeout = val;
 		/* If the watchdog is active then we send a keepalive ping
 		 * to make sure that the watchdog keep's running (and if
 		 * possible that it takes the new timeout) */
@@ -321,6 +426,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 		goto out_mod;
 
 	file->private_data = wdd;
+	if (wdd->ops->ref)
+		wdd->ops->ref(wdd);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
@@ -368,6 +475,10 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(WDOG_DEV_OPEN, &wdd->status);
 
+	/* Note wdd may be gone after this, do not use after this! */
+	if (wdd->ops->unref)
+		wdd->ops->unref(wdd);
+
 	return 0;
 }
 
@@ -383,6 +494,8 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 {
 	int idx, err;
 
+	mutex_init(&watchdog->lock);
+
 	/*
 	 * Note ideally we would just walk our wdd_list here and stop at the
 	 * first place which holds a NULL, but that assumes all watchdog
@@ -446,5 +559,10 @@ int watchdog_dev_unregister(struct watchdog_device *watchdog)
 
 	misc_deregister(&watchdog_miscdev[idx]);
 	wdd_list[idx] = NULL;
+
+	mutex_lock(&watchdog->lock);
+	set_bit(WDOG_UNREGISTERED, &watchdog->status);
+	mutex_unlock(&watchdog->lock);
+
 	return 0;
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 111843f..17a55ba 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -83,6 +83,8 @@ struct watchdog_ops {
 	int (*start)(struct watchdog_device *);
 	int (*stop)(struct watchdog_device *);
 	/* optional operations */
+	void (*ref)(struct watchdog_device *);
+	void (*unref)(struct watchdog_device *);
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
@@ -93,6 +95,7 @@ struct watchdog_ops {
  *
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
+ * @lock:       Lock for watchdog core internal use only.
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value.
  * @min_timeout:The watchdog devices minimum timeout value.
@@ -105,10 +108,14 @@ struct watchdog_ops {
  *
  * The driver-data field may not be accessed directly. It must be accessed
  * via the watchdog_set_drvdata and watchdog_get_drvdata helpers.
+ *
+ * The lock field is for watchdog core internal use only and should not be
+ * touched.
  */
 struct watchdog_device {
 	const struct watchdog_info *info;
 	const struct watchdog_ops *ops;
+	struct mutex lock;
 	unsigned int bootstatus;
 	unsigned int timeout;
 	unsigned int min_timeout;
@@ -120,6 +127,7 @@ struct watchdog_device {
 #define WDOG_DEV_OPEN		1	/* Opened via /dev/watchdog ? */
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
+#define WDOG_UNREGISTERED	4	/* The device has been unregistered */
 };
 
 /* Use the following functions to manipulate watchdog driver specific data */
-- 
1.7.6.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
