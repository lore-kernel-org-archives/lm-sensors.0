From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 15 Mar 2012 11:59:17 +0000
Subject: [lm-sensors] [PATCH 3/3] watchdog_dev: Let the driver update the timeout field on set_timeout succes
Message-Id: <1331812757-3491-4-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, Hans de Goede <hdegoede@redhat.com>

When a set_timeout operation succeeds this does not necessarily mean that
the exact timeout requested has been achieved, because the watchdog does not
necessarily have a 1 second resolution. So rather then have the core set
the timeout member of the watchdog_device struct to the exact requested
value, instead the driver should set it to the actually achieved timeout value.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/watchdog/watchdog-kernel-api.txt |    7 ++++---
 drivers/staging/mei/wd.c                       |    1 +
 drivers/watchdog/s3c2410_wdt.c                 |    2 ++
 drivers/watchdog/via_wdt.c                     |    1 +
 drivers/watchdog/watchdog_dev.c                |    2 --
 drivers/watchdog/wm831x_wdt.c                  |    1 +
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index b43c40c..e7a7de1 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -136,9 +136,10 @@ they are supported. These optional routines/operations are:
   status of the device is reported with watchdog WDIOF_* status flags/bits.
 * set_timeout: this routine checks and changes the timeout of the watchdog
   timer device. It returns 0 on success, -EINVAL for "parameter out of range"
-  and -EIO for "could not write value to the watchdog". On success the timeout
-  value of the watchdog_device will be changed to the value that was just used
-  to re-program the watchdog timer device.
+  and -EIO for "could not write value to the watchdog". On success this
+  routine should set the timeout value of the watchdog_device to the
+  achieved timeout value (which may be different from the requested one
+  because the watchdog does not necessarily has a 1 second resolution).
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
 * ioctl: if this routine is present then it will be called first before we do
diff --git a/drivers/staging/mei/wd.c b/drivers/staging/mei/wd.c
index 8094941..9503c32 100644
--- a/drivers/staging/mei/wd.c
+++ b/drivers/staging/mei/wd.c
@@ -326,6 +326,7 @@ static int mei_wd_ops_set_timeout(struct watchdog_device *wd_dev, unsigned int t
 
 	dev->wd_timeout = timeout;
 	mei_wd_set_start_timeout(dev, dev->wd_timeout);
+	wd_dev->timeout = dev->wd_timeout;
 
 	mutex_unlock(&dev->device_lock);
 
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 404172f..6ea79b0 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -200,6 +200,8 @@ static int s3c2410wdt_set_heartbeat(struct watchdog_device *wdd, unsigned timeou
 	writel(count, wdt_base + S3C2410_WTDAT);
 	writel(wtcon, wdt_base + S3C2410_WTCON);
 
+	wdd->timeout = (count * divisor) / freq;
+
 	return 0;
 }
 
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 8f07dd4..47afe5b 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -126,6 +126,7 @@ static int wdt_set_timeout(struct watchdog_device *wdd,
 {
 	writel(new_timeout, wdt_mem + VIA_WDT_COUNT);
 	timeout = new_timeout;
+	wdd->timeout = timeout;
 	return 0;
 }
 
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 15dc3df..c8a594e 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -265,8 +265,6 @@ static int watchdog_set_timeout(struct watchdog_device *wddev,
 	}
 
 	ret = wddev->ops->set_timeout(wddev, timeout);
-	if (ret = 0)
-		wddev->timeout = timeout;
 leave:
 	mutex_unlock(&wddev->lock);
 	return ret;
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 263c883..8664ff1 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -157,6 +157,7 @@ static int wm831x_wdt_set_timeout(struct watchdog_device *wdt_dev,
 		ret = wm831x_set_bits(wm831x, WM831X_WATCHDOG,
 				      WM831X_WDOG_TO_MASK,
 				      wm831x_wdt_cfgs[i].val);
+		wdt_dev->timeout = timeout;
 		wm831x_reg_lock(wm831x);
 	} else {
 		dev_err(wm831x->dev, "Failed to unlock security key: %d\n",
-- 
1.7.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
