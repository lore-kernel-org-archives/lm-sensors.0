From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 10 Dec 2010 14:06:54 +0000
Subject: [lm-sensors] [PATCH] emc1403: added emc1423 support
Message-Id: <20101210140650.30747.50537.stgit@bob.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101210101036.12174.79352.stgit@bob.linux.org.uk>
In-Reply-To: <20101210101036.12174.79352.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jekyll Lai <jekyll_lai@wistron.com>

emc1423 uses the similar register and adds a hardware shutdown pin to
protect exceed temperature. This function is set by resistor; it's not
necessary to do anything in the driver except add the emc1423 pid of 0x23.

Signed-off-by: Jekyll Lai <jekyll_lai@wistron.com>
[Updated Kconfig/comments and minor further changes asked for by the hwmon
 maintainers]
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/hwmon/Kconfig   |    4 ++--
 drivers/hwmon/emc1403.c |   22 ++++++++++++++--------
 2 files changed, 16 insertions(+), 10 deletions(-)


diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e5bdf24..a740f29 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -789,10 +789,10 @@ config SENSORS_DME1737
 	  will be called dme1737.
 
 config SENSORS_EMC1403
-	tristate "SMSC EMC1403 thermal sensor"
+	tristate "SMSC EMC1403/23 thermal sensor"
 	depends on I2C
 	help
-	  If you say yes here you get support for the SMSC EMC1403
+	  If you say yes here you get support for the SMSC EMC1403/23
 	  temperature monitoring chip.
 
 	  Threshold values can be configured using sysfs.
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 8dee3f3..76eeb6c 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -269,23 +269,28 @@ static int emc1403_detect(struct i2c_client *client,
 			struct i2c_board_info *info)
 {
 	int id;
-	/* Check if thermal chip is SMSC and EMC1403 */
+	/* Check if thermal chip is SMSC and EMC1403 or EMC1423 */
 
 	id = i2c_smbus_read_byte_data(client, THERMAL_SMSC_ID_REG);
 	if (id != 0x5d)
 		return -ENODEV;
 
-	/* Note: 0x25 is the 1404 which is very similar and this
-	   driver could be extended */
 	id = i2c_smbus_read_byte_data(client, THERMAL_PID_REG);
-	if (id != 0x21)
-		return -ENODEV;
-
+	switch (id) {
+		case 0x21:
+			strlcpy(info->type, "emc1403", I2C_NAME_SIZE);
+			break;
+		case 0x23:
+			strlcpy(info->type, "emc1423", I2C_NAME_SIZE);
+			break;
+		/* Note: 0x25 is the 1404 which is very similar and this
+		   driver could be extended */
+		default:
+			return -ENODEV;
+	}
 	id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);
 	if (id != 0x01)
 		return -ENODEV;
-
-	strlcpy(info->type, "emc1403", I2C_NAME_SIZE);
 	return 0;
 }
 
@@ -342,6 +347,7 @@ static const unsigned short emc1403_address_list[] = {
 
 static const struct i2c_device_id emc1403_idtable[] = {
 	{ "emc1403", 0 },
+	{ "emc1423", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, emc1403_idtable);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
