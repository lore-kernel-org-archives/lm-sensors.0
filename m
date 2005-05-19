From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: LM75 - detection for tmp101 (and possibly others)
Message-Id: <20050222150822.GA12746@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch adds detection for the TI TMP101, an
LM75 compatible.

The detection routines have been split out into their own
functions to aid readability, and to make the detection
code-path easier to read.

diff -urN -X ../dontdiff linux-2.6.11-rc4-bk8/drivers/i2c/chips/lm75.c linux-2.6.11-rc4-bk8-tmp101-v3/drivers/i2c/chips/lm75.c
--- linux-2.6.11-rc4-bk8/drivers/i2c/chips/lm75.c	2005-01-04 10:57:49.000000000 +0000
+++ linux-2.6.11-rc4-bk8-tmp101-v3/drivers/i2c/chips/lm75.c	2005-02-22 15:06:17.000000000 +0000
@@ -109,10 +109,116 @@
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }
 
+/* lm75_check_real()
+ *
+ * Is this chip an _real_ lm75
+*/
+
+static int lm75_check_real(struct i2c_client *new_client)
+{
+	int cur, conf, hyst, os;
+	int i;
+
+	/* Now, we do the remaining detection. There is no identification-
+	   dedicated register so we have to rely on several tricks:
+	   unused bits, registers cycling over 8-address boundaries,
+	   addresses 0x04-0x07 returning the last read value.
+	   The cycling+unused addresses combination is not tested,
+	   since it would significantly slow the detection down and would
+	   hardly add any value. */
+
+	/* Unused addresses */
+	cur = i2c_smbus_read_word_data(new_client, 0);
+	conf = i2c_smbus_read_byte_data(new_client, 1);
+	hyst = i2c_smbus_read_word_data(new_client, 2);
+
+	if (i2c_smbus_read_word_data(new_client, 4) != hyst
+	    || i2c_smbus_read_word_data(new_client, 5) != hyst
+	    || i2c_smbus_read_word_data(new_client, 6) != hyst
+	    || i2c_smbus_read_word_data(new_client, 7) != hyst)
+		goto not_lm75;
+
+	os = i2c_smbus_read_word_data(new_client, 3);
+
+	if (i2c_smbus_read_word_data(new_client, 4) != os
+	    || i2c_smbus_read_word_data(new_client, 5) != os
+	    || i2c_smbus_read_word_data(new_client, 6) != os
+	    || i2c_smbus_read_word_data(new_client, 7) != os)
+		goto not_lm75;
+
+	/* Unused bits */
+	if (conf & 0xe0)
+		goto not_lm75;
+
+	/* Addresses cycling */
+	for (i = 8; i < 0xff; i += 8)
+		if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
+		    || i2c_smbus_read_word_data(new_client, i + 2) != hyst
+		    || i2c_smbus_read_word_data(new_client, i + 3) != os)
+			goto not_lm75;
+
+	return 1;
+
+ not_lm75:
+	return 0;
+}
+
+static int lm75_check_clone(struct i2c_client *new_client)
+{
+	int cur, conf, hyst, os;
+	int i;
+
+	dev_dbg(&new_client->adapter->dev, "checking for a clone\n");
+
+	/* some of the clones have a number of slightly different behaviour
+	 * to the standard lm75, which makes them a little bit more difficult
+	 * to detect.
+	 */
+
+	cur = i2c_smbus_read_word_data(new_client, 0);
+	conf = i2c_smbus_read_byte_data(new_client, 1);
+	hyst = i2c_smbus_read_word_data(new_client, 2);	
+
+	if (i2c_smbus_read_word_data(new_client, 4) != hyst
+	    || i2c_smbus_read_word_data(new_client, 5) != hyst
+	    || i2c_smbus_read_word_data(new_client, 6) != hyst
+	    || i2c_smbus_read_word_data(new_client, 7) != hyst)
+		goto not_lm75;
+
+	os = i2c_smbus_read_word_data(new_client, 3);
+	if (i2c_smbus_read_word_data(new_client, 4) != os
+	    || i2c_smbus_read_word_data(new_client, 5) != os
+	    || i2c_smbus_read_word_data(new_client, 6) != os
+	    || i2c_smbus_read_word_data(new_client, 7) != os)
+		goto not_lm75;
+
+
+	dev_dbg(&new_client->adapter->dev, "checking aliasing\n");
+
+	/* the tmp101 seems to alias the last read value throughout the
+	 * rest of the register address space, check to see if this is
+	 * the case.
+	 *
+	 * Note, we could try all locations, but that does take a while
+	 * even with a hardware controller.
+	 */
+
+	os = i2c_smbus_read_word_data(new_client, 3);
+
+	for (i = 8; i < 0xff; i += 4) {
+		if (i2c_smbus_read_word_data(new_client, i) != os)
+			goto not_lm75;
+	}
+
+	return 1;
+
+ not_lm75:
+	return 0;
+}
+
 /* This function is called by i2c_detect */
 static int lm75_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i;
 	struct i2c_client *new_client;
 	struct lm75_data *data;
 	int err = 0;
@@ -148,48 +254,23 @@
 	new_client->driver = &lm75_driver;
 	new_client->flags = 0;
 
-	/* Now, we do the remaining detection. There is no identification-
-	   dedicated register so we have to rely on several tricks:
-	   unused bits, registers cycling over 8-address boundaries,
-	   addresses 0x04-0x07 returning the last read value.
-	   The cycling+unused addresses combination is not tested,
-	   since it would significantly slow the detection down and would
-	   hardly add any value. */
 	if (kind < 0) {
-		int cur, conf, hyst, os;
-
-		/* Unused addresses */
-		cur = i2c_smbus_read_word_data(new_client, 0);
-		conf = i2c_smbus_read_byte_data(new_client, 1);
-		hyst = i2c_smbus_read_word_data(new_client, 2);
-		if (i2c_smbus_read_word_data(new_client, 4) != hyst
-		 || i2c_smbus_read_word_data(new_client, 5) != hyst
-		 || i2c_smbus_read_word_data(new_client, 6) != hyst
-		 || i2c_smbus_read_word_data(new_client, 7) != hyst)
-		 	goto exit_free;
-		os = i2c_smbus_read_word_data(new_client, 3);
-		if (i2c_smbus_read_word_data(new_client, 4) != os
-		 || i2c_smbus_read_word_data(new_client, 5) != os
-		 || i2c_smbus_read_word_data(new_client, 6) != os
-		 || i2c_smbus_read_word_data(new_client, 7) != os)
-		 	goto exit_free;
-
-		/* Unused bits */
-		if (conf & 0xe0)
-		 	goto exit_free;
-
-		/* Addresses cycling */
-		for (i = 8; i < 0xff; i += 8)
-			if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
-			 || i2c_smbus_read_word_data(new_client, i + 2) != hyst
-			 || i2c_smbus_read_word_data(new_client, i + 3) != os)
-				goto exit_free;
+		if (lm75_check_real(new_client))
+			goto is_lm75;
+		else
+			dev_dbg(&adapter->dev, "lm75 or direct compatible\n");
+
+		if (!lm75_check_clone(new_client))
+			goto exit_free;
+		else
+			dev_dbg(&adapter->dev, "lm75 clone detected\n");
 	}
 
 	/* Determine the chip type - only one kind supported! */
 	if (kind <= 0)
 		kind = lm75;
 
+ is_lm75:
 	if (kind = lm75) {
 		name = "lm75";
 	}
