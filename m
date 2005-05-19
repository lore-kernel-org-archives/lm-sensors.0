From: jkl@sarvega.com (John K. Lash)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: ticket 721
Message-Id: <3BEBE198.3050607@sarvega.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reply from support:

Get CVS release of lm_sensors and
use ?modprobe w83781d init=0? which should prevent the hangs.
Let us know if it doesn?t at
sensors@stimpy.netroedge.com.
MDS 11/8/01

------------------------

Still no luck. I grabbed sensors2 and i2c as described in download.html page.

I generated a patch file:

  mkpatch/mkpatch.pl . /usr/src/linux > /tmp/pat
  cd /usr/src/linux
  patch -p1 < /tmp/pat

I didn't see any new settings in the make xconfig section.

Then I ran
  make dep && make clean && make bzImage && make modules && make modules_install

Then I went back to the i2c directory and ran
  make
  make install

then went to sensors2

  make
  make install

Pushed new kernel and modules to my test system, rebooted and ran

  modprobe w83781d init=0
  modprobe i2c-piix4

and it hung. on the next boot I tried the modprobes in the reverse order and it hung after the 
second modprobe.

This kernel has mods for reiserfs and kernel crash dump in it (should have mentioned that 
originally). They haven't given me trouble in the past but I can build against a clean 2.2.19 if 
that would be helpful.

I'm including the patch file (can't think of anything else useful to do ;-)


--john


-- 
John Lash	jkl@sarvega.com	630-734-5925

Sarvega Inc.
745 McClintock, Suite 230
Burr Ridge, IL 60527
-------------- next part --------------
--- linux-old/Documentation/i2c/dev-interface	Fri Nov  9 06:42:26 CST 2001
+++ linux/Documentation/i2c/dev-interface	Fri Nov  9 06:42:26 CST 2001
--- linux-old/Documentation/i2c/functionality	Fri Nov  9 06:42:26 CST 2001
+++ linux/Documentation/i2c/functionality	Fri Nov  9 06:42:26 CST 2001
--- linux-old/Documentation/i2c/i2c-protocol	Fri Nov  9 06:42:26 CST 2001
+++ linux/Documentation/i2c/i2c-protocol	Fri Nov  9 06:42:26 CST 2001
--- linux-old/Documentation/i2c/proc-interface	Fri Nov  9 06:42:27 CST 2001
+++ linux/Documentation/i2c/proc-interface	Fri Nov  9 06:42:27 CST 2001
--- linux-old/Documentation/i2c/smbus-protocol	Fri Nov  9 06:42:27 CST 2001
+++ linux/Documentation/i2c/smbus-protocol	Fri Nov  9 06:42:27 CST 2001
--- linux-old/Documentation/i2c/summary	Fri Nov  9 06:42:27 CST 2001
+++ linux/Documentation/i2c/summary	Fri Nov  9 06:42:27 CST 2001
--- linux-old/Documentation/i2c/ten-bit-addresses	Fri Nov  9 06:42:27 CST 2001
+++ linux/Documentation/i2c/ten-bit-addresses	Fri Nov  9 06:42:27 CST 2001
--- linux-old/Documentation/i2c/writing-clients	Fri Nov  9 06:42:28 CST 2001
+++ linux/Documentation/i2c/writing-clients	Fri Nov  9 06:42:28 CST 2001
--- linux-old/drivers/i2c/i2c-algo-bit.c	Fri Nov  9 06:42:28 CST 2001
+++ linux/drivers/i2c/i2c-algo-bit.c	Fri Nov  9 06:42:28 CST 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.30 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.33 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -34,5 +34,4 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -610,5 +609,5 @@
 int __init i2c_algo_bit_init (void)
 {
-	printk("i2c-algo-bit.o: i2c bit algorithm module\n");
+	printk("i2c-algo-bit.o: i2c bit algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return 0;
 }
@@ -622,4 +621,7 @@
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 MODULE_PARM(bit_test, "i");
--- linux-old/include/linux/i2c-algo-bit.h	Fri Nov  9 06:42:28 CST 2001
+++ linux/include/linux/i2c-algo-bit.h	Fri Nov  9 06:42:28 CST 2001
--- linux-old/drivers/i2c/i2c-algo-pcf.c	Fri Nov  9 06:42:29 CST 2001
+++ linux/drivers/i2c/i2c-algo-pcf.c	Fri Nov  9 06:42:29 CST 2001
@@ -38,5 +38,4 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
@@ -525,5 +524,5 @@
 int __init i2c_algo_pcf_init (void)
 {
-	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module\n");
+	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return 0;
 }
@@ -536,4 +535,7 @@
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 MODULE_PARM(pcf_scan, "i");
--- linux-old/include/linux/i2c-algo-pcf.h	Fri Nov  9 06:42:29 CST 2001
+++ linux/include/linux/i2c-algo-pcf.h	Fri Nov  9 06:42:29 CST 2001
--- linux-old/drivers/i2c/i2c-core.c	Fri Nov  9 06:42:30 CST 2001
+++ linux/drivers/i2c/i2c-core.c	Fri Nov  9 06:42:30 CST 2001
@@ -21,5 +21,5 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-core.c,v 1.64 2001/08/13 01:35:56 mds Exp $ */
+/* $Id: i2c-core.c,v 1.69 2001/10/28 20:41:47 mds Exp $ */
 
 #include <linux/module.h>
@@ -29,5 +29,4 @@
 #include <linux/proc_fs.h>
 #include <linux/config.h>
-
 #include <linux/i2c.h>
 
@@ -37,5 +36,5 @@
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,18)
 #define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
 #endif
@@ -1264,5 +1263,5 @@
 static int __init i2c_init(void)
 {
-	printk("i2c-core.o: i2c core module\n");
+	printk("i2c-core.o: i2c core module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	memset(adapters,0,sizeof(adapters));
 	memset(drivers,0,sizeof(drivers));
@@ -1330,11 +1329,11 @@
 	i2c_algo_bit_init();
 #endif
-#ifdef CONFIG_I2C_PHILIPSPAR
+#ifdef CONFIG_I2C_BITLP
 	i2c_bitlp_init();
 #endif
-#ifdef CONFIG_I2C_ELV
+#ifdef CONFIG_I2C_BITELV
 	i2c_bitelv_init();
 #endif
-#ifdef CONFIG_I2C_VELLEMAN
+#ifdef CONFIG_I2C_BITVELLE
 	i2c_bitvelle_init();
 #endif
@@ -1344,5 +1343,5 @@
 	i2c_algo_pcf_init();	
 #endif
-#ifdef CONFIG_I2C_ELEKTOR
+#ifdef CONFIG_I2C_PCFISA
 	i2c_pcfisa_init();
 #endif
@@ -1411,4 +1410,7 @@
 MODULE_PARM(i2c_debug, "i");
 MODULE_PARM_DESC(i2c_debug,"debug level");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 int init_module(void) 
--- linux-old/drivers/i2c/i2c-dev.c	Fri Nov  9 06:42:30 CST 2001
+++ linux/drivers/i2c/i2c-dev.c	Fri Nov  9 06:42:30 CST 2001
@@ -29,5 +29,5 @@
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.40 2001/08/25 01:28:01 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.43 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/config.h>
@@ -50,5 +50,4 @@
 #include <linux/init.h>
 #include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
@@ -488,5 +487,5 @@
 	int res;
 
-	printk("i2c-dev.o: i2c /dev entries driver module\n");
+	printk("i2c-dev.o: i2c /dev entries driver module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	i2cdev_initialized = 0;
@@ -549,4 +548,7 @@
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 int init_module(void)
--- linux-old/include/linux/i2c-dev.h	Fri Nov  9 06:42:31 CST 2001
+++ linux/include/linux/i2c-dev.h	Fri Nov  9 06:42:31 CST 2001
--- linux-old/drivers/i2c/i2c-elektor.c	Fri Nov  9 06:42:31 CST 2001
+++ linux/drivers/i2c/i2c-elektor.c	Fri Nov  9 06:42:31 CST 2001
@@ -36,5 +36,4 @@
 #include <asm/irq.h>
 #include <asm/io.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
@@ -274,5 +273,5 @@
 	}
 
-	printk("i2c-elektor.o: i2c pcf8584-isa adapter module\n");
+	printk("i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	if (base = 0) {
@@ -301,4 +300,7 @@
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 MODULE_PARM(base, "i");
--- linux-old/include/linux/i2c-elektor.h	Fri Nov  9 06:42:31 CST 2001
+++ linux/include/linux/i2c-elektor.h	Fri Nov  9 06:42:31 CST 2001
--- linux-old/drivers/i2c/i2c-elv.c	Fri Nov  9 06:42:31 CST 2001
+++ linux/drivers/i2c/i2c-elv.c	Fri Nov  9 06:42:31 CST 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elv.c,v 1.17 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-elv.c,v 1.20 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -30,7 +30,5 @@
 #include <linux/version.h>
 #include <linux/init.h>
-
 #include <asm/uaccess.h>
-
 #include <linux/ioport.h>
 #include <asm/io.h>
@@ -171,5 +169,5 @@
 int __init i2c_bitelv_init(void)
 {
-	printk("i2c-elv.o: i2c ELV parallel port adapter module\n");
+	printk("i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base=0) {
 		/* probe some values */
@@ -200,6 +198,9 @@
 #ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
-MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter")
-;
+MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
 
 MODULE_PARM(base, "i");
--- linux-old/include/linux/i2c-id.h	Fri Nov  9 06:42:31 CST 2001
+++ linux/include/linux/i2c-id.h	Fri Nov  9 06:42:31 CST 2001
@@ -21,5 +21,5 @@
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.35 2001/08/12 17:22:20 mds Exp $ */
+/* $Id: i2c-id.h,v 1.39 2001/10/31 19:04:45 knobi Exp $ */
 
 #ifndef I2C_ID_H
@@ -128,4 +128,6 @@
 #define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
+#define I2C_DRIVERID_FSCPOS 1028
+#define I2C_DRIVERID_FSCSCY 1029
 
 /*
@@ -144,5 +146,6 @@
 #define I2C_ALGO_SAA7146 0x060000	/* SAA 7146 video decoder bus	*/
 #define I2C_ALGO_ACB 	0x070000	/* ACCESS.bus algorithm         */
-
+#define I2C_ALGO_IIC    0x080000 	/* ITE IIC bus */
+#define I2C_ALGO_SAA7134 0x090000
 #define I2C_ALGO_EC     0x100000        /* ACPI embedded controller     */
 
@@ -189,4 +192,7 @@
 /* --- MPC8xx PowerPC adapters						*/
 #define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
+
+/* --- ITE based algorithms						*/
+#define I2C_HW_I_IIC	0x00	/* controller on the ITE */
 
 /* --- SMBus only adapters						*/
--- linux-old/drivers/i2c/i2c-pcf8584.h	Fri Nov  9 06:42:32 CST 2001
+++ linux/drivers/i2c/i2c-pcf8584.h	Fri Nov  9 06:42:32 CST 2001
@@ -22,5 +22,5 @@
 /* With some changes from Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-pcf8584.h,v 1.3 2000/01/18 23:54:07 frodo Exp $ */
+/* $Id: i2c-pcf8584.h,v 1.4 2001/10/02 00:07:37 mds Exp $ */
 
 #ifndef I2C_PCF8584_H
@@ -76,3 +76,3 @@
 #define I2C_PCF_CLKREG	I2C_PCF_ES1
 
-#endif I2C_PCF8584_H
+#endif /* I2C_PCF8584_H */
--- linux-old/drivers/i2c/i2c-philips-par.c	Fri Nov  9 06:42:32 CST 2001
+++ linux/drivers/i2c/i2c-philips-par.c	Fri Nov  9 06:42:32 CST 2001
@@ -22,5 +22,5 @@
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-philips-par.c,v 1.18 2000/07/06 19:21:49 frodo Exp $ */
+/* $Id: i2c-philips-par.c,v 1.21 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -30,5 +30,4 @@
 #include <linux/stddef.h>
 #include <linux/parport.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -265,5 +264,5 @@
 	struct parport *port;
 #endif
-	printk("i2c-philips-par.o: i2c Philips parallel port adapter module\n");
+	printk("i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
@@ -292,4 +291,7 @@
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Philips parallel port adapter");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 MODULE_PARM(type, "i");
--- linux-old/drivers/i2c/i2c-proc.c	Fri Nov  9 06:42:33 CST 2001
+++ linux/drivers/i2c/i2c-proc.c	Fri Nov  9 06:42:33 CST 2001
@@ -33,14 +33,8 @@
 #include <linux/ioport.h>
 #include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-proc.h>
-
 #include <linux/init.h>
 
-/* FIXME need i2c versioning */
-#define LM_DATE "20010825"
-#define LM_VERSION "2.6.1"
-
 #ifndef THIS_MODULE
 #define THIS_MODULE NULL
@@ -859,5 +853,5 @@
 int __init sensors_init(void)
 {
-	printk("i2c-proc.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	printk("i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	i2c_initialized = 0;
 	if (!
@@ -884,4 +878,7 @@
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-proc driver");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 int i2c_cleanup(void)
--- linux-old/include/linux/i2c-proc.h	Fri Nov  9 06:42:33 CST 2001
+++ linux/include/linux/i2c-proc.h	Fri Nov  9 06:42:33 CST 2001
--- linux-old/drivers/i2c/i2c-velleman.c	Fri Nov  9 06:42:33 CST 2001
+++ linux/drivers/i2c/i2c-velleman.c	Fri Nov  9 06:42:33 CST 2001
@@ -19,5 +19,5 @@
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-velleman.c,v 1.19 2000/01/24 02:06:33 mds Exp $ */
+/* $Id: i2c-velleman.c,v 1.22 2001/10/14 15:04:46 mds Exp $ */
 
 #include <linux/kernel.h>
@@ -28,5 +28,4 @@
 #include <asm/errno.h>     /* for 2.0 kernels to get ENODEV */
 #include <asm/io.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -161,5 +160,5 @@
 int __init  i2c_bitvelle_init(void)
 {
-	printk("i2c-velleman.o: i2c Velleman K8000 adapter module\n");
+	printk("i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base=0) {
 		/* probe some values */
@@ -190,4 +189,7 @@
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Velleman K8000 adapter");
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
 
 MODULE_PARM(base, "i");
--- linux-old/include/linux/i2c.h	Fri Nov  9 06:42:34 CST 2001
+++ linux/include/linux/i2c.h	Fri Nov  9 06:42:34 CST 2001
--- linux-old/drivers/i2c/Config.in	Fri Nov  9 06:42:34 CST 2001
+++ linux/drivers/i2c/Config.in	Fri Nov  9 06:42:34 CST 2001
@@ -11,12 +11,12 @@
    dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
-      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
-      dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
-      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_BITLP $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
+      dep_tristate '  ELV adapter' CONFIG_I2C_BITELV $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_BITVELLE $CONFIG_I2C_ALGOBIT
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then
-      dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
+      dep_tristate '  Elektor ISA card' CONFIG_I2C_PCFISA $CONFIG_I2C_ALGOPCF
    fi
 
@@ -30,5 +30,5 @@
    if [ "$CONFIG_405" = "y" ]; then
       dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
-      if [ "CONFIG_I2C_PPC405_ALGO" != "n" ]; then
+      if [ "$CONFIG_I2C_PPC405_ALGO" != "n" ]; then
          dep_tristate '  PPC 405 I2C Adapter' CONFIG_I2C_PPC405_ADAP $CONFIG_I2C_PPC405_ALGO
       fi
--- linux-old/Makefile	Fri Nov  9 06:42:34 CST 2001
+++ linux/Makefile	Fri Nov  9 06:42:34 CST 2001
--- linux-old/drivers/Makefile	Fri Nov  9 06:42:34 CST 2001
+++ linux/drivers/Makefile	Fri Nov  9 06:42:34 CST 2001
--- linux-old/drivers/i2c/Makefile	Fri Nov  9 06:42:34 CST 2001
+++ linux/drivers/i2c/Makefile	Fri Nov  9 06:42:34 CST 2001
@@ -54,24 +54,24 @@
 endif
 
-ifeq ($(CONFIG_I2C_PHILIPSPAR),y)
+ifeq ($(CONFIG_I2C_BITLP),y)
   L_OBJS += i2c-philips-par.o
 else
-  ifeq ($(CONFIG_I2C_PHILIPSPAR),m)
+  ifeq ($(CONFIG_I2C_BITLP),m)
     M_OBJS += i2c-philips-par.o
   endif
 endif
 
-ifeq ($(CONFIG_I2C_ELV),y)
+ifeq ($(CONFIG_I2C_BITELV),y)
   L_OBJS += i2c-elv.o
 else
-  ifeq ($(CONFIG_I2C_ELV),m)
+  ifeq ($(CONFIG_I2C_BITELV),m)
     M_OBJS += i2c-elv.o
   endif
 endif
 
-ifeq ($(CONFIG_I2C_VELLEMAN),y)
+ifeq ($(CONFIG_I2C_BITVELLE),y)
   L_OBJS += i2c-velleman.o
 else
-  ifeq ($(CONFIG_I2C_VELLEMAN),m)
+  ifeq ($(CONFIG_I2C_BITVELLE),m)
     M_OBJS += i2c-velleman.o
   endif
@@ -92,8 +92,8 @@
 endif
 
-ifeq ($(CONFIG_I2C_ELEKTOR),y)
+ifeq ($(CONFIG_I2C_PCFISA),y)
   L_OBJS += i2c-elektor.o
 else
-  ifeq ($(CONFIG_I2C_ELEKTOR),m)
+  ifeq ($(CONFIG_I2C_PCFISA),m)
     M_OBJS += i2c-elektor.o
   endif
--- linux-old/drivers/char/Config.in	Fri Nov  9 06:42:34 CST 2001
+++ linux/drivers/char/Config.in	Fri Nov  9 06:42:34 CST 2001
--- linux-old/drivers/char/mem.c	Fri Nov  9 06:42:34 CST 2001
+++ linux/drivers/char/mem.c	Fri Nov  9 06:42:34 CST 2001
--- linux-old/Documentation/Configure.help	Fri Nov  9 06:42:34 CST 2001
+++ linux/Documentation/Configure.help	Fri Nov  9 06:42:34 CST 2001
@@ -13710,4 +13710,13 @@
    
 #
+I2C /proc support
+CONFIG_I2C_PROC
+  This provides support for i2c device entries in the /proc filesystem.
+  The entries will be found in /proc/sys/dev/sensors.
+
+  This code is also available as a module. If you want to compile
+  it as a module, say M here and read Documentation/modules.txt. The
+  module will be called i2c-proc.o.
+
 I2C support
 CONFIG_I2C
@@ -13744,5 +13753,5 @@
 
 Philips style parallel port adapter
-CONFIG_I2C_PHILIPSPAR
+CONFIG_I2C_BITLP
   This supports parallel-port I2C adapters made by Philips. Say Y if
   you own such an adapter.
@@ -13756,5 +13765,5 @@
 
 ELV adapter
-CONFIG_I2C_ELV
+CONFIG_I2C_BITELV
   This supports parallel-port I2C adapters called ELV. Say Y if you
   own such an adapter.
@@ -13765,5 +13774,5 @@
 
 Velleman K9000 adapter
-CONFIG_I2C_VELLEMAN
+CONFIG_I2C_BITVELLE
   This supports the Velleman K9000 parallel-port I2C adapter. Say Y if
   you own such an adapter.
@@ -13784,5 +13793,5 @@
 
 Elektor ISA card
-CONFIG_I2C_ELEKTOR
+CONFIG_I2C_PCFISA
   This supports the PCF8584 ISA bus I2C adapter. Say Y if you own such
   an adapter.
--- linux-old/MAINTAINERS	Fri Nov  9 06:42:34 CST 2001
+++ linux/MAINTAINERS	Fri Nov  9 06:42:34 CST 2001
