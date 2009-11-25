From: Mark Ware <mware@elphinstone.net>
Date: Wed, 25 Nov 2009 02:36:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max6650) Allow setting of fan voltage
Message-Id: <4B0C982F.2090500@elphinstone.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The current way to set fan voltage and prescaler parameters is
system-wide via module parameters.  This patch allows them to be set on
a per chip basis using platform_data.  If no platform data is provided,
the existing behaviour is maintained.
---
 drivers/hwmon/max6650.c |   88 +++++++++++++++++++++++++----------------------
 1 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 58f66be..2e8ab9e 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -635,52 +635,58 @@ static int max6650_init_client(struct i2c_client *client)
 		return err;
 	}
 
-	switch (fan_voltage) {
-		case 0:
-			break;
-		case 5:
-			config &= ~MAX6650_CFG_V12;
-			break;
-		case 12:
-			config |= MAX6650_CFG_V12;
-			break;
-		default:
-			dev_err(&client->dev,
-				"illegal value for fan_voltage (%d)\n",
-				fan_voltage);
+	if (client->dev.platform_data) {
+		config = *(u8 *)client->dev.platform_data;
+	}
+	else
+	{
+		switch (fan_voltage) {
+			case 0:
+				break;
+			case 5:
+				config &= ~MAX6650_CFG_V12;
+				break;
+			case 12:
+				config |= MAX6650_CFG_V12;
+				break;
+			default:
+				dev_err(&client->dev,
+					"illegal value for fan_voltage (%d)\n",
+					fan_voltage);
+		}
+
+		switch (prescaler) {
+			case 0:
+				break;
+			case 1:
+				config &= ~MAX6650_CFG_PRESCALER_MASK;
+				break;
+			case 2:
+				config = (config & ~MAX6650_CFG_PRESCALER_MASK)
+					 | MAX6650_CFG_PRESCALER_2;
+				break;
+			case  4:
+				config = (config & ~MAX6650_CFG_PRESCALER_MASK)
+					 | MAX6650_CFG_PRESCALER_4;
+				break;
+			case  8:
+				config = (config & ~MAX6650_CFG_PRESCALER_MASK)
+					 | MAX6650_CFG_PRESCALER_8;
+				break;
+			case 16:
+				config = (config & ~MAX6650_CFG_PRESCALER_MASK)
+					 | MAX6650_CFG_PRESCALER_16;
+				break;
+			default:
+				dev_err(&client->dev,
+					"illegal value for prescaler (%d)\n",
+					prescaler);
+		}
 	}
 
 	dev_info(&client->dev, "Fan voltage is set to %dV.\n",
 		 (config & MAX6650_CFG_V12) ? 12 : 5);
 
-	switch (prescaler) {
-		case 0:
-			break;
-		case 1:
-			config &= ~MAX6650_CFG_PRESCALER_MASK;
-			break;
-		case 2:
-			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
-				 | MAX6650_CFG_PRESCALER_2;
-			break;
-		case  4:
-			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
-				 | MAX6650_CFG_PRESCALER_4;
-			break;
-		case  8:
-			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
-				 | MAX6650_CFG_PRESCALER_8;
-			break;
-		case 16:
-			config = (config & ~MAX6650_CFG_PRESCALER_MASK)
-				 | MAX6650_CFG_PRESCALER_16;
-			break;
-		default:
-			dev_err(&client->dev,
-				"illegal value for prescaler (%d)\n",
-				prescaler);
-	}
-
 	dev_info(&client->dev, "Prescaler is set to %d.\n",
 		 1 << (config & MAX6650_CFG_PRESCALER_MASK));
 
-- 
1.5.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
