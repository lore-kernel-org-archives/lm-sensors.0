From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Sep 2009 13:16:27 +0000
Subject: [lm-sensors] [PATCH] ltc4215/ltc4245: Discard obsolete detect
Message-Id: <20090920151627.76dd424e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

There is no point in implementing a detect callback for the LTC4215
and LTC4245, as these devices can't be detected. It was there solely
to handle "force" module parameters to instantiate devices, but now
we have a better sysfs interface that can do the same.

So we can get rid of the ugly module parameters and the detect
callbacks. This shrinks the binary module sizes by 36% and 46%,
respectively.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Ira W. Snyder <iws@ovro.caltech.edu>
---
Ira, can you please test and confirm it works OK for you?

 Documentation/hwmon/ltc4215 |    7 +-
 Documentation/hwmon/ltc4245 |    7 +-
 drivers/hwmon/ltc4215.c     |   47 +--------------
 drivers/hwmon/ltc4245.c     |  131 +------------------------------------------
 4 files changed, 18 insertions(+), 174 deletions(-)

--- linux-2.6.32-pre.orig/Documentation/hwmon/ltc4215	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-pre/Documentation/hwmon/ltc4215	2009-09-20 13:57:37.000000000 +0200
@@ -22,12 +22,13 @@ Usage Notes
 -----------
 
 This driver does not probe for LTC4215 devices, due to the fact that some
-of the possible addresses are unfriendly to probing. You will need to use
-the "force" parameter to tell the driver where to find the device.
+of the possible addresses are unfriendly to probing. You will have to
+instantiate the devices explicitly.
 
 Example: the following will load the driver for an LTC4215 at address 0x44
 on I2C bus #0:
-$ modprobe ltc4215 force=0,0x44
+$ modprobe ltc4215
+$ echo ltc4215 0x44 > /sys/bus/i2c/devices/i2c-0/new_device
 
 
 Sysfs entries
--- linux-2.6.32-pre.orig/Documentation/hwmon/ltc4245	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.32-pre/Documentation/hwmon/ltc4245	2009-09-20 14:06:24.000000000 +0200
@@ -23,12 +23,13 @@ Usage Notes
 -----------
 
 This driver does not probe for LTC4245 devices, due to the fact that some
-of the possible addresses are unfriendly to probing. You will need to use
-the "force" parameter to tell the driver where to find the device.
+of the possible addresses are unfriendly to probing. You will have to
+instantiate the devices explicitly.
 
 Example: the following will load the driver for an LTC4245 at address 0x23
 on I2C bus #1:
-$ modprobe ltc4245 force=1,0x23
+$ modprobe ltc4245
+$ echo ltc4245 0x23 > /sys/bus/i2c/devices/i2c-1/new_device
 
 
 Sysfs entries
--- linux-2.6.32-pre.orig/drivers/hwmon/ltc4215.c	2009-09-20 10:52:20.000000000 +0200
+++ linux-2.6.32-pre/drivers/hwmon/ltc4215.c	2009-09-20 14:01:55.000000000 +0200
@@ -20,11 +20,6 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(ltc4215);
-
 /* Here are names of the chip's registers (a.k.a. commands) */
 enum ltc4215_cmd {
 	LTC4215_CONTROL			= 0x00, /* rw */
@@ -246,9 +241,13 @@ static const struct attribute_group ltc4
 static int ltc4215_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct i2c_adapter *adapter = client->adapter;
 	struct ltc4215_data *data;
 	int ret;
 
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
@@ -294,56 +293,20 @@ static int ltc4215_remove(struct i2c_cli
 	return 0;
 }
 
-static int ltc4215_detect(struct i2c_client *client,
-			  int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
-
-	if (kind < 0) {		/* probed detection - check the chip type */
-		s32 v;		/* 8 bits from the chip, or -ERRNO */
-
-		/*
-		 * Register 0x01 bit b7 is reserved, expect 0
-		 * Register 0x03 bit b6 and b7 are reserved, expect 0
-		 */
-		v = i2c_smbus_read_byte_data(client, LTC4215_ALERT);
-		if (v < 0 || (v & (1 << 7)) != 0)
-			return -ENODEV;
-
-		v = i2c_smbus_read_byte_data(client, LTC4215_FAULT);
-		if (v < 0 || (v & ((1 << 6) | (1 << 7))) != 0)
-				return -ENODEV;
-	}
-
-	strlcpy(info->type, "ltc4215", I2C_NAME_SIZE);
-	dev_info(&adapter->dev, "ltc4215 %s at address 0x%02x\n",
-			kind < 0 ? "probed" : "forced",
-			client->addr);
-
-	return 0;
-}
-
 static const struct i2c_device_id ltc4215_id[] = {
-	{ "ltc4215", ltc4215 },
+	{ "ltc4215", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc4215_id);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver ltc4215_driver = {
-	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "ltc4215",
 	},
 	.probe		= ltc4215_probe,
 	.remove		= ltc4215_remove,
 	.id_table	= ltc4215_id,
-	.detect		= ltc4215_detect,
-	.address_data	= &addr_data,
 };
 
 static int __init ltc4215_init(void)
--- linux-2.6.32-pre.orig/drivers/hwmon/ltc4245.c	2009-09-20 10:52:20.000000000 +0200
+++ linux-2.6.32-pre/drivers/hwmon/ltc4245.c	2009-09-20 14:03:52.000000000 +0200
@@ -22,15 +22,6 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 
-/* Valid addresses are 0x20 - 0x3f
- *
- * For now, we do not probe, since some of these addresses
- * are known to be unfriendly to probing */
-static const unsigned short normal_i2c[] = { I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(ltc4245);
-
 /* Here are names of the chip's registers (a.k.a. commands) */
 enum ltc4245_cmd {
 	LTC4245_STATUS			= 0x00, /* readonly */
@@ -369,9 +360,13 @@ static const struct attribute_group ltc4
 static int ltc4245_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	struct i2c_adapter *adapter = client->adapter;
 	struct ltc4245_data *data;
 	int ret;
 
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;
+
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
@@ -417,136 +412,20 @@ static int ltc4245_remove(struct i2c_cli
 	return 0;
 }
 
-/* Check that some bits in a control register appear at all possible
- * locations without changing value
- *
- * @client: the i2c client to use
- * @reg: the register to read
- * @bits: the bits to check (0xff checks all bits,
- *                           0x03 checks only the last two bits)
- *
- * return -ERRNO if the register read failed
- * return -ENODEV if the register value doesn't stay constant at all
- * possible addresses
- *
- * return 0 for success
- */
-static int ltc4245_check_control_reg(struct i2c_client *client, u8 reg, u8 bits)
-{
-	int i;
-	s32 v, voff1, voff2;
-
-	/* Read register and check for error */
-	v = i2c_smbus_read_byte_data(client, reg);
-	if (v < 0)
-		return v;
-
-	v &= bits;
-
-	for (i = 0x00; i < 0xff; i += 0x20) {
-
-		voff1 = i2c_smbus_read_byte_data(client, reg + i);
-		if (voff1 < 0)
-			return voff1;
-
-		voff2 = i2c_smbus_read_byte_data(client, reg + i + 0x08);
-		if (voff2 < 0)
-			return voff2;
-
-		voff1 &= bits;
-		voff2 &= bits;
-
-		if (v != voff1 || v != voff2)
-			return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int ltc4245_detect(struct i2c_client *client,
-			  int kind,
-			  struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
-
-	if (kind < 0) {		/* probed detection - check the chip type */
-		s32 v;		/* 8 bits from the chip, or -ERRNO */
-
-		/* Chip registers 0x00-0x07 are control registers
-		 * Chip registers 0x10-0x1f are data registers
-		 *
-		 * Address bits b7-b5 are ignored. This makes the chip "repeat"
-		 * in steps of 0x20. Any control registers should appear with
-		 * the same values across all duplicated addresses.
-		 *
-		 * Register 0x02 bit b2 is reserved, expect 0
-		 * Register 0x07 bits b7 to b4 are reserved, expect 0
-		 *
-		 * Registers 0x01, 0x02 are control registers and should not
-		 * change on their own.
-		 *
-		 * Register 0x06 bits b6 and b7 are control bits, and should
-		 * not change on their own.
-		 *
-		 * Register 0x07 bits b3 to b0 are control bits, and should
-		 * not change on their own.
-		 */
-
-		/* read register 0x02 reserved bit, expect 0 */
-		v = i2c_smbus_read_byte_data(client, LTC4245_CONTROL);
-		if (v < 0 || (v & 0x04) != 0)
-			return -ENODEV;
-
-		/* read register 0x07 reserved bits, expect 0 */
-		v = i2c_smbus_read_byte_data(client, LTC4245_ADCADR);
-		if (v < 0 || (v & 0xf0) != 0)
-			return -ENODEV;
-
-		/* check that the alert register appears at all locations */
-		if (ltc4245_check_control_reg(client, LTC4245_ALERT, 0xff))
-			return -ENODEV;
-
-		/* check that the control register appears at all locations */
-		if (ltc4245_check_control_reg(client, LTC4245_CONTROL, 0xff))
-			return -ENODEV;
-
-		/* check that register 0x06 bits b6 and b7 stay constant */
-		if (ltc4245_check_control_reg(client, LTC4245_GPIO, 0xc0))
-			return -ENODEV;
-
-		/* check that register 0x07 bits b3-b0 stay constant */
-		if (ltc4245_check_control_reg(client, LTC4245_ADCADR, 0x0f))
-			return -ENODEV;
-	}
-
-	strlcpy(info->type, "ltc4245", I2C_NAME_SIZE);
-	dev_info(&adapter->dev, "ltc4245 %s at address 0x%02x\n",
-			kind < 0 ? "probed" : "forced",
-			client->addr);
-
-	return 0;
-}
-
 static const struct i2c_device_id ltc4245_id[] = {
-	{ "ltc4245", ltc4245 },
+	{ "ltc4245", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc4245_id);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver ltc4245_driver = {
-	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "ltc4245",
 	},
 	.probe		= ltc4245_probe,
 	.remove		= ltc4245_remove,
 	.id_table	= ltc4245_id,
-	.detect		= ltc4245_detect,
-	.address_data	= &addr_data,
 };
 
 static int __init ltc4245_init(void)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
