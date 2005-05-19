From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <Pine.LNX.4.53.0312281736020.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Dec 2003, Jean Delvare wrote:

> > Forget about -km-2 and -km-6. I will post them in smaller parts.
>
> Never received -km-6, so I can forget about it very easily ;) What about
> -km-4?

Go ahead with -km-4 if you like.

> As for -km-2, don't forget that there is no real use splitting patches
> if parts cannot be applied independantly. And I repeat myself, please
> first fix module reference counting in CVS before posting any patch
> related to this point. Again, we cannot send anything to Marcelo with
> regression in it.

Module reference counting patches.

Patch -km-24: Add .owner reference counting.
Patch -km-23: Inits with .owner and without .inc/dec_use
Patch -km-26: Unused code and whitespace.
Patch -km-13: Unused code and whitespace. (yes, here)

There is one more (yet unwritten) patch for this set coming up. It will
replace (deprecated) __MOD_INC_USE_COUNT with try_inc_mod_count.

The broken part in CVS refcounting is i2c_register_entry, and I'll
either fix it or take the one from 2.4 tree. The question with
i2c_register_entry is whether to pass controlling_mod which
is equal to client->driver->owner. Latest sensors don't pass it, any
other users for i2c-proc ?

Once I have this all finished I will commit on CVS head.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
-------------- next part --------------
diff -ur lk-i2c-km-23/drivers/i2c/i2c-core.c lk-i2c-km-24/drivers/i2c/i2c-core.c
--- lk-i2c-km-23/drivers/i2c/i2c-core.c	2003-12-27 23:05:29.000000000 +0200
+++ lk-i2c-km-24/drivers/i2c/i2c-core.c	2003-12-27 23:13:21.000000000 +0200
@@ -397,21 +397,27 @@
 
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
 
diff -ur lk-i2c-km-23/drivers/i2c/i2c-dev.c lk-i2c-km-24/drivers/i2c/i2c-dev.c
--- lk-i2c-km-23/drivers/i2c/i2c-dev.c	2003-12-27 23:14:41.000000000 +0200
+++ lk-i2c-km-24/drivers/i2c/i2c-dev.c	2003-12-27 23:13:20.000000000 +0200
@@ -391,11 +391,11 @@
 	if(! (client = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))
 		return -ENOMEM;
 	memcpy(client,&i2cdev_client_template,sizeof(struct i2c_client));
+
+	/* registered with adapter, passed as client to user */
 	client->adapter = i2cdev_adaps[minor];
 	file->private_data = client;
-
-	if (i2cdev_adaps[minor]->inc_use)
-		i2cdev_adaps[minor]->inc_use(i2cdev_adaps[minor]);
+	i2c_inc_use_client(client);
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
@@ -405,16 +405,20 @@
 
 static int i2cdev_release (struct inode *inode, struct file *file)
 {
-	unsigned int minor = MINOR(inode->i_rdev);
-	kfree(file->private_data);
-	file->private_data=NULL;
+	struct i2c_client *client;
 #ifdef DEBUG
-	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
+	unsigned int minor = MINOR(inode->i_rdev);
 #endif
+
+	client = file->private_data;
+	file->private_data = NULL;
 	lock_kernel();
-	if (i2cdev_adaps[minor]->dec_use)
-		i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
+	i2c_dec_use_client(client);
 	unlock_kernel();
+	kfree(client);
+#ifdef DEBUG
+	printk(KERN_DEBUG "i2c-dev.o: Closed: i2c-%d\n", minor);
+#endif
 	return 0;
 }
 
Only in lk-i2c-km-23/drivers/i2c: i2c-dev.c.orig
Only in lk-i2c-km-23/drivers/i2c: i2c-dev.c~
diff -ur lk-i2c-km-23/include/linux/i2c.h lk-i2c-km-24/include/linux/i2c.h
--- lk-i2c-km-23/include/linux/i2c.h	2003-12-27 23:05:29.000000000 +0200
+++ lk-i2c-km-24/include/linux/i2c.h	2003-12-27 23:13:45.000000000 +0200
@@ -128,6 +128,7 @@
  */
 
 struct i2c_driver {
+	struct module *owner;
 	char name[32];
 	int id;
 	unsigned int flags;		/* div., see below		*/
@@ -195,6 +196,7 @@
  * to name two of the most common.
  */
 struct i2c_algorithm {
+	struct module *owner;			/* future use --km	*/
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
@@ -219,12 +221,12 @@
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
-------------- next part --------------
diff -ur lk-i2c-km-22/Documentation/i2c/writing-clients lk-i2c-km-23/Documentation/i2c/writing-clients
--- lk-i2c-km-22/Documentation/i2c/writing-clients	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/Documentation/i2c/writing-clients	2003-12-27 23:05:48.000000000 +0200
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
diff -ur lk-i2c-km-22/drivers/i2c/i2c-algo-bit.c lk-i2c-km-23/drivers/i2c/i2c-algo-bit.c
--- lk-i2c-km-22/drivers/i2c/i2c-algo-bit.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-algo-bit.c	2003-12-27 23:05:48.000000000 +0200
@@ -523,14 +523,11 @@
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
diff -ur lk-i2c-km-22/drivers/i2c/i2c-algo-pcf.c lk-i2c-km-23/drivers/i2c/i2c-algo-pcf.c
--- lk-i2c-km-22/drivers/i2c/i2c-algo-pcf.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-algo-pcf.c	2003-12-27 23:05:48.000000000 +0200
@@ -435,14 +435,11 @@
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
diff -ur lk-i2c-km-22/drivers/i2c/i2c-dev.c lk-i2c-km-23/drivers/i2c/i2c-dev.c
--- lk-i2c-km-22/drivers/i2c/i2c-dev.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-dev.c	2003-12-27 23:09:52.000000000 +0200
@@ -76,13 +76,13 @@
 
   
 static struct file_operations i2cdev_fops = {
- 	owner:		THIS_MODULE,
- 	llseek:		no_llseek,
- 	read:		i2cdev_read,
- 	write:		i2cdev_write,
- 	ioctl:		i2cdev_ioctl,
- 	open:		i2cdev_open,
- 	release:	i2cdev_release,
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.read		= i2cdev_read,
+	.write		= i2cdev_write,
+	.ioctl		= i2cdev_ioctl,
+	.open		= i2cdev_open,
+	.release	= i2cdev_release,
 };
 
 #define I2CDEV_ADAPS_MAX I2C_ADAP_MAX
@@ -93,24 +93,20 @@
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
 
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count,
Only in lk-i2c-km-23/drivers/i2c: i2c-dev.c~
diff -ur lk-i2c-km-22/drivers/i2c/i2c-elektor.c lk-i2c-km-23/drivers/i2c/i2c-elektor.c
--- lk-i2c-km-22/drivers/i2c/i2c-elektor.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-elektor.c	2003-12-27 23:05:48.000000000 +0200
@@ -200,24 +200,21 @@
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
 
 int __init i2c_pcfisa_init(void) 
diff -ur lk-i2c-km-22/drivers/i2c/i2c-elv.c lk-i2c-km-23/drivers/i2c/i2c-elv.c
--- lk-i2c-km-22/drivers/i2c/i2c-elv.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-elv.c	2003-12-27 23:05:48.000000000 +0200
@@ -151,23 +151,20 @@
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
 
 int __init i2c_bitelv_init(void)
diff -ur lk-i2c-km-22/drivers/i2c/i2c-philips-par.c lk-i2c-km-23/drivers/i2c/i2c-philips-par.c
--- lk-i2c-km-22/drivers/i2c/i2c-philips-par.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-philips-par.c	2003-12-27 23:05:48.000000000 +0200
@@ -156,33 +156,28 @@
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
diff -ur lk-i2c-km-22/drivers/i2c/i2c-velleman.c lk-i2c-km-23/drivers/i2c/i2c-velleman.c
--- lk-i2c-km-22/drivers/i2c/i2c-velleman.c	2003-12-27 23:05:18.000000000 +0200
+++ lk-i2c-km-23/drivers/i2c/i2c-velleman.c	2003-12-27 23:05:48.000000000 +0200
@@ -139,23 +139,20 @@
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
 
 int __init  i2c_bitvelle_init(void)
-------------- next part --------------
diff -ur lk-i2c-km-25/drivers/i2c/i2c-algo-bit.c lk-i2c-km-26/drivers/i2c/i2c-algo-bit.c
--- lk-i2c-km-25/drivers/i2c/i2c-algo-bit.c	2003-12-27 23:05:48.000000000 +0200
+++ lk-i2c-km-26/drivers/i2c/i2c-algo-bit.c	2003-12-27 23:30:33.000000000 +0200
@@ -554,9 +554,6 @@
 	adap->timeout = 100;	/* default values, should	*/
 	adap->retries = 3;	/* be replaced by defines	*/
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
 	i2c_add_adapter(adap);
 
 	return 0;
@@ -572,9 +569,6 @@
 
 	DEB2(printk("i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
 
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
Only in lk-i2c-km-26/drivers/i2c: i2c-algo-bit.c~
diff -ur lk-i2c-km-25/drivers/i2c/i2c-algo-pcf.c lk-i2c-km-26/drivers/i2c/i2c-algo-pcf.c
--- lk-i2c-km-25/drivers/i2c/i2c-algo-pcf.c	2003-12-27 23:05:48.000000000 +0200
+++ lk-i2c-km-26/drivers/i2c/i2c-algo-pcf.c	2003-12-27 23:33:48.000000000 +0200
@@ -465,10 +465,6 @@
 		return i;
 	}
 
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
 	i2c_add_adapter(adap);
 	return 0;
 }
@@ -481,9 +477,6 @@
 		return res;
 	DEB2(printk("i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
 
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
 	return 0;
 }
 
Only in lk-i2c-km-26/drivers/i2c: i2c-algo-pcf.c~
diff -ur lk-i2c-km-25/drivers/i2c/i2c-elektor.c lk-i2c-km-26/drivers/i2c/i2c-elektor.c
--- lk-i2c-km-25/drivers/i2c/i2c-elektor.c	2003-12-27 23:05:48.000000000 +0200
+++ lk-i2c-km-26/drivers/i2c/i2c-elektor.c	2003-12-27 23:31:21.000000000 +0200
@@ -156,45 +156,6 @@
 	return 0;
 }
 
-
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
Only in lk-i2c-km-26/drivers/i2c: i2c-elektor.c~
diff -ur lk-i2c-km-25/drivers/i2c/i2c-elv.c lk-i2c-km-26/drivers/i2c/i2c-elv.c
--- lk-i2c-km-25/drivers/i2c/i2c-elv.c	2003-12-27 23:05:48.000000000 +0200
+++ lk-i2c-km-26/drivers/i2c/i2c-elv.c	2003-12-27 23:30:04.000000000 +0200
@@ -122,30 +122,6 @@
 	release_region( base , (base = 0x3bc)? 3 : 8 );
 }
 
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
Only in lk-i2c-km-26/drivers/i2c: i2c-elv.c~
diff -ur lk-i2c-km-25/drivers/i2c/i2c-philips-par.c lk-i2c-km-26/drivers/i2c/i2c-philips-par.c
--- lk-i2c-km-25/drivers/i2c/i2c-philips-par.c	2003-12-27 23:05:48.000000000 +0200
+++ lk-i2c-km-26/drivers/i2c/i2c-philips-par.c	2003-12-27 23:32:01.000000000 +0200
@@ -130,26 +130,6 @@
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
-
 /* ------------------------------------------------------------------------
  * Encapsulate the above functions in the correct operations structure.
  * This is only done when more than one hardware adapter is supported.
Only in lk-i2c-km-26/drivers/i2c: i2c-philips-par.c~
diff -ur lk-i2c-km-25/drivers/i2c/i2c-velleman.c lk-i2c-km-26/drivers/i2c/i2c-velleman.c
--- lk-i2c-km-25/drivers/i2c/i2c-velleman.c	2003-12-27 23:05:48.000000000 +0200
+++ lk-i2c-km-26/drivers/i2c/i2c-velleman.c	2003-12-27 23:32:47.000000000 +0200
@@ -108,31 +108,6 @@
 	release_region( base , (base = 0x3bc)? 3 : 8 );
 }
 
-
-static int bit_velle_reg(struct i2c_client *client)
-{
-	return 0;
-}
-
-static int bit_velle_unreg(struct i2c_client *client)
-{
-	return 0;
-}
-
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
Only in lk-i2c-km-26/drivers/i2c: i2c-velleman.c~
