From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:40:10 +0000
Subject: [lm-sensors] [PATCH 07/11] hwmon: (adt7475) Print device
Message-Id: <20091202164010.51327d0c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Print the device name and revision at probe time, as well as a list of
all optional features which are available.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jordan Crouse <jordan@cosmicpenguin.net>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>
---
 drivers/hwmon/adt7475.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- linux-2.6.32-rc8.orig/drivers/hwmon/adt7475.c	2009-12-02 14:31:11.000000000 +0100
+++ linux-2.6.32-rc8/drivers/hwmon/adt7475.c	2009-12-02 14:31:16.000000000 +0100
@@ -40,6 +40,8 @@
 
 /* 7475 Common Registers */
 
+#define REG_DEVREV2		0x12	/* ADT7490 only */
+
 #define REG_VTT			0x1E	/* ADT7490 only */
 #define REG_EXTEND3		0x1F	/* ADT7490 only */
 
@@ -1149,6 +1151,12 @@ static void adt7475_remove_files(struct
 static int adt7475_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	static const char *names[] = {
+		[adt7473] = "ADT7473",
+		[adt7475] = "ADT7475",
+		[adt7490] = "ADT7490",
+	};
+
 	struct adt7475_data *data;
 	int i, ret = 0, revision;
 	u8 config3;
@@ -1165,6 +1173,8 @@ static int adt7475_probe(struct i2c_clie
 	case adt7490:
 		data->has_voltage = 0x3e;	/* in1 to in5 */
 		revision = adt7475_read(REG_DEVID2) & 0x03;
+		if (revision = 0x03)
+			revision += adt7475_read(REG_DEVREV2);
 		break;
 	default:
 		data->has_voltage = 0x06;	/* in1, in2 */
@@ -1234,6 +1244,14 @@ static int adt7475_probe(struct i2c_clie
 		goto eremove;
 	}
 
+	dev_info(&client->dev, "%s device, revision %d\n",
+		 names[id->driver_data], revision);
+	if ((data->has_voltage & (1 << 0)) || data->has_fan4 || data->has_pwm2)
+		dev_info(&client->dev, "Optional features:%s%s%s\n",
+			 (data->has_voltage & (1 << 0)) ? " in0" : "",
+			 data->has_fan4 ? " fan4" : "",
+			 data->has_pwm2 ? " pwm2" : "");
+
 	return 0;
 
 eremove:

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
