From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 May 2007 12:52:26 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47m192: Semaphore to mutex conversion
Message-Id: <20070504145226.29951890@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Subject: hwmon/smsc47m192: Semaphore to mutex conversion

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47m192.c |   29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

--- linux-2.6.21-git.orig/drivers/hwmon/smsc47m192.c	2007-05-04 14:43:27.000000000 +0200
+++ linux-2.6.21-git/drivers/hwmon/smsc47m192.c	2007-05-04 14:47:55.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/sysfs.h>
+#include <linux/mutex.h>
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
@@ -97,7 +98,7 @@ static inline int TEMP_FROM_REG(s8 val)
 struct smsc47m192_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
@@ -164,11 +165,11 @@ static ssize_t set_in_min(struct device 
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_min[nr] = IN_TO_REG(val, nr);
 	i2c_smbus_write_byte_data(client, SMSC47M192_REG_IN_MIN(nr),
 							data->in_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -181,11 +182,11 @@ static ssize_t set_in_max(struct device 
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->in_max[nr] = IN_TO_REG(val, nr);
 	i2c_smbus_write_byte_data(client, SMSC47M192_REG_IN_MAX(nr),
 							data->in_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -243,11 +244,11 @@ static ssize_t set_temp_min(struct devic
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_min[nr] = TEMP_TO_REG(val);
 	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MIN[nr],
 						data->temp_min[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -260,11 +261,11 @@ static ssize_t set_temp_max(struct devic
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_max[nr] = TEMP_TO_REG(val);
 	i2c_smbus_write_byte_data(client, SMSC47M192_REG_TEMP_MAX[nr],
 						data->temp_max[nr]);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -287,7 +288,7 @@ static ssize_t set_temp_offset(struct de
 	u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = TEMP_TO_REG(val);
 	if (nr>1)
 		i2c_smbus_write_byte_data(client,
@@ -303,7 +304,7 @@ static ssize_t set_temp_offset(struct de
 	} else if ((sfr & 0x10) = (nr=0 ? 0x10 : 0))
 		i2c_smbus_write_byte_data(client,
 					SMSC47M192_REG_TEMP_OFFSET(nr), 0);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -531,7 +532,7 @@ static int smsc47m192_detect(struct i2c_
 	/* Fill in the remaining client fields and put into the global list */
 	strlcpy(client->name, "smsc47m192", I2C_NAME_SIZE);
 	data->vrm = vid_which_vrm();
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(client)))
@@ -594,7 +595,7 @@ static struct smsc47m192_data *smsc47m19
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	int i, config;
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	 || !data->valid) {
@@ -645,7 +646,7 @@ static struct smsc47m192_data *smsc47m19
 		data->valid = 1;
 	}
 
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return data;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
