From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:37 +0000
Subject: [lm-sensors] [PATCH 6/30] i2c-algo-sibyte: Cleanups
Message-Id: <11593189382540-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c-algo-sibyte: Cleanups

* Delete empty algo_control implementation.
* Simplify i2c_sibyte_del_bus.
* Delete empty module init and cleanup functions.
* Drop out-of-date #ifdef MODULE construct.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Ralf Baechle <ralf at linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/algos/i2c-algo-sibyte.c |   31 +------------------------------
 1 files changed, 1 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-sibyte.c b/drivers/i2c/algos/i2c-algo-sibyte.c
index 32d41c6..16d666f 100644
--- a/drivers/i2c/algos/i2c-algo-sibyte.c
+++ b/drivers/i2c/algos/i2c-algo-sibyte.c
@@ -119,12 +119,6 @@ static int smbus_xfer(struct i2c_adapter
         return 0;
 }
 
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-	return 0;
-}
-
 static u32 bit_func(struct i2c_adapter *adap)
 {
 	return (I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -136,7 +130,6 @@ static u32 bit_func(struct i2c_adapter *
 
 static struct i2c_algorithm i2c_sibyte_algo = {
 	.smbus_xfer	= smbus_xfer,
-	.algo_control	= algo_control, /* ioctl */
 	.functionality	= bit_func,
 };
 
@@ -179,37 +172,15 @@ int i2c_sibyte_add_bus(struct i2c_adapte
 
 int i2c_sibyte_del_bus(struct i2c_adapter *adap)
 {
-	int res;
-
-	if ((res = i2c_del_adapter(adap)) < 0)
-		return res;
-
-	return 0;
-}
-
-int __init i2c_algo_sibyte_init (void)
-{
-	printk("i2c-algo-sibyte.o: i2c SiByte algorithm module\n");
-	return 0;
+	return i2c_del_adapter(adap);
 }
 
 
 EXPORT_SYMBOL(i2c_sibyte_add_bus);
 EXPORT_SYMBOL(i2c_sibyte_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Kip Walker, Broadcom Corp.");
 MODULE_DESCRIPTION("SiByte I2C-Bus algorithm");
 module_param(bit_scan, int, 0);
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_LICENSE("GPL");
-
-int init_module(void) 
-{
-	return i2c_algo_sibyte_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
-- 
1.4.2.1


