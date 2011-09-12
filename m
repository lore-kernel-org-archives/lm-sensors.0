From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Sep 2011 09:56:57 +0000
Subject: [lm-sensors] [PATCH 2/5] watchdog_dev: Add support for having more
Message-Id: <1315821420-16205-3-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Hans de Goede <hdegoede@redhat.com>

I know that having more then one watchdog is not really usefull, but some
systems ship with more then one watchdog, so why not make all of them
available to the user. Maybe he wants to use a certain one because it
has additional features / a better resolution ... ?

Also having this support in watchdog_dev makes developing watchdog drivers
for watchdog hardware which happens to often be found on systems with
multiple watchdogs a lot easier.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/watchdog/watchdog_dev.c |  137 +++++++++++++++++++++++++++------------
 1 files changed, 96 insertions(+), 41 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 1199da0..6483327 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -42,10 +42,49 @@
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 
-/* make sure we only register one /dev/watchdog device */
-static unsigned long watchdog_dev_busy;
-/* the watchdog device behind /dev/watchdog */
-static struct watchdog_device *wdd;
+#define MAX_WATCHDOGS 5
+
+static int watchdog_open(struct inode *inode, struct file *file);
+static int watchdog_release(struct inode *inode, struct file *file);
+static ssize_t watchdog_write(struct file *file, const char __user *data,
+						size_t len, loff_t *ppos);
+static long watchdog_ioctl(struct file *file, unsigned int cmd,
+						unsigned long arg);
+
+/* the watchdog devices behind /dev/watchdog* */
+static DEFINE_MUTEX(wdd_list_mutex);
+static struct watchdog_device *wdd_list[MAX_WATCHDOGS];
+
+static const struct file_operations watchdog_fops = {
+	.owner		= THIS_MODULE,
+	.write		= watchdog_write,
+	.unlocked_ioctl	= watchdog_ioctl,
+	.open		= watchdog_open,
+	.release	= watchdog_release,
+};
+
+static struct miscdevice watchdog_miscdev[MAX_WATCHDOGS] = { {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &watchdog_fops,
+}, {
+	.minor		= 212,
+	.name		= "watchdog1",
+	.fops		= &watchdog_fops,
+}, {
+	.minor		= 213,
+	.name		= "watchdog2",
+	.fops		= &watchdog_fops,
+}, {
+	.minor		= 214,
+	.name		= "watchdog3",
+	.fops		= &watchdog_fops,
+}, {
+	.minor		= 215,
+	.name		= "watchdog4",
+	.fops		= &watchdog_fops,
+} };
+
 
 /*
  *	watchdog_ping: ping the watchdog.
@@ -136,6 +175,7 @@ static int watchdog_stop(struct watchdog_device *wddev)
 static ssize_t watchdog_write(struct file *file, const char __user *data,
 						size_t len, loff_t *ppos)
 {
+	struct watchdog_device *wdd = file->private_data;
 	size_t i;
 	char c;
 
@@ -175,6 +215,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 static long watchdog_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
+	struct watchdog_device *wdd = file->private_data;
 	void __user *argp = (void __user *)arg;
 	int __user *p = argp;
 	unsigned int val;
@@ -254,7 +295,15 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 
 static int watchdog_open(struct inode *inode, struct file *file)
 {
-	int err = -EBUSY;
+	int idx, err = -EBUSY;
+	struct watchdog_device *wdd = NULL;
+
+	/* Find our watchdog_device */
+	for (idx = 0; idx < MAX_WATCHDOGS; idx++)
+		if (watchdog_miscdev[idx].minor = iminor(inode)) {
+			wdd = wdd_list[idx];
+			break;
+		}
 
 	/* the watchdog is single open! */
 	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
@@ -271,6 +320,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	if (err < 0)
 		goto out_mod;
 
+	file->private_data = wdd;
+
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
 	return nonseekable_open(inode, file);
 
@@ -293,6 +344,7 @@ out:
 
 static int watchdog_release(struct inode *inode, struct file *file)
 {
+	struct watchdog_device *wdd = file->private_data;
 	int err = -EBUSY;
 
 	/*
@@ -319,20 +371,6 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static const struct file_operations watchdog_fops = {
-	.owner		= THIS_MODULE,
-	.write		= watchdog_write,
-	.unlocked_ioctl	= watchdog_ioctl,
-	.open		= watchdog_open,
-	.release	= watchdog_release,
-};
-
-static struct miscdevice watchdog_miscdev = {
-	.minor		= WATCHDOG_MINOR,
-	.name		= "watchdog",
-	.fops		= &watchdog_fops,
-};
-
 /*
  *	watchdog_dev_register:
  *	@watchdog: watchdog device
@@ -343,28 +381,44 @@ static struct miscdevice watchdog_miscdev = {
 
 int watchdog_dev_register(struct watchdog_device *watchdog)
 {
-	int err;
+	int idx, err;
 
-	/* Only one device can register for /dev/watchdog */
-	if (test_and_set_bit(0, &watchdog_dev_busy)) {
-		pr_err("only one watchdog can use /dev/watchdog.\n");
-		return -EBUSY;
+	/*
+	 * Note ideally we would just walk our wdd_list here and stop at the
+	 * first place which holds a NULL, but that assumes all watchdog
+	 * drivers use the watchdog_core, which is not true, hence the retry.
+	 * Once all drivers are converted, the check for EBUSY and goto retry
+	 * can be eliminated (and the while converted to a standard for loop).
+	 */
+	idx = 0;
+retry:
+	mutex_lock(&wdd_list_mutex);
+	while (idx < MAX_WATCHDOGS) {
+		if (wdd_list[idx] = NULL) {
+			wdd_list[idx] = watchdog;
+			break;
+		}
+		idx++;
 	}
+	mutex_unlock(&wdd_list_mutex);
 
-	wdd = watchdog;
+	if (idx = MAX_WATCHDOGS) {
+		pr_err("maximum number of watchdogs exceeded.\n");
+		return -EBUSY;
+	}
 
-	err = misc_register(&watchdog_miscdev);
+	err = misc_register(&watchdog_miscdev[idx]);
 	if (err != 0) {
+		wdd_list[idx] = NULL;
+		if (err = -EBUSY) {
+			idx++; /* Try again with the next watchdog minor */
+			goto retry;
+		}
 		pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
-			watchdog->info->identity, WATCHDOG_MINOR, err);
-		goto out;
+			watchdog->info->identity, watchdog_miscdev[idx].minor,
+			err);
 	}
 
-	return 0;
-
-out:
-	wdd = NULL;
-	clear_bit(0, &watchdog_dev_busy);
 	return err;
 }
 
@@ -377,19 +431,20 @@ out:
 
 int watchdog_dev_unregister(struct watchdog_device *watchdog)
 {
-	/* Check that a watchdog device was registered in the past */
-	if (!test_bit(0, &watchdog_dev_busy) || !wdd)
-		return -ENODEV;
+	int idx;
+
+	/* No need to lock */
+	for (idx = 0; idx < MAX_WATCHDOGS; idx++)
+		if (wdd_list[idx] = watchdog)
+			break;
 
-	/* We can only unregister the watchdog device that was registered */
-	if (watchdog != wdd) {
+	if (idx = MAX_WATCHDOGS) {
 		pr_err("%s: watchdog was not registered as /dev/watchdog.\n",
 			watchdog->info->identity);
 		return -ENODEV;
 	}
 
-	misc_deregister(&watchdog_miscdev);
-	wdd = NULL;
-	clear_bit(0, &watchdog_dev_busy);
+	misc_deregister(&watchdog_miscdev[idx]);
+	wdd_list[idx] = NULL;
 	return 0;
 }
-- 
1.7.6.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
