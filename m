From: David Brownell <david-b@pacbell.net>
Date: Wed, 16 Apr 2008 17:35:41 +0000
Subject: [lm-sensors] [patch/rfc 2.6.25-rc9 5/5] lm75: smbalert# support
Message-Id: <200804161035.42036.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add a simple SMBALERT# capability to the LM75 driver (for the various
TMPx75 parts), relying on the smbalert patch (which hasn't yet seen
any response, sigh).

Doesn't handle "normal" IRQs yet though.

NOT yet signed-off ... it's not clear to me how to handle such alerts
well with hwmon.

---
 drivers/hwmon/lm75.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

--- a/drivers/hwmon/lm75.c	2007-09-27 16:07:49.000000000 -0700
+++ b/drivers/hwmon/lm75.c	2007-09-27 16:09:55.000000000 -0700
@@ -143,6 +143,22 @@ static const struct attribute_group lm75
 	.attrs = lm75_attributes,
 };
 
+static void lm75_alert(struct i2c_client *client, bool flag)
+{
+	struct lm75_data *data = lm75_update_device(&client->dev);
+	int temp = reg_to_temp(data->temp[0]);
+	int limit = reg_to_temp(data->temp[flag ? 2 : 3]);
+
+	/* FIXME notify something!  temp1_{min,max}_alarm could be
+	 * set to one; but then, how to clear?  hwmon seems not to
+	 * actually understand (or expect) asynch notifications ...
+	 */
+	dev_warn(&client->dev, "%d.%03d is %s %d.%03d (degrees C)\n",
+		temp / 1000, temp % 1000,
+		flag ? "above" : "below",
+		limit / 1000, limit % 1000);
+}
+
 /*-----------------------------------------------------------------------*/
 
 /* "New style" I2C driver binding -- following the driver model */
@@ -154,6 +170,7 @@ static int lm75_probe(struct i2c_client 
 	u8 set_mask, clr_mask;
 	int new;
 	int resolution;
+	int alert = 0;
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
@@ -181,23 +198,39 @@ static int lm75_probe(struct i2c_client 
 	/* for tmp175 or tmp275, use name "tmp75" */
 	if (strcmp(client->name, "tmp75") = 0) {
 		data->min = -40 * 1000;
+		alert = 1;
 		set_mask |= (1 << 6) | (1 << 5);
 		resolution = 12;
 
 	/* for ds1775, use name "ds75" */
 	} else if (strcmp(client->name, "ds75") = 0
 			|| strcmp(client->name, "mcp980x") = 0
-			|| strcmp(client->name, "tmp100") = 0
-			|| strcmp(client->name, "tmp101") = 0) {
+			|| strcmp(client->name, "tmp100") = 0) {
+		set_mask |= (1 << 6) | (1 << 5);
+		resolution = 12;
+
+	} else if (strcmp(client->name, "tmp101") = 0) {
+		alert = 1;
 		set_mask |= (1 << 6) | (1 << 5);
 		resolution = 12;
 
 	} else if (strcmp(client->name, "max6626") = 0)
 		resolution = 12;
 
-	/* NOTE:  also need to ensure that the chip is in interrupt mode
-	 * in various cases, and maybe handle SMBALERT#.
+	/* Force IRQ mode if it looks appropriate:
+	 *   - chip and bus both support (shared) SMBALERT#; or
+	 *   - we have a (unshared) IRQ registered
+	 *
+	 * FIXME when client->irq, arrange an irq handler which knows how
+	 * to kick a work struct to poll the temperature, then call alert()
+	 * with the relevant info.
+	 *
+	 * NOTE it's possible that a bus support SMBALERT# but that this
+	 * sensor not be hooked up to it.  If that's your situation, you
+	 * may need to use platform_data to say how to handle this...
 	 */
+	if ((alert && client->adapter->ara) || client->irq > 0)
+		set_mask |= (1 << 1);
 
 	/* configure as specified */
 	status = lm75_read_value(client, LM75_REG_CONF);
@@ -257,6 +290,7 @@ static struct i2c_driver lm75_driver = {
 	},
 	.probe		= lm75_probe,
 	.remove		= lm75_remove,
+	.alert		= lm75_alert,
 };
 
 /*-----------------------------------------------------------------------*/
@@ -370,6 +404,7 @@ static struct i2c_driver lm75_legacy_dri
 	},
 	.attach_adapter	= lm75_attach_adapter,
 	.detach_client	= lm75_detach_client,
+	.alert		= lm75_alert,
 };
 
 /*-----------------------------------------------------------------------*/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
