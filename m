From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:56:50 +0000
Subject: [lm-sensors] [patch 13/36] hwmon: (w83795) Only start monitoring if
Message-Id: <20100915155650.3f3e8341@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This saves an SMBus write if monitoring was already enabled.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:45.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:48.000000000 +0200
@@ -55,6 +55,7 @@ MODULE_PARM_DESC(reset, "Set to 1 to res
 #define W83795_REG_I2C_ADDR		0xfc
 #define W83795_REG_CONFIG		0x01
 #define W83795_REG_CONFIG_CONFIG48	0x04
+#define W83795_REG_CONFIG_START	0x01
 
 /* Multi-Function Pin Ctrl Registers */
 #define W83795_REG_VOLT_CTRL1		0x02
@@ -1664,12 +1665,18 @@ static const struct sensor_device_attrib
 
 static void w83795_init_client(struct i2c_client *client)
 {
+	u8 config;
+
 	if (reset)
 		w83795_write(client, W83795_REG_CONFIG, 0x80);
 
-	/* Start monitoring */
-	w83795_write(client, W83795_REG_CONFIG,
-		     w83795_read(client, W83795_REG_CONFIG) | 0x01);
+	/* Start monitoring if needed */
+	config = w83795_read(client, W83795_REG_CONFIG);
+	if (!(config & W83795_REG_CONFIG_START)) {
+		dev_info(&client->dev, "Enabling monitoring operations\n");
+		w83795_write(client, W83795_REG_CONFIG,
+			     config | W83795_REG_CONFIG_START);
+	}
 }
 
 static int w83795_get_device_id(struct i2c_client *client)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
