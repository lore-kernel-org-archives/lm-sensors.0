From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312230123050.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 21 Dec 2003, Ky?sti M?lkki wrote:
> I will prepare a set of incremental patches from the CVS with minimal
> changes, with compatible API. Binary compatibility not maintained.

Jean, here is something to start with. Tested to apply cleanly
over 2.4.23 after your set of 4 patches.

Patch -km-1 :

Remove code for KERNEL_VERSION tests.

Patch -km-2 :

This has .owner and .inc/dec_use for reference counting. Also, C99
initializers and initcalls are imported from i2c CVS head.
No new drivers, SMBus commands or driver ID's. This is about 1/4 of
changes needed to bring 2.4.24 in-sync with i2c 2.8.2.

At least i2c-proc is not yet in sync with 2.8.0, so sensor chips will
not build. I probably forgot some tiny parts elsewhere too but seems
you were working on similar cleanups so maybe this is some assistance.
We cannot get 200kB+ patches through anyway.

I'll prepare some more patches today. Driver ID's, SMBus commands,
and i2c-proc. The in-file revision tag $id has not been in sync with
CVS files for ages and I plan to unexpand them with a separate patch.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
-------------- next part --------------
diff -ur lk-i2c-km-1/Documentation/i2c/writing-clients lk-i2c-km-2/Documentation/i2c/writing-clients
--- lk-i2c-km-1/Documentation/i2c/writing-clients	2003-12-22 19:41:53.000000000 +0200
+++ lk-i2c-km-2/Documentation/i2c/writing-clients	2003-12-22 22:09:34.000000000 +0200
@@ -24,16 +24,14 @@
 routines, a client structure specific information like the actual I2C
 address.
 
-  struct i2c_driver foo_driver
-  {  
-    /* name           */  "Foo version 2.3 and later driver",
-    /* id             */  I2C_DRIVERID_FOO,
-    /* flags          */  I2C_DF_NOTIFY,
-    /* attach_adapter */  &foo_attach_adapter,
-    /* detach_client  */  &foo_detach_client,
-    /* command        */  &foo_command,   /* May be NULL */
-    /* inc_use        */  &foo_inc_use,   /* May be NULL */
-    /* dec_use        */  &foo_dec_use    /* May be NULL */
+  static struct i2c_driver foo_driver = {
+    .owner          = THIS_MODULE,
+    .name           = "Foo version 2.3 driver",
+    .id             = I2C_DRIVERID_FOO, /* usually from i2c-id.h */
+    .flags          = I2C_DF_NOTIFY,
+    .attach_adapter = &foo_attach_adapter,
+    .detach_client  = &foo_detach_client,
+    .command        = &foo_command /* may be NULL */
   }
  
 The name can be chosen freely, and may be upto 40 characters long. Please
diff -ur lk-i2c-km-1/drivers/i2c/i2c-algo-bit.c lk-i2c-km-2/drivers/i2c/i2c-algo-bit.c
--- lk-i2c-km-1/drivers/i2c/i2c-algo-bit.c	2003-12-22 19:41:53.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-algo-bit.c	2003-12-22 22:59:46.000000000 +0200
@@ -18,25 +18,22 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
+/* With some changes from Frodo Looijaard <frodol@dds.nl>, Ky?sti M?lkki
+   <kmalkki@cc.hut.fi> and Jean Delvare <khali@linux-fr.org> */
 
-/* $Id: i2c-algo-bit.c,v 1.30 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.46 2003/11/01 16:20:01 khali Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
-#include <linux/ioport.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
+
 /* ----- global defines ----------------------------------------------- */
 #define DEB(x) if (i2c_debug>=1) x;
 #define DEB2(x) if (i2c_debug>=2) x;
@@ -531,14 +528,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm i2c_bit_algo = {
-	"Bit-shift algorithm",
-	I2C_ALGO_BIT,
-	bit_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	bit_func,			/* functionality	*/
+	.owner		= THIS_MODULE,
+	.name		= "Bit-shift algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= bit_xfer,
+	.functionality	= bit_func,
 };
 
 /* 
@@ -583,42 +577,19 @@
 		printk("\n");
 	}
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
 	i2c_add_adapter(adap);
-
 	return 0;
 }
 
 
 int i2c_bit_del_bus(struct i2c_adapter *adap)
 {
-	int res;
-
-	if ((res = i2c_del_adapter(adap)) < 0)
-		return res;
-
-	DEB2(printk("i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
-
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-	return 0;
-}
-
-int __init i2c_algo_bit_init (void)
-{
-	printk(KERN_INFO "i2c-algo-bit.o: i2c bit algorithm module\n");
-	return 0;
+	return i2c_del_adapter(adap);
 }
 
-
-
 EXPORT_SYMBOL(i2c_bit_add_bus);
 EXPORT_SYMBOL(i2c_bit_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
 MODULE_LICENSE("GPL");
@@ -630,14 +601,4 @@
 MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
 MODULE_PARM_DESC(bit_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
-            "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
-
-int init_module(void) 
-{
-	return i2c_algo_bit_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
+		 "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
diff -ur lk-i2c-km-1/drivers/i2c/i2c-algo-pcf.c lk-i2c-km-2/drivers/i2c/i2c-algo-pcf.c
--- lk-i2c-km-1/drivers/i2c/i2c-algo-pcf.c	2003-12-22 19:41:53.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-algo-pcf.c	2003-12-22 23:22:21.000000000 +0200
@@ -31,13 +31,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
-#include <asm/uaccess.h>
-#include <linux/ioport.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
 #include "i2c-pcf8584.h"
@@ -443,14 +438,11 @@
 /* -----exported algorithm data: -------------------------------------	*/
 
 static struct i2c_algorithm pcf_algo = {
-	"PCF8584 algorithm",
-	I2C_ALGO_PCF,
-	pcf_xfer,
-	NULL,
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	pcf_func,			/* functionality	*/
+	.owner		= THIS_MODULE,
+	.name		= "PCF8584 algorithm",
+	.id		= I2C_ALGO_PCF,
+	.master_xfer	= pcf_xfer,
+	.functionality	= pcf_func,
 };
 
 /* 
@@ -476,10 +468,6 @@
 		return i;
 	}
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
 	i2c_add_adapter(adap);
 
 	/* scan bus */
@@ -511,28 +499,12 @@
 
 int i2c_pcf_del_bus(struct i2c_adapter *adap)
 {
-	int res;
-	if ((res = i2c_del_adapter(adap)) < 0)
-		return res;
-	DEB2(printk("i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
-
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-	return 0;
-}
-
-int __init i2c_algo_pcf_init (void)
-{
-	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module\n");
-	return 0;
+	return i2c_del_adapter(adap);
 }
 
-
 EXPORT_SYMBOL(i2c_pcf_add_bus);
 EXPORT_SYMBOL(i2c_pcf_del_bus);
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
 MODULE_LICENSE("GPL");
@@ -543,14 +515,3 @@
 MODULE_PARM_DESC(pcf_scan, "Scan for active chips on the bus");
 MODULE_PARM_DESC(i2c_debug,
         "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
-
-
-int init_module(void) 
-{
-	return i2c_algo_pcf_init();
-}
-
-void cleanup_module(void) 
-{
-}
-#endif
diff -ur lk-i2c-km-1/drivers/i2c/i2c-core.c lk-i2c-km-2/drivers/i2c/i2c-core.c
--- lk-i2c-km-1/drivers/i2c/i2c-core.c	2003-12-22 20:06:47.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-core.c	2003-12-22 23:43:33.000000000 +0200
@@ -18,24 +18,18 @@
 /* ------------------------------------------------------------------------- */
 
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi>.
-   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl> */
+   All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
+   SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-/* $Id: i2c-core.c,v 1.64 2001/08/13 01:35:56 mds Exp $ */
+/* i2c-core.c,v 1.91.2.2 2003/01/21 10:00:19 kmalkki Exp */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
-#include <linux/config.h>
-
-#include <linux/i2c.h>
-
-/* ----- compatibility stuff ----------------------------------------------- */
-
-#include <linux/version.h>
 #include <linux/init.h>
-
+#include <linux/i2c.h>
 #include <asm/uaccess.h>
 
 /* ----- global defines ---------------------------------------------------- */
@@ -78,7 +72,7 @@
 #ifdef CONFIG_PROC_FS
 
 static int i2cproc_init(void);
-static int i2cproc_cleanup(void);
+static void i2cproc_cleanup(void);
 
 
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
@@ -464,21 +458,27 @@
 
 void i2c_inc_use_client(struct i2c_client *client)
 {
-
-	if (client->driver->inc_use != NULL)
+	if (client->driver->owner)
+		__MOD_INC_USE_COUNT(client->driver->owner);
+	else if (client->driver->inc_use != NULL)
 		client->driver->inc_use(client);
 
-	if (client->adapter->inc_use != NULL)
+	if (client->adapter->owner)
+		__MOD_INC_USE_COUNT(client->adapter->owner);
+	else if (client->adapter->inc_use != NULL)
 		client->adapter->inc_use(client->adapter);
 }
 
 void i2c_dec_use_client(struct i2c_client *client)
 {
-	
-	if (client->driver->dec_use != NULL)
+	if (client->driver->owner)
+		__MOD_DEC_USE_COUNT(client->driver->owner);
+	else if (client->driver->dec_use != NULL)
 		client->driver->dec_use(client);
 
-	if (client->adapter->dec_use != NULL)
+	if (client->adapter->owner)
+		__MOD_DEC_USE_COUNT(client->adapter->owner);
+	else if (client->adapter->dec_use != NULL)
 		client->adapter->dec_use(client->adapter);
 }
 
@@ -591,9 +591,8 @@
 
 #ifdef CONFIG_PROC_FS
 
-
 /* This function generates the output for /proc/bus/i2c */
-int read_bus_i2c(char *buf, char **start, off_t offset, int len, int *eof, 
+static int read_bus_i2c(char *buf, char **start, off_t offset, int len, int *eof, 
                  void *private)
 {
 	int i;
@@ -682,7 +681,7 @@
 	return -ENOENT;
 }
 
-int i2cproc_init(void)
+static int __init i2cproc_init(void)
 {
 
 	struct proc_dir_entry *proc_bus_i2c;
@@ -706,7 +705,7 @@
 	return 0;
 }
 
-int i2cproc_cleanup(void)
+static void __exit i2cproc_cleanup(void)
 {
 
 	if (i2cproc_initialized >= 1) {
@@ -1243,116 +1242,20 @@
 	return 0;
 }
 
-#ifndef MODULE
-#ifdef CONFIG_I2C_CHARDEV
-	extern int i2c_dev_init(void);
-#endif
-#ifdef CONFIG_I2C_ALGOBIT
-	extern int i2c_algo_bit_init(void);
-#endif
-#ifdef CONFIG_I2C_PHILIPSPAR
-	extern int i2c_bitlp_init(void);
-#endif
-#ifdef CONFIG_I2C_ELV
-	extern int i2c_bitelv_init(void);
-#endif
-#ifdef CONFIG_I2C_VELLEMAN
-	extern int i2c_bitvelle_init(void);
-#endif
-#ifdef CONFIG_I2C_BITVIA
-	extern int i2c_bitvia_init(void);
-#endif
-
-#ifdef CONFIG_I2C_ALGOPCF
-	extern int i2c_algo_pcf_init(void);	
-#endif
-#ifdef CONFIG_I2C_ELEKTOR
-	extern int i2c_pcfisa_init(void);
-#endif
-
-#ifdef CONFIG_I2C_ALGO8XX
-	extern int i2c_algo_8xx_init(void);
-#endif
-#ifdef CONFIG_I2C_RPXLITE
-	extern int i2c_rpx_init(void);
-#endif
-
-#ifdef CONFIG_I2C_ALGO_SIBYTE
-	extern int i2c_algo_sibyte_init(void);
-	extern int i2c_sibyte_init(void);
-#endif
-#ifdef CONFIG_I2C_MAX1617
-	extern int i2c_max1617_init(void);
-#endif
-
-#ifdef CONFIG_I2C_PROC
-	extern int sensors_init(void);
+static void __exit i2c_exit(void) 
+{
+#ifdef CONFIG_PROC_FS
+	i2cproc_cleanup();
 #endif
+}
 
-/* This is needed for automatic patch generation: sensors code starts here */
-/* This is needed for automatic patch generation: sensors code ends here   */
-
+/* leave this in for now simply to make patching easier so we don't have
+   to remove the call in drivers/char/mem.c */
 int __init i2c_init_all(void)
 {
-	/* --------------------- global ----- */
-	i2c_init();
-
-#ifdef CONFIG_I2C_CHARDEV
-	i2c_dev_init();
-#endif
-	/* --------------------- bit -------- */
-#ifdef CONFIG_I2C_ALGOBIT
-	i2c_algo_bit_init();
-#endif
-#ifdef CONFIG_I2C_PHILIPSPAR
-	i2c_bitlp_init();
-#endif
-#ifdef CONFIG_I2C_ELV
-	i2c_bitelv_init();
-#endif
-#ifdef CONFIG_I2C_VELLEMAN
-	i2c_bitvelle_init();
-#endif
-
-	/* --------------------- pcf -------- */
-#ifdef CONFIG_I2C_ALGOPCF
-	i2c_algo_pcf_init();	
-#endif
-#ifdef CONFIG_I2C_ELEKTOR
-	i2c_pcfisa_init();
-#endif
-
-	/* --------------------- 8xx -------- */
-#ifdef CONFIG_I2C_ALGO8XX
-	i2c_algo_8xx_init();
-#endif
-#ifdef CONFIG_I2C_RPXLITE
-	i2c_rpx_init();
-#endif
-
-	/* --------------------- SiByte -------- */
-#ifdef CONFIG_I2C_ALGO_SIBYTE
-	i2c_algo_sibyte_init();
-	i2c_sibyte_init();
-#endif
-#ifdef CONFIG_I2C_MAX1617
-	i2c_max1617_init();
-#endif
-
-	/* -------------- proc interface ---- */
-#ifdef CONFIG_I2C_PROC
-	sensors_init();
-#endif
-/* This is needed for automatic patch generation: sensors code starts here */
-/* This is needed for automatic patch generation: sensors code ends here */
-
 	return 0;
 }
 
-#endif
-
-
-
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1389,7 +1292,6 @@
 EXPORT_SYMBOL(i2c_get_functionality);
 EXPORT_SYMBOL(i2c_check_functionality);
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
@@ -1397,13 +1299,5 @@
 MODULE_PARM(i2c_debug, "i");
 MODULE_PARM_DESC(i2c_debug,"debug level");
 
-int init_module(void) 
-{
-	return i2c_init();
-}
-
-void cleanup_module(void) 
-{
-	i2cproc_cleanup();
-}
-#endif
+module_init(i2c_init);
+module_exit(i2c_exit);
diff -ur lk-i2c-km-1/drivers/i2c/i2c-dev.c lk-i2c-km-2/drivers/i2c/i2c-dev.c
--- lk-i2c-km-1/drivers/i2c/i2c-dev.c	2003-12-22 20:06:47.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-dev.c	2003-12-23 01:09:19.000000000 +0200
@@ -28,33 +28,24 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.40 2001/08/25 01:28:01 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.56 2003/11/22 14:57:48 khali Exp $ */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/smp_lock.h>
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
-
-
-/* If you want debugging uncomment: */
-/* #define DEBUG */
-
 #include <linux/init.h>
-#include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
+#include <asm/uaccess.h>
+
+/* If you want debugging uncomment: */
+/* #define DEBUG */
 
-#ifdef MODULE
-extern int init_module(void);
-extern int cleanup_module(void);
-#endif /* def MODULE */
 
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
@@ -74,22 +65,16 @@
 static int i2cdev_command(struct i2c_client *client, unsigned int cmd,
                            void *arg);
 
-#ifdef MODULE
-static
-#else
-extern
-#endif
-       int __init i2c_dev_init(void);
-static int i2cdev_cleanup(void);
+static void i2c_dev_exit(void);
 
 static struct file_operations i2cdev_fops = {
-	owner:		THIS_MODULE,
-	llseek:		no_llseek,
-	read:		i2cdev_read,
-	write:		i2cdev_write,
-	ioctl:		i2cdev_ioctl,
-	open:		i2cdev_open,
-	release:	i2cdev_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= i2cdev_read,
+	.write		= i2cdev_write,
+	.ioctl		= i2cdev_ioctl,
+	.open		= i2cdev_open,
+	.release	= i2cdev_release,
 };
 
 #define I2CDEV_ADAPS_MAX I2C_ADAP_MAX
@@ -100,24 +85,20 @@
 #endif
 
 static struct i2c_driver i2cdev_driver = {
-	name:		"i2c-dev dummy driver",
-	id:		I2C_DRIVERID_I2CDEV,
-	flags:		I2C_DF_DUMMY,
-	attach_adapter:	i2cdev_attach_adapter,
-	detach_client:	i2cdev_detach_client,
-	command:	i2cdev_command,
-/*	inc_use:	NULL,
-	dec_use:	NULL, */
+	.owner		= THIS_MODULE, /* not really used */
+	.name		= "i2c-dev dummy driver",
+	.id		= I2C_DRIVERID_I2CDEV,
+	.flags		= I2C_DF_DUMMY,
+	.attach_adapter	= i2cdev_attach_adapter,
+	.detach_client	= i2cdev_detach_client,
+	.command	= i2cdev_command,
 };
 
 static struct i2c_client i2cdev_client_template = {
-	name:		"I2C /dev entry",
-	id:		1,
-	flags:		0,
-	addr:		-1,
-/*	adapter:	NULL, */
-	driver:		&i2cdev_driver,
-/*	data:		NULL */
+	.name		= "I2C /dev entry",
+	.id		= 1,
+	.addr		= -1,
+	.driver		= &i2cdev_driver,
 };
 
 static int i2cdev_initialized;
@@ -480,7 +461,7 @@
 	return -1;
 }
 
-int __init i2c_dev_init(void)
+static int __init i2c_dev_init(void)
 {
 	int res;
 
@@ -503,14 +484,14 @@
 
 	if ((res = i2c_add_driver(&i2cdev_driver))) {
 		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
-		i2cdev_cleanup();
+		i2c_dev_exit();
 		return res;
 	}
 	i2cdev_initialized ++;
 	return 0;
 }
 
-int i2cdev_cleanup(void)
+static void __exit i2c_dev_exit(void)
 {
 	int res;
 
@@ -541,21 +522,9 @@
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
-
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C /dev entries driver");
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return i2c_dev_init();
-}
-
-int cleanup_module(void)
-{
-	return i2cdev_cleanup();
-}
-
-#endif /* def MODULE */
-
+module_init(i2c_dev_init);
+module_exit(i2c_dev_exit);
diff -ur lk-i2c-km-1/drivers/i2c/i2c-elektor.c lk-i2c-km-2/drivers/i2c/i2c-elektor.c
--- lk-i2c-km-1/drivers/i2c/i2c-elektor.c	2003-12-22 20:06:47.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-elektor.c	2003-12-23 00:11:48.000000000 +0200
@@ -30,14 +30,14 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-
+#include <linux/wait.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
+#include <asm/io.h>
+#include <asm/irq.h>
 #include <linux/i2c-elektor.h>
 #include "i2c-pcf8584.h"
 
@@ -157,70 +157,29 @@
 }
 
 
-static void __exit pcf_isa_exit(void)
-{
-	if (irq > 0) {
-		disable_irq(irq);
-		free_irq(irq, 0);
-	}
-	if (!mmapped) {
-		release_region(base , 2);
-	}
-}
-
-
-static int pcf_isa_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-
-static int pcf_isa_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void pcf_isa_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void pcf_isa_dec_use(struct i2c_adapter *adap)
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
  */
 static struct i2c_algo_pcf_data pcf_isa_data = {
-	NULL,
-	pcf_isa_setbyte,
-	pcf_isa_getbyte,
-	pcf_isa_getown,
-	pcf_isa_getclock,
-	pcf_isa_waitforpin,
-	10, 10, 100,		/*	waits, timeout */
+	.setpcf	    = pcf_isa_setbyte,
+	.getpcf	    = pcf_isa_getbyte,
+	.getown	    = pcf_isa_getown,
+	.getclock   = pcf_isa_getclock,
+	.waitforpin = pcf_isa_waitforpin,
+	.udelay	    = 10,
+	.mdelay	    = 10,
+	.timeout    = HZ,
 };
 
 static struct i2c_adapter pcf_isa_ops = {
-	"PCF8584 ISA adapter",
-	I2C_HW_P_ELEK,
-	NULL,
-	&pcf_isa_data,
-	pcf_isa_inc_use,
-	pcf_isa_dec_use,
-	pcf_isa_reg,
-	pcf_isa_unreg,
+	.owner		   = THIS_MODULE,
+	.name		   = "PCF8584 ISA adapter",
+	.id		   = I2C_HW_P_ELEK,
+	.algo_data	   = &pcf_isa_data,
 };
 
-int __init i2c_pcfisa_init(void) 
+static int __init i2c_pcfisa_init(void) 
 {
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the 
@@ -291,9 +250,20 @@
 }
 
 
+static void __exit pcf_isa_exit(void)
+{
+	if (irq > 0) {
+		disable_irq(irq);
+		free_irq(irq, 0);
+	}
+
+	if (!mmapped) {
+		release_region(base , 2);
+	}
+}
+
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for PCF8584 ISA bus adapter");
 MODULE_LICENSE("GPL");
@@ -305,15 +275,5 @@
 MODULE_PARM(mmapped, "i");
 MODULE_PARM(i2c_debug, "i");
 
-int init_module(void) 
-{
-	return i2c_pcfisa_init();
-}
-
-void cleanup_module(void) 
-{
-	i2c_pcf_del_bus(&pcf_isa_ops);
-	pcf_isa_exit();
-}
-
-#endif
+module_init(i2c_pcfisa_init);
+module_exit(i2c_pcfisa_exit);
diff -ur lk-i2c-km-1/drivers/i2c/i2c-elv.c lk-i2c-km-2/drivers/i2c/i2c-elv.c
--- lk-i2c-km-1/drivers/i2c/i2c-elv.c	2003-12-22 19:41:53.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-elv.c	2003-12-23 00:12:06.000000000 +0200
@@ -21,22 +21,18 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elv.c,v 1.17 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-elv.c,v 1.28 2003/07/25 07:56:42 khali Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
-
-#include <asm/uaccess.h>
-
 #include <linux/ioport.h>
-#include <asm/io.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
 
 #define DEFAULT_BASE 0x378
 static int base=0;
@@ -115,60 +111,28 @@
 	return 0;
 }
 
-static void __exit bit_elv_exit(void)
-{
-	release_region( base , (base = 0x3bc)? 3 : 8 );
-}
-
-static int bit_elv_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int bit_elv_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void bit_elv_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void bit_elv_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
  */
 static struct i2c_algo_bit_data bit_elv_data = {
-	NULL,
-	bit_elv_setsda,
-	bit_elv_setscl,
-	bit_elv_getsda,
-	bit_elv_getscl,
-	80, 80, 100,		/*	waits, timeout */
+	.setsda		= bit_elv_setsda,
+	.setscl		= bit_elv_setscl,
+	.getsda		= bit_elv_getsda,
+	.getscl		= bit_elv_getscl,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
 };
 
 static struct i2c_adapter bit_elv_ops = {
-	"ELV Parallel port adaptor",
-	I2C_HW_B_ELV,
-	NULL,
-	&bit_elv_data,
-	bit_elv_inc_use,
-	bit_elv_dec_use,
-	bit_elv_reg,
-	bit_elv_unreg,	
+	.owner		= THIS_MODULE,
+	.name		= "ELV Parallel port adaptor",
+	.id		= I2C_HW_B_ELV,
+	.algo_data	= &bit_elv_data,
 };
 
-int __init i2c_bitelv_init(void)
+static int __init i2c_bitelv_init(void)
 {
 	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base=0) {
@@ -194,25 +158,19 @@
 	return 0;
 }
 
+static void __exit i2c_bitelv_exit(void)
+{
+	i2c_bit_del_bus(&bit_elv_ops);
+	release_region(base , (base = 0x3bc) ? 3 : 8);
+}
 
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for ELV parallel port adapter");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(base, "i");
 
-int init_module(void)
-{
-	return i2c_bitelv_init();
-}
-
-void cleanup_module(void)
-{
-	i2c_bit_del_bus(&bit_elv_ops);
-	bit_elv_exit();
-}
-
-#endif
+module_init(i2c_bitelv_init);
+module_exit(i2c_bitelv_exit);
diff -ur lk-i2c-km-1/drivers/i2c/i2c-philips-par.c lk-i2c-km-2/drivers/i2c/i2c-philips-par.c
--- lk-i2c-km-1/drivers/i2c/i2c-philips-par.c	2003-12-22 20:06:47.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-philips-par.c	2003-12-23 00:12:24.000000000 +0200
@@ -21,7 +21,7 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-philips-par.c,v 1.18 2000/07/06 19:21:49 frodo Exp $ */
+/* $Id: i2c-philips-par.c,v 1.31 2003/07/25 08:44:13 khali Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/ioport.h>
@@ -29,14 +29,10 @@
 #include <linux/init.h>
 #include <linux/stddef.h>
 #include <linux/parport.h>
-
+#include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-#ifndef __exit
-#define __exit __init
-#endif
-
 static int type;
 
 struct i2c_par
@@ -130,25 +126,6 @@
 			             PARPORT_STATUS_BUSY) ? 0 : 1;
 }
 
-static int bit_lp_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int bit_lp_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static void bit_lp_inc_use(struct i2c_adapter *adap)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void bit_lp_dec_use(struct i2c_adapter *adap)
-{
-	MOD_DEC_USE_COUNT;
-}
 
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
@@ -156,33 +133,28 @@
  */
  
 static struct i2c_algo_bit_data bit_lp_data = {
-	NULL,
-	bit_lp_setsda,
-	bit_lp_setscl,
-	bit_lp_getsda,
-	bit_lp_getscl,
-	80, 80, 100,		/*	waits, timeout */
+	.setsda		= bit_lp_setsda,
+	.setscl		= bit_lp_setscl,
+	.getsda		= bit_lp_getsda,
+	.getscl		= bit_lp_getscl,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
 }; 
 
 static struct i2c_algo_bit_data bit_lp_data2 = {
-	NULL,
-	bit_lp_setsda2,
-	bit_lp_setscl2,
-	bit_lp_getsda2,
-	NULL,
-	80, 80, 100,		/*	waits, timeout */
+	.setsda		= bit_lp_setsda2,
+	.setscl		= bit_lp_setscl2,
+	.getsda		= bit_lp_getsda2,
+	.udelay		= 80,
+	.mdelay		= 80,
+	.timeout	= HZ
 }; 
 
 static struct i2c_adapter bit_lp_ops = {
-	"Philips Parallel port adapter",
-	I2C_HW_B_LP,
-	NULL,
-	NULL,
-	bit_lp_inc_use,
-	bit_lp_dec_use,
-	bit_lp_reg,
-
-	bit_lp_unreg,
+	.owner		= THIS_MODULE,
+	.name		= "Philips Parallel port adapter",
+	.id		= I2C_HW_B_LP,
 };
 
 static void i2c_parport_attach (struct parport *port)
@@ -257,15 +229,16 @@
 	NULL
 };
 
-int __init i2c_bitlp_init(void)
+static int __init i2c_bitlp_init(void)
 {
- 	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	parport_register_driver(&i2c_driver);
+	
 	return 0;
 }
 
-void __exit i2c_bitlp_exit(void)
+static void __exit i2c_bitlp_exit(void)
 {
 	parport_unregister_driver(&i2c_driver);
 }
@@ -278,14 +251,5 @@
 
 MODULE_PARM(type, "i");
 
-#ifdef MODULE
-int init_module(void)
-{
-	return i2c_bitlp_init();
-}
-
-void cleanup_module(void)
-{
-	i2c_bitlp_exit();
-}
-#endif
+module_init(i2c_bitlp_init);
+module_exit(i2c_bitlp_exit);
diff -ur lk-i2c-km-1/drivers/i2c/i2c-proc.c lk-i2c-km-2/drivers/i2c/i2c-proc.c
--- lk-i2c-km-1/drivers/i2c/i2c-proc.c	2003-12-22 20:06:47.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-proc.c	2003-12-22 21:09:37.000000000 +0200
@@ -23,20 +23,17 @@
     This driver puts entries in /proc/sys/dev/sensors for each I2C device
 */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
-#include <asm/uaccess.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-proc.h>
-
-#include <linux/init.h>
+#include <asm/uaccess.h>
 
 #ifndef THIS_MODULE
 #define THIS_MODULE NULL
@@ -56,8 +53,6 @@
 				void *newval, size_t newlen,
 				void **context);
 
-int __init sensors_init(void);
-
 #define SENSORS_ENTRY_MAX 20
 static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
 
@@ -847,7 +842,7 @@
 	return 0;
 }
 
-int __init sensors_init(void)
+static int __init i2c_proc_init(void)
 {
 	printk(KERN_INFO "i2c-proc.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	i2c_initialized = 0;
@@ -859,34 +854,20 @@
 	return 0;
 }
 
+static void __exit i2c_proc_exit(void)
+{
+	unregister_sysctl_table(i2c_proc_header);
+}
+
+EXPORT_SYMBOL(i2c_register_entry);
 EXPORT_SYMBOL(i2c_deregister_entry);
-EXPORT_SYMBOL(i2c_detect);
 EXPORT_SYMBOL(i2c_proc_real);
-EXPORT_SYMBOL(i2c_register_entry);
 EXPORT_SYMBOL(i2c_sysctl_real);
-
-#ifdef MODULE
+EXPORT_SYMBOL(i2c_detect);
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
 MODULE_DESCRIPTION("i2c-proc driver");
 MODULE_LICENSE("GPL");
 
-int i2c_cleanup(void)
-{
-	if (i2c_initialized >= 1) {
-		unregister_sysctl_table(i2c_proc_header);
-		i2c_initialized--;
-	}
-	return 0;
-}
-
-int init_module(void)
-{
-	return sensors_init();
-}
-
-int cleanup_module(void)
-{
-	return i2c_cleanup();
-}
-#endif				/* MODULE */
+module_init(i2c_proc_init);
+module_exit(i2c_proc_exit);
diff -ur lk-i2c-km-1/drivers/i2c/i2c-velleman.c lk-i2c-km-2/drivers/i2c/i2c-velleman.c
--- lk-i2c-km-1/drivers/i2c/i2c-velleman.c	2003-12-22 19:41:53.000000000 +0200
+++ lk-i2c-km-2/drivers/i2c/i2c-velleman.c	2003-12-23 00:12:39.000000000 +0200
@@ -18,18 +18,18 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-velleman.c,v 1.19 2000/01/24 02:06:33 mds Exp $ */
+/* $Id: i2c-velleman.c,v 1.31 2003/07/25 08:44:13 khali Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/string.h>  /* for 2.0 kernels to get NULL   */
-#include <asm/errno.h>     /* for 2.0 kernels to get ENODEV */
-#include <asm/io.h>
-
+#include <linux/errno.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <asm/io.h>
+#include <asm/param.h> /* for HZ */
 
 /* ----- global defines -----------------------------------------------	*/
 #define DEB(x)		/* should be reasonable open, close &c. 	*/
@@ -90,75 +90,38 @@
 
 static int bit_velle_init(void)
 {
-	if (check_region(base,(base = 0x3bc)? 3 : 8) < 0 ) {
-		DEBE(printk("i2c-velleman.o: Port %#x already in use.\n",
-		     base));
+	if (!request_region(base, (base = 0x3bc) ? 3 : 8, 
+			"i2c (Vellemann adapter)"))
 		return -ENODEV;
-	} else {
-		request_region(base, (base = 0x3bc)? 3 : 8, 
-			"i2c (Vellemann adapter)");
-		bit_velle_setsda((void*)base,1);
-		bit_velle_setscl((void*)base,1);
-	}
-	return 0;
-}
 
-static void __exit bit_velle_exit(void)
-{	
-	release_region( base , (base = 0x3bc)? 3 : 8 );
-}
-
-
-static int bit_velle_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int bit_velle_unreg(struct i2c_client *client)
-{
+	bit_velle_setsda((void*)base,1);
+	bit_velle_setscl((void*)base,1);
 	return 0;
 }
 
-static void bit_velle_inc_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void bit_velle_dec_use(struct i2c_adapter *adap)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
  */
 
 static struct i2c_algo_bit_data bit_velle_data = {
-	NULL,
-	bit_velle_setsda,
-	bit_velle_setscl,
-	bit_velle_getsda,
-	bit_velle_getscl,
-	10, 10, 100,		/*	waits, timeout */
+	.setsda		= bit_velle_setsda,
+	.setscl		= bit_velle_setscl,
+	.getsda		= bit_velle_getsda,
+	.getscl		= bit_velle_getscl,
+	.udelay		= 10,
+	.mdelay		= 10,
+	.timeout	= HZ
 };
 
 static struct i2c_adapter bit_velle_ops = {
-	"Velleman K8000",
-	I2C_HW_B_VELLE,
-	NULL,
-	&bit_velle_data,
-	bit_velle_inc_use,
-	bit_velle_dec_use,
-	bit_velle_reg,
-	bit_velle_unreg,
+	.owner		= THIS_MODULE,
+	.name		= "Velleman K8000",
+	.id		= I2C_HW_B_VELLE,
+	.algo_data	= &bit_velle_data,
 };
 
-int __init  i2c_bitvelle_init(void)
+static int __init i2c_bitvelle_init(void)
 {
 	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base=0) {
@@ -184,24 +147,19 @@
 	return 0;
 }
 
+static void __exit i2c_bitvelle_exit(void)
+{	
+	i2c_bit_del_bus(&bit_velle_ops);
+	release_region(base, (base = 0x3bc) ? 3 : 8);
+}
+
 EXPORT_NO_SYMBOLS;
 
-#ifdef MODULE
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus adapter routines for Velleman K8000 adapter");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(base, "i");
 
-int init_module(void) 
-{
-	return i2c_bitvelle_init();
-}
-
-void cleanup_module(void) 
-{
-	i2c_bit_del_bus(&bit_velle_ops);
-	bit_velle_exit();
-}
-
-#endif
+module_init(i2c_bitvelle_init);
+module_exit(i2c_bitvelle_exit);
diff -ur lk-i2c-km-1/drivers/media/video/saa7110.c lk-i2c-km-2/drivers/media/video/saa7110.c
--- lk-i2c-km-1/drivers/media/video/saa7110.c	2003-12-22 19:41:53.000000000 +0200
+++ lk-i2c-km-2/drivers/media/video/saa7110.c	2003-12-22 21:14:26.000000000 +0200
@@ -404,7 +404,7 @@
 {
 	"saa7110",			/* name */
 
-	I2C_DRIVERID_VIDEODECODER,	/* in i2c-old.h */
+	I2C_DRIVERID_VIDEODECODER,	/* in i2c.h */
 	I2C_SAA7110, I2C_SAA7110+1,	/* Addr range */
 
 	saa7110_attach,
diff -ur lk-i2c-km-1/include/linux/i2c-algo-bit.h lk-i2c-km-2/include/linux/i2c-algo-bit.h
--- lk-i2c-km-1/include/linux/i2c-algo-bit.h	2003-11-25 21:47:32.000000000 +0200
+++ lk-i2c-km-2/include/linux/i2c-algo-bit.h	2003-12-22 20:46:16.000000000 +0200
@@ -21,12 +21,10 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.h,v 1.7 1999/12/21 23:45:58 frodo Exp $ */
+/* $Id: i2c-algo-bit.h,v 1.11 2003/07/25 07:56:42 khali Exp $ */
 
-#ifndef I2C_ALGO_BIT_H
-#define I2C_ALGO_BIT_H 1
-
-#include <linux/i2c.h>
+#ifndef _LINUX_I2C_ALGO_BIT_H
+#define _LINUX_I2C_ALGO_BIT_H
 
 /* --- Defines for bit-adapters ---------------------------------------	*/
 /*
@@ -42,9 +40,10 @@
 	int  (*getscl) (void *data);
 
 	/* local settings */
-	int udelay;
-	int mdelay;
-	int timeout;
+	int udelay;		/* half-clock-cycle time in microsecs */
+				/* i.e. clock is (500 / udelay) KHz */
+	int mdelay;		/* in millisecs, unused */
+	int timeout;		/* in jiffies */
 };
 
 #define I2C_BIT_ADAP_MAX	16
@@ -52,4 +51,4 @@
 int i2c_bit_add_bus(struct i2c_adapter *);
 int i2c_bit_del_bus(struct i2c_adapter *);
 
-#endif /* I2C_ALGO_BIT_H */
+#endif /* _LINUX_I2C_ALGO_BIT_H */
diff -ur lk-i2c-km-1/include/linux/i2c-algo-pcf.h lk-i2c-km-2/include/linux/i2c-algo-pcf.h
--- lk-i2c-km-1/include/linux/i2c-algo-pcf.h	2000-12-11 23:22:34.000000000 +0200
+++ lk-i2c-km-2/include/linux/i2c-algo-pcf.h	2003-12-22 20:50:15.000000000 +0200
@@ -22,13 +22,12 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-pcf.h,v 1.7 2000/02/27 23:02:45 frodo Exp $ */
+/* $Id: i2c-algo-pcf.h,v 1.9 2003/07/25 07:56:42 khali Exp $ */
 
-#ifndef I2C_ALGO_PCF_H
-#define I2C_ALGO_PCF_H 1
+#ifndef _LINUX_I2C_ALGO_PCF_H
+#define _LINUX_I2C_ALGO_PCF_H
 
-/* --- Defines for pcf-adapters ---------------------------------------	*/
-#include <linux/i2c.h>
+#include <linux/i2c-pcf8584.h>
 
 struct i2c_algo_pcf_data {
 	void *data;		/* private data for lolevel routines	*/
@@ -49,4 +48,4 @@
 int i2c_pcf_add_bus(struct i2c_adapter *);
 int i2c_pcf_del_bus(struct i2c_adapter *);
 
-#endif /* I2C_ALGO_PCF_H */
+#endif /* _LINUX_I2C_ALGO_PCF_H */
diff -ur lk-i2c-km-1/include/linux/i2c-dev.h lk-i2c-km-2/include/linux/i2c-dev.h
--- lk-i2c-km-1/include/linux/i2c-dev.h	2003-11-25 21:47:29.000000000 +0200
+++ lk-i2c-km-2/include/linux/i2c-dev.h	2003-12-23 00:41:47.000000000 +0200
@@ -19,14 +19,12 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-/* $Id: i2c-dev.h,v 1.9 2001/08/15 03:04:58 mds Exp $ */
-
-#ifndef I2C_DEV_H
-#define I2C_DEV_H
+/* $Id: i2c-dev.h,v 1.14 2003/07/25 07:56:42 khali Exp $ */
 
+#ifndef _LINUX_I2C_DEV_H
+#define _LINUX_I2C_DEV_H
 
 #include <linux/types.h>
-#include <linux/i2c.h>
 
 /* Some IOCTL commands are defined in <linux/i2c.h> */
 /* Note: 10-bit addresses are NOT supported! */
diff -ur lk-i2c-km-1/include/linux/i2c-id.h lk-i2c-km-2/include/linux/i2c-id.h
--- lk-i2c-km-1/include/linux/i2c-id.h	2003-12-22 19:42:42.000000000 +0200
+++ lk-i2c-km-2/include/linux/i2c-id.h	2003-12-22 20:50:13.000000000 +0200
@@ -20,10 +20,11 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.35 2001/08/12 17:22:20 mds Exp $ */
+/* $Id: i2c-id.h,v 1.84 2003/11/22 14:58:51 khali Exp $ */
+
+#ifndef LINUX_I2C_ID_H
+#define LINUX_I2C_ID_H
 
-#ifndef I2C_ID_H
-#define I2C_ID_H
 /*
  * This file is part of the i2c-bus package and contains the identifier
  * values for drivers, adapters and other folk populating these serial
diff -ur lk-i2c-km-1/include/linux/i2c-proc.h lk-i2c-km-2/include/linux/i2c-proc.h
--- lk-i2c-km-1/include/linux/i2c-proc.h	2003-11-25 21:47:36.000000000 +0200
+++ lk-i2c-km-2/include/linux/i2c-proc.h	2003-12-22 22:09:37.000000000 +0200
@@ -1,6 +1,7 @@
 /*
-    sensors.h - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
+    i2c-proc.h - Part of the i2c package
+    was originally sensors.h - Part of lm_sensors, Linux kernel modules
+                               for hardware monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
 
     This program is free software; you can redistribute it and/or modify
@@ -18,14 +19,9 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#ifndef SENSORS_SENSORS_H
-#define SENSORS_SENSORS_H
+#ifndef _LINUX_I2C_PROC_H
+#define _LINUX_I2C_PROC_H
 
-#ifdef __KERNEL__
-
-/* Next two must be included before sysctl.h can be included, in 2.0 kernels */
-#include <linux/types.h>
-#include <linux/fs.h>
 #include <linux/sysctl.h>
 
 /* The type of callback functions used in sensors_{proc,sysctl}_real */
@@ -362,7 +358,7 @@
 
 /* This macro is used to scale user-input to sensible values in almost all
    chip drivers. */
-extern inline int SENSORS_LIMIT(long value, long low, long high)
+static inline int SENSORS_LIMIT(long value, long low, long high)
 {
 	if (value < low)
 		return low;
@@ -372,8 +368,6 @@
 		return value;
 }
 
-#endif				/* def __KERNEL__ */
-
 
 /* The maximum length of the prefix */
 #define SENSORS_PREFIX_MAX 20
@@ -392,5 +386,5 @@
 	char name[SENSORS_PREFIX_MAX + 13];
 };
 
-#endif				/* def SENSORS_SENSORS_H */
+#endif				/* def _LINUX_I2C_PROC_H */
 
diff -ur lk-i2c-km-1/include/linux/i2c.h lk-i2c-km-2/include/linux/i2c.h
--- lk-i2c-km-1/include/linux/i2c.h	2003-12-22 20:06:47.000000000 +0200
+++ lk-i2c-km-2/include/linux/i2c.h	2003-12-23 00:41:41.000000000 +0200
@@ -23,39 +23,28 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c.h,v 1.46 2001/08/31 00:04:07 phil Exp $ */
+/* $Id: i2c.h,v 1.72 2003/10/05 23:54:10 phil Exp $ */
 
-#ifndef I2C_H
-#define I2C_H
+#ifndef _LINUX_I2C_H
+#define _LINUX_I2C_H
 
-#define I2C_DATE "20010830"
-#define I2C_VERSION "2.6.1"
+#define I2C_DATE "20031005"
+#define I2C_VERSION "2.8.1"
 
-#include <linux/i2c-id.h>	/* id values of adapters et. al. 	*/
+#include <linux/module.h>
 #include <linux/types.h>
-
-
-struct i2c_msg;
-
-
-#ifdef __KERNEL__
-
-/* --- Includes and compatibility declarations ------------------------ */
-
-#include <linux/version.h>
-
-#include <asm/page.h>			/* for 2.2.xx 			*/
+#include <linux/errno.h>
+#include <linux/sched.h>
 #include <asm/semaphore.h>
-#include <linux/config.h>
+#include <linux/i2c-id.h>
 
 /* --- General options ------------------------------------------------	*/
 
-#define I2C_ALGO_MAX	4		/* control memory consumption	*/
-#define I2C_ADAP_MAX	16
+#define I2C_ADAP_MAX	16		/* control memory consumption	*/
 #define I2C_DRIVER_MAX	16
 #define I2C_CLIENT_MAX	32
-#define I2C_DUMMY_MAX 4
 
+struct i2c_msg;
 struct i2c_algorithm;
 struct i2c_adapter;
 struct i2c_client;
@@ -63,7 +52,6 @@
 struct i2c_client_address_data;
 union i2c_smbus_data;
 
-
 /*
  * The master routines are the ones normally used to transmit data to devices
  * on a bus (or read from them). Apart from two basic transfer functions to 
@@ -128,6 +116,7 @@
  */
 
 struct i2c_driver {
+	struct module *owner;
 	char name[32];
 	int id;
 	unsigned int flags;		/* div., see below		*/
@@ -195,6 +184,7 @@
  * to name two of the most common.
  */
 struct i2c_algorithm {
+	struct module *owner;			/* future use --km	*/
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
@@ -219,12 +209,12 @@
 	u32 (*functionality) (struct i2c_adapter *);
 };
 
-
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
  * with the access algorithms necessary to access it.
  */
 struct i2c_adapter {
+	struct module *owner;
 	char name[32];	/* some useful name to identify the adapter	*/
 	unsigned int id;/* = is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
@@ -362,8 +352,6 @@
 /* Return 1 if adapter supports everything we need, 0 if not. */
 extern int i2c_check_functionality (struct i2c_adapter *adap, u32 func);
 
-#endif /* __KERNEL__ */
-
 /*
  * I2C Message - used for pure i2c transaction, also from /dev interface
  */
@@ -476,16 +464,6 @@
 
 #define I2C_MAJOR	89		/* Device major number		*/
 
-#ifdef __KERNEL__
-
-#  ifndef NULL
-#    define NULL ( (void *) 0 )
-#  endif
-
-#  ifndef ENODEV
-#    include <asm/errno.h>
-#  endif
-
 /* These defines are used for probing i2c client addresses */
 /* Default fill of many variables */
 #define I2C_CLIENT_DEFAULTS {I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
@@ -547,5 +525,11 @@
 #define i2c_is_isa_adapter(adapptr) \
         ((adapptr)->algo->id = I2C_ALGO_ISA)
 
-#endif /* def __KERNEL__ */
-#endif /* I2C_H */
+/* Tiny delay function used by the i2c bus drivers */
+static inline void i2c_delay(signed long timeout)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(timeout);
+}
+
+#endif /* _LINUX_I2C_H */
-------------- next part --------------
diff -ur lk-2.4.23-i2c-khali/drivers/i2c/i2c-core.c lk-2.4.23-i2c-km/drivers/i2c/i2c-core.c
--- lk-2.4.23-i2c-khali/drivers/i2c/i2c-core.c	2003-12-22 16:05:44.000000000 +0200
+++ lk-2.4.23-i2c-km/drivers/i2c/i2c-core.c	2003-12-22 18:35:10.000000000 +0200
@@ -36,10 +36,6 @@
 #include <linux/version.h>
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
-#endif
-
 #include <asm/uaccess.h>
 
 /* ----- global defines ---------------------------------------------------- */
@@ -84,9 +80,6 @@
 static int i2cproc_init(void);
 static int i2cproc_cleanup(void);
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-static void monitor_bus_i2c(struct inode *inode, int fill);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
 
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
                                 loff_t *ppos);
@@ -99,11 +92,6 @@
 	read:		i2cproc_bus_read,
 };
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,48))
-static struct inode_operations i2cproc_inode_operations = {
-	&i2cproc_operations
-};
-#endif
 
 static int i2cproc_initialized = 0;
 
@@ -164,16 +152,8 @@
 			goto ERROR1;
 		}
 
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,48))
 		proc_entry->proc_fops = &i2cproc_operations;
-#else
-		proc_entry->ops = &i2cproc_inode_operations;
-#endif
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 		proc_entry->owner = THIS_MODULE;
-#else
-		proc_entry->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
 		adap->inode = proc_entry->low_ino;
 	}
 
@@ -611,17 +591,6 @@
 
 #ifdef CONFIG_PROC_FS
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-/* Monitor access to /proc/bus/i2c*; make unloading i2c-proc impossible
-   if some process still uses it or some file in it */
-void monitor_bus_i2c(struct inode *inode, int fill)
-{
-	if (fill)
-		MOD_INC_USE_COUNT;
-	else
-		MOD_DEC_USE_COUNT;
-}
-#endif /* (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,37)) */
 
 /* This function generates the output for /proc/bus/i2c */
 int read_bus_i2c(char *buf, char **start, off_t offset, int len, int *eof, 
@@ -732,11 +701,7 @@
 		return -ENOENT;
  	}
 	proc_bus_i2c->read_proc = &read_bus_i2c;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 	proc_bus_i2c->owner = THIS_MODULE;
-#else
-	proc_bus_i2c->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 	i2cproc_initialized += 2;
 	return 0;
 }
diff -ur lk-2.4.23-i2c-khali/drivers/i2c/i2c-dev.c lk-2.4.23-i2c-km/drivers/i2c/i2c-dev.c
--- lk-2.4.23-i2c-khali/drivers/i2c/i2c-dev.c	2003-12-22 16:05:44.000000000 +0200
+++ lk-2.4.23-i2c-km/drivers/i2c/i2c-dev.c	2003-12-22 18:35:10.000000000 +0200
@@ -36,9 +36,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/version.h>
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 #include <linux/smp_lock.h>
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
@@ -60,9 +58,6 @@
 
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-static loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin);
-#endif
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
                             loff_t *offset);
 static ssize_t i2cdev_write (struct file *file, const char *buf, size_t count, 
@@ -88,14 +83,8 @@
 static int i2cdev_cleanup(void);
 
 static struct file_operations i2cdev_fops = {
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 	owner:		THIS_MODULE,
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-	llseek:		i2cdev_lseek,
-#else
 	llseek:		no_llseek,
-#endif
 	read:		i2cdev_read,
 	write:		i2cdev_write,
 	ioctl:		i2cdev_ioctl,
@@ -133,20 +122,6 @@
 
 static int i2cdev_initialized;
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-/* Note that the lseek function is called llseek in 2.1 kernels. But things
-   are complicated enough as is. */
-loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin)
-{
-#ifdef DEBUG
-	struct inode *inode = file->f_dentry->d_inode;
-	printk("i2c-dev.o: i2c-%d lseek to %ld bytes relative to %d.\n",
-	       MINOR(inode->i_rdev),(long) offset,origin);
-#endif /* DEBUG */
-	return -ESPIPE;
-}
-#endif
-
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count,
                             loff_t *offset)
 {
@@ -434,9 +409,6 @@
 
 	if (i2cdev_adaps[minor]->inc_use)
 		i2cdev_adaps[minor]->inc_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-	MOD_INC_USE_COUNT;
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
@@ -452,16 +424,10 @@
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
 #endif
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-	MOD_DEC_USE_COUNT;
-#else /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 	lock_kernel();
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 	if (i2cdev_adaps[minor]->dec_use)
 		i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 	unlock_kernel();
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 	return 0;
 }
 
diff -ur lk-2.4.23-i2c-khali/drivers/i2c/i2c-elektor.c lk-2.4.23-i2c-km/drivers/i2c/i2c-elektor.c
--- lk-2.4.23-i2c-khali/drivers/i2c/i2c-elektor.c	2003-12-22 16:05:44.000000000 +0200
+++ lk-2.4.23-i2c-km/drivers/i2c/i2c-elektor.c	2003-12-22 18:35:10.000000000 +0200
@@ -55,11 +55,7 @@
   in some functions, called from the algo-pcf module. Sometimes it's
   need to be rewriten - but for now just remove this for simpler reading */
 
-#if (LINUX_VERSION_CODE < 0x020301)
-static struct wait_queue *pcf_wait = NULL;
-#else
 static wait_queue_head_t pcf_wait;
-#endif
 static int pcf_pending;
 
 /* ----- global defines -----------------------------------------------	*/
@@ -281,9 +277,7 @@
 		base = DEFAULT_BASE;
 	}
 
-#if (LINUX_VERSION_CODE >= 0x020301)
 	init_waitqueue_head(&pcf_wait);
-#endif
 	if (pcf_isa_init() = 0) {
 		if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
 			return -ENODEV;
diff -ur lk-2.4.23-i2c-khali/drivers/i2c/i2c-philips-par.c lk-2.4.23-i2c-km/drivers/i2c/i2c-philips-par.c
--- lk-2.4.23-i2c-khali/drivers/i2c/i2c-philips-par.c	2003-12-22 16:05:44.000000000 +0200
+++ lk-2.4.23-i2c-km/drivers/i2c/i2c-philips-par.c	2003-12-22 18:39:06.000000000 +0200
@@ -250,41 +250,24 @@
 }
 
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 static struct parport_driver i2c_driver = {
 	"i2c-philips-par",
 	i2c_parport_attach,
 	i2c_parport_detach,
 	NULL
 };
-#endif
 
 int __init i2c_bitlp_init(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
-	struct parport *port;
-#endif
-	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+ 	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_register_driver(&i2c_driver);
-#else
-	for (port = parport_enumerate(); port; port=port->next)
-		i2c_parport_attach(port);
-#endif
-	
 	return 0;
 }
 
 void __exit i2c_bitlp_exit(void)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_unregister_driver(&i2c_driver);
-#else
-	struct parport *port;
-	for (port = parport_enumerate(); port; port=port->next)
-		i2c_parport_detach(port);
-#endif
 }
 
 EXPORT_NO_SYMBOLS;
diff -ur lk-2.4.23-i2c-khali/drivers/i2c/i2c-proc.c lk-2.4.23-i2c-km/drivers/i2c/i2c-proc.c
--- lk-2.4.23-i2c-khali/drivers/i2c/i2c-proc.c	2003-12-22 16:05:44.000000000 +0200
+++ lk-2.4.23-i2c-km/drivers/i2c/i2c-proc.c	2003-12-22 18:35:10.000000000 +0200
@@ -63,10 +63,6 @@
 
 static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
 static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-static void i2c_fill_inode(struct inode *inode, int fill);
-static void i2c_dir_fill_inode(struct inode *inode, int fill);
-#endif			/* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1) */
 
 static ctl_table sysctl_table[] = {
 	{CTL_DEV, "dev", NULL, 0, 0555},
@@ -196,12 +192,7 @@
 #endif				/* DEBUG */
 	i2c_inodes[id - 256]  	    new_header->ctl_table->child->child->de->low_ino;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 	new_header->ctl_table->child->child->de->owner = controlling_mod;
-#else
-	new_header->ctl_table->child->child->de->fill_inode -	    &i2c_dir_fill_inode;
-#endif	/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 
 	return id;
 }
@@ -863,12 +854,7 @@
 	if (!
 	    (i2c_proc_header  	     register_sysctl_table(i2c_proc, 0))) return -ENOMEM;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1))
 	i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
-#else
-	i2c_proc_header->ctl_table->child->de->fill_inode -	    &i2c_fill_inode;
-#endif			/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1)) */
 	i2c_initialized++;
 	return 0;
 }
diff -ur lk-2.4.23-i2c-khali/include/linux/i2c.h lk-2.4.23-i2c-km/include/linux/i2c.h
--- lk-2.4.23-i2c-khali/include/linux/i2c.h	2003-11-25 21:47:24.000000000 +0200
+++ lk-2.4.23-i2c-km/include/linux/i2c.h	2003-12-22 18:12:12.000000000 +0200
@@ -43,16 +43,9 @@
 /* --- Includes and compatibility declarations ------------------------ */
 
 #include <linux/version.h>
-#ifndef KERNEL_VERSION
-#define KERNEL_VERSION(a,b,c) (((a) << 16) | ((b) << 8) | (c))
-#endif
 
 #include <asm/page.h>			/* for 2.2.xx 			*/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,0,25)
-#include <linux/sched.h>
-#else
 #include <asm/semaphore.h>
-#endif
 #include <linux/config.h>
 
 /* --- General options ------------------------------------------------	*/
@@ -226,9 +219,6 @@
 	u32 (*functionality) (struct i2c_adapter *);
 };
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-struct proc_dir_entry;
-#endif
 
 /*
  * i2c_adapter is the structure used to identify a physical i2c bus along
@@ -267,9 +257,6 @@
 #ifdef CONFIG_PROC_FS 
 	/* No need to set this when you initialize the adapter          */
 	int inode;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-	struct proc_dir_entry *proc_entry;
-#endif
 #endif /* def CONFIG_PROC_FS */
 };
 
