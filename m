From: clock@twibright.com (Karel Kulhavy)
Date: Sat, 11 Jun 2005 13:50:09 +0000
Subject: [lm-sensors] driver for Twibright I2C2P parallel port adapter
Message-Id: <20050611114914.GA24384@kestrel>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I am sending a driver for 2.6.11.9 kernel for Twibright I2C2P parallel port
adapter ( http://i2c2p.twibright.com ).

The driver was tested to work in the form that is published here:
http://i2c2p.twibright.com/linux/i2c2p.patch . It was tested with
pcf8591 chip as described here:
http://i2c2p.twibright.com/usage.php

However then I stopped working in the place where I developed the
hardware and I don't have any more piece of the hardware.

After sending to Jean Delvare, maintainer written in i2c-parports.c,
I was told to rewrite it. I rewrote the following:
1) As the device needs three distinctive outs to initialize, the
   initializataion was rewritten from .init, .init2 and .init3 to
   more general zero-terminated list.
2) make menuconfig [Help] was improved
3) Instead of decreasing timeout constant from 1s to 10ms (because with
   1s constant it was generating 90s delay on pcf8591 module load when
   the adapter's optically isolated half was unpowered), I rewrote the
   i2c-algo-bit.c to check for -ETIMEDOUT propagating from sclhi()
   upwards, and decreased the constant from 1s to only 500ms.

Please look at the driver and either tell me what needs to be redone or
incorporate it into the kernel.

Cheers,

CL<

diff -Pur /usr/src/linux-2.6.11.9/drivers/i2c/busses/Kconfig busses/Kconfig
--- /usr/src/linux-2.6.11.9/drivers/i2c/busses/Kconfig	2005-05-12 00:42:53.000000000 +0200
+++ busses/Kconfig	2005-05-29 14:05:15.000000000 +0200
@@ -246,9 +246,10 @@
 	select I2C_ALGOBIT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
-	  Philips or Velleman, Analog Devices evaluation boards, and more.
-	  Basically any adapter using the parallel port as an I2C bus with
-	  no extra chipset is supported by this driver, or could be.
+	  Philips or Velleman, Analog Devices evaluation boards, Twibright
+	  I2C2P, and more. Basically any adapter using the parallel port as an
+	  I2C bus with no extra chipset is supported by this driver, or could
+	  be.
 
 	  This driver is a replacement for (and was inspired by) an older
 	  driver named i2c-philips-par.  The new driver supports more devices,
@@ -261,6 +262,35 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-parport.
 
+	  Supported adapters
+	  =========
+	  type	description
+	  -----------------
+	  0	Philips adapter
+	  1	home brew teletext adapter
+	  2 	Velleman K8000 adapter
+	  3	ELV adapter
+	  4	ADM1032 evaluation board
+	  5	ADM1025, ADM1030 and ADM1031 evaluation boards
+	  6	Twibright I2C2P adapter http://i2c2p.twibright.com
+
+	  Setting adapter type
+	  ==========
+	  If this driver is hard-compiled in kernel, add i2c_parport.type=<type
+	  number from table above> to your append string in boot loader
+	  (separate by space if something is already there).
+
+	  If this driver is selected as module, use module option (parameter)
+	  "type=<type number from table above>" (without quotes) for insmod or
+	  modprobe.
+
+	  Note
+	  ==
+	  If I2C2P adapter has not it's optically separated output half
+	  powered, SDA/SCL readback will not work, initialization will fail and
+	  couple seconds delay will be introduced on kernel boot or module
+	  insertion. This doesn't indicate driver malfunction.
+
 config I2C_PARPORT_LIGHT
 	tristate "Parallel port adapter (light)"
 	depends on I2C
diff -Pur /usr/src/linux-2.6.11.9/drivers/i2c/busses/i2c-parport.c busses/i2c-parport.c
--- /usr/src/linux-2.6.11.9/drivers/i2c/busses/i2c-parport.c	2005-05-12 00:42:10.000000000 +0200
+++ busses/i2c-parport.c	2005-06-11 13:23:08.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -131,7 +132,7 @@
 /* Encapsulate the functions above in the correct structure.
    Note that this is only a template, from which the real structures are
    copied. The attaching code will set getscl to NULL for adapters that
-   cannot read SCL back, and will also make the the data field point to
+   cannot read SCL back, and will also make the data field point to
    the parallel port structure. */
 static struct i2c_algo_bit_data parport_algo_data = {
 	.setsda		= parport_setsda,
@@ -140,7 +141,12 @@
 	.getscl		= parport_getscl,
 	.udelay		= 60,
 	.mdelay		= 60,
-	.timeout	= HZ,
+	.timeout	= (HZ+1)/2,
+			/* This is 500ms rounded upwards.
+			 * Parport adapter of type 6 may be
+			 * powered down which introduces a delay to
+			 * machine boot. Therefore it's sensible to keep
+			 * this timeout reasonably low. */
 }; 
 
 /* ----- I2c and parallel port call-back functions and structures --------- */
@@ -152,6 +158,22 @@
 	.name		= "Parallel port adapter",
 };
 
+/* up=1 means start and up=0 stop. Also does a wait after init (and no wait
+ * on deinit). */
+static void start_stop_adapter(struct parport *port,
+		struct adapter_parm* adap, int up)
+{
+	struct lineop *p = adap->init;
+
+	if (p) while (p->val){
+		line_set(port, up, p);
+		p++;
+	}
+
+	if (up&&adap->msleep)
+		msleep_interruptible(adap->msleep);
+}
+
 static void i2c_parport_attach (struct parport *port)
 {
 	struct i2c_par *adapter;
@@ -188,8 +210,7 @@
 	parport_setsda(port, 1);
 	parport_setscl(port, 1);
 	/* Other init if needed (power on...) */
-	if (adapter_parm[type].init.val)
-		line_set(port, 1, &adapter_parm[type].init);
+	start_stop_adapter(port,adapter_parm+type,1);
 
 	parport_release(adapter->pdev);
 
@@ -218,8 +239,7 @@
 	     prev = adapter, adapter = adapter->next) {
 		if (adapter->pdev->port = port) {
 			/* Un-init if needed (power off...) */
-			if (adapter_parm[type].init.val)
-				line_set(port, 0, &adapter_parm[type].init);
+			start_stop_adapter(port, adapter_parm+type,0);
 				
 			i2c_bit_del_bus(&adapter->adapter);
 			parport_unregister_device(adapter->pdev);
diff -Pur /usr/src/linux-2.6.11.9/drivers/i2c/busses/i2c-parport.h busses/i2c-parport.h
--- /usr/src/linux-2.6.11.9/drivers/i2c/busses/i2c-parport.h	2005-05-12 00:43:48.000000000 +0200
+++ busses/i2c-parport.h	2005-06-11 13:29:17.000000000 +0200
@@ -37,28 +37,47 @@
 	struct lineop setscl;
 	struct lineop getsda;
 	struct lineop getscl;
-	struct lineop init;
+	int msleep;		/* Milliseconds to wait after init */
+	struct lineop* init;	/* Zero-terminated list, where an entry with
+				   zero .val serves as terminator. */
 };
 
+static struct lineop adm1032_init[] = {
+				{ 0xf0, DATA, 0},
+				{ 0, 0, 0}, /* End */
+			  };
+static struct lineop i2c2p_init[] = {
+				{ 0xff, DATA, 0},
+				{ 0x04, CTRL, 0},
+				{ 0x02, CTRL, 1},
+				{ 0, 0, 0 } /* End */
+			  };
+
 static struct adapter_parm adapter_parm[] = {
 	/* type 0: Philips adapter */
 	{
-		.setsda	= { 0x80, DATA, 1 },
-		.setscl	= { 0x08, CTRL, 0 },
-		.getsda	= { 0x80, STAT, 0 },
-		.getscl	= { 0x08, STAT, 0 },
+		.setsda = { 0x80, DATA, 1 },
+		.setscl = { 0x08, CTRL, 0 },
+		.getsda = { 0x80, STAT, 0 },
+		.getscl = { 0x08, STAT, 0 },
+		.msleep = 0,
+		.init=NULL,
 	},
 	/* type 1: home brew teletext adapter */
 	{
 		.setsda	= { 0x02, DATA, 0 },
 		.setscl	= { 0x01, DATA, 0 },
 		.getsda	= { 0x80, STAT, 1 },
+		.msleep = 0,
+		.init	= NULL,
 	},
 	/* type 2: Velleman K8000 adapter */
 	{
 		.setsda	= { 0x02, CTRL, 1 },
 		.setscl	= { 0x08, CTRL, 1 },
 		.getsda	= { 0x10, STAT, 0 },
+		.msleep = 0,
+		.init	= NULL,
 	},
 	/* type 3: ELV adapter */
 	{
@@ -66,19 +85,33 @@
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x40, STAT, 1 },
 		.getscl	= { 0x08, STAT, 1 },
+		.msleep = 0,
+		.init	= NULL,
 	},
 	/* type 4: ADM1032 evaluation board */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
-		.init	= { 0xf0, DATA, 0 },
+		.msleep = 0,
+		.init	= adm1032_init,
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
 		.setsda	= { 0x02, DATA, 1 },
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
+		.msleep = 0,
+		.init	= NULL,
+	},
+	/* type 6: Twibright I2C2P adapter */
+	{
+		.setsda = { 0x01, CTRL, 1},
+		.getsda = { 0x80, STAT, 1},
+		.setscl = { 0x08, CTRL, 1},
+		.getscl = { 0x40, STAT, 0},
+		.msleep = 100,
+		.init	= i2c2p_init,
 	},
 };
 
@@ -91,4 +124,6 @@
 	" 2 = Velleman K8000 adapter\n"
 	" 3 = ELV adapter\n"
 	" 4 = ADM1032 evaluation board\n"
-	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
+	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
+	" 6 = Twibright I2C2P adapter\n"
+	"See [Help] in make menuconfig for more info.");
