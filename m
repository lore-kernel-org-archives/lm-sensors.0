From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Jun 2005 23:43:29 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: drop bogus eeprom comment
Message-Id: <20050623234300.345056cb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This simple patch drops an out-of-date comment in the eeprom i2c chip
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/eeprom.c |    3 ---
 1 files changed, 3 deletions(-)

--- linux-2.6.12-git5.orig/drivers/i2c/chips/eeprom.c	2005-06-23 21:32:01.000000000 +0200
+++ linux-2.6.12-git5/drivers/i2c/chips/eeprom.c	2005-06-23 23:38:56.000000000 +0200
@@ -173,9 +173,6 @@
 					    | I2C_FUNC_SMBUS_BYTE))
 		goto exit;
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access eeprom_{read,write}_value. */
 	if (!(data = kmalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;


-- 
Jean Delvare
