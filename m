From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:45 +0000
Subject: [lm-sensors] [PATCH 51/82] hwmon: (pc87360) Fix multi-line comments
Message-Id: <1327017376-20466-52-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pc87360.c |   73 +++++++++++++++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 51c97ca..7f95761 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -531,9 +531,11 @@ static struct sensor_device_attribute in_max[] = {
 #define CHAN_ALM_MAX	0x04	/* max limit exceeded */
 #define TEMP_ALM_CRIT	0x08	/* temp crit exceeded (temp only) */
 
-/* show_in_min/max_alarm() reads data from the per-channel status
-   register (sec 11.5.12), not the vin event status registers (sec
-   11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms) */
+/*
+ * show_in_min/max_alarm() reads data from the per-channel status
+ * register (sec 11.5.12), not the vin event status registers (sec
+ * 11.5.2) that (legacy) show_in_alarm() resds (via data->in_alarms)
+ */
 
 static ssize_t show_in_min_alarm(struct device *dev,
 			struct device_attribute *devattr, char *buf)
@@ -748,9 +750,10 @@ static ssize_t set_therm_crit(struct device *dev,
 	return count;
 }
 
-/* the +11 term below reflects the fact that VLM units 11,12,13 are
-   used in the chip to measure voltage across the thermistors
-*/
+/*
+ * the +11 term below reflects the fact that VLM units 11,12,13 are
+ * used in the chip to measure voltage across the thermistors
+ */
 static struct sensor_device_attribute therm_input[] = {
 	SENSOR_ATTR(temp4_input, S_IRUGO, show_therm_input, NULL, 0 + 11),
 	SENSOR_ATTR(temp5_input, S_IRUGO, show_therm_input, NULL, 1 + 11),
@@ -786,8 +789,10 @@ static struct sensor_device_attribute therm_crit[] = {
 		    show_therm_crit, set_therm_crit, 2 + 11),
 };
 
-/* show_therm_min/max_alarm() reads data from the per-channel voltage
-   status register (sec 11.5.12) */
+/*
+ * show_therm_min/max_alarm() reads data from the per-channel voltage
+ * status register (sec 11.5.12)
+ */
 
 static ssize_t show_therm_min_alarm(struct device *dev,
 				struct device_attribute *devattr, char *buf)
@@ -1007,9 +1012,11 @@ static ssize_t show_temp_alarms(struct device *dev,
 
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
 
-/* show_temp_min/max_alarm() reads data from the per-channel status
-   register (sec 12.3.7), not the temp event status registers (sec
-   12.3.2) that show_temp_alarm() reads (via data->temp_alarms) */
+/*
+ * show_temp_min/max_alarm() reads data from the per-channel status
+ * register (sec 12.3.7), not the temp event status registers (sec
+ * 12.3.2) that show_temp_alarm() reads (via data->temp_alarms)
+ */
 
 static ssize_t show_temp_min_alarm(struct device *dev,
 			struct device_attribute *devattr, char *buf)
@@ -1172,9 +1179,11 @@ static int __init pc87360_find(int sioaddr, u8 *devid,
 		} else if (i = 1) { /* Voltages */
 			/* Are we using thermistors? */
 			if (*devid = 0xE9) { /* PC87366 */
-				/* These registers are not logical-device
-				   specific, just that we won't need them if
-				   we don't use the VLM device */
+				/*
+				 * These registers are not logical-device
+				 * specific, just that we won't need them if
+				 * we don't use the VLM device
+				 */
 				confreg[2] = superio_inb(sioaddr, 0x2B);
 				confreg[3] = superio_inb(sioaddr, 0x25);
 
@@ -1258,9 +1267,11 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	if (data->fannr)
 		data->fan_conf = confreg[0] | (confreg[1] << 8);
 
-	/* Use the correct reference voltage
-	   Unless both the VLM and the TMS logical devices agree to
-	   use an external Vref, the internal one is used. */
+	/*
+	 * Use the correct reference voltage
+	 * Unless both the VLM and the TMS logical devices agree to
+	 * use an external Vref, the internal one is used.
+	 */
 	if (data->innr) {
 		i = pc87360_read_value(data, LD_IN, NO_BANK,
 				       PC87365_REG_IN_CONFIG);
@@ -1402,8 +1413,10 @@ static int __devexit pc87360_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/* ldi is the logical device index
-   bank is for voltages and temperatures only */
+/*
+ * ldi is the logical device index
+ * bank is for voltages and temperatures only
+ */
 static int pc87360_read_value(struct pc87360_data *data, u8 ldi, u8 bank,
 			      u8 reg)
 {
@@ -1474,8 +1487,10 @@ static void pc87360_init_device(struct platform_device *pdev,
 		}
 	}
 
-	/* We can't blindly trust the Super-I/O space configuration bit,
-	   most BIOS won't set it properly */
+	/*
+	 * We can't blindly trust the Super-I/O space configuration bit,
+	 * most BIOS won't set it properly
+	 */
 	dev_dbg(&pdev->dev, "bios thermistors:%d\n", use_thermistors);
 	for (i = 11; i < data->innr; i++) {
 		reg = pc87360_read_value(data, LD_IN, i,
@@ -1506,8 +1521,10 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (use_thermistors) {
 		for (i = 11; i < data->innr; i++) {
 			if (init >= init_in[i]) {
-				/* The pin may already be used by thermal
-				   diodes */
+				/*
+				 * The pin may already be used by thermal
+				 * diodes
+				 */
 				reg = pc87360_read_value(data, LD_TEMP,
 				      (i - 11) / 2, PC87365_REG_TEMP_STATUS);
 				if (reg & CHAN_ENA) {
@@ -1560,10 +1577,12 @@ static void pc87360_init_device(struct platform_device *pdev,
 		if (init >= 2) {
 			/* Chip config as documented by National Semi. */
 			pc87360_write_value(data, LD_TEMP, 0xF, 0xA, 0x08);
-			/* We voluntarily omit the bank here, in case the
-			   sequence itself matters. It shouldn't be a problem,
-			   since nobody else is supposed to access the
-			   device at that point. */
+			/*
+			 * We voluntarily omit the bank here, in case the
+			 * sequence itself matters. It shouldn't be a problem,
+			 * since nobody else is supposed to access the
+			 * device at that point.
+			 */
 			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xB, 0x04);
 			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xC, 0x35);
 			pc87360_write_value(data, LD_TEMP, NO_BANK, 0xD, 0x05);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
