From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Wed, 16 Apr 2008 11:34:09 +0000
Subject: [lm-sensors] [PATCH] lm75: Fix lm75a detection
Message-Id: <200804161334.10533.laurentp@cse-semaphore.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philips LM75A temperature sensors don't pass the current detection check
as they return 0xffff when reading unimplemented registers instead of the
last read value. This patch modifies device detection to accept 0xffff as
valid values when reading registers 0x04-0x07.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 drivers/hwmon/lm75.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 115f409..d7a22a5 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -159,28 +159,29 @@ static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 	/* Now, we do the remaining detection. There is no identification-
 	   dedicated register so we have to rely on several tricks:
 	   unused bits, registers cycling over 8-address boundaries,
-	   addresses 0x04-0x07 returning the last read value.
+	   addresses 0x04-0x07 returning the last read value (LM75) or
+	   0xffff (Philips LM75A).
 	   The cycling+unused addresses combination is not tested,
 	   since it would significantly slow the detection down and would
 	   hardly add any value. */
 	if (kind < 0) {
-		int cur, conf, hyst, os;
+		int cur, conf, hyst, os, na;
 
 		/* Unused addresses */
 		cur = i2c_smbus_read_word_data(new_client, 0);
 		conf = i2c_smbus_read_byte_data(new_client, 1);
 		hyst = i2c_smbus_read_word_data(new_client, 2);
-		if (i2c_smbus_read_word_data(new_client, 4) != hyst
-		 || i2c_smbus_read_word_data(new_client, 5) != hyst
-		 || i2c_smbus_read_word_data(new_client, 6) != hyst
-		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
-		 	goto exit_free;
+		for (i = 4; i < 8; ++i) {
+			na = i2c_smbus_read_word_data(new_client, i);
+			if (na != hyst && na != 0xffff)
+				goto exit_free;
+		}
 		os = i2c_smbus_read_word_data(new_client, 3);
-		if (i2c_smbus_read_word_data(new_client, 4) != os
-		 || i2c_smbus_read_word_data(new_client, 5) != os
-		 || i2c_smbus_read_word_data(new_client, 6) != os
-		 || i2c_smbus_read_word_data(new_client, 7) != os)
-		 	goto exit_free;
+		for (i = 4; i < 8; ++i) {
+			na = i2c_smbus_read_word_data(new_client, i);
+			if (na != os && na != 0xffff)
+				goto exit_free;
+		}
 
 		/* Unused bits */
 		if (conf & 0xe0)
-- 
1.5.0

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
