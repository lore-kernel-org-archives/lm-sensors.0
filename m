From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 16:19:03 +0000
Subject: [lm-sensors] [PATCH v2 2/4] hwmon: (pmbus) Don't return errors from
Message-Id: <1314375545-18335-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Driver remove functions have an error return value, but rarely return an error
in practice. If a driver does return an error from its remove function, the
driver won't be unloaded and is expected to stay alive.

pmbus_do_remove() is defined as returning an int, but always returns 0 (no
error). Calling code passes that return value on to high level driver
remove functions, but does not evaluate it and removes driver data even if
pmbus_do_remove() returned an error (which it in practice never does). Even if
this code could never cause a real problem, it is nevertheless conceptually
wrong.

To reduce confusion and simplify the code, change pmbus_do_remove() to be a void
function, and have PMBus client driver always return zero in its driver remove
function.

Reported-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/adm1275.c    |    5 ++---
 drivers/hwmon/pmbus/lm25066.c    |    5 ++---
 drivers/hwmon/pmbus/max16064.c   |    3 ++-
 drivers/hwmon/pmbus/max34440.c   |    3 ++-
 drivers/hwmon/pmbus/max8688.c    |    3 ++-
 drivers/hwmon/pmbus/pmbus.c      |    5 ++---
 drivers/hwmon/pmbus/pmbus.h      |    2 +-
 drivers/hwmon/pmbus/pmbus_core.c |    3 +--
 drivers/hwmon/pmbus/ucd9000.c    |    5 ++---
 drivers/hwmon/pmbus/ucd9200.c    |    5 ++---
 10 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index c936e27..424d0d7 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -152,11 +152,10 @@ err_mem:
 static int adm1275_remove(struct i2c_client *client)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	int ret;
 
-	ret = pmbus_do_remove(client);
+	pmbus_do_remove(client);
 	kfree(info);
-	return ret;
+	return 0;
 }
 
 static const struct i2c_device_id adm1275_id[] = {
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index ac254fb..2107f41 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -309,11 +309,10 @@ static int lm25066_remove(struct i2c_client *client)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	const struct lm25066_data *data = to_lm25066_data(info);
-	int ret;
 
-	ret = pmbus_do_remove(client);
+	pmbus_do_remove(client);
 	kfree(data);
-	return ret;
+	return 0;
 }
 
 static const struct i2c_device_id lm25066_id[] = {
diff --git a/drivers/hwmon/pmbus/max16064.c b/drivers/hwmon/pmbus/max16064.c
index e50b296..1d77cf4 100644
--- a/drivers/hwmon/pmbus/max16064.c
+++ b/drivers/hwmon/pmbus/max16064.c
@@ -105,7 +105,8 @@ static int max16064_probe(struct i2c_client *client,
 
 static int max16064_remove(struct i2c_client *client)
 {
-	return pmbus_do_remove(client);
+	pmbus_do_remove(client);
+	return 0;
 }
 
 static const struct i2c_device_id max16064_id[] = {
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index fda621d..c824365 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -224,7 +224,8 @@ static int max34440_probe(struct i2c_client *client,
 
 static int max34440_remove(struct i2c_client *client)
 {
-	return pmbus_do_remove(client);
+	pmbus_do_remove(client);
+	return 0;
 }
 
 static const struct i2c_device_id max34440_id[] = {
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
index c3e72f1..e148e2c 100644
--- a/drivers/hwmon/pmbus/max8688.c
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -182,7 +182,8 @@ static int max8688_probe(struct i2c_client *client,
 
 static int max8688_remove(struct i2c_client *client)
 {
-	return pmbus_do_remove(client);
+	pmbus_do_remove(client);
+	return 0;
 }
 
 static const struct i2c_device_id max8688_id[] = {
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 73de9f1..1dfba44 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -187,13 +187,12 @@ out:
 
 static int pmbus_remove(struct i2c_client *client)
 {
-	int ret;
 	const struct pmbus_driver_info *info;
 
 	info = pmbus_get_driver_info(client);
-	ret = pmbus_do_remove(client);
+	pmbus_do_remove(client);
 	kfree(info);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index da90167..f022f4e 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -361,7 +361,7 @@ bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
 bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
 int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 		   struct pmbus_driver_info *info);
-int pmbus_do_remove(struct i2c_client *client);
+void pmbus_do_remove(struct i2c_client *client);
 const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client
 						      *client);
 
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index a561c3a..b1320cf 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1757,7 +1757,7 @@ out_data:
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
 
-int pmbus_do_remove(struct i2c_client *client)
+void pmbus_do_remove(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	hwmon_device_unregister(data->hwmon_dev);
@@ -1767,7 +1767,6 @@ int pmbus_do_remove(struct i2c_client *client)
 	kfree(data->booleans);
 	kfree(data->sensors);
 	kfree(data);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
 
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index ace1c73..285bb15 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -241,13 +241,12 @@ out:
 
 static int ucd9000_remove(struct i2c_client *client)
 {
-	int ret;
 	struct ucd9000_data *data;
 
 	data = to_ucd9000_data(pmbus_get_driver_info(client));
-	ret = pmbus_do_remove(client);
+	pmbus_do_remove(client);
 	kfree(data);
-	return ret;
+	return 0;
 }
 
 
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index ffcc1cf..786f6cd 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -173,13 +173,12 @@ out:
 
 static int ucd9200_remove(struct i2c_client *client)
 {
-	int ret;
 	const struct pmbus_driver_info *info;
 
 	info = pmbus_get_driver_info(client);
-	ret = pmbus_do_remove(client);
+	pmbus_do_remove(client);
 	kfree(info);
-	return ret;
+	return 0;
 }
 
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
