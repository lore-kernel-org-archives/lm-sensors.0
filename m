From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: Inline w83792d register access functions
Message-Id: <11392571372371@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Inline w83792d register access functions

Inline w83792d_{read,write}_value for better performance.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Yuan Mu <Ymu at winbond.com.tw>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 0d0ab7fe4c009c40dc485731f9ad98e1d336ddae
tree d459f9a5551643307c92a790969ea6a181cadc68
parent 806ba6409061ae49421319e3745026014abc49c2
author Jean Delvare <khali at linux-fr.org> Mon, 09 Jan 2006 23:07:05 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:15 -0800

 drivers/hwmon/w83792d.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index b176bf0..a2f6bb6 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -303,10 +303,6 @@ struct w83792d_data {
 static int w83792d_attach_adapter(struct i2c_adapter *adapter);
 static int w83792d_detect(struct i2c_adapter *adapter, int address, int kind);
 static int w83792d_detach_client(struct i2c_client *client);
-
-static int w83792d_read_value(struct i2c_client *client, u8 register);
-static int w83792d_write_value(struct i2c_client *client, u8 register,
-				u8 value);
 static struct w83792d_data *w83792d_update_device(struct device *dev);
 
 #ifdef DEBUG
@@ -329,6 +325,20 @@ static inline long in_count_from_reg(int
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
@@ -1386,19 +1396,6 @@ w83792d_detach_client(struct i2c_client 
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


