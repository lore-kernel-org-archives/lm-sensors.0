From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Remove checksum code in eeprom driver
Message-Id: <20041219201934.511ace3e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

As a follow-up to my earlier proposal to remove the checksum code from
the i2c eeprom driver, here is a patch that does just that. This shrinks
the driver size by around 5%, and paves the way for further fixes and
cleanups.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/i2c/chips/eeprom.c.orig	2004-12-05 17:33:04.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/eeprom.c	2004-12-19 19:57:19.000000000 +0100
@@ -43,13 +43,6 @@
 /* Insmod parameters */
 SENSORS_INSMOD_1(eeprom);
 
-static int checksum = 0;
-module_param(checksum, bool, 0);
-MODULE_PARM_DESC(checksum, "Only accept eeproms whose checksum is correct");
-
-
-/* EEPROM registers */
-#define EEPROM_REG_CHECKSUM	0x3f
 
 /* Size of EEPROM in bytes */
 #define EEPROM_SIZE		256
@@ -168,7 +161,6 @@
 /* This function is called by i2c_detect */
 int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	int i, cs;
 	struct i2c_client *new_client;
 	struct eeprom_data *data;
 	int err = 0;
@@ -205,17 +197,6 @@
 	/* prevent 24RF08 corruption */
 	i2c_smbus_write_quick(new_client, 0);
 
-	/* Now, we do the remaining detection. It is not there, unless you force
-	   the checksum to work out. */
-	if (checksum) {
-		cs = 0;
-		for (i = 0; i <= 0x3e; i++)
-			cs += i2c_smbus_read_byte_data(new_client, i);
-		cs &= 0xff;
-		if (i2c_smbus_read_byte_data (new_client, EEPROM_REG_CHECKSUM) != cs)
-			goto exit_kfree;
-	}
-
 	data->nature = UNKNOWN;
 	/* Detect the Vaio nature of EEPROMs.
 	   We use the "PCG-" prefix as the signature. */


-- 
Jean Delvare
http://khali.linux-fr.org/
