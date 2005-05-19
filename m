From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: Fix Vaio EEPROM detection
Message-Id: <1112311393634@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <111231139374@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2339, 2005/03/31 14:29:23-08:00, khali@linux-fr.org

[PATCH] I2C: Fix Vaio EEPROM detection

This fixes a bug in the eeprom driver, which made all EEPROMs at
location 0x57 be erroneously treated as Vaio EEPROMs. I have to say I'm
quite ashamed that I introduced the bug in the first place, as this was
a really stupid one.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/eeprom.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	2005-03-31 15:17:18 -08:00
+++ b/drivers/i2c/chips/eeprom.c	2005-03-31 15:17:18 -08:00
@@ -210,10 +210,11 @@
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

