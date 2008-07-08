From: Wolfgang Grandegger <wg@grandegger.com>
Date: Tue, 08 Jul 2008 09:22:36 +0000
Subject: [lm-sensors] [PATCH] Support for DS75 thermal sensor
Message-Id: <487331DC.2020601@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The existing driver for the LM75 is unable to identify a compatible DS75 
device properly. This patch from

http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018838.html 

does fix the problem and I wonder why it did not make it into the kernel yet.

Signed-off-by: Alan?
Acked-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/hwmon/lm75.c |   59 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 22 deletions(-)

Index: linux-2.6-denx/drivers/hwmon/lm75.c
=================================--- linux-2.6-denx.orig/drivers/hwmon/lm75.c
+++ linux-2.6-denx/drivers/hwmon/lm75.c
@@ -35,7 +35,7 @@ static const unsigned short normal_i2c[]
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
 
 /* Insmod parameters */
-I2C_CLIENT_INSMOD_1(lm75);
+I2C_CLIENT_INSMOD_2(lm75, ds75);
 
 /* Many LM75 constants specified below */
 
@@ -157,49 +157,64 @@ static int lm75_detect(struct i2c_adapte
 	new_client->flags = 0;
 
 	/* Now, we do the remaining detection. There is no identification-
-	   dedicated register so we have to rely on several tricks:
-	   unused bits, registers cycling over 8-address boundaries,
-	   addresses 0x04-0x07 returning the last read value.
+	   dedicated register so we have to rely on several tricks.
+	   The LM75 and DS75 share unused bits. The LM75 has registers
+	   cycling over 8-address boundaries, and addresses 0x04-0x07
+	   returning the last read value.
+	   The DS75 has addresses 0x04-0x0f returning the last read value,
+	   but does not register cycle.
 	   The cycling+unused addresses combination is not tested,
 	   since it would significantly slow the detection down and would
 	   hardly add any value. */
 	if (kind < 0) {
-		int cur, conf, hyst, os;
+		int cur, conf, hyst, os, addr;
 
 		/* Unused addresses */
 		cur = i2c_smbus_read_word_data(new_client, 0);
 		conf = i2c_smbus_read_byte_data(new_client, 1);
 		hyst = i2c_smbus_read_word_data(new_client, 2);
-		if (i2c_smbus_read_word_data(new_client, 4) != hyst
-		 || i2c_smbus_read_word_data(new_client, 5) != hyst
-		 || i2c_smbus_read_word_data(new_client, 6) != hyst
-		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
-		 	goto exit_free;
+
+		for (addr = 0x04; addr <= 0x0f; addr++)
+			if (i2c_smbus_read_word_data(new_client, addr) != hyst)
+				break;
+
+		if (addr < 0x08)
+			goto exit_free;
+		if (addr = 0x10)
+			kind = ds75;
+		else
+			kind = lm75;
+
 		os = i2c_smbus_read_word_data(new_client, 3);
-		if (i2c_smbus_read_word_data(new_client, 4) != os
-		 || i2c_smbus_read_word_data(new_client, 5) != os
-		 || i2c_smbus_read_word_data(new_client, 6) != os
-		 || i2c_smbus_read_word_data(new_client, 7) != os)
-		 	goto exit_free;
+		for (addr = 0x04; addr <= 0x0f; addr++)
+			if (i2c_smbus_read_word_data(new_client, addr) != os)
+				break;
+
+		if (addr < (kind = ds75 ? 0x10 : 0x08))
+			goto exit_free;
 
 		/* Unused bits */
 		if (conf & 0xe0)
 		 	goto exit_free;
 
-		/* Addresses cycling */
-		for (i = 8; i < 0xff; i += 8)
-			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
-			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
-			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
-				goto exit_free;
+		/* Addresses cycling - LM75 only */
+		if (kind = lm75) {
+			for (i = 8; i < 0xff; i += 8)
+				if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
+				    || i2c_smbus_read_word_data(new_client, i + 2) != hyst
+				    || i2c_smbus_read_word_data(new_client, i + 3) != os)
+					goto exit_free;
+		}
 	}
 
-	/* Determine the chip type - only one kind supported! */
 	if (kind <= 0)
 		kind = lm75;
 
+	/* Determine the chip type */
 	if (kind = lm75) {
 		name = "lm75";
+	} else if (kind = ds75) {
+		name = "ds75";
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
