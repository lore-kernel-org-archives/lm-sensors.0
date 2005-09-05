From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:28 +0000
Subject: [lm-sensors] [PATCH] hwmon: hwmon vs i2c, second round (11/11)
Message-Id: <11259567691080@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: hwmon vs i2c, second round (11/11)

Use the common vid_from_reg function in lm78 rather than
reimplementing it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 19f673eddb5a406be72989fb57b7f286772b8cf4
tree d552112cd0721467e6ff0a13f8eef7c3491c847c
parent d0f282706df877f8fd8869419e308d24eedb523b
author Jean Delvare <khali@linux-fr.org> Sun, 31 Jul 2005 22:12:09 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:24 -0700

 drivers/hwmon/Kconfig |    1 +
 drivers/hwmon/lm78.c  |   10 ++--------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -207,6 +207,7 @@ config SENSORS_LM78
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
 	select I2C_ISA
+	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
 	  LM78-J and LM79.
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
@@ -106,13 +107,6 @@ static inline int TEMP_FROM_REG(s8 val)
 	return val * 1000;
 }
 
-/* VID: mV
-   REG: (see doc/vid) */
-static inline int VID_FROM_REG(u8 val)
-{
-	return val=0x1f ? 0 : val>=0x10 ? 5100-val*100 : 2050-val*50;
-}
-
 #define DIV_FROM_REG(val) (1 << (val))
 
 /* There are some complications in a module like this. First off, LM78 chips
@@ -457,7 +451,7 @@ static DEVICE_ATTR(fan3_div, S_IRUGO, sh
 static ssize_t show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
-	return sprintf(buf, "%d\n", VID_FROM_REG(data->vid));
+	return sprintf(buf, "%d\n", vid_from_reg(82, data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 

