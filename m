From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 28 Oct 2013 19:09:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: lm73: reset device during lm73_probe()
Message-Id: <1382987347-7824-1-git-send-email-kg4ysn@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM73 datasheet recommends resetting the sensor at power-up to avoid
certain VDD ramp-up problems.  The full sequence and rationale is
described in the LM73 datasheet, May 2009 revision, page 19, section
"Power Supply Ramp-Up Considerations."

This patch augments the lm73_probe() behavior to perform the described
reset sequence at device initialization time.  The sequence performed
is:

  1. Power down the LM73 using the "PD" bit in the CONF register.
  2. Wait at least 14 to 112 msec for the LM73 to process the request
     (depending on conversion resolution configured)
  3. Power up the LM73 using the reverse process.

The datasheet recommends running the reset sequence only after VDD has
been cut/restored to a LM73.  This patch assumes that VDD is provided to
the sensor at system boot and is not cut/restored during the runtime of
the system.  For embedded systems that may provide such control,
additional patching of the driver or module unloading/loading would be
required.

Signed-off-by: Chris Verges <kg4ysn@gmail.com>
---
 Documentation/hwmon/lm73 |    9 +++++++++
 drivers/hwmon/lm73.c     |   48 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
index 8af059d..a116fc8 100644
--- a/Documentation/hwmon/lm73
+++ b/Documentation/hwmon/lm73
@@ -18,6 +18,15 @@ Description
 The LM73 is a digital temperature sensor.  All temperature values are
 given in degrees Celsius.
 
+Initialization
+--------------
+
+At initialization, the LM73 driver attempts to detect the device by
+reading the control, configuration, and id registers.  The device is
+next probed, at which time a "soft reset" is performed, as recommended
+by TI in the "Power Supply Ramp-Up Considerations" section of the LM73
+datasheet (May 2009 revision, Page 19).
+
 Measurement Resolution Support
 ------------------------------
 
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 9bde964..5ee582f 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -21,7 +21,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
-
+#include <linux/delay.h>
 
 /* Addresses scanned */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
@@ -47,6 +47,8 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
 #define LM73_CTRL_HI_SHIFT	2
 #define LM73_CTRL_LO_SHIFT	1
 
+#define LM73_CONF_PD_MASK	BIT(7)
+
 static const unsigned short lm73_convrates[] = {
 	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
 	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
@@ -201,6 +203,44 @@ static const struct attribute_group lm73_group = {
 
 /* device probe and removal */
 
+static int lm73_soft_reset(struct i2c_client *client)
+{
+	struct lm73_data *data = i2c_get_clientdata(client);
+	s32 err;
+	u8 value;
+	unsigned long res;
+
+	err = i2c_smbus_read_byte_data(client, LM73_REG_CONF);
+	if (err < 0)
+		goto reset_error;
+
+	value = err;
+	value &= ~(BIT(1) | BIT(0)); /* always clear bits 1:0 */
+	value |= (BIT(6));           /* always set bit 6      */
+
+	/* power down the sensor */
+	value |= LM73_CONF_PD_MASK;
+	err = i2c_smbus_write_byte_data(client, LM73_REG_CONF, value);
+	if (err < 0)
+		goto reset_error;
+
+	/* let the sensor settle, dependent on the resolution configured */
+	mutex_lock(&data->lock);
+	res = (data->ctrl & LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_SHIFT;
+	mutex_unlock(&data->lock);
+
+	mdelay(lm73_convrates[res]);
+
+	/* power up the sensor */
+	value &= ~LM73_CONF_PD_MASK;
+	err = i2c_smbus_write_byte_data(client, LM73_REG_CONF, value);
+	if (err < 0)
+		goto reset_error;
+
+reset_error:
+	return err;
+}
+
 static int
 lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
@@ -235,6 +275,12 @@ lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	dev_info(&client->dev, "%s: sensor '%s'\n",
 		 dev_name(data->hwmon_dev), client->name);
 
+	/* Reset the device */
+	status = lm73_soft_reset(client);
+	if (status < 0)
+		dev_warn(&client->dev, "%s: unable to reset device\n",
+			 dev_name(data->hwmon_dev));
+
 	return 0;
 
 exit_remove:
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
