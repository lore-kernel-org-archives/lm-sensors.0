From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 25 Oct 2005 22:49:27 +0000
Subject: [lm-sensors] [Ticket #2078] sensor values are sometimes wrong
Message-Id: <435E9A4A.2040503@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051021083606.GB19748@westend.com>
In-Reply-To: <20051021083606.GB19748@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> There are no related syslog messages and I'm not aware of any other
> application using the i2c bus. There's no TV card in this server, are
> there other likely candidates?

OK,

This ASB100 chip was reverse engineered it is very hard to support such chip. We can try last thing. Please apply patch from attachment to asb100.c

It should retry the reading when failed. I hope you know C, please fix the typos in code if any. If not just post the errors back to the list. I'm very busy nowdays so I'm
sorry I cant test it...

Please let it run with the patch for some time, ideally until you see strange values. Check the system log for details. It might happen that we wont see
any problems because this patch solved them :) In this case please change dev_dbg to dev_err and we will see.

I hope this helps,

regards
Rudolf
-------------- next part --------------
diff -Naur a/asb100.c b/asb100.c
--- a/asb100.c	2005-10-20 08:23:05.000000000 +0200
+++ b/asb100.c	2005-10-25 22:44:53.352492250 +0200
@@ -880,6 +880,54 @@
 	return 0;
 }
 
+#define MAX_RETRIES 30
+static int do_read_8(struct i2c_client *client, u8 reg, u8 defval)
+{
+	int value, i;
+
+	/* Frequent read errors have been reported on Asus boards, so we
+	 * retry on read errors. If it still fails (unlikely), return the
+	 * default value requested by the caller. */
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_byte_data(client, reg);
+		if (value >= 0) {
+			dev_dbg(&client->dev, "Read 0x%02x from register "
+				"0x%02x.\n", value, reg);
+			return value;
+		}
+		dev_dbg(&client->dev, "Read failed, will retry in %d.\n", i);
+		msleep(i);
+	}
+
+	dev_err(&client->dev, "Couldn't read value from register 0x%02x. "
+		"Please report.\n", reg);
+	return defval;
+}
+
+static int do_read_16(struct i2c_client *client, u16 reg, u8 defval)
+{
+	int value, i;
+
+	/* Frequent read errors have been reported on Asus boards, so we
+	 * retry on read errors. If it still fails (unlikely), return the
+	 * default value requested by the caller. */
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		value = i2c_smbus_read_word_data(client, reg);
+		if (value >= 0) {
+			dev_dbg(&client->dev, "Read 0x%02x from register "
+				"0x%02x.\n", value, reg);
+			return value;
+		}
+		dev_dbg(&client->dev, "Read failed, will retry in %d.\n", i);
+		msleep(i);
+	}
+
+	dev_err(&client->dev, "Couldn't read value from register 0x%02x. "
+		"Please report.\n", reg);
+	return defval;
+}
+
+
 /* The SMBus locks itself, usually, but nothing may access the chip between
    bank switches. */
 static int asb100_read_value(struct i2c_client *client, u16 reg)
@@ -896,7 +944,7 @@
 		i2c_smbus_write_byte_data(client, ASB100_REG_BANK, bank);
 
 	if (bank = 0 || bank > 2) {
-		res = i2c_smbus_read_byte_data(client, reg & 0xff);
+		res = do_read_8(client, reg & 0xff,0x0);
 	} else {
 		/* switch to subclient */
 		cl = data->lm75[bank - 1];
@@ -904,17 +952,17 @@
 		/* convert from ISA to LM75 I2C addresses */
 		switch (reg & 0xff) {
 		case 0x50: /* TEMP */
-			res = swab16(i2c_smbus_read_word_data (cl, 0));
+			res = swab16(do_read_16(cl, 0,0x0));
 			break;
 		case 0x52: /* CONFIG */
-			res = i2c_smbus_read_byte_data(cl, 1);
+			res = do_read_8(cl, 1,0x0);
 			break;
 		case 0x53: /* HYST */
-			res = swab16(i2c_smbus_read_word_data (cl, 2));
+			res = swab16(do_read_16(cl, 2,0x0));
 			break;
 		case 0x55: /* MAX */
 		default:
-			res = swab16(i2c_smbus_read_word_data (cl, 3));
+			res = swab16(do_read_16 (cl, 3,0x0));
 			break;
 		}
 	}
