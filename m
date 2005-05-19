From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: [PATCH 2.6] Incomplete AT24RF08 corruption prevention in i2c eeprom
Message-Id: <20040516191842.024a907c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The AT24RF08 corruption prevention trick that is found in the i2c eeprom
driver is not correct. The prevention is activated only conditionally,
while it should be done all the time.

Please apply,
thanks.

--- linux-2.6.6-bk2/drivers/i2c/chips/eeprom.c.orig	Sat May 15 07:52:14 2004
+++ linux-2.6.6-bk2/drivers/i2c/chips/eeprom.c	Sun May 16 19:11:11 2004
@@ -203,11 +203,12 @@
 	new_client->driver = &eeprom_driver;
 	new_client->flags = 0;
 
+	/* prevent 24RF08 corruption */
+	i2c_smbus_write_quick(new_client, 0);
+
 	/* Now, we do the remaining detection. It is not there, unless you force
 	   the checksum to work out. */
 	if (checksum) {
-		/* prevent 24RF08 corruption */
-		i2c_smbus_write_quick(new_client, 0);
 		cs = 0;
 		for (i = 0; i <= 0x3e; i++)
 			cs += i2c_smbus_read_byte_data(new_client, i);


-- 
Jean Delvare
http://khali.linux-fr.org/
