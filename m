From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 May 2015 20:27:45 +0000
Subject: [lm-sensors] [PATCH v2 2/2] hwmon: (atxp1) Drop auto-detection
Message-Id: <1432931265-21499-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Auto-detection for this chip is highly unreliable, and one of its
I2C addresses can also be used by EEPROMs, increasing the risk for
false positives even more. Drop auto-detection entirely to remove
the risk.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add text describing the supported I2C addresses, and that the driver
    must be instantiated explicitly.
    Validate supported vrm values in probe function.

 drivers/hwmon/atxp1.c | 55 +++++++++------------------------------------------
 1 file changed, 9 insertions(+), 46 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 78edc56b59e5..40fe10e3ce51 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -11,6 +11,10 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
+ *
+ * The ATXP1 can reside on I2C addresses 0x37 or 0x4e. The chip is
+ * not auto-detected by the driver and must be instantiated explicitly.
+ * See Documentation/i2c/instantiating-devices for more information.
  */
 
 #include <linux/kernel.h>
@@ -38,8 +42,6 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 #define ATXP1_VIDMASK	0x1f
 #define ATXP1_GPIO1MASK	0x0f
 
-static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
-
 struct atxp1_data {
 	struct i2c_client *client;
 	struct mutex update_lock;
@@ -254,48 +256,6 @@ static struct attribute *atxp1_attrs[] = {
 };
 ATTRIBUTE_GROUPS(atxp1);
 
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int atxp1_detect(struct i2c_client *new_client,
-			struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = new_client->adapter;
-
-	u8 temp;
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
-
-	/* Detect ATXP1, checking if vendor ID registers are all zero */
-	if (!((i2c_smbus_read_byte_data(new_client, 0x3e) = 0) &&
-	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
-	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
-	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0)))
-		return -ENODEV;
-
-	/*
-	 * No vendor ID, now checking if registers 0x10,0x11 (non-existent)
-	 * showing the same as register 0x00
-	 */
-	temp = i2c_smbus_read_byte_data(new_client, 0x00);
-
-	if (!((i2c_smbus_read_byte_data(new_client, 0x10) = temp) &&
-	      (i2c_smbus_read_byte_data(new_client, 0x11) = temp)))
-		return -ENODEV;
-
-	/* Get VRM */
-	temp = vid_which_vrm();
-
-	if ((temp != 90) && (temp != 91)) {
-		dev_err(&adapter->dev, "atxp1: Not supporting VRM %d.%d\n",
-				temp / 10, temp % 10);
-		return -ENODEV;
-	}
-
-	strlcpy(info->type, "atxp1", I2C_NAME_SIZE);
-
-	return 0;
-}
-
 static int atxp1_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
@@ -309,6 +269,11 @@ static int atxp1_probe(struct i2c_client *client,
 
 	/* Get VRM */
 	data->vrm = vid_which_vrm();
+	if (data->vrm != 90 && data->vrm != 91) {
+		 dev_err(&adapter->dev, "atxp1: Not supporting VRM %d.%d\n",
+			 data->vrm / 10, data->vrm % 10);
+		 return -ENODEV;
+	}
 
 	data->client = client;
 	mutex_init(&data->update_lock);
@@ -337,8 +302,6 @@ static struct i2c_driver atxp1_driver = {
 	},
 	.probe		= atxp1_probe,
 	.id_table	= atxp1_id,
-	.detect		= atxp1_detect,
-	.address_list	= normal_i2c,
 };
 
 module_i2c_driver(atxp1_driver);
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
