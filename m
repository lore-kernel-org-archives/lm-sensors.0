From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: testers wanted
Message-Id: <20031223204901.65e4902a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031222231810.53439aaf.khali@linux-fr.org>
In-Reply-To: <20031222231810.53439aaf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a second patch on my stack, provided by Ky?sti. This is km1 (drop
older kernels compatibility), reviewed, fixed and extended. Attached.

Patch is voluntarily generated with -U1 so that it won't fail if applied
without the first patch. Since this patch only contains removals, no
context is really needed.

Ky?sti, the next patch I'll push on my stack will be km3+km5. I've
cleaned it up and fixed what needed to be so that it compiles and work
fine, but there are three points I'd like to hear you about:

1* What is the reason for disabling i2c_get_client? Is it in any way
related to locks? To me it belongs to a different patch.

2* Your patch includes a large rewrite of i2cproc_bus_read. How tightly
is it related to locks? I see that the new version uses locks, but it
also looks like this isn't the reason why the function was rewritten. If
possible, we'd better split the patch in two pieces, one for the locks,
and one for the rewrite.

3* The argument name change in i2c_smbus_xfer doesn't belong to this
patch either. Is it OK to move it apart, or am I missing something?

No need to resend a patch, I'll make the updates by myself, providing
you answer the questions above, so that I don't break anything. It is
important that we provide patches that don't mix too much things, if we
want them to be accepted.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-adap-ite.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-adap-ite.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-adap-ite.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-adap-ite.c	2003-12-23 13:43:26.000000000 +0100
@@ -40,3 +40,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
@@ -63,7 +62,3 @@
 static struct iic_ite gpi;
-#if (LINUX_VERSION_CODE < 0x020301)
-static struct wait_queue *iic_wait = NULL;
-#else
 static wait_queue_head_t iic_wait;
-#endif
 static int iic_pending;
@@ -273,5 +268,2 @@
 	iic_ite_data.data = (void *)piic;
-#if (LINUX_VERSION_CODE >= 0x020301)
-	init_waitqueue_head(&iic_wait);
-#endif
 	if (iic_hw_resrc_init() = 0) {
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-bit.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-bit.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-bit.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-bit.c	2003-12-23 13:45:50.000000000 +0100
@@ -29,3 +29,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-ite.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-ite.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-ite.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-ite.c	2003-12-23 13:44:49.000000000 +0100
@@ -40,3 +40,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-pcf.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-pcf.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-algo-pcf.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-algo-pcf.c	2003-12-23 13:45:44.000000000 +0100
@@ -33,3 +33,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-core.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-core.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-core.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-core.c	2003-12-23 13:45:36.000000000 +0100
@@ -35,9 +35,4 @@
 
-#include <linux/version.h>
 #include <linux/init.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-#define init_MUTEX(s) do { *(s) = MUTEX; } while(0)
-#endif
-
 #include <asm/uaccess.h>
@@ -86,6 +81,2 @@
 
-#if (LINUX_VERSION_CODE <= KERNEL_VERSION(2,3,27))
-static void monitor_bus_i2c(struct inode *inode, int fill);
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,58)) */
-
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
@@ -101,8 +92,2 @@
 
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,48))
-static struct inode_operations i2cproc_inode_operations = {
-	&i2cproc_operations
-};
-#endif
-
 static int i2cproc_initialized = 0;
@@ -166,12 +151,4 @@
 
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
@@ -613,14 +590,2 @@
 
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
-
 /* This function generates the output for /proc/bus/i2c */
@@ -734,7 +699,3 @@
 	proc_bus_i2c->read_proc = &read_bus_i2c;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 	proc_bus_i2c->owner = THIS_MODULE;
-#else
-	proc_bus_i2c->fill_inode = &monitor_bus_i2c;
-#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 	i2cproc_initialized += 2;
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-dev.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-dev.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-dev.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-dev.c	2003-12-23 13:45:27.000000000 +0100
@@ -37,6 +37,3 @@
 #include <linux/slab.h>
-#include <linux/version.h>
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 #include <linux/smp_lock.h>
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 #ifdef CONFIG_DEVFS_FS
@@ -57,5 +54,2 @@
 
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,9)
-static loff_t i2cdev_lseek (struct file *file, loff_t offset, int origin);
-#endif
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
@@ -79,10 +73,4 @@
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
@@ -124,16 +112,2 @@
 
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
@@ -425,5 +399,2 @@
 		i2cdev_adaps[minor]->inc_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
-	MOD_INC_USE_COUNT;
-#endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 
@@ -443,12 +414,6 @@
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
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-elektor.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-elektor.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-elektor.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-elektor.c	2003-12-23 13:45:23.000000000 +0100
@@ -32,3 +32,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
@@ -57,7 +56,3 @@
 
-#if (LINUX_VERSION_CODE < 0x020301)
-static struct wait_queue *pcf_wait = NULL;
-#else
 static wait_queue_head_t pcf_wait;
-#endif
 static int pcf_pending;
@@ -270,5 +265,3 @@
 
-#if (LINUX_VERSION_CODE >= 0x020301)
 	init_waitqueue_head(&pcf_wait);
-#endif
 	if (pcf_isa_init() = 0) {
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-elv.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-elv.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-elv.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-elv.c	2003-12-23 13:45:13.000000000 +0100
@@ -29,3 +29,2 @@
 #include <linux/slab.h>
-#include <linux/version.h>
 #include <linux/init.h>
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-keywest.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-keywest.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-keywest.c	2002-11-29 00:53:13.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-keywest.c	2003-12-23 13:45:06.000000000 +0100
@@ -47,3 +47,2 @@
 #include <linux/config.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-philips-par.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-philips-par.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-philips-par.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-philips-par.c	2003-12-23 13:29:29.000000000 +0100
@@ -248,3 +248,2 @@
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 static struct parport_driver i2c_driver = {
@@ -255,3 +254,2 @@
 };
-#endif
 
@@ -259,13 +257,5 @@
 {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
-	struct parport *port;
-#endif
 	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_register_driver(&i2c_driver);
-#else
-	for (port = parport_enumerate(); port; port=port->next)
-		i2c_parport_attach(port);
-#endif
 	
@@ -276,9 +266,3 @@
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_unregister_driver(&i2c_driver);
-#else
-	struct parport *port;
-	for (port = parport_enumerate(); port; port=port->next)
-		i2c_parport_detach(port);
-#endif
 }
diff -U1 -r linux-2.4.24-pre2-k1/drivers/i2c/i2c-proc.c linux-2.4.24-pre2-k2/drivers/i2c/i2c-proc.c
--- linux-2.4.24-pre2-k1/drivers/i2c/i2c-proc.c	2003-12-23 11:53:22.000000000 +0100
+++ linux-2.4.24-pre2-k2/drivers/i2c/i2c-proc.c	2003-12-23 13:44:58.000000000 +0100
@@ -25,3 +25,2 @@
 
-#include <linux/version.h>
 #include <linux/module.h>
@@ -63,6 +62,2 @@
 static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1)
-static void i2c_fill_inode(struct inode *inode, int fill);
-static void i2c_dir_fill_inode(struct inode *inode, int fill);
-#endif			/* LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1) */
 
@@ -196,8 +191,3 @@
 	    new_header->ctl_table->child->child->de->low_ino;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27))
 	new_header->ctl_table->child->child->de->owner = controlling_mod;
-#else
-	new_header->ctl_table->child->child->de->fill_inode -	    &i2c_dir_fill_inode;
-#endif	/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,27)) */
 
@@ -863,8 +853,3 @@
 	     register_sysctl_table(i2c_proc, 0))) return -ENOMEM;
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1))
 	i2c_proc_header->ctl_table->child->de->owner = THIS_MODULE;
-#else
-	i2c_proc_header->ctl_table->child->de->fill_inode -	    &i2c_fill_inode;
-#endif			/* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,1)) */
 	i2c_initialized++;
diff -U1 -r linux-2.4.24-pre2-k1/include/linux/i2c.h linux-2.4.24-pre2-k2/include/linux/i2c.h
--- linux-2.4.24-pre2-k1/include/linux/i2c.h	2003-06-13 16:51:38.000000000 +0200
+++ linux-2.4.24-pre2-k2/include/linux/i2c.h	2003-12-23 14:05:44.000000000 +0100
@@ -44,13 +44,3 @@
 
-#include <linux/version.h>
-#ifndef KERNEL_VERSION
-#define KERNEL_VERSION(a,b,c) (((a) << 16) | ((b) << 8) | (c))
-#endif
-
-#include <asm/page.h>			/* for 2.2.xx 			*/
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,0,25)
-#include <linux/sched.h>
-#else
 #include <asm/semaphore.h>
-#endif
 #include <linux/config.h>
@@ -228,6 +218,2 @@
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-struct proc_dir_entry;
-#endif
-
 /*
@@ -269,5 +255,2 @@
 	int inode;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
-	struct proc_dir_entry *proc_entry;
-#endif
 #endif /* def CONFIG_PROC_FS */
