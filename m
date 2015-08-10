From: yalin wang <yalin.wang2010@gmail.com>
Date: Mon, 10 Aug 2015 14:41:43 +0000
Subject: [lm-sensors] [PATCH] hwmon:change sht15_reverse()
Message-Id: <3ED35BB5-7173-4149-885B-0FEB0596743C@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.com, linux@roeck-us.net, lm-sensors@lm-sensors.org, open list <linux-kernel@vger.kernel.org>


This change sht15_reverse() to be generic bitrev8().

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/hwmon/sht15.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 497a7f8..a2fdbb7 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -33,6 +33,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
+#include <linux/bitrev.h>
 
 /* Commands */
 #define SHT15_MEASURE_TEMP		0x03
@@ -173,19 +174,6 @@ struct sht15_data {
 };
 
 /**
- * sht15_reverse() - reverse a byte
- * @byte:    byte to reverse.
- */
-static u8 sht15_reverse(u8 byte)
-{
-	u8 i, c;
-
-	for (c = 0, i = 0; i < 8; i++)
-		c |= (!!(byte & (1 << i))) << (7 - i);
-	return c;
-}
-
-/**
  * sht15_crc8() - compute crc8
  * @data:	sht15 specific data.
  * @value:	sht15 retrieved data.
@@ -196,7 +184,7 @@ static u8 sht15_crc8(struct sht15_data *data,
 		const u8 *value,
 		int len)
 {
-	u8 crc = sht15_reverse(data->val_status & 0x0F);
+	u8 crc = bitrev8(data->val_status & 0x0F);
 
 	while (len--) {
 		crc = sht15_crc8_table[*value ^ crc];
@@ -477,7 +465,7 @@ static int sht15_update_status(struct sht15_data *data)
 
 		if (data->checksumming) {
 			sht15_ack(data);
-			dev_checksum = sht15_reverse(sht15_read_byte(data));
+			dev_checksum = bitrev8(sht15_read_byte(data));
 			checksum_vals[0] = SHT15_READ_STATUS;
 			checksum_vals[1] = status;
 			data->checksum_ok = (sht15_crc8(data, checksum_vals, 2)
@@ -864,7 +852,7 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 		 */
 		if (sht15_ack(data))
 			goto wakeup;
-		dev_checksum = sht15_reverse(sht15_read_byte(data));
+		dev_checksum = bitrev8(sht15_read_byte(data));
 		checksum_vals[0] = (data->state = SHT15_READING_TEMP) ?
 			SHT15_MEASURE_TEMP : SHT15_MEASURE_RH;
 		checksum_vals[1] = (u8) (val >> 8);
-- 
1.9.1

yalin@ubuntu:~/linux-next$ 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
