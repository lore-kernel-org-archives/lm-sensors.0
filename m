From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 23 Feb 2007 13:16:57 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47m1: Get rid of a useless mutex
Message-Id: <20070223141657.3dc5b9b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The smsc47m1 driver uses a mutex to protect the accesses to the
hardware registers. It really doesn't need any protection, as the
register space is flat. Get rid of that mutex for a smaller and
faster driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |   33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

--- linux-2.6.21-rc1.orig/drivers/hwmon/smsc47m1.c	2007-02-23 14:04:42.000000000 +0100
+++ linux-2.6.21-rc1/drivers/hwmon/smsc47m1.c	2007-02-23 14:11:52.000000000 +0100
@@ -116,7 +116,6 @@ struct smsc47m1_data {
 	struct i2c_client client;
 	enum chips type;
 	struct class_device *class_dev;
-	struct mutex lock;
 
 	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
@@ -131,13 +130,19 @@ struct smsc47m1_data {
 
 static int smsc47m1_detect(struct i2c_adapter *adapter);
 static int smsc47m1_detach_client(struct i2c_client *client);
-
-static int smsc47m1_read_value(struct i2c_client *client, u8 reg);
-static void smsc47m1_write_value(struct i2c_client *client, u8 reg, u8 value);
-
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
 		int init);
 
+static inline int smsc47m1_read_value(struct i2c_client *client, u8 reg)
+{
+	return inb_p(client->addr + reg);
+}
+
+static inline void smsc47m1_write_value(struct i2c_client *client, u8 reg,
+		u8 value)
+{
+	outb_p(value, client->addr + reg);
+}
 
 static struct i2c_driver smsc47m1_driver = {
 	.driver = {
@@ -477,7 +482,6 @@ static int smsc47m1_detect(struct i2c_ad
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	mutex_init(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &smsc47m1_driver;
 	new_client->flags = 0;
@@ -633,23 +637,6 @@ static int smsc47m1_detach_client(struct
 	return 0;
 }
 
-static int smsc47m1_read_value(struct i2c_client *client, u8 reg)
-{
-	int res;
-
-	mutex_lock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
-	res = inb_p(client->addr + reg);
-	mutex_unlock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
-	return res;
-}
-
-static void smsc47m1_write_value(struct i2c_client *client, u8 reg, u8 value)
-{
-	mutex_lock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
-	outb_p(value, client->addr + reg);
-	mutex_unlock(&((struct smsc47m1_data *) i2c_get_clientdata(client))->lock);
-}
-
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
 		int init)
 {


-- 
Jean Delvare

