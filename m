From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 18:00:18 +0000
Subject: [lm-sensors] [PATCH 06/10] hwmon: (lm85) Simplify device
Message-Id: <20080412200018.79bd315e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Clean up and simplify the device initialization function:
* Degrade error messages to warnings - what they really are.
* Stop warning about VxI mode, we don't really care.
* Drop comment about lack of limit initialization - that's the standard
  way, all hardware monitoring drivers do that.
* Only read the configuration register once.
* Only write back to the configuration register if needed.
* Don't attempt to clear the lock bit, it locks itself to 1.
* Move the function to before it's called, so that we no longer need to
  forware declare it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm85.c |   61 ++++++++++++++------------------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-03 15:27:45.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-03 15:28:10.000000000 +0200
@@ -319,7 +319,6 @@ static int lm85_detach_client(struct i2c
 static int lm85_read_value(struct i2c_client *client, u8 reg);
 static void lm85_write_value(struct i2c_client *client, u8 reg, int value);
 static struct lm85_data *lm85_update_device(struct device *dev);
-static void lm85_init_client(struct i2c_client *client);
 
 
 static struct i2c_driver lm85_driver = {
@@ -1087,6 +1086,24 @@ static const struct attribute_group lm85
 	.attrs = lm85_attributes_in567,
 };
 
+static void lm85_init_client(struct i2c_client *client)
+{
+	int value;
+
+	/* Start monitoring if needed */
+	value = lm85_read_value(client, LM85_REG_CONFIG);
+	if (!(value & 0x01)) {
+		dev_info(&client->dev, "Starting monitoring\n");
+		lm85_write_value(client, LM85_REG_CONFIG, value | 0x01);
+	}
+
+	/* Warn about unusual configuration bits */
+	if (value & 0x02)
+		dev_warn(&client->dev, "Device configuration is locked\n");
+	if (!(value & 0x04))
+		dev_warn(&client->dev, "Device is not ready\n");
+}
+
 static int lm85_detect(struct i2c_adapter *adapter, int address,
 		int kind)
 {
@@ -1331,48 +1348,6 @@ static void lm85_write_value(struct i2c_
 	}
 }
 
-static void lm85_init_client(struct i2c_client *client)
-{
-	int value;
-	struct lm85_data *data = i2c_get_clientdata(client);
-
-	dev_dbg(&client->dev, "Initializing device\n");
-
-	/* Warn if part was not "READY" */
-	value = lm85_read_value(client, LM85_REG_CONFIG);
-	dev_dbg(&client->dev, "LM85_REG_CONFIG is: 0x%02x\n", value);
-	if (value & 0x02) {
-		dev_err(&client->dev, "Client (%d,0x%02x) config is locked.\n",
-			i2c_adapter_id(client->adapter), client->addr);
-	}
-	if (!(value & 0x04)) {
-		dev_err(&client->dev, "Client (%d,0x%02x) is not ready.\n",
-			i2c_adapter_id(client->adapter), client->addr);
-	}
-	if (value & 0x10
-	    && (data->type = adm1027
-		|| data->type = adt7463)) {
-		dev_err(&client->dev, "Client (%d,0x%02x) VxI mode is set.  "
-			"Please report this to the lm85 maintainer.\n",
-			i2c_adapter_id(client->adapter), client->addr);
-	}
-
-	/* WE INTENTIONALLY make no changes to the limits,
-	 *   offsets, pwms, fans and zones.  If they were
-	 *   configured, we don't want to mess with them.
-	 *   If they weren't, the default is 100% PWM, no
-	 *   control and will suffice until 'sensors -s'
-	 *   can be run by the user.
-	 */
-
-	/* Start monitoring */
-	value = lm85_read_value(client, LM85_REG_CONFIG);
-	/* Try to clear LOCK, Set START, save everything else */
-	value = (value & ~0x02) | 0x01;
-	dev_dbg(&client->dev, "Setting CONFIG to: 0x%02x\n", value);
-	lm85_write_value(client, LM85_REG_CONFIG, value);
-}
-
 static struct lm85_data *lm85_update_device(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
