From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 Jan 2009 15:56:34 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (ds1621) Save an I2C write at
Message-Id: <20090116165634.0d4569d8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't write back the configuration register if not needed. This is
important because on every write there's a delay before we can write
to the chip again.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/ds1621.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/ds1621.c	2008-07-07 16:33:38.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/ds1621.c	2008-07-07 17:03:01.000000000 +0200
@@ -147,10 +147,10 @@ static int ds1621_write_value(struct i2c
 static void ds1621_init_client(struct i2c_client *client)
 {
 	struct ds1621_data *data = i2c_get_clientdata(client);
-	int reg;
+	int old_reg, reg;
 
 	data->last_written = jiffies;
-	reg = ds1621_read_value(client, DS1621_REG_CONF);
+	old_reg = reg = ds1621_read_value(client, DS1621_REG_CONF);
 	/* switch to continuous conversion mode */
 	reg &= ~ DS1621_REG_CONFIG_1SHOT;
 
@@ -160,7 +160,8 @@ static void ds1621_init_client(struct i2
 	else if (polarity = 1)
 		reg |= DS1621_REG_CONFIG_POLARITY;
 	
-	ds1621_write_value(client, DS1621_REG_CONF, reg);
+	if (reg != old_reg)
+		ds1621_write_value(client, DS1621_REG_CONF, reg);
 	
 	/* start conversion */
 	i2c_smbus_write_byte(client, DS1621_COM_START);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
