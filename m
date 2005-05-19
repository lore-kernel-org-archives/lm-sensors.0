From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040111205346.6182c330.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a patch to the eeprom driver in 2.6.1 that changes the way Vaio
eeproms are handled. In 2.6.1, the eeprom is readable only by root,
which isn't consistent with the 2.4 driver which simple hides (i.e.
fills it with zeroes) the first row (16 bytes) of the eeprom to regular
users.

The patch restores a similar behaviour in the 2.6 driver. Greg, feel
free to apply it if you like it.

I'd also have a remark. In the 2.4 driver I had divided the driver into
arbitrary slices (32 bytes each) in order to improve sensors'
responsiveness. As the driver was ported to 2.6, it was dicussed wether
such an optimization would be possible, since the whole eeprom is now
exported as a single file. Our conclusion back to that time was that the
optimization wasn't possible anymore. But now that I saw the actual
code, it seems clear to me that it is. The eeprom_read fuction can
return any part of the file that is requested, not necessarily the whole
file. So the same mechanism used in the 2.4 driver could be added to the
2.6 driver. Two questions then:

1* Would the current 2.6 tweaks in libsensors let sensors take any
benefit of it?

2* Such a trick makes the driver a little bigger (more internal vars,
more code), and slightly slower in the case you really want to read the
whole file. The step was taken for 2.4, will we do the same for 2.6?

Comments welcome.

--- linux-2.6.1/drivers/i2c/chips/eeprom.c	Thu Dec 18 03:58:40 2003
+++ linux-2.6.1-k1/drivers/i2c/chips/eeprom.c	Sun Jan 11 20:05:13 2004
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sched.h> /* for capable() */
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 
@@ -62,6 +63,7 @@
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	u8 data[EEPROM_SIZE];		/* Register values */
+	enum eeprom_nature nature;
 };
 
 
@@ -127,7 +129,16 @@
 	if (off + count > EEPROM_SIZE)
 		count = EEPROM_SIZE - off;
 
-	memcpy(buf, &data->data[off], count);
+	/* Hide Vaio security settings to regular users (16 first bytes) */
+	if (data->nature = VAIO && off < 16 && !capable(CAP_SYS_ADMIN)) {
+		int in_row1 = 16 - off;
+		memset(buf, 0, in_row1);
+		if (count - in_row1 > 0)
+			memcpy(buf + in_row1, &data->data[16], count - in_row1);
+	} else {
+		memcpy(buf, &data->data[off], count);
+	}
+
 	return count;
 }
 
@@ -151,7 +162,6 @@
 	int i, cs;
 	struct i2c_client *new_client;
 	struct eeprom_data *data;
-	enum eeprom_nature nature = UNKNOWN;
 	int err = 0;
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
@@ -199,6 +209,7 @@
 			goto exit_kfree;
 	}
 
+	data->nature = UNKNOWN;
 	/* Detect the Vaio nature of EEPROMs.
 	   We use the "PCG-" prefix as the signature. */
 	if (address = 0x57) {
@@ -206,17 +217,7 @@
 		    i2c_smbus_read_byte_data(new_client, 0x81) = 'C' && 
 		    i2c_smbus_read_byte_data(new_client, 0x82) = 'G' &&
 		    i2c_smbus_read_byte_data(new_client, 0x83) = '-')
-			nature = VAIO;
-	}
-
-	/* If this is a VIAO, then we only allow root to read from this file,
-	   as BIOS passwords can be present here in plaintext */
-	switch (nature) {
- 	case VAIO:
-		eeprom_attr.attr.mode = S_IRUSR;
-		break;
-	default:
-		eeprom_attr.attr.mode = S_IRUGO;
+			data->nature = VAIO;
 	}
 
 	/* Fill in the remaining client fields */


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
