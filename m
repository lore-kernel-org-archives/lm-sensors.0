From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 12:16:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: (fschmd) Drop useless mutex
Message-Id: <20101129131657.10d2a81c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As discussed one year ago, the WDIOC_GETSUPPORT ioctl only needs a
mutex because it operates on a static variable. There is no good
reason to keep this variable static, so let's just make it non-static
and drop the now useless mutex altogether.

See the discussion at:
http://marc.info/?l=lm-sensors&m5563869402323&w=2

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/fschmd.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.37-rc3.orig/drivers/hwmon/fschmd.c	2010-11-02 09:19:35.000000000 +0100
+++ linux-2.6.37-rc3/drivers/hwmon/fschmd.c	2010-11-29 13:02:16.000000000 +0100
@@ -49,7 +49,6 @@
 #include <linux/kref.h>
 
 /* Addresses to scan */
-static DEFINE_MUTEX(watchdog_mutex);
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 
 /* Insmod parameters */
@@ -850,7 +849,7 @@ static ssize_t watchdog_write(struct fil
 
 static long watchdog_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	static struct watchdog_info ident = {
+	struct watchdog_info ident = {
 		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
 				WDIOF_CARDRESET,
 		.identity = "FSC watchdog"
@@ -858,7 +857,6 @@ static long watchdog_ioctl(struct file *
 	int i, ret = 0;
 	struct fschmd_data *data = filp->private_data;
 
-	mutex_lock(&watchdog_mutex);
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
 		ident.firmware_version = data->revision;
@@ -915,7 +913,6 @@ static long watchdog_ioctl(struct file *
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
