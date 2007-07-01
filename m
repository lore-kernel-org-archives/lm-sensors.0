From: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>
Date: Sun, 01 Jul 2007 16:32:24 +0000
Subject: [lm-sensors] [PATCH 3/5] use mutex instead of semaphore in SMSC
Message-Id: <20070701163224.GF3940@traven>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701162529.GC3940@traven>
In-Reply-To: <20070701162529.GC3940@traven>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org

The SMSC LPC47M192 driver uses a semaphore as mutex. Use the mutex API
instead of the (binary) semaphore.

Signed-off-by: Matthias Kaehlcke <matthias.kaehlcke@gmail.com>

--

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index a012f39..7c5cfa2 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
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
 
@@ -164,11 +165,11 @@ static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
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
 
@@ -181,11 +182,11 @@ static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
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
 
@@ -243,11 +244,11 @@ static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
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
 
@@ -260,11 +261,11 @@ static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
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
 
@@ -287,7 +288,7 @@ static ssize_t set_temp_offset(struct device *dev, struct device_attribute
 	u8 sfr = i2c_smbus_read_byte_data(client, SMSC47M192_REG_SFR);
 	long val = simple_strtol(buf, NULL, 10);
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = TEMP_TO_REG(val);
 	if (nr>1)
 		i2c_smbus_write_byte_data(client,
@@ -303,7 +304,7 @@ static ssize_t set_temp_offset(struct device *dev, struct device_attribute
 	} else if ((sfr & 0x10) = (nr=0 ? 0x10 : 0))
 		i2c_smbus_write_byte_data(client,
 					SMSC47M192_REG_TEMP_OFFSET(nr), 0);
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -531,7 +532,7 @@ static int smsc47m192_detect(struct i2c_adapter *adapter, int address,
 	/* Fill in the remaining client fields and put into the global list */
 	strlcpy(client->name, "smsc47m192", I2C_NAME_SIZE);
 	data->vrm = vid_which_vrm();
-	init_MUTEX(&data->update_lock);
+	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(client)))
@@ -594,7 +595,7 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 	struct smsc47m192_data *data = i2c_get_clientdata(client);
 	int i, config;
 
-	down(&data->update_lock);
+	mutex_lock(&data->update_lock);
 
 	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	 || !data->valid) {
@@ -645,7 +646,7 @@ static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
 		data->valid = 1;
 	}
 
-	up(&data->update_lock);
+	mutex_unlock(&data->update_lock);
 
 	return data;
 }

-- 
Matthias Kaehlcke
Linux Application Developer
Barcelona

                       El camino se hace al andar
                           (Antonio Machado)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
