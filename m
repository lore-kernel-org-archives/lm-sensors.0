From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:27:08 +0000
Subject: [lm-sensors] [PATCH 03/11] hwmon: (adt7475) Improve device detection
Message-Id: <20091202162708.456f421b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Check the value of register 0x3f as part of the device detection, to
make it more robust.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 12:53:17.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 12:55:18.000000000 +0100
@@ -47,6 +47,7 @@
 
 #define REG_DEVID		0x3D
 #define REG_VENDID		0x3E
+#define REG_DEVID2		0x3F
 
 #define REG_STATUS1		0x41
 #define REG_STATUS2		0x42
@@ -1014,18 +1015,22 @@ static int adt7475_detect(struct i2c_cli
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	int vendid, devid;
+	int vendid, devid, devid2;
 	const char *name;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
 
 	vendid = adt7475_read(REG_VENDID);
-	devid = adt7475_read(REG_DEVID);
+	devid2 = adt7475_read(REG_DEVID2);
+	if (vendid != 0x41 ||		/* Analog Devices */
+	    (devid2 & 0xf8) != 0x68)
+		return -ENODEV;
 
-	if (vendid = 0x41 && devid = 0x73)
+	devid = adt7475_read(REG_DEVID);
+	if (devid = 0x73)
 		name = "adt7473";
-	else if (vendid = 0x41 && devid = 0x75 && client->addr = 0x2e)
+	else if (devid = 0x75 && client->addr = 0x2e)
 		name = "adt7475";
 	else {
 		dev_dbg(&adapter->dev,

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
