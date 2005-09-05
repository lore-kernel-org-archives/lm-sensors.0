From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:15 +0000
Subject: [lm-sensors] [PATCH] I2C: Drop probe parameter of i2c-keywest
Message-Id: <11259567713020@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Drop probe parameter of i2c-keywest

The i2c-keywest driver has a "probe" module parameter which enables bus
scanning at load time. This can be done in userspace with the i2cdetect
tool (part of the lm_sensors package) instead. What's more, i2cdetect
gives more control on the way the bus is scanned, and is safer
(i2c-keywest currently scans reserved addresses and doesn't properly
handle the famous 24RF08 corruption case.)

Thus, I would propose that this module parameter be simply dropped.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b280dab6d62c8d0434cbc0aaeebf56d1fa4fcc19
tree 591ad43d6466310312254f6bd1766f9e1e92f010
parent 386625f9f5cd94d10a21241b555b130dcec484fb
author Jean Delvare <khali@linux-fr.org> Mon, 29 Aug 2005 21:10:31 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:26:52 -0700

 drivers/i2c/busses/i2c-keywest.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
--- a/drivers/i2c/busses/i2c-keywest.c
+++ b/drivers/i2c/busses/i2c-keywest.c
@@ -87,12 +87,9 @@ static const char *__kw_state_names[] = 
 };
 #endif /* DEBUG */
 
-static int probe;
-
 MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
 MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
 MODULE_LICENSE("GPL");
-module_param(probe, bool, 0);
 
 #ifdef POLLED_MODE
 /* Don't schedule, the g5 fan controller is too
@@ -632,15 +629,6 @@ create_iface(struct device_node *np, str
 				chan->adapter.name);
 			i2c_set_adapdata(&chan->adapter, NULL);
 		}
-		if (probe) {
-			printk("Probe: ");
-			for (addr = 0x00; addr <= 0x7f; addr++) {
-				if (i2c_smbus_xfer(&chan->adapter,addr,
-				    0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
-					printk("%02x ", addr);
-			}
-			printk("\n");
-		}
 	}
 
 	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",

