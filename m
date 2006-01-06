From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: w83792d misc cleanups
Message-Id: <1136585257898@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: w83792d misc cleanups

Cleanup the w83792d driver a bit:
* Discard unused lock and irrelevant comments inherited from the
  w83781d driver.
* Simplify w83792d_{read,write}_value functions.
* Drop useless address test during detection.
* Drop useless bitmasking.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Yuan Mu <Ymu at winbond.com.tw>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit c9152deaa635cab09cb43c17cf80130b9e6ee29d
tree f05e5e846b0c042d0f7421bf33c68337aaca20ed
parent 79472132f555ae1e912699e116e5c82f338872f6
author Jean Delvare <khali at linux-fr.org> Sun, 18 Dec 2005 16:29:40 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:25 -0800

 drivers/hwmon/w83792d.c |   29 +++++++++--------------------
 1 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index ff1c9f0..0ad1ae5 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -269,7 +269,6 @@ DIV_TO_REG(long val)
 struct w83792d_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -1192,7 +1191,6 @@ w83792d_detect(struct i2c_adapter *adapt
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	init_MUTEX(&data->lock);
 	new_client->adapter = adapter;
 	new_client->driver = &w83792d_driver;
 	new_client->flags = 0;
@@ -1243,7 +1241,7 @@ w83792d_detect(struct i2c_adapter *adapt
 			goto ERROR1;
 		}
 		val1 = w83792d_read_value(new_client, W83792D_REG_WCHIPID);
-		if (val1 = 0x7a && address >= 0x2c) {
+		if (val1 = 0x7a) {
 			kind = w83792d;
 		} else {
 			if (kind = 0)
@@ -1416,26 +1414,17 @@ w83792d_detach_client(struct i2c_client 
 	return 0;
 }
 
-/* The SMBus locks itself, usually, but nothing may access the Winbond between
-   bank switches. ISA access must always be locked explicitly!
-   We ignore the W83792D BUSY flag at this moment - it could lead to deadlocks,
-   would slow down the W83792D access and should not be necessary.
-   There are some ugly typecasts here, but the good news is - they should
-   nowhere else be necessary! */
-static int
-w83792d_read_value(struct i2c_client *client, u8 reg)
+/* The SMBus locks itself. The Winbond W83792D chip has a bank register,
+   but the driver only accesses registers in bank 0, so we don't have
+   to switch banks and lock access between switches. */
+static int w83792d_read_value(struct i2c_client *client, u8 reg)
 {
-	int res=0;
-	res = i2c_smbus_read_byte_data(client, reg);
-
-	return res;
+	return i2c_smbus_read_byte_data(client, reg);
 }
 
-static int
-w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)
+static int w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
-	i2c_smbus_write_byte_data(client, reg,  value);
-	return 0;
+	return i2c_smbus_write_byte_data(client, reg, value);
 }
 
 static void
@@ -1506,7 +1495,7 @@ static struct w83792d_data *w83792d_upda
 			pwm_array_tmp[i] = w83792d_read_value(client,
 						W83792D_REG_PWM[i]);
 			data->pwm[i] = pwm_array_tmp[i] & 0x0f;
-			data->pwm_mode[i] = (pwm_array_tmp[i] >> 7) & 0x01;
+			data->pwm_mode[i] = pwm_array_tmp[i] >> 7;
 		}
 
 		reg_tmp = w83792d_read_value(client, W83792D_REG_FAN_CFG);


