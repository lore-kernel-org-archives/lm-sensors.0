From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 22:07:05 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: Inline w83792d register access
Message-Id: <20060109230705.457c0960.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83792d-inline-register-access-functions.patch

Inline w83792d_{read,write}_value for better performance.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Yuan Mu <Ymu at winbond.com.tw>
---
 drivers/hwmon/w83792d.c |   31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

--- linux-2.6.15-rc6.orig/drivers/hwmon/w83792d.c	2005-12-23 17:54:52.000000000 +0100
+++ linux-2.6.15-rc6/drivers/hwmon/w83792d.c	2005-12-23 17:58:12.000000000 +0100
@@ -303,10 +303,6 @@
 static int w83792d_attach_adapter(struct i2c_adapter *adapter);
 static int w83792d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83792d_detach_client(struct i2c_client *client);
-
-static int w83792d_read_value(struct i2c_client *client, u8 register);
-static int w83792d_write_value(struct i2c_client *client, u8 register,
-				u8 value);
 static struct w83792d_data *w83792d_update_device(struct device *dev);
 
 #ifdef DEBUG
@@ -329,6 +325,20 @@
 	return ((data->in[nr] << 2) | ((data->low_bits >> (2 * nr)) & 0x03));
 }
 
+/* The SMBus locks itself. The Winbond W83792D chip has a bank register,
+   but the driver only accesses registers in bank 0, so we don't have
+   to switch banks and lock access between switches. */
+static inline int w83792d_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static inline int
+w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
 /* following are the sysfs callback functions */
 static ssize_t show_in(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -1386,19 +1396,6 @@
 	return 0;
 }
 
-/* The SMBus locks itself. The Winbond W83792D chip has a bank register,
-   but the driver only accesses registers in bank 0, so we don't have
-   to switch banks and lock access between switches. */
-static int w83792d_read_value(struct i2c_client *client, u8 reg)
-{
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static int w83792d_write_value(struct i2c_client *client, u8 reg, u8 value)
-{
-	return i2c_smbus_write_byte_data(client, reg, value);
-}
-
 static void
 w83792d_init_client(struct i2c_client *client)
 {

-- 
Jean Delvare

