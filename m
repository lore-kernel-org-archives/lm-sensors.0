From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567643883@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567633966@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.16, 2004/01/15 17:28:54-08:00, khali@linux-fr.org

[PATCH] I2C: restore correct vaio handling in eeprom driver

Here is a patch to the eeprom driver in 2.6.1 that changes the way Vaio
eeproms are handled. In 2.6.1, the eeprom is readable only by root,
which isn't consistent with the 2.4 driver which simple hides (i.e.
fills it with zeroes) the first row (16 bytes) of the eeprom to regular
users.

The patch restores a similar behaviour in the 2.6 driver.


 drivers/i2c/chips/eeprom.c |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Mon Jan 19 15:30:17 2004
+++ b/drivers/i2c/chips/eeprom.c	Mon Jan 19 15:30:17 2004
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
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

