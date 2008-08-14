From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Aug 2008 10:10:39 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (adm1026) Fix debug messages
Message-Id: <20080814121039.28966738@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Add missing new-line to one debug message.
* Remove leading colon from 3 debug messages.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Philip Pokorny <ppokorny@penguincomputing.com>
---
 drivers/hwmon/adm1026.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.26-rc9.orig/drivers/hwmon/adm1026.c	2008-07-08 14:05:02.000000000 +0200
+++ linux-2.6.26-rc9/drivers/hwmon/adm1026.c	2008-07-08 14:48:51.000000000 +0200
@@ -455,7 +455,7 @@ static void adm1026_print_gpio(struct i2
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int i;
 
-	dev_dbg(&client->dev, "GPIO config is:");
+	dev_dbg(&client->dev, "GPIO config is:\n");
 	for (i = 0;i <= 7;++i) {
 		if (data->config2 & (1 << i)) {
 			dev_dbg(&client->dev, "\t%sGP%s%d\n",
@@ -1681,17 +1681,16 @@ static int adm1026_detect(struct i2c_cli
 			kind = adm1026;
 		} else if (company = ADM1026_COMPANY_ANALOG_DEV
 			&& (verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
-			dev_err(&adapter->dev, ": Unrecognized stepping "
+			dev_err(&adapter->dev, "Unrecognized stepping "
 				"0x%02x. Defaulting to ADM1026.\n", verstep);
 			kind = adm1026;
 		} else if ((verstep & 0xf0) = ADM1026_VERSTEP_GENERIC) {
-			dev_err(&adapter->dev, ": Found version/stepping "
+			dev_err(&adapter->dev, "Found version/stepping "
 				"0x%02x. Assuming generic ADM1026.\n",
 				verstep);
 			kind = any_chip;
 		} else {
-			dev_dbg(&adapter->dev, ": Autodetection "
-				"failed\n");
+			dev_dbg(&adapter->dev, "Autodetection failed\n");
 			/* Not an ADM1026 ... */
 			if (kind = 0) { /* User used force=x,y */
 				dev_err(&adapter->dev, "Generic ADM1026 not "


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
