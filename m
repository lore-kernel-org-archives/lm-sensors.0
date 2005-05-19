From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: [PATCH 2.6] Fix Vaio EEPROM detection
Message-Id: <20050318191927.650a5ed3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This fixes a bug in the eeprom driver, which made all EEPROMs at
location 0x57 be erroneously treated as Vaio EEPROMs. I have to say I'm
quite ashamed that I introduced the bug in the first place, as this was
a really stupid one.

Please apply,
thanks.

Signed-off-by: Jean Delvare

--- linux-2.6.11.4/drivers/i2c/chips/eeprom.c.orig	Thu Mar 17 14:07:01 2005
+++ linux-2.6.11.4/drivers/i2c/chips/eeprom.c	Thu Mar 17 14:33:29 2005
@@ -209,10 +209,11 @@
 		if (i2c_smbus_read_byte_data(new_client, 0x80) = 'P'
 		 && i2c_smbus_read_byte(new_client) = 'C'
 		 && i2c_smbus_read_byte(new_client) = 'G'
-		 && i2c_smbus_read_byte(new_client) = '-')
+		 && i2c_smbus_read_byte(new_client) = '-') {
 			dev_info(&new_client->dev, "Vaio EEPROM detected, "
 				"enabling password protection\n");
 			data->nature = VAIO;
+		}
 	}
 
 	/* create the sysfs eeprom file */


-- 
Jean Delvare
