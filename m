From: Axel Lin <axel.lin@gmail.com>
Date: Wed, 31 Aug 2011 03:44:32 +0000
Subject: [lm-sensors] [PATCH] hwmon: (pmbus) Fix the logic of checking if no
Message-Id: <1314762272.3189.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

If no id is matched, the mid pointer is not NULL in current implementation.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/pmbus/ucd9000.c |    3 +--
 drivers/hwmon/pmbus/ucd9200.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index 285bb15..4aa8701 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -141,13 +141,12 @@ static int ucd9000_probe(struct i2c_client *client,
 	block_buffer[ret] = '\0';
 	dev_info(&client->dev, "Device ID %s\n", block_buffer);
 
-	mid = NULL;
 	for (i = 0; i < ARRAY_SIZE(ucd9000_id); i++) {
 		mid = &ucd9000_id[i];
 		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
 			break;
 	}
-	if (!mid || !strlen(mid->name)) {
+	if ((i = ARRAY_SIZE(ucd9000_id)) || !strlen(mid->name)) {
 		dev_err(&client->dev, "Unsupported device\n");
 		return -ENODEV;
 	}
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index 786f6cd..826cc8f 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -68,13 +68,12 @@ static int ucd9200_probe(struct i2c_client *client,
 	block_buffer[ret] = '\0';
 	dev_info(&client->dev, "Device ID %s\n", block_buffer);
 
-	mid = NULL;
 	for (i = 0; i < ARRAY_SIZE(ucd9200_id); i++) {
 		mid = &ucd9200_id[i];
 		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
 			break;
 	}
-	if (!mid || !strlen(mid->name)) {
+	if ((i = ARRAY_SIZE(ucd9200_id)) || !strlen(mid->name)) {
 		dev_err(&client->dev, "Unsupported device\n");
 		return -ENODEV;
 	}
-- 
1.7.4.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
