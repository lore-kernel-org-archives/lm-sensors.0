From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:36 +0000
Subject: [lm-sensors] [PATCH 42/82] hwmon: (lm92) Fix multi-line comments
Message-Id: <1327017376-20466-43-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm92.c |   46 ++++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index 95cda41..cf3894b 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -49,8 +49,10 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 
-/* The LM92 and MAX6635 have 2 two-state pins for address selection,
-   resulting in 4 possible addresses. */
+/*
+ * The LM92 and MAX6635 have 2 two-state pins for address selection,
+ * resulting in 4 possible addresses.
+ */
 static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 						I2C_CLIENT_END };
 
@@ -63,11 +65,13 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 #define LM92_REG_TEMP_HIGH		0x05 /* 16-bit, RW */
 #define LM92_REG_MAN_ID			0x07 /* 16-bit, RO, LM92 only */
 
-/* The LM92 uses signed 13-bit values with LSB = 0.0625 degree Celsius,
-   left-justified in 16-bit registers. No rounding is done, with such
-   a resolution it's just not worth it. Note that the MAX6635 doesn't
-   make use of the 4 lower bits for limits (i.e. effective resolution
-   for limits is 1 degree Celsius). */
+/*
+ * The LM92 uses signed 13-bit values with LSB = 0.0625 degree Celsius,
+ * left-justified in 16-bit registers. No rounding is done, with such
+ * a resolution it's just not worth it. Note that the MAX6635 doesn't
+ * make use of the 4 lower bits for limits (i.e. effective resolution
+ * for limits is 1 degree Celsius).
+ */
 static inline int TEMP_FROM_REG(s16 reg)
 {
 	return reg / 8 * 625 / 10;
@@ -261,19 +265,23 @@ static void lm92_init_client(struct i2c_client *client)
 					  config & 0xFE);
 }
 
-/* The MAX6635 has no identification register, so we have to use tricks
-   to identify it reliably. This is somewhat slow.
-   Note that we do NOT rely on the 2 MSB of the configuration register
-   always reading 0, as suggested by the datasheet, because it was once
-   reported not to be true. */
+/*
+ * The MAX6635 has no identification register, so we have to use tricks
+ * to identify it reliably. This is somewhat slow.
+ * Note that we do NOT rely on the 2 MSB of the configuration register
+ * always reading 0, as suggested by the datasheet, because it was once
+ * reported not to be true.
+ */
 static int max6635_check(struct i2c_client *client)
 {
 	u16 temp_low, temp_high, temp_hyst, temp_crit;
 	u8 conf;
 	int i;
 
-	/* No manufacturer ID register, so a read from this address will
-	   always return the last read value. */
+	/*
+	 * No manufacturer ID register, so a read from this address will
+	 * always return the last read value.
+	 */
 	temp_low = i2c_smbus_read_word_data(client, LM92_REG_TEMP_LOW);
 	if (i2c_smbus_read_word_data(client, LM92_REG_MAN_ID) != temp_low)
 		return 0;
@@ -289,10 +297,12 @@ static int max6635_check(struct i2c_client *client)
 	if ((temp_hyst & 0x7f00) || (temp_crit & 0x7f00))
 		return 0;
 
-	/* Registers addresses were found to cycle over 16-byte boundaries.
-	   We don't test all registers with all offsets so as to save some
-	   reads and time, but this should still be sufficient to dismiss
-	   non-MAX6635 chips. */
+	/*
+	 * Registers addresses were found to cycle over 16-byte boundaries.
+	 * We don't test all registers with all offsets so as to save some
+	 * reads and time, but this should still be sufficient to dismiss
+	 * non-MAX6635 chips.
+	 */
 	conf = i2c_smbus_read_byte_data(client, LM92_REG_CONFIG);
 	for (i = 16; i < 96; i *= 2) {
 		if (temp_hyst != i2c_smbus_read_word_data(client,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
