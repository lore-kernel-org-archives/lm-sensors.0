From: daniel@oden.homeip.net (Daniel Nilsson)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Patch for i2c-tsunami.c
Message-Id: <3FEB9352.3080401@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

First of all, sorry for the previous "subscribe" email, I thought this 
was a normal mailing list that I had to subscribe to...

I've spent some time playing with the i2c-tsunami kernel driver on my 
DS10 Alphaserver. I'm working on a Debian stable system using kernel 
2.4.18 and I installed i2c and lm-sensors 2.8.1 from backports.org. The 
supplied i2c-tsunami.c will not compile correctly and even when I fixed 
the compile issue the module would oops upon any read/write attempts. 
The simple patch below solved both the compile issues and the kernel 
oops, though I didn't complete when appears to be an attempt to convert 
this module to a newer interface (the static struct pci_driver stuff). 
The module now works fine on this test system, though there is nothing 
but eeproms on the i2c bus connected to the tsunami chipset on this 
machine :-)

Thanks
Daniel Nilsson
-------------- next part --------------
--- kernel/busses/i2c-tsunami.c	Tue Jan 21 15:01:27 2003
+++ /usr/src/modules/lm-sensors/kernel/busses/i2c-tsunami.c	Thu Dec 25 15:44:23 2003
@@ -101,11 +101,13 @@
 
 static struct i2c_algo_bit_data tsunami_i2c_bit_data = {
 	
-	bit_tsunami_setsda,
-	bit_tsunami_setscl,
-	bit_tsunami_getsda,
-	bit_tsunami_getscl,
-	10, 10, HZ/2	/* delays/timeout */
+	.setsda  = bit_tsunami_setsda,
+	.setscl  = bit_tsunami_setscl,
+	.getsda  = bit_tsunami_getsda,
+	.getscl  = bit_tsunami_getscl,
+	.udelay  = 10,
+	.mdelay  = 10,
+	.timeout = HZ/2	/* delays/timeout */
 };
 
 static struct i2c_adapter tsunami_i2c_adapter = {
@@ -116,24 +118,24 @@
 };
 
 
-static struct pci_driver tsunami_driver = {
-	.name		= "tsunami smbus",
-	.id_table	= tsunami_ids,
-	.probe		= tsunami_probe,
-	.remove		= __devexit_p(tsunami_remove),
-};
+/*  static struct pci_driver tsunami_driver = { */
+/*  	.name		= "tsunami smbus", */
+/*  	.id_table	= tsunami_ids, */
+/*  	.probe		= tsunami_probe, */
+/*  	.remove		= __devexit_p(tsunami_remove), */
+/*  }; */
 
 static int __init i2c_tsunami_init(void)
 {
 	printk("i2c-tsunami.o version %s (%s)\n", LM_VERSION, LM_DATE);
 
 	if (hwrpb->sys_type != ST_DEC_TSUNAMI) {
-		printk("i2c-tsunami.o: not Tsunami based system (%d), module not inserted.\n", hwrpb->sys_type);
+		printk("i2c-tsunami.o: not Tsunami based system (%ld), module not inserted.\n", hwrpb->sys_type);
 		return -ENXIO;
 	} else {
-		printk("i2c-tsunami.o: using Cchip MPD at 0x%lx.\n", &TSUNAMI_cchip->mpd);
+		printk("i2c-tsunami.o: using Cchip MPD at 0x%lx.\n", (long) &TSUNAMI_cchip->mpd);
 	}
-	i2c_bit_add_bus(&tsunami_i2c_adapter);
+	return i2c_bit_add_bus(&tsunami_i2c_adapter);
 }
 
 
