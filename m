From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:04 +0000
Subject: [lm-sensors] [PATCH] I2C: Drop debug eeprom dump code in pcilynx
Message-Id: <11259567713638@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Drop debug eeprom dump code in pcilynx

The pcilynx driver includes code to dump the contents of an i2c eeprom
for debugging purposes. The same can be done from userspace using the
i2cdump tool (part of the lm_sensors project) instead, in a more
efficient and flexible way.

Thus I would suggest that this functionality be simply dropped from the
pcilynx driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 386625f9f5cd94d10a21241b555b130dcec484fb
tree 15746d1a5c66fa476487a7f95d84115f86ac3f81
parent 4e0c64cfc1126a2946487d4771168458bb9ba9be
author Jean Delvare <khali@linux-fr.org> Thu, 25 Aug 2005 16:43:29 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:52 -0700

 drivers/ieee1394/pcilynx.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
--- a/drivers/ieee1394/pcilynx.c
+++ b/drivers/ieee1394/pcilynx.c
@@ -1464,26 +1464,6 @@ static int __devinit add_card(struct pci
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

