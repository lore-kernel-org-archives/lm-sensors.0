From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Feb 2012 16:56:44 +0000
Subject: [lm-sensors] [PATCH 2/7] hwmon: (pmbus) Simplify remove functions
Message-Id: <1329929809-6085-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since devm_kzalloc() is now used to allocate driver memory, the client
driver remove function has no purpose other than to call pmbus_do_remove().
This means we can get rid of it by redefining pmbus_do_remove() to use the
same prototype, and pointing to it directly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/adm1275.c    |    8 +-------
 drivers/hwmon/pmbus/lm25066.c    |    8 +-------
 drivers/hwmon/pmbus/ltc2978.c    |    8 +-------
 drivers/hwmon/pmbus/max16064.c   |    8 +-------
 drivers/hwmon/pmbus/max34440.c   |    8 +-------
 drivers/hwmon/pmbus/max8688.c    |    8 +-------
 drivers/hwmon/pmbus/pmbus.c      |    8 +-------
 drivers/hwmon/pmbus/pmbus.h      |    2 +-
 drivers/hwmon/pmbus/pmbus_core.c |    3 ++-
 drivers/hwmon/pmbus/ucd9000.c    |    9 +--------
 drivers/hwmon/pmbus/ucd9200.c    |    9 +--------
 drivers/hwmon/pmbus/zl6100.c     |    8 +-------
 12 files changed, 13 insertions(+), 74 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index f81cb4a..5e4421e 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -301,18 +301,12 @@ static int adm1275_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, info);
 }
 
-static int adm1275_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 static struct i2c_driver adm1275_driver = {
 	.driver = {
 		   .name = "adm1275",
 		   },
 	.probe = adm1275_probe,
-	.remove = adm1275_remove,
+	.remove = pmbus_do_remove,
 	.id_table = adm1275_id,
 };
 
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index e70d4ca..c299392 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -295,12 +295,6 @@ static int lm25066_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, info);
 }
 
-static int lm25066_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 static const struct i2c_device_id lm25066_id[] = {
 	{"lm25066", lm25066},
 	{"lm5064", lm5064},
@@ -316,7 +310,7 @@ static struct i2c_driver lm25066_driver = {
 		   .name = "lm25066",
 		   },
 	.probe = lm25066_probe,
-	.remove = lm25066_remove,
+	.remove = pmbus_do_remove,
 	.id_table = lm25066_id,
 };
 
diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index 5e07a36..9652a2c 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -361,19 +361,13 @@ static int ltc2978_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, info);
 }
 
-static int ltc2978_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 /* This is the driver that will be inserted */
 static struct i2c_driver ltc2978_driver = {
 	.driver = {
 		   .name = "ltc2978",
 		   },
 	.probe = ltc2978_probe,
-	.remove = ltc2978_remove,
+	.remove = pmbus_do_remove,
 	.id_table = ltc2978_id,
 };
 
diff --git a/drivers/hwmon/pmbus/max16064.c b/drivers/hwmon/pmbus/max16064.c
index 5cfe20f..fa237a3 100644
--- a/drivers/hwmon/pmbus/max16064.c
+++ b/drivers/hwmon/pmbus/max16064.c
@@ -103,12 +103,6 @@ static int max16064_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, &max16064_info);
 }
 
-static int max16064_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 static const struct i2c_device_id max16064_id[] = {
 	{"max16064", 0},
 	{}
@@ -122,7 +116,7 @@ static struct i2c_driver max16064_driver = {
 		   .name = "max16064",
 		   },
 	.probe = max16064_probe,
-	.remove = max16064_remove,
+	.remove = pmbus_do_remove,
 	.id_table = max16064_id,
 };
 
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index 89ae303..15050d8 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -224,12 +224,6 @@ static int max34440_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, &max34440_info[id->driver_data]);
 }
 
-static int max34440_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 static const struct i2c_device_id max34440_id[] = {
 	{"max34440", max34440},
 	{"max34441", max34441},
@@ -244,7 +238,7 @@ static struct i2c_driver max34440_driver = {
 		   .name = "max34440",
 		   },
 	.probe = max34440_probe,
-	.remove = max34440_remove,
+	.remove = pmbus_do_remove,
 	.id_table = max34440_id,
 };
 
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index 82c598d..f04454a 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -180,12 +180,6 @@ static int max8688_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, &max8688_info);
 }
 
-static int max8688_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 static const struct i2c_device_id max8688_id[] = {
 	{"max8688", 0},
 	{ }
@@ -199,7 +193,7 @@ static struct i2c_driver max8688_driver = {
 		   .name = "max8688",
 		   },
 	.probe = max8688_probe,
-	.remove = max8688_remove,
+	.remove = pmbus_do_remove,
 	.id_table = max8688_id,
 };
 
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index b94bec2..3488740 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -178,12 +178,6 @@ static int pmbus_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, id, info);
 }
 
-static int pmbus_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 /*
  * Use driver_data to set the number of pages supported by the chip.
  */
@@ -209,7 +203,7 @@ static struct i2c_driver pmbus_driver = {
 		   .name = "pmbus",
 		   },
 	.probe = pmbus_probe,
-	.remove = pmbus_remove,
+	.remove = pmbus_do_remove,
 	.id_table = pmbus_id,
 };
 
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 5d31d1c..0b17d4f 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -364,7 +364,7 @@ bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
 int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		   struct pmbus_driver_info *info);
-void pmbus_do_remove(struct i2c_client *client);
+int pmbus_do_remove(struct i2c_client *client);
 const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client
 						      *client);
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index c03b762..2fb2e48 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1777,11 +1777,12 @@ out_hwmon_device_register:
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
 
-void pmbus_do_remove(struct i2c_client *client)
+int pmbus_do_remove(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&client->dev.kobj, &data->group);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
 
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index e057345..fbb1479 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -229,20 +229,13 @@ static int ucd9000_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, mid, info);
 }
 
-static int ucd9000_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
-
 /* This is the driver that will be inserted */
 static struct i2c_driver ucd9000_driver = {
 	.driver = {
 		.name = "ucd9000",
 	},
 	.probe = ucd9000_probe,
-	.remove = ucd9000_remove,
+	.remove = pmbus_do_remove,
 	.id_table = ucd9000_id,
 };
 
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index c0d41b9..033d6ac 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -163,20 +163,13 @@ static int ucd9200_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, mid, info);
 }
 
-static int ucd9200_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
-
 /* This is the driver that will be inserted */
 static struct i2c_driver ucd9200_driver = {
 	.driver = {
 		.name = "ucd9200",
 	},
 	.probe = ucd9200_probe,
-	.remove = ucd9200_remove,
+	.remove = pmbus_do_remove,
 	.id_table = ucd9200_id,
 };
 
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index ae925a2..4a8fc63 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -244,18 +244,12 @@ static int zl6100_probe(struct i2c_client *client,
 	return pmbus_do_probe(client, mid, info);
 }
 
-static int zl6100_remove(struct i2c_client *client)
-{
-	pmbus_do_remove(client);
-	return 0;
-}
-
 static struct i2c_driver zl6100_driver = {
 	.driver = {
 		   .name = "zl6100",
 		   },
 	.probe = zl6100_probe,
-	.remove = zl6100_remove,
+	.remove = pmbus_do_remove,
 	.id_table = zl6100_id,
 };
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
