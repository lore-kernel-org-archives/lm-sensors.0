From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Sep 2007 16:48:16 +0000
Subject: [lm-sensors] [PATCH] hwmon/thmc50: Fix a debug message
Message-Id: <20070918184816.769f15f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

type_name was used before being set. See why I don't like play-it-safe
variable initializations: they prevent the compiler from warning you
about such mistakes. So fix that as well.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/thmc50.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.23-rc6.orig/drivers/hwmon/thmc50.c	2007-09-18 18:04:18.000000000 +0200
+++ linux-2.6.23-rc6/drivers/hwmon/thmc50.c	2007-09-18 18:33:06.000000000 +0200
@@ -259,7 +259,7 @@ static int thmc50_detect(struct i2c_adap
 	struct thmc50_data *data;
 	struct device *dev;
 	int err = 0;
-	const char *type_name = "";
+	const char *type_name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		pr_debug("thmc50: detect failed, "
@@ -309,13 +309,9 @@ static int thmc50_detect(struct i2c_adap
 		pr_debug("thmc50: Detection of THMC50/ADM1022 failed\n");
 		goto exit_free;
 	}
-	pr_debug("thmc50: Detected %s (version %x, revision %x)\n",
-		 type_name, (revision >> 4) - 0xc, revision & 0xf);
 	data->type = kind;
 
-	if (kind = thmc50)
-		type_name = "thmc50";
-	else if (kind = adm1022) {
+	if (kind = adm1022) {
 		int id = i2c_adapter_id(client->adapter);
 		int i;
 
@@ -328,7 +324,11 @@ static int thmc50_detect(struct i2c_adap
 				data->has_temp3 = 1;
 				break;
 			}
+	} else {
+		type_name = "thmc50";
 	}
+	pr_debug("thmc50: Detected %s (version %x, revision %x)\n",
+		 type_name, (revision >> 4) - 0xc, revision & 0xf);
 
 	/* Fill in the remaining client fields & put it into the global list */
 	strlcpy(client->name, type_name, I2C_NAME_SIZE);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
