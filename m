From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:04 +0000
Subject: [lm-sensors] [PATCH 02/39] hwmon: (abitguru3) Fix checkpatch issues
Message-Id: <1326703781-14272-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: do not use assignment in if condition
ERROR: "foo* bar" should be "foo *bar"
WARNING: line over 80 characters

Not fixed:
WARNING: msleep < 20ms can sleep for up to 20ms

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru3.c |   56 +++++++++++++++++++++++++++----------------
 1 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index d30855a..172377f 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -80,7 +80,8 @@
 #define ABIT_UGURU3_MAX_NO_SENSORS 26
 /* sum of strlen +1 of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
    in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0, in??_label\0 */
-#define ABIT_UGURU3_IN_NAMES_LENGTH (11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14 + 11)
+#define ABIT_UGURU3_IN_NAMES_LENGTH \
+				(11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14 + 11)
 /* sum of strlen +1 of: temp??_input\0, temp??_max\0, temp??_crit\0,
    temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0,
    temp??_label\0 */
@@ -112,7 +113,7 @@
 
 /* Structures */
 struct abituguru3_sensor_info {
-	const char* name;
+	const char *name;
 	int port;
 	int type;
 	int multiplier;
@@ -659,34 +660,39 @@ static int abituguru3_synchronize(struct abituguru3_data *data)
 {
 	int x, timeout = ABIT_UGURU3_SYNCHRONIZE_TIMEOUT;
 
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("synchronize timeout during initial busy "
 			"wait, status: 0x%02x\n", x);
 		return -EIO;
 	}
 
 	outb(0x20, data->addr + ABIT_UGURU3_DATA);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("synchronize timeout after sending 0x20, "
 			"status: 0x%02x\n", x);
 		return -EIO;
 	}
 
 	outb(0x10, data->addr + ABIT_UGURU3_CMD);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("synchronize timeout after sending 0x10, "
 			"status: 0x%02x\n", x);
 		return -EIO;
 	}
 
 	outb(0x00, data->addr + ABIT_UGURU3_CMD);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("synchronize timeout after sending 0x00, "
 			"status: 0x%02x\n", x);
 		return -EIO;
 	}
 
-	if ((x = abituguru3_wait_for_read(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_for_read(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("synchronize timeout waiting for read, "
 			"status: 0x%02x\n", x);
 		return -EIO;
@@ -712,11 +718,13 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 {
 	int i, x;
 
-	if ((x = abituguru3_synchronize(data)))
+	x = abituguru3_synchronize(data);
+	if (x)
 		return x;
 
 	outb(0x1A, data->addr + ABIT_UGURU3_DATA);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("read from 0x%02x:0x%02x timed out after "
 			"sending 0x1A, status: 0x%02x\n", (unsigned int)bank,
 			(unsigned int)offset, x);
@@ -724,7 +732,8 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 	}
 
 	outb(bank, data->addr + ABIT_UGURU3_CMD);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("read from 0x%02x:0x%02x timed out after "
 			"sending the bank, status: 0x%02x\n",
 			(unsigned int)bank, (unsigned int)offset, x);
@@ -732,7 +741,8 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 	}
 
 	outb(offset, data->addr + ABIT_UGURU3_CMD);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("read from 0x%02x:0x%02x timed out after "
 			"sending the offset, status: 0x%02x\n",
 			(unsigned int)bank, (unsigned int)offset, x);
@@ -740,7 +750,8 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 	}
 
 	outb(count, data->addr + ABIT_UGURU3_CMD);
-	if ((x = abituguru3_wait_while_busy(data)) != ABIT_UGURU3_SUCCESS) {
+	x = abituguru3_wait_while_busy(data);
+	if (x != ABIT_UGURU3_SUCCESS) {
 		ABIT_UGURU3_DEBUG("read from 0x%02x:0x%02x timed out after "
 			"sending the count, status: 0x%02x\n",
 			(unsigned int)bank, (unsigned int)offset, x);
@@ -748,8 +759,8 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 	}
 
 	for (i = 0; i < count; i++) {
-		if ((x = abituguru3_wait_for_read(data)) !-				ABIT_UGURU3_SUCCESS) {
+		x = abituguru3_wait_for_read(data);
+		if (x != ABIT_UGURU3_SUCCESS) {
 			ABIT_UGURU3_DEBUG("timeout reading byte %d from "
 				"0x%02x:0x%02x, status: 0x%02x\n", i,
 				(unsigned int)bank, (unsigned int)offset, x);
@@ -768,13 +779,15 @@ static int abituguru3_read_increment_offset(struct abituguru3_data *data,
 {
 	int i, x;
 
-	for (i = 0; i < offset_count; i++)
-		if ((x = abituguru3_read(data, bank, offset + i, count,
-				buf + i * count)) != count) {
+	for (i = 0; i < offset_count; i++) {
+		x = abituguru3_read(data, bank, offset + i, count,
+				    buf + i * count);
+		if (x != count) {
 			if (x < 0)
 				return x;
 			return i * count + x;
 		}
+	}
 
 	return i * count;
 }
@@ -923,7 +936,8 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
 	u8 buf[2];
 	u16 id;
 
-	if (!(data = kzalloc(sizeof(struct abituguru3_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct abituguru3_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
@@ -931,10 +945,10 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, data);
 
 	/* Read the motherboard ID */
-	if ((i = abituguru3_read(data, ABIT_UGURU3_MISC_BANK,
-			ABIT_UGURU3_BOARD_ID, 2, buf)) != 2) {
+	i = abituguru3_read(data, ABIT_UGURU3_MISC_BANK, ABIT_UGURU3_BOARD_ID,
+			    2, buf);
+	if (i != 2)
 		goto abituguru3_probe_error;
-	}
 
 	/* Completely read the uGuru to see if one really is there */
 	if (!abituguru3_update_device(&pdev->dev))
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
