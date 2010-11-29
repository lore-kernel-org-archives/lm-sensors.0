From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 13:16:59 +0000
Subject: [lm-sensors] hwmon: (w83793) Drop useless mutex
Message-Id: <20101129141659.3429d849@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is the same case as fschmd, from which the code was copied as far
as I can see. So the same clean-up applies:

The WDIOC_GETSUPPORT ioctl only needs a mutex because it operates on a
static variable. There is no good reason to keep this variable static,
so let's just make it non-static and drop the now useless mutex
altogether.

See the discussion at:
http://marc.info/?l=lm-sensors&m5563869402323&w=2

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/w83793.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.37-rc3.orig/drivers/hwmon/w83793.c	2010-11-29 14:00:25.000000000 +0100
+++ linux-2.6.37-rc3/drivers/hwmon/w83793.c	2010-11-29 14:03:01.000000000 +0100
@@ -51,7 +51,6 @@
 #define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
 
 /* Addresses to scan */
-static DEFINE_MUTEX(watchdog_mutex);
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 						I2C_CLIENT_END };
 
@@ -1350,7 +1349,7 @@ static ssize_t watchdog_write(struct fil
 static long watchdog_ioctl(struct file *filp, unsigned int cmd,
 			   unsigned long arg)
 {
-	static struct watchdog_info ident = {
+	struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING |
 			   WDIOF_SETTIMEOUT |
 			   WDIOF_CARDRESET,
@@ -1360,7 +1359,6 @@ static long watchdog_ioctl(struct file *
 	int val, ret = 0;
 	struct w83793_data *data = filp->private_data;
 
-	mutex_lock(&watchdog_mutex);
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		if (!nowayout)
@@ -1414,7 +1412,6 @@ static long watchdog_ioctl(struct file *
 	default:
 		ret = -ENOTTY;
 	}
-	mutex_unlock(&watchdog_mutex);
 	return ret;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
