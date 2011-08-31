From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Aug 2011 15:53:41 +0000
Subject: [lm-sensors] hwmon: (ucd9000/ucd9200) Optimize array walk
Message-Id: <20110831175341.38102427@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rewrite the loop walking the id array during probe. The new code is
better adapted to a null-terminated array, and is also clearer and
more efficient than the original.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Axel Lin <axel.lin@gmail.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
Inspired by a previous patch from Axel.

 drivers/hwmon/pmbus/ucd9000.c |    6 ++----
 drivers/hwmon/pmbus/ucd9200.c |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

--- linux-3.1-rc4.orig/drivers/hwmon/pmbus/ucd9000.c	2011-08-30 13:41:32.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/pmbus/ucd9000.c	2011-08-31 11:53:28.000000000 +0200
@@ -141,13 +141,11 @@ static int ucd9000_probe(struct i2c_clie
 	block_buffer[ret] = '\0';
 	dev_info(&client->dev, "Device ID %s\n", block_buffer);
 
-	mid = NULL;
-	for (i = 0; i < ARRAY_SIZE(ucd9000_id); i++) {
-		mid = &ucd9000_id[i];
+	for (mid = ucd9000_id; mid->name[0]; mid++) {
 		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
 			break;
 	}
-	if (!mid || !strlen(mid->name)) {
+	if (!mid->name[0]) {
 		dev_err(&client->dev, "Unsupported device\n");
 		return -ENODEV;
 	}
--- linux-3.1-rc4.orig/drivers/hwmon/pmbus/ucd9200.c	2011-08-30 13:41:32.000000000 +0200
+++ linux-3.1-rc4/drivers/hwmon/pmbus/ucd9200.c	2011-08-31 11:53:20.000000000 +0200
@@ -68,13 +68,11 @@ static int ucd9200_probe(struct i2c_clie
 	block_buffer[ret] = '\0';
 	dev_info(&client->dev, "Device ID %s\n", block_buffer);
 
-	mid = NULL;
-	for (i = 0; i < ARRAY_SIZE(ucd9200_id); i++) {
-		mid = &ucd9200_id[i];
+	for (mid = ucd9200_id; mid->name[0]; mid++) {
 		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
 			break;
 	}
-	if (!mid || !strlen(mid->name)) {
+	if (!mid->name[0]) {
 		dev_err(&client->dev, "Unsupported device\n");
 		return -ENODEV;
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
