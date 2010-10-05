From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Oct 2010 11:31:38 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (pcf8591) Don't attempt to detect
Message-Id: <20101005133138.489ed684@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The PCF8591 can't be detected, don't even try. There are plenty of
other means to instantiate i2c devices these days.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 Documentation/hwmon/pcf8591 |   18 ++++++++----------
 drivers/hwmon/pcf8591.c     |   26 --------------------------
 2 files changed, 8 insertions(+), 36 deletions(-)

--- linux-2.6.36-rc6.orig/Documentation/hwmon/pcf8591	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.36-rc6/Documentation/hwmon/pcf8591	2010-10-05 13:14:59.000000000 +0200
@@ -4,7 +4,7 @@ Kernel driver pcf8591
 Supported chips:
   * Philips/NXP PCF8591
     Prefix: 'pcf8591'
-    Addresses scanned: I2C 0x48 - 0x4f
+    Addresses scanned: none
     Datasheet: Publicly available at the NXP website
                http://www.nxp.com/pip/PCF8591_6.html
 
@@ -58,18 +58,16 @@ Module parameters
 Accessing PCF8591 via /sys interface
 -------------------------------------
 
-! Be careful !
-The PCF8591 is plainly impossible to detect! Stupid chip.
-So every chip with address in the interval [0x48..0x4f] is
-detected as PCF8591. If you have other chips in this address
-range, the workaround is to load this module after the one
-for your others chips.
+The PCF8591 is plainly impossible to detect! Thus the driver won't even
+try. You have to explicitly instantiate the device at the relevant
+address (in the interval [0x48..0x4f]) either through platform data, or
+using the sysfs interface. See Documentation/i2c/instantiating-devices
+for details.
 
-On detection (i.e. insmod, modprobe et al.), directories are being
-created for each detected PCF8591:
+Directories are being created for each instantiated PCF8591:
 
 /sys/bus/i2c/devices/<0>-<1>/
-where <0> is the bus the chip was detected on (e. g. i2c-0)
+where <0> is the bus the chip is connected to (e. g. i2c-0)
 and <1> the chip address ([48..4f])
 
 Inside these directories, there are such files:
--- linux-2.6.36-rc6.orig/drivers/hwmon/pcf8591.c	2010-10-05 13:03:39.000000000 +0200
+++ linux-2.6.36-rc6/drivers/hwmon/pcf8591.c	2010-10-05 13:16:43.000000000 +0200
@@ -25,10 +25,6 @@
 #include <linux/mutex.h>
 #include <linux/hwmon.h>
 
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
-					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-
 /* Insmod parameters */
 
 static int input_mode;
@@ -169,24 +165,6 @@ static const struct attribute_group pcf8
  * Real code
  */
 
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int pcf8591_detect(struct i2c_client *client,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
-				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
-		return -ENODEV;
-
-	/* Now, we would do the remaining detection. But the PCF8591 is plainly
-	   impossible to detect! Stupid chip. */
-
-	strlcpy(info->type, "pcf8591", I2C_NAME_SIZE);
-
-	return 0;
-}
-
 static int pcf8591_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -306,10 +284,6 @@ static struct i2c_driver pcf8591_driver
 	.probe		= pcf8591_probe,
 	.remove		= pcf8591_remove,
 	.id_table	= pcf8591_id,
-
-	.class		= I2C_CLASS_HWMON,	/* Nearest choice */
-	.detect		= pcf8591_detect,
-	.address_list	= normal_i2c,
 };
 
 static int __init pcf8591_init(void)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
