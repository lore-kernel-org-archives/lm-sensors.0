From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 28 Dec 2005 22:39:41 +0000
Subject: [lm-sensors] [PATCH 01/11] hwmon: w83792d misc cleanups
Message-Id: <20051228233941.53d125e2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051218162940.702a24ac.khali@linux-fr.org>
In-Reply-To: <20051218162940.702a24ac.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> > Can you explain please? We have four other hardware monitoring drivers
> > with similar code, and no problem was ever reported. This change to the
> > w83792d driver was compiling just fine for me with both gcc 2.95.3 and
> > gcc 3.3.6. What exactly is supposed to cause problems, and with which
> > compiler?
> 
> I'm using gcc 3.4.4 here, and this change caused build errors.  You
> can't declare a function "static inline" and not actually declare the
> full function before calling it, like this driver did (it called
> w83792d_write_value() before that function was fully written.)  I think
> older versions of gcc just ignore this and don't inline it.
> 
> The other drivers that do this, properly define the functions fully
> before calling them, that's why it works.

OK, thanks for the clarification. It all makes perfect sense now. Here
comes a fixup patch. Can you please fold it into your version of
hwmon-w83792d-misc-cleanups.patch? Thanks.

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

