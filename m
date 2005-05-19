From: kmalkki@cc.hut.fi (Kyosti Malkki)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: penguin on i2c bus after motherboard change (PCTVpro,with msp34xx)
Message-Id: <Pine.OSF.4.50.0211251750070.22783-200000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211251007410.4255-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211251007410.4255-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 25 Nov 2002, Kyosti Malkki wrote:
>
> Chapter 5 "I2C Bus Interface" of MSP34x0D datasheet describes conditions
> when SCL is held low to allow time for internal processing.

The same chapter states, that MSP does not acknowledge its address after
internal failure. Current algo-bit will not complete any message if
device address is not acknowledged. Support for I2C_M_IGNORE_NAK flag is
now in CVS for i2c-algo-bit.

A sample use is the attached patch for msp3400.
It ignores NAKs for both reset_off and _on messages, where the original
code ignored NAKs (well, tried to) for reset_off message only.
Datasheet advices to ignore all NAKs while in CONTROL sequence.
Make sure you use i2c from CVS if you try this.

For most cards, boot_msp() in bttv-cards does nothing! This is a good
candidate for any MSP problems, and easy to fix if you trace RESET from
MSP or manage to get details from the card manufacturer.

Timeout field in algo_bit_data should have jiffies in bttv-if.
For MSP use, some 2 ms worth should do.

Having tuned i2c-algo-bit for maximum speed, I am able to get MSP error
#1, but no #2 nor #3. This indicates retry from msp_write/read has
worked with no need for reset.
NAK to cause error #1-#3 can appear in any of the client ACK slots.
Currently algo-bit does three retries for address acknowledge, but fails
if further acknowledge is missing.
I think this will change to retry the complete message.

-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi
-------------- next part --------------
--- linux-2.4.19.orig/drivers/media/video/msp3400.c	Tue Jul  9 23:03:10 2002
+++ linux-2.4.19/drivers/media/video/msp3400.c	Tue Nov 26 19:48:13 2002
@@ -145,14 +145,31 @@
 /* ----------------------------------------------------------------------- */
 /* functions for talking to the MSP3400C Sound processor                   */
 
+#ifdef I2C_M_IGNORE_NAK
+#define _IGNORE_NAK I2C_M_IGNORE_NAK
+#else
+#define _IGNORE_NAK 0x1000
+#endif
+
 static int msp3400c_reset(struct i2c_client *client)
 {
+	/* reset and read revision code */
         static char reset_off[3] = { 0x00, 0x80, 0x00 };
         static char reset_on[3]  = { 0x00, 0x00, 0x00 };
-
-        i2c_master_send(client,reset_off,3);  /* XXX ignore errors here */
-        if (3 != i2c_master_send(client,reset_on, 3)) {
-		printk(KERN_ERR "msp3400: chip reset failed, penguin on i2c bus?\n");
+        static char write[3] = { I2C_MSP3400C_DFP + 1, 0x00, 0x1e };
+        char read[2];
+        struct i2c_msg reset_test[4] = {
+                { client->addr, _IGNORE_NAK, 3, reset_off },
+                { client->addr, _IGNORE_NAK, 3, reset_on },
+                { client->addr, 0,        3, write },
+                { client->addr, I2C_M_RD, 2, read  }
+        };
+	
+ 	if (4 != i2c_transfer(client->adapter,reset_test,4)) {
+#ifndef I2C_M_IGNORE_NAK
+		printk(KERN_ERR "msp3400: i2c-2.7.0+ required for chip reset, tried it anyway\n");
+#endif
+  		printk(KERN_ERR "msp3400: chip reset failed, penguin on i2c bus?\n");
                 return -1;
 	}
         return 0;
