From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 25 Aug 2005 16:44:00 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Drop debug eeprom dump code in pcilynx
Message-Id: <20050825164329.5c1e71a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Jody, all,

The pcilynx driver includes code to dump the contents of an i2c eeprom
for debugging purposes. The same can be done from userspace using the
i2cdump tool (part of the lm_sensors project) instead, in a more
efficient and flexible way.

Thus I would suggest that this functionality be simply dropped from the
pcilynx driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/ieee1394/pcilynx.c |   20 --------------------
 1 file changed, 20 deletions(-)

--- linux-2.6.13-rc7.orig/drivers/ieee1394/pcilynx.c	2005-08-24 21:29:49.000000000 +0200
+++ linux-2.6.13-rc7/drivers/ieee1394/pcilynx.c	2005-08-25 16:17:54.000000000 +0200
@@ -1464,26 +1464,6 @@
                                                   { 0x50, I2C_M_RD, 20, (unsigned char*) lynx->bus_info_block }
                                                 };
 
-
-#ifdef CONFIG_IEEE1394_VERBOSEDEBUG
-                        union i2c_smbus_data data;
-
-                        if (i2c_smbus_xfer(i2c_ad, 80, 0, I2C_SMBUS_WRITE, 0, I2C_SMBUS_BYTE,NULL))
-                                PRINT(KERN_ERR, lynx->id,"eeprom read start has failed");
-                        else
-                        {
-                                u16 addr;
-                                for (addr=0x00; addr < 0x100; addr++) {
-                                        if (i2c_smbus_xfer(i2c_ad, 80, 0, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE,& data)) {
-                                                PRINT(KERN_ERR, lynx->id, "unable to read i2c %x", addr);
-                                                break;
-                                        }
-                                        else
-                                                PRINT(KERN_DEBUG, lynx->id,"got serial eeprom data at %x: %x",addr, data.byte);
-                                }
-                        }
-#endif
-
                         /* we use i2c_transfer, because i2c_smbus_read_block_data does not work properly and we
                            do it more efficiently in one transaction rather then using several reads */
                         if (i2c_transfer(i2c_ad, msg, 2) < 0) {


-- 
Jean Delvare
