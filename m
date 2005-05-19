From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: I2C patch for Linux 2.4
Message-Id: <20030712095859.64d3cefa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

> Individual diffs are good.  In an incremental fashion is even better
> (this one fixes up the core files to match cvs, this one adds one
> driver, etc...)

OK, let's go.

> Always against the latest kernel is the best, 2.4.22-preX or
> 2.4.21-bkX is fine, I should be able to handle either of them.

The core patch is against 2.4.21-bk7, others are against 2.4.21 but
apply correctly to 2.4.21-bk7.

> I can imagine that we aren't going to just be able to drop in the cvs
> version into the kernel, due to some cleanups that we might want to do
> (along the lines of what's happened in 2.5 before I did the sysfs
> changes.)  So this will be an iterative process.

Of course. Don't forget to CC: me on everything you send to the LKML
with regard to this topic, so that I can follow the evolution and help
when I can.

Also, I'm not sure what you mean with "iterative process", so please
note that once the main i2c patch is applied, all others but the last
one (pcmcia) also need to be, or the drivers won't work (and some of
them won't even compile.)

Attached are all the patches but the core patch (too large for the list,
I'll send it to you only in a minute; anyway everyone can generate it
using mkpatch.) Here comes the logical order they should be applied in,
and a description of what they do.


* linux-2.4.21-bk7-i2c-2.8.0.patch

The core patch, as generated using "./mkpatch /usr/src/i2c-CVS
/usr/src/linux-2.4.21-bk7". Note that all patches are labeled
"i2c-2.8.0" because we are so close to releasing. The patch includes the
following changes (U means update, + means creation, - means deletion):

  + drivers/i2c/i2c-adap-ibm_ocp.c
  + drivers/i2c/i2c-algo-8xx.c
  U drivers/i2c/i2c-algo-bit.c
  + drivers/i2c/i2c-algo-ibm_ocp.c
  U drivers/i2c/i2c-algo-pcf.c
  U drivers/i2c/i2c-core.c
  U drivers/i2c/i2c-dev.c
  U drivers/i2c/i2c-elektor.c
  U drivers/i2c/i2c-elv.c
  + drivers/i2c/i2c-frodo.c
  + drivers/i2c/i2c-pcf-epp.c
  U drivers/i2c/i2c-philips-par.c
  + drivers/i2c/i2c-pport.c
  U drivers/i2c/i2c-proc.c
  + drivers/i2c/i2c-rpx.c
  U drivers/i2c/i2c-velleman.c
  U include/linux/i2c.h
  U include/linux/i2c-dev.h
  + include/linux/i2c-algo-8xx.h
  U include/linux/i2c-algo-bit.h
  + include/linux/i2c-algo-ibm_ocp.h
  U include/linux/i2c-algo-pcf.h
  - include/linux/i2c-elektor.h
  U include/linux/i2c-id.h
  U include/linux/i2c-pcf8584.h
  U include/linux/i2c-proc.h
  U Documentation/i2c/dev-interface
  U Documentation/i2c/functionality
  + Documentation/i2c/i2c-pport
  U Documentation/i2c/i2c-protocol
  + Documentation/i2c/i2c-velleman
  U Documentation/i2c/proc-interface
  U Documentation/i2c/smbus-protocol
  U Documentation/i2c/summary
  U Documentation/i2c/ten-bit-addresses
  U Documentation/i2c/writing-clients
  U Documentation/Configure.help


* i2c-2.8.0-drivers-i2c-i2c-adap-ite.c.diff
* i2c-2.8.0-drivers-i2c-i2c-keywest.c.diff
* i2c-2.8.0-drivers-i2c-scx200_acb.c.diff
* i2c-2.8.0-drivers-i2c-scx200_i2c.c.diff

These four patches fix the i2c drivers that are part of the kernel but
are not present in our i2c tree. This is required due to changes on our
side in struct i2c_adapter. Changes are: adding the owner field,
removing the inc_use and dec_use fields and associated functions, and
using C99 initializers. Note that these patches only fix the drivers
that are located in the drivers/i2c directory. Other drivers that use
our i2c layer are fixed later. Files changed:

  U drivers/i2c/i2c-adap-ite.c
  U drivers/i2c/i2c-keywest.c
  U drivers/i2c/scx200_acb.c
  U drivers/i2c/scx200_i2c.c


* i2c-2.8.0-drivers-i2c-Config.in.diff
* i2c-2.8.0-drivers-i2c-Makefile.diff

These two patches integrate our new drivers in the Linux configuration
and compilation mechanisms, respectively. New drivers are: i2c-pport.o,
i2c-frodo.o, i2c-pcf-epp.o, i2c-algo-8xx.o, i2c-rpx.o,
i2c-algo-ibm_ocp.o, i2c-adap-ibm_ocp.o. The Config.in also includes
dependency and typo fixes. Files changed:

  U drivers/i2c/Config.in
  U drivers/i2c/Makefile


* i2c-2.8.0-drivers-acorn-char.diff
* i2c-2.8.0-drivers-ieee1394.diff
* i2c-2.8.0-drivers-media-video.diff
* i2c-2.8.0-drivers-sound-dmasound.diff
* i2c-2.8.0-drivers-video-matrox.diff

These five patches fix all other i2c drivers that live outside of the
drivers/i2c directory. This is required due to changes on our side in
struct i2c_adapter and struct i2c_driver. Changes are: adding the owner
field, removing the inc_use and dec_use fields and associated functions,
and using C99 initializers. Expect the acorn-char one to apply with a
hundred line delta due to a recent change to drivers/acorn/char/i2c.c.
The media-video patch also fixes some errors in the Makefile, removes
dead code in i2c-old.c and unused headers in saa7146.h. Files changed:

  U drivers/acorn/char/i2c.c
  U drivers/acorn/char/pcf8583.c
  U drivers/ieee1394/pcilynx.c
  U drivers/media/video/Makefile
  U drivers/media/video/bt832.c
  U drivers/media/video/i2c-old.c
  U drivers/media/video/msp3400.c
  U drivers/media/video/saa5249.c
  U drivers/media/video/tda7432.c
  U drivers/media/video/tda9875.c
  U drivers/media/video/tda9887.c
  U drivers/media/video/tuner-3036.c
  U drivers/media/video/tuner.c
  U drivers/media/video/tvaudio.c
  U drivers/media/video/tvmixer.c
  U drivers/sound/dmasound/dac3550a.c
  U drivers/sound/dmasound/tas3001c.c
  U drivers/video/matrox/i2c-matroxfb.c
  U drivers/video/matrox/matroxfb_maven.c


* i2c-2.8.0-drivers-pcmcia.diff

This last patch removes an unused header in sa1100_stork.c. This is not
really related to our problem, but I came accross this file while I was
listing the drivers that needed to be edited, and fixed it. Files
changed:

  U drivers/pcmcia/sa1100_stork.c


Ok, I hope everything is clear. Let me know if you need more details or
any other kind of work.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
--- linux-2.4.21-orig/drivers/i2c/i2c-adap-ite.c	2003-06-16 09:29:59.000000000 +0200
+++ linux-2.4.21-i2c/drivers/i2c/i2c-adap-ite.c	2003-07-11 10:36:30.000000000 +0200
@@ -199,22 +199,6 @@
 }
 
 
-static void iic_ite_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-
-static void iic_ite_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -230,14 +214,13 @@
 };
 
 static struct i2c_adapter iic_ite_ops = {
-	"ITE IIC adapter",
-	I2C_HW_I_IIC,
-	NULL,
-	&iic_ite_data,
-	iic_ite_inc_use,
-	iic_ite_dec_use,
-	iic_ite_reg,
-	iic_ite_unreg,
+	.owner             = THIS_MODULE,
+	.name              = "ITE IIC adapter",
+	.id                = I2C_HW_I_IIC,
+	.algo              = NULL,
+	.algo_data         = &iic_ite_data,
+	.client_register   = iic_ite_reg,
+	.client_unregieter = iic_ite_unreg,
 };
 
 /* Called when the module is loaded.  This function starts the
-------------- next part --------------
--- linux-2.4.21-orig/drivers/i2c/i2c-keywest.c	2003-06-16 09:30:13.000000000 +0200
+++ linux-2.4.21-i2c/drivers/i2c/i2c-keywest.c	2003-07-11 10:50:15.000000000 +0200
@@ -412,18 +412,6 @@
 	       I2C_FUNC_SMBUS_BLOCK_DATA;
 }
 
-static void
-keywest_inc(struct i2c_adapter *adapter)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void
-keywest_dec(struct i2c_adapter *adapter)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm keywest_algorithm = {
 	name:		"Keywest i2c",
@@ -527,14 +515,13 @@
 		struct keywest_chan* chan = &iface->channels[i];
 		u8 addr;
 		
+		chan->adapter.name = THIS_MODULE;
 		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
 		chan->iface = iface;
 		chan->chan_no = i;
 		chan->adapter.id = I2C_ALGO_SMBUS;
 		chan->adapter.algo = &keywest_algorithm;
 		chan->adapter.algo_data = NULL;
-		chan->adapter.inc_use = keywest_inc;
-		chan->adapter.dec_use = keywest_dec;
 		chan->adapter.client_register = NULL;
 		chan->adapter.client_unregister = NULL;
 		chan->adapter.data = chan;
-------------- next part --------------
--- linux-2.4.21-orig/drivers/i2c/scx200_acb.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/i2c/scx200_acb.c	2003-07-11 10:55:56.000000000 +0200
@@ -408,16 +408,6 @@
 	return 0;
 }
 
-static void scx200_acb_inc_use(struct i2c_adapter *adapter)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void scx200_acb_dec_use(struct i2c_adapter *adapter)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* For now, we only handle combined mode (smbus) */
 static struct i2c_algorithm scx200_acb_algorithm = {
 	name:		"NatSemi SCx200 ACCESS.bus",
@@ -479,11 +469,10 @@
 	memset(iface, 0, sizeof(*iface));
 	adapter = &iface->adapter;
 	adapter->data = iface;
+	adapter->owner = THIS_MODULE;
 	sprintf(adapter->name, "SCx200 ACB%d", index);
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
-	adapter->inc_use = scx200_acb_inc_use;
-	adapter->dec_use = scx200_acb_dec_use;
 	adapter->client_register = scx200_acb_reg;
 	adapter->client_unregister = scx200_acb_unreg;
 
-------------- next part --------------
--- linux-2.4.21-orig/drivers/i2c/scx200_i2c.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/i2c/scx200_i2c.c	2003-07-11 10:54:39.000000000 +0200
@@ -76,16 +76,6 @@
 	return 0;
 }
 
-static void scx200_i2c_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void scx200_i2c_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
@@ -101,11 +91,10 @@
 };
 
 static struct i2c_adapter scx200_i2c_ops = {
+	.owner             = THIS_MODULE,
 	.name              = "NatSemi SCx200 I2C",
 	.id		   = I2C_HW_B_VELLE,
 	.algo_data	   = &scx200_i2c_data,
-	.inc_use	   = scx200_i2c_inc_use,
-	.dec_use	   = scx200_i2c_dec_use,
 	.client_register   = scx200_i2c_reg,
 	.client_unregister = scx200_i2c_unreg,
 };
-------------- next part --------------
--- linux-2.4.21-orig/drivers/i2c/Config.in	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/i2c/Config.in	2003-07-11 14:15:43.000000000 +0200
@@ -13,17 +13,22 @@
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
       dep_tristate '  ELV adapter' CONFIG_I2C_ELV $CONFIG_I2C_ALGOBIT
       dep_tristate '  Velleman K9000 adapter' CONFIG_I2C_VELLEMAN $CONFIG_I2C_ALGOBIT
-      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200 $CONFIG_I2C_ALGOBIT
+      dep_tristate '  Basic I2C on Parallel Port' CONFIG_I2C_PPORT $CONFIG_I2C_ALGOBIT
+      if [ "$CONFIG_ARCH_SA1100" = "y" ]; then
+         dep_tristate 'SA1100 I2C Adapter' CONFIG_I2C_FRODO $CONFIG_I2C_ALGOBIT
+      fi
+      dep_tristate '  NatSemi SCx200 I2C using GPIO pins' CONFIG_SCx200_I2C $CONFIG_SCx200_GPIO $CONFIG_I2C_ALGOBIT
       if [ "$CONFIG_SCx200_I2C" != "n" ]; then
          int  '    GPIO pin used for SCL' CONFIG_SCx200_I2C_SCL 12
          int  '    GPIO pin used for SDA' CONFIG_SCx200_I2C_SDA 13
       fi
-      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C
+      dep_tristate '  NatSemi SCx200 ACCESS.bus' CONFIG_SCx200_ACB $CONFIG_I2C_ALGOBIT
    fi
 
    dep_tristate 'I2C PCF 8584 interfaces' CONFIG_I2C_ALGOPCF $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOPCF" != "n" ]; then
       dep_tristate '  Elektor ISA card' CONFIG_I2C_ELEKTOR $CONFIG_I2C_ALGOPCF
+      dep_tristate '  PCF on EPP port' CONFIG_I2C_PCFEPP $CONFIG_I2C_ALGOPCF
    fi
 
    if [ "$CONFIG_MIPS_ITE8172" = "y" ]; then
@@ -35,13 +40,13 @@
    if [ "$CONFIG_8xx" = "y" ]; then
       dep_tristate 'MPC8xx CPM I2C interface' CONFIG_I2C_ALGO8XX $CONFIG_I2C
       if [ "$CONFIG_RPXLITE" = "y" -o "$CONFIG_RPXCLASSIC" = "y" ]; then
-         dep_tristate '  Embedded Planet RPX Lite/Classic suppoort' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
+         dep_tristate '  Embedded Planet RPX Lite/Classic support' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
       fi
    fi
-   if [ "$CONFIG_405" = "y" ]; then
-      dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
-      if [ "$CONFIG_I2C_PPC405_ALGO" != "n" ]; then
-         dep_tristate '  PPC 405 I2C Adapter' CONFIG_I2C_PPC405_ADAP $CONFIG_I2C_PPC405_ALGO
+   if [ "$CONFIG_IBM_OCP" = "y" ]; then
+      dep_tristate 'IBM on-chip I2C Algorithm' CONFIG_I2C_IBM_OCP_ALGO $CONFIG_I2C
+      if [ "$CONFIG_I2C_IBM_OCP_ALGO" != "n" ]; then
+         dep_tristate '  IBM on-chip I2C Adapter' CONFIG_I2C_IBM_OCP_ADAP $CONFIG_I2C_IBM_OCP_ALGO
       fi
    fi
 
@@ -53,7 +58,7 @@
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
 fi
 endmenu
-------------- next part --------------
--- linux-2.4.21-orig/drivers/i2c/Makefile	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/i2c/Makefile	2003-07-11 16:37:48.000000000 +0200
@@ -5,7 +5,8 @@
 O_TARGET := i2c.o
 
 export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
-		   i2c-algo-ite.o i2c-proc.o
+		   i2c-algo-ite.o i2c-proc.o i2c-algo-8xx.o \
+		   i2c-algo-ibm_ocp.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
@@ -13,10 +14,17 @@
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
 obj-$(CONFIG_I2C_VELLEMAN)	+= i2c-velleman.o
+obj-$(CONFIG_I2C_PPORT)		+= i2c-pport.o
+obj-$(CONFIG_I2C_FRODO)		+= i2c-frodo.o
 obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
+obj-$(CONFIG_I2C_PCFEPP)	+= i2c-pcf-epp.o
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
+obj-$(CONFIG_I2C_ALGO_8XX)	+= i2c-algo-8xx.o
+obj-$(CONFIG_I2C_RPXLITE)	+= i2c-rpx.o
+obj-$(CONFIG_I2C_IBM_OCP_ALGO)	+= i2c-algo-ibm_ocp.o
+obj-$(CONFIG_I2C_IBM_OCP_ADAP)	+= i2c-adap-ibm_ocp.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
-------------- next part --------------
diff -ru linux-2.4.21-orig/drivers/acorn/char/i2c.c linux-2.4.21-i2c/drivers/acorn/char/i2c.c
--- linux-2.4.21-orig/drivers/acorn/char/i2c.c	2001-03-03 03:38:37.000000000 +0100
+++ linux-2.4.21-i2c/drivers/acorn/char/i2c.c	2003-07-10 09:46:14.000000000 +0200
@@ -203,11 +203,12 @@
 }
 
 static struct i2c_adapter ioc_ops = {
-	name:			"IOC/IOMD",
-	id:			I2C_HW_B_IOC,
-	algo_data:		&ioc_data,
-	client_register:	ioc_client_reg,
-	client_unregister:	ioc_client_unreg
+	.owner             = THIS_MODULE,
+	.name              = "IOC/IOMD",
+	.id                = I2C_HW_B_IOC,
+	.algo_data         = &ioc_data,
+	.client_register   = ioc_client_reg,
+	.client_unregister = ioc_client_unreg
 };
 
 static int __init i2c_ioc_init(void)
diff -ru linux-2.4.21-orig/drivers/acorn/char/pcf8583.c linux-2.4.21-i2c/drivers/acorn/char/pcf8583.c
--- linux-2.4.21-orig/drivers/acorn/char/pcf8583.c	2003-06-16 09:30:12.000000000 +0200
+++ linux-2.4.21-i2c/drivers/acorn/char/pcf8583.c	2003-07-10 09:56:05.000000000 +0200
@@ -225,12 +225,13 @@
 }
 
 static struct i2c_driver pcf8583_driver = {
-	name:		"PCF8583",
-	id:		I2C_DRIVERID_PCF8583,
-	flags:		I2C_DF_NOTIFY,
-	attach_adapter:	pcf8583_probe,
-	detach_client:	pcf8583_detach,
-	command:	pcf8583_command
+	.owner          = THIS_MODULE,
+	.name           = "PCF8583",
+	.id 	        = I2C_DRIVERID_PCF8583,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = pcf8583_probe,
+	.detach_client  = pcf8583_detach,
+	.command        = pcf8583_command
 };
 
 static __init int pcf8583_init(void)
-------------- next part --------------
diff -ru linux-2.4.21-orig/drivers/ieee1394/pcilynx.c linux-2.4.21-i2c/drivers/ieee1394/pcilynx.c
--- linux-2.4.21-orig/drivers/ieee1394/pcilynx.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/ieee1394/pcilynx.c	2003-07-10 12:02:22.000000000 +0200
@@ -138,6 +138,7 @@
 }; 
 
 static struct i2c_adapter bit_ops = {
+	.owner                  = THIS_MODULE,
 	.id 			= 0xAA, //FIXME: probably we should get an id in i2c-id.h
 	.client_register	= bit_reg,
 	.client_unregister	= bit_unreg,
-------------- next part --------------
diff -ru linux-2.4.21-orig/drivers/media/video/Makefile linux-2.4.21-i2c/drivers/media/video/Makefile
--- linux-2.4.21-orig/drivers/media/video/Makefile	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/Makefile	2003-07-10 09:27:59.000000000 +0200
@@ -40,7 +40,7 @@
 
 obj-$(CONFIG_VIDEO_ZR36120) += zoran.o
 obj-$(CONFIG_I2C_PARPORT) += i2c-parport.o i2c-old.o
-obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o i2c-old.o
+obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o
 obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o
 obj-$(CONFIG_VIDEO_BWQCAM) += bw-qcam.o
 obj-$(CONFIG_VIDEO_W9966) += w9966.o
@@ -48,11 +48,10 @@
 obj-$(CONFIG_VIDEO_ZORAN_BUZ) += saa7111.o saa7185.o
 obj-$(CONFIG_VIDEO_ZORAN_DC10) += saa7110.o adv7175.o
 obj-$(CONFIG_VIDEO_ZORAN_LML33) += bt819.o bt856.o
-obj-$(CONFIG_VIDEO_LML33) += bt856.o bt819.o
 obj-$(CONFIG_VIDEO_PMS) += pms.o
 obj-$(CONFIG_VIDEO_PLANB) += planb.o
 obj-$(CONFIG_VIDEO_VINO) += vino.o
-obj-$(CONFIG_VIDEO_STRADIS) += stradis.o
+obj-$(CONFIG_VIDEO_STRADIS) += stradis.o i2c-old.o
 obj-$(CONFIG_VIDEO_CPIA) += cpia.o
 obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
 obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
@@ -80,8 +79,8 @@
 
 fastdep:
 
-zoran.o: zr36120.o zr36120_i2c.o zr36120_mem.o
-	$(LD) $(LD_RFLAG) -r -o $@ zr36120.o zr36120_i2c.o zr36120_mem.o
+zoran.o: $(zoran-objs)
+	$(LD) $(LD_RFLAG) -r -o $@ $(zoran-objs)
 
 bttv.o: $(bttv-objs)
 	$(LD) $(LD_RFLAG) -r -o $@ $(bttv-objs)
diff -ru linux-2.4.21-orig/drivers/media/video/bt832.c linux-2.4.21-i2c/drivers/media/video/bt832.c
--- linux-2.4.21-orig/drivers/media/video/bt832.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/bt832.c	2003-07-10 10:03:25.000000000 +0200
@@ -257,6 +257,7 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
+        .owner          = THIS_MODULE,
         .name           = "i2c bt832 driver",
         .id             = -1, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/bttv-if.c linux-2.4.21-i2c/drivers/media/video/bttv-if.c
--- linux-2.4.21-orig/drivers/media/video/bttv-if.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/bttv-if.c	2003-07-10 10:03:45.000000000 +0200
@@ -194,16 +194,6 @@
 	return state;
 }
 
-static void bttv_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void bttv_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static int attach_inform(struct i2c_client *client)
 {
         struct bttv *btv = (struct bttv*)client->adapter->data;
@@ -252,8 +242,7 @@
 };
 
 static struct i2c_adapter bttv_i2c_adap_template = {
-	.inc_use           = bttv_inc_use,
-	.dec_use           = bttv_dec_use,
+	.owner             = THIS_MODULE,
 	.name              = "bt848",
 	.id                = I2C_HW_B_BT848,
 	.client_register   = attach_inform,
diff -ru linux-2.4.21-orig/drivers/media/video/i2c-old.c linux-2.4.21-i2c/drivers/media/video/i2c-old.c
--- linux-2.4.21-orig/drivers/media/video/i2c-old.c	2001-09-30 21:26:06.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/i2c-old.c	2003-07-10 09:30:43.000000000 +0200
@@ -36,28 +36,11 @@
 static struct i2c_driver *drivers[I2C_DRIVER_MAX];
 static int bus_count = 0, driver_count = 0;
 
-#ifdef CONFIG_VIDEO_BUZ
-extern int saa7111_init(void);
-extern int saa7185_init(void);
-#endif
-#ifdef CONFIG_VIDEO_LML33
-extern int bt819_init(void);
-extern int bt856_init(void);
-#endif
-
 int i2c_init(void)
 {
 	printk(KERN_INFO "i2c: initialized%s\n",
 		scan ? " (i2c bus scan enabled)" : "");
 	/* anything to do here ? */
-#ifdef CONFIG_VIDEO_BUZ
-	saa7111_init();
-	saa7185_init();
-#endif
-#ifdef CONFIG_VIDEO_LML33
-	bt819_init();
-	bt856_init();
-#endif
 	return 0;
 }
 
diff -ru linux-2.4.21-orig/drivers/media/video/msp3400.c linux-2.4.21-i2c/drivers/media/video/msp3400.c
--- linux-2.4.21-orig/drivers/media/video/msp3400.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/msp3400.c	2003-07-10 10:04:08.000000000 +0200
@@ -1255,6 +1255,7 @@
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
 static struct i2c_driver driver = {
+        .owner          = THIS_MODULE,
         .name           = "i2c msp3400 driver",
         .id             = I2C_DRIVERID_MSP3400,
         .flags          = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/saa5249.c linux-2.4.21-i2c/drivers/media/video/saa5249.c
--- linux-2.4.21-orig/drivers/media/video/saa5249.c	2001-09-30 21:26:06.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/saa5249.c	2003-07-10 10:10:41.000000000 +0200
@@ -258,12 +258,13 @@
 
 static struct i2c_driver i2c_driver_videotext = 
 {
-	IF_NAME,		/* name */
-	I2C_DRIVERID_SAA5249, /* in i2c.h */
-	I2C_DF_NOTIFY,
-	saa5249_probe,
-	saa5249_detach,
-	saa5249_command
+	.owner          = THIS_MODULE,
+	.name           = IF_NAME,
+	.id             = I2C_DRIVERID_SAA5249, /* in i2c-id.h */
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = saa5249_probe,
+	.detach_client  = saa5249_detach,
+	.command        = saa5249_command
 };
 
 static struct i2c_client client_template = {
diff -ru linux-2.4.21-orig/drivers/media/video/saa7146.h linux-2.4.21-i2c/drivers/media/video/saa7146.h
--- linux-2.4.21-orig/drivers/media/video/saa7146.h	2000-12-11 22:15:51.000000000 +0100
+++ linux-2.4.21-i2c/drivers/media/video/saa7146.h	2003-07-09 19:05:33.000000000 +0200
@@ -25,9 +25,6 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#include <linux/i2c.h>
-#include <linux/videodev.h>
-
 #ifndef O_NONCAP  
 #define O_NONCAP	O_TRUNC
 #endif
diff -ru linux-2.4.21-orig/drivers/media/video/tda7432.c linux-2.4.21-i2c/drivers/media/video/tda7432.c
--- linux-2.4.21-orig/drivers/media/video/tda7432.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tda7432.c	2003-07-10 10:11:46.000000000 +0200
@@ -515,6 +515,7 @@
 }
 
 static struct i2c_driver driver = {
+        .owner           = THIS_MODULE,
         .name            = "i2c tda7432 driver",
 	.id              = I2C_DRIVERID_TDA7432,
         .flags           = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/tda9875.c linux-2.4.21-i2c/drivers/media/video/tda9875.c
--- linux-2.4.21-orig/drivers/media/video/tda9875.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tda9875.c	2003-07-10 10:12:16.000000000 +0200
@@ -387,6 +387,7 @@
 
 
 static struct i2c_driver driver = {
+        .owner          = THIS_MODULE,
         .name           = "i2c tda9875 driver",
         .id             = I2C_DRIVERID_TDA9875,
         .flags          = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/tda9887.c linux-2.4.21-i2c/drivers/media/video/tda9887.c
--- linux-2.4.21-orig/drivers/media/video/tda9887.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tda9887.c	2003-07-10 10:12:29.000000000 +0200
@@ -448,6 +448,7 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
+        .owner          = THIS_MODULE,
         .name           = "i2c tda9887 driver",
         .id             = -1, /* FIXME */
         .flags          = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/tuner-3036.c linux-2.4.21-i2c/drivers/media/video/tuner-3036.c
--- linux-2.4.21-orig/drivers/media/video/tuner-3036.c	2001-09-30 21:26:06.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tuner-3036.c	2003-07-10 10:13:28.000000000 +0200
@@ -185,12 +185,13 @@
 static struct i2c_driver 
 i2c_driver_tuner = 
 {
-	"sab3036",		/* name       */
-	I2C_DRIVERID_SAB3036,	/* ID         */
-        I2C_DF_NOTIFY,
-	tuner_probe,
-	tuner_detach,
-	tuner_command
+	.owner          = THIS_MODULE,
+	.name           = "sab3036",
+	.id             = I2C_DRIVERID_SAB3036,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = tuner_probe,
+	.detach_client  = tuner_detach,
+	.command        = tuner_command
 };
 
 static struct i2c_client client_template diff -ru linux-2.4.21-orig/drivers/media/video/tuner.c linux-2.4.21-i2c/drivers/media/video/tuner.c
--- linux-2.4.21-orig/drivers/media/video/tuner.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tuner.c	2003-07-10 10:13:42.000000000 +0200
@@ -961,6 +961,7 @@
 /* ----------------------------------------------------------------------- */
 
 static struct i2c_driver driver = {
+        .owner          = THIS_MODULE,
         .name           = "i2c TV tuner driver",
         .id             = I2C_DRIVERID_TUNER,
         .flags          = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/tvaudio.c linux-2.4.21-i2c/drivers/media/video/tvaudio.c
--- linux-2.4.21-orig/drivers/media/video/tvaudio.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tvaudio.c	2003-07-10 10:13:50.000000000 +0200
@@ -1548,6 +1548,7 @@
 
 
 static struct i2c_driver driver = {
+        .owner           = THIS_MODULE,
         .name            = "generic i2c audio driver",
         .id              = I2C_DRIVERID_TVAUDIO,
         .flags           = I2C_DF_NOTIFY,
diff -ru linux-2.4.21-orig/drivers/media/video/tvmixer.c linux-2.4.21-i2c/drivers/media/video/tvmixer.c
--- linux-2.4.21-orig/drivers/media/video/tvmixer.c	2003-06-16 09:30:27.000000000 +0200
+++ linux-2.4.21-i2c/drivers/media/video/tvmixer.c	2003-07-10 10:14:14.000000000 +0200
@@ -195,8 +195,6 @@
 
 	/* lock bttv in memory while the mixer is in use  */
 	file->private_data = mix;
-	if (client->adapter->inc_use)
-		client->adapter->inc_use(client->adapter);
         return 0;
 }
 
@@ -210,12 +208,11 @@
 		return -ENODEV;
 	}
 
-	if (client->adapter->dec_use)
-		client->adapter->dec_use(client->adapter);
 	return 0;
 }
 
 static struct i2c_driver driver = {
+	.owner           = THIS_MODULE,
 	.name            = "tv card mixer driver",
         .id              = I2C_DRIVERID_TVMIXER,
 	.flags           = I2C_DF_DUMMY,
-------------- next part --------------
diff -ru linux-2.4.21-orig/drivers/sound/dmasound/dac3550a.c linux-2.4.21-i2c/drivers/sound/dmasound/dac3550a.c
--- linux-2.4.21-orig/drivers/sound/dmasound/dac3550a.c	2003-06-16 09:29:49.000000000 +0200
+++ linux-2.4.21-i2c/drivers/sound/dmasound/dac3550a.c	2003-07-10 14:16:36.000000000 +0200
@@ -52,14 +52,13 @@
 };
 
 struct i2c_driver daca_driver = {  
-	name:		"DAC3550A driver  V " DACA_VERSION,
-	id:		I2C_DRIVERID_DACA,
-	flags:		I2C_DF_NOTIFY,
-	attach_adapter:	&daca_attach_adapter,
-	detach_client:	&daca_detach_client,
-	command:	NULL,
-	inc_use:	NULL, /* &daca_inc_use, */
-	dec_use:	NULL  /* &daca_dev_use  */
+	.owner          = THIS_MODULE,
+	.name           = "DAC3550A driver  V " DACA_VERSION,
+	.id             = I2C_DRIVERID_DACA,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = &daca_attach_adapter,
+	.detach_client  = &daca_detach_client,
+	.command        = NULL
   };
 
 
diff -ru linux-2.4.21-orig/drivers/sound/dmasound/tas3001c.c linux-2.4.21-i2c/drivers/sound/dmasound/tas3001c.c
--- linux-2.4.21-orig/drivers/sound/dmasound/tas3001c.c	2003-06-16 09:29:49.000000000 +0200
+++ linux-2.4.21-i2c/drivers/sound/dmasound/tas3001c.c	2003-07-10 14:20:05.000000000 +0200
@@ -90,14 +90,13 @@
 };
 
 struct i2c_driver tas_driver = {  
-	name:		"TAS3001C driver  V 0.3",
-	id:		I2C_DRIVERID_TAS,
-	flags:		I2C_DF_NOTIFY,
-	attach_adapter:	&tas_attach_adapter,
-	detach_client:	&tas_detach_client,
-	command:	NULL,
-	inc_use:	NULL, /* &tas_inc_use, */
-	dec_use:	NULL  /* &tas_dev_use  */
+	.owner          = THIS_MODULE,
+	.name           = "TAS3001C driver  V 0.3",
+	.id             = I2C_DRIVERID_TAS,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = &tas_attach_adapter,
+	.detach_client  = &tas_detach_client,
+	.command        = NULL
 };
 
 int
-------------- next part --------------
diff -ru linux-2.4.21-orig/drivers/video/matrox/i2c-matroxfb.c linux-2.4.21-i2c/drivers/video/matrox/i2c-matroxfb.c
--- linux-2.4.21-orig/drivers/video/matrox/i2c-matroxfb.c	2003-06-16 09:30:29.000000000 +0200
+++ linux-2.4.21-i2c/drivers/video/matrox/i2c-matroxfb.c	2003-07-10 14:35:57.000000000 +0200
@@ -87,19 +87,10 @@
 	return (matroxfb_read_gpio(b->minfo) & b->mask.clock) ? 1 : 0;
 }
 
-static void matroxfb_dh_inc_use(struct i2c_adapter* dummy) {
-	MOD_INC_USE_COUNT;
-}
-
-static void matroxfb_dh_dec_use(struct i2c_adapter* dummy) {
-	MOD_DEC_USE_COUNT;
-}
-
 static struct i2c_adapter matrox_i2c_adapter_template  {
+	.owner =	THIS_MODULE,
 	.id =		I2C_HW_B_G400,
-	.inc_use =	matroxfb_dh_inc_use,
-	.dec_use =	matroxfb_dh_dec_use,
 };
 
 static struct i2c_algo_bit_data matrox_i2c_algo_template diff -ru linux-2.4.21-orig/drivers/video/matrox/matroxfb_maven.c linux-2.4.21-i2c/drivers/video/matrox/matroxfb_maven.c
--- linux-2.4.21-orig/drivers/video/matrox/matroxfb_maven.c	2003-06-16 09:30:29.000000000 +0200
+++ linux-2.4.21-i2c/drivers/video/matrox/matroxfb_maven.c	2003-07-10 14:42:47.000000000 +0200
@@ -1246,14 +1246,6 @@
 static unsigned short normal_i2c_range[] = { MAVEN_I2CID, MAVEN_I2CID, I2C_CLIENT_END };
 I2C_CLIENT_INSMOD;
 
-static void maven_inc_use(struct i2c_client* clnt) {
-	MOD_INC_USE_COUNT;
-}
-
-static void maven_dec_use(struct i2c_client* clnt) {
-	MOD_DEC_USE_COUNT;
-}
-
 static struct i2c_driver maven_driver;
 
 static int maven_detect_client(struct i2c_adapter* adapter, int address, unsigned short flags,
@@ -1320,14 +1312,13 @@
 static int maven_driver_registered = 0;
 
 static struct i2c_driver maven_driver={
-	"maven",
-	I2C_DRIVERID_MGATVO,
-	I2C_DF_NOTIFY,
-	maven_attach_adapter,
-	maven_detach_client,
-	maven_command,
-	maven_inc_use,
-	maven_dec_use
+	.owner          = THIS_MODULE,
+	.name           = "maven",
+	.id             = I2C_DRIVERID_MGATVO,
+	.flags          = I2C_DF_NOTIFY,
+	.attach_adapter = maven_attach_adapter,
+	.detach_client  = maven_detach_client,
+	.command        = maven_command
 };
 
 /* ************************** */
-------------- next part --------------
diff -ru linux-2.4.21-orig/drivers/pcmcia/sa1100_stork.c linux-2.4.21-i2c/drivers/pcmcia/sa1100_stork.c
--- linux-2.4.21-orig/drivers/pcmcia/sa1100_stork.c	2003-06-16 09:30:01.000000000 +0200
+++ linux-2.4.21-i2c/drivers/pcmcia/sa1100_stork.c	2003-07-10 12:15:01.000000000 +0200
@@ -24,7 +24,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/irq.h>
