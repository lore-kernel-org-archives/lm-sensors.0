From: bkuschak@yahoo.com (Brian Kuschak)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: [PATCH] - i2c virtual adapter driver for multiplexed busses
Message-Id: <20031111210329.77736.qmail@web40903.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, Mark,

As described in a previous email to this list, this is
a patch for simplified access to multiplexed i2c
busses.  A documentation file is included, as well as
an example (i2c-virtual_cb.c) of how to implement the
mux-control callbacks.

Tested on a heavily patched 2.4.19 kernel on embedded
PowerPC.  However, this patch is against a clean
kernel.org 2.4.19 tree.  I don't have the bandwidth to
port this to 2.6.0 right now, but I wanted to make it
available in case someone else finds it useful. 

Comments/feedback welcome.

Thanks,
Brian Kuschak



__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
-------------- next part --------------
diff -urN linux-2.4.19/Documentation/Configure.help linux-2.4.19.new/Documentation/Configure.help
--- linux-2.4.19/Documentation/Configure.help	Fri Aug  2 17:39:42 2002
+++ linux-2.4.19.new/Documentation/Configure.help	Tue Nov 11 09:54:38 2003
@@ -16905,6 +16905,15 @@
   it as a module, say M here and read <file:Documentation/modules.txt>.
   The module will be called i2c-proc.o.
 
+I2C virtual bus
+CONFIG_I2C_VIRTUAL
+  This driver allows you to handle multiplexed or bus-switched I2C
+  bus topologies by registering 'virtual' i2c busses for each multiplexed
+  bus segment.  It requires some hardware-specific code to be written to 
+  perform the multiplexor control.
+
+  See Documentation/i2c/virtual_i2c for details.
+
 Bus Mouse Support
 CONFIG_BUSMOUSE
   Say Y here if your machine has a bus mouse as opposed to a serial
diff -urN linux-2.4.19/Documentation/i2c/virtual_i2c linux-2.4.19.new/Documentation/i2c/virtual_i2c
--- linux-2.4.19/Documentation/i2c/virtual_i2c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19.new/Documentation/i2c/virtual_i2c	Tue Nov 11 09:54:38 2003
@@ -0,0 +1,102 @@
+Virtual i2c bus
+Brian Kuschak  <bkuschak@yahoo.com>
+
+
+I2C devices must have a unique 7 bit address on the bus to which they 
+are attached.  Many I2C chips have one or more input lines which can be
+used to configure one or more of their address bits.  This allows the
+hardware designer to include multiple chips on a single bus by selecting
+different addresses for each one.  However, some chips have fixed addresses
+which present a problem if more than one of them are required on a board.
+Also, sometimes there are more devices than there are selectable addresses.
+
+A common solution is to break the i2c bus into disjoint segments, by using
+a multiplexor or i2c bus switch.  This electrically isolates the individual
+bus segments.  Then the devices with duplicate addresses are placed on 
+separate bus segments, to prevent address conflicts.
+
+This seems to be a very common approach in certain types of applications,
+such as bladed chassis, where many identical 'blades' or cards are inserted
+into a common backplane.  The I2C bus on each blade is then located behind
+a mux or i2c bus switch.  This solution works great from the hardware 
+perspective, but presents some complexities for software.
+
+The 'virtual i2c adapter' driver is an attempt to provide a flexible software
+abstraction to simiplify these issues, while minimizing the impact on 
+existing code and fitting nicely into the i2c driver framework.
+
+
+What is a 'virtual i2c adapter'
+===============+
+Think of this adapter as a layer above the existing algorithm and adapter
+drivers.  The virtual i2c adapter is the handle by which you access a 
+specific multiplexed bus segment.  Each disjoint bus segment becomes a new
+virtual bus.  The virtual adapter is associated with a 'real' adapter and a 
+set of multiplexor control variables.
+
+For example: you have an i2c-0 bus with one multiplexor or i2c bus switch,
+and the mux has four outputs which can be electrically connected to the
+i2c-0 bus.  You would register four virtual i2c busses, one for each position
+of the mux.  As part of the registration, you provide callback functions to
+select and deselect the mux as well as the selector values to be passed to
+these functions.
+
+                     ---------  <-------->  i2c-1  virtual
+                    | i2c mux | <-------->  i2c-2  virtual
+   i2c-0 <------->  |         | <-------->  i2c-3  virtual
+  ibm_ocp           |  0x74   | <-------->  i2c-4  virtual
+                     ---------
+                        ^ 
+                        |
+                        +---  (or externally controlled)
+
+The mux may be i2c-controlled, in which case the mux_addr is set to the 
+slave address (0x74) and the mux_val would be the port number to select (0-3).  
+Alternatively, the mux could be controlled by some fixed memory-mapped register
+in which case only the mux_val would be needed.  The callback functions
+are hardware specific and written by the user.  
+
+Once the virtual busses are registered, you may talk to any devices behind
+the mux simply the using the i2c-1, i2c-2, i2c-3, etc. adapters instead of
+the i2c-0 adapter.  This makes the mux essentially transparent to the 
+i2c_client. 
+
+The great advantage of course is that all the existing sensor drivers and
+other i2c client drivers automatically work, and the mux becomes transparent
+to them.
+
+
+Additional capabilities
+===========+
+This driver also supports multiple levels of muxing, by allowing the
+user to register a virtual bus which has a different virtual bus as its
+'real' adapter.  In addition, each virtual bus may have different kinds of 
+multiplexors, with each bus having its own set of callback functions.
+This allows you to easily support some very complex topologies.
+
+In addition to multiplexing, some systems require that you obtain hardware 
+access to the bus behind the mux before talking on it.  (Again, bladed chassis
+typically 'fence' other blades off the bus to prevent a crashed blade from 
+bringing down the whole backplane.)  Before talking on this bus, you have to
+arbitrate with the other blades to acquire exclusive access to the bus.  This
+requirement is met by the addition of two new function pointers to the 
+algorithm drivers, acquire_exclusive() and release_exclusive().  Traditional
+adapters will not use these and they can safely be left NULL.  If they are
+non-null, the virtual bus driver will call the acquire_exclusive() function 
+before attempting any operations on that virtual bus.  This function may block,
+and this is done before acquiring the lock on the underlying 'real' bus to
+allow transactions on the real bus to continue unimpeded while waiting for
+arbitrartion.  In addition the ownership is only held for as long as it takes
+to complete the transfer.  
+
+
+Files
+==+
+drivers/i2c/i2c-virtual.c: 	The 'algorithm' and 'adapter' driver
+include/linux/i2c-virtual.h:	Header file with the mux control structure
+                                and callback prototypes.
+
+
diff -urN linux-2.4.19/drivers/i2c/Config.in linux-2.4.19.new/drivers/i2c/Config.in
--- linux-2.4.19/drivers/i2c/Config.in	Mon Feb 25 11:37:57 2002
+++ linux-2.4.19.new/drivers/i2c/Config.in	Tue Nov 11 10:01:51 2003
@@ -48,6 +48,7 @@
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
    dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'Virtualized I2C adapter' CONFIG_I2C_VIRTUAL $CONFIG_I2C
 
 fi
 endmenu
diff -urN linux-2.4.19/drivers/i2c/Makefile linux-2.4.19.new/drivers/i2c/Makefile
--- linux-2.4.19/drivers/i2c/Makefile	Mon Feb 25 11:37:57 2002
+++ linux-2.4.19.new/drivers/i2c/Makefile	Tue Nov 11 10:02:48 2003
@@ -5,7 +5,7 @@
 O_TARGET := i2c.o
 
 export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
-		   i2c-algo-ite.o i2c-proc.o
+		   i2c-algo-ite.o i2c-proc.o i2c-virtual.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
@@ -19,9 +19,12 @@
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
+obj-$(CONFIG_I2C_VIRTUAL)	+= i2c-virtual.o
 
 # This is needed for automatic patch generation: sensors code starts here
 # This is needed for automatic patch generation: sensors code ends here
+
+ 
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.4.19/drivers/i2c/i2c-core.c linux-2.4.19.new/drivers/i2c/i2c-core.c
--- linux-2.4.19/drivers/i2c/i2c-core.c	Fri Aug  2 17:39:44 2002
+++ linux-2.4.19.new/drivers/i2c/i2c-core.c	Tue Nov 11 10:00:32 2003
@@ -30,6 +30,7 @@
 #include <linux/config.h>
 
 #include <linux/i2c.h>
+#include <linux/i2c-virtual.h>
 
 /* ----- compatibility stuff ----------------------------------------------- */
 
@@ -120,6 +121,19 @@
  * --------------------------------------------------- 
  */
 
+struct i2c_adapter* i2c_get_adapter(int index)
+{
+	struct i2c_adapter *ret;
+
+	if(index > I2C_ADAP_MAX) 
+		return NULL;
+
+	ADAP_LOCK();
+	ret = adapters[index];
+	ADAP_UNLOCK();
+	return ret;
+}
+
 /* -----
  * i2c_add_adapter is called from within the algorithm layer,
  * when a new hw adapter registers. A new device is register to be
@@ -410,6 +424,16 @@
 	for (i = 0; i < I2C_CLIENT_MAX ; i++) 
 		if (adapter->clients[i] && (adapter->clients[i]->addr = addr))
 			return -EBUSY;
+
+#ifdef CONFIG_I2C_VIRTUAL
+	/* Also check for aliasing on multiplexed busses (even if they are nested) */
+	while((adapter = i2c_get_real_adap(adapter)) != NULL) {
+
+		for (i = 0; i < I2C_CLIENT_MAX ; i++)
+			if (adapter->clients[i] && (adapter->clients[i]->addr = addr))
+				return -EBUSY;
+	}
+#endif
 	return 0;
 }
 
@@ -760,16 +784,27 @@
 
 int i2c_transfer(struct i2c_adapter * adap, struct i2c_msg msgs[],int num)
 {
-	int ret;
+	int ret, ret2;
 
 	if (adap->algo->master_xfer) {
  	 	DEB2(printk("i2c-core.o: master_xfer: %s with %d msgs.\n",
 		            adap->name,num));
 
+ 		/* Acquire exclusive access to a shared I2C bus _before_ taking the local I2C lock
+ 		 * to prevent stalling local I2C transactions while waiting for exclusive access.
+ 		 */
+ 		if(adap->algo->acquire_exclusive) 
+ 			if ((ret = adap->algo->acquire_exclusive(adap)) < 0)
+ 				return ret;
+
 		I2C_LOCK(adap);
 		ret = adap->algo->master_xfer(adap,msgs,num);
 		I2C_UNLOCK(adap);
 
+ 		if(adap->algo->release_exclusive) 
+ 			if ((ret2 = adap->algo->release_exclusive(adap)) < 0)
+ 				return ret2;
+
 		return ret;
 	} else {
 		printk("i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
@@ -780,7 +815,7 @@
 
 int i2c_master_send(struct i2c_client *client,const char *buf ,int count)
 {
-	int ret;
+	int ret, ret2;
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
 
@@ -793,10 +828,20 @@
 		DEB2(printk("i2c-core.o: master_send: writing %d bytes on %s.\n",
 			count,client->adapter->name));
 	
+		/* Acquire exclusive access to a shared I2C bus _before_ taking the local I2C lock
+		 * to prevent stalling local I2C transactions while waiting for exclusive access.
+		 */
+		if(adap->algo->acquire_exclusive) 
+			if ((ret = adap->algo->acquire_exclusive(adap)) < 0)
+				return ret;
 		I2C_LOCK(adap);
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		I2C_UNLOCK(adap);
 
+		if(adap->algo->release_exclusive) 
+			if ((ret2 = adap->algo->release_exclusive(adap)) < 0)
+				return ret2;
+
 		/* if everything went ok (i.e. 1 msg transmitted), return #bytes
 		 * transmitted, else error code.
 		 */
@@ -812,7 +857,7 @@
 {
 	struct i2c_adapter *adap=client->adapter;
 	struct i2c_msg msg;
-	int ret;
+	int ret, ret2;
 	if (client->adapter->algo->master_xfer) {
 		msg.addr   = client->addr;
 		msg.flags = client->flags & I2C_M_TEN;
@@ -823,10 +868,21 @@
 		DEB2(printk("i2c-core.o: master_recv: reading %d bytes on %s.\n",
 			count,client->adapter->name));
 	
+ 		/* Acquire exclusive access to a shared I2C bus _before_ taking the local I2C lock
+ 		 * to prevent stalling local I2C transactions while waiting for exclusive access.
+ 		 */
+ 		if(adap->algo->acquire_exclusive) 
+ 			if ((ret = adap->algo->acquire_exclusive(adap)) < 0)
+ 				return ret;
+
 		I2C_LOCK(adap);
 		ret = adap->algo->master_xfer(adap,&msg,1);
 		I2C_UNLOCK(adap);
 	
+ 		if(adap->algo->release_exclusive) 
+ 			if ((ret2 = adap->algo->release_exclusive(adap)) < 0)
+ 				return ret2;
+ 
 		DEB2(printk("i2c-core.o: master_recv: return:%d (count:%d, addr:0x%02x)\n",
 			ret, count, client->addr));
 	
@@ -872,7 +928,7 @@
                    struct i2c_client_address_data *address_data,
                    i2c_client_found_addr_proc *found_proc)
 {
-	int addr,i,found,err;
+	int addr,i,found,err,ret;
 	int adap_id = i2c_adapter_id(adapter);
 
 	/* Forget it if we can't probe using SMBUS_QUICK */
@@ -982,7 +1038,12 @@
 
 		/* OK, so we really should examine this address. First check
 		   whether there is some client here at all! */
-		if (i2c_smbus_xfer(adapter,addr,0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
+		ret = i2c_smbus_xfer(adapter,addr,0,0,0,I2C_SMBUS_QUICK,NULL);
+			
+		DEB2(printk("i2c_probe: bus=%d addr=%02hx, ret=%d\n", 
+			i2c_adapter_id(adapter), addr, ret));
+
+		if (ret >= 0)
 			if ((err = found_proc(adapter,addr,0,-1)))
 				return err;
 	}
@@ -1142,7 +1203,7 @@
 	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 }, 
 	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
 	                        };
-	int i;
+	int i, ret;
 
 	msgbuf0[0] = command;
 	switch(size) {
@@ -1205,9 +1266,9 @@
 		       size);
 		return -1;
 	}
-
-	if (i2c_transfer(adapter, msg, num) < 0)
-		return -1;
+	
+	if ((ret = i2c_transfer(adapter, msg, num)) < 0)
+		return ret;
 
 	if (read_write = I2C_SMBUS_READ)
 		switch(size) {
@@ -1230,13 +1291,24 @@
                    char read_write, u8 command, int size, 
                    union i2c_smbus_data * data)
 {
-	s32 res;
+	s32 res, res2;
 	flags = flags & I2C_M_TEN;
 	if (adapter->algo->smbus_xfer) {
+
+		/* Acquire exclusive access to a shared I2C bus _before_ taking the local I2C lock
+		 * to prevent stalling local I2C transactions while waiting for exclusive access.
+		 */
+		if(adapter->algo->acquire_exclusive) 
+			if ((res = adapter->algo->acquire_exclusive(adapter)) < 0)
+				return res;
 		I2C_LOCK(adapter);
 		res = adapter->algo->smbus_xfer(adapter,addr,flags,read_write,
 		                                command,size,data);
 		I2C_UNLOCK(adapter);
+
+		if(adapter->algo->release_exclusive) 
+			if ((res2 = adapter->algo->release_exclusive(adapter)) < 0)
+				return res2;
 	} else
 		res = i2c_smbus_xfer_emulated(adapter,addr,flags,read_write,
 	                                      command,size,data);
@@ -1389,6 +1461,7 @@
 EXPORT_SYMBOL(i2c_transfer);
 EXPORT_SYMBOL(i2c_adapter_id);
 EXPORT_SYMBOL(i2c_probe);
+EXPORT_SYMBOL(i2c_get_adapter);
 
 EXPORT_SYMBOL(i2c_smbus_xfer);
 EXPORT_SYMBOL(i2c_smbus_write_quick);
diff -urN linux-2.4.19/drivers/i2c/i2c-virtual.c linux-2.4.19.new/drivers/i2c/i2c-virtual.c
--- linux-2.4.19/drivers/i2c/i2c-virtual.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19.new/drivers/i2c/i2c-virtual.c	Tue Nov 11 09:54:38 2003
@@ -0,0 +1,275 @@
+/*
+ * Virtual I2C bus driver.
+ * Simplifies access to complex multiplexed I2C bus topologies, by presenting
+ * each multiplexed bus segment as a virtual I2C adapter.  Supports multi-level
+ * mux'ing (mux behind a mux), as well as arbitration for exclusive bus access
+ * for those systems which require it (some bladed chassis for example).
+ *
+ * Brian Kuschak <bkuschak@yahoo.com>
+ *
+ * Adapted from i2c-adap-ibm_ocp.c 
+ * Original file Copyright 2000-2002 MontaVista Software Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-virtual.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#include <asm/uaccess.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+
+
+
+//#define		DBG(x)		x
+#define	DBG(x)		{}
+
+#define VIRT_TIMEOUT		(HZ/2)		/* 500msec */
+#define VIRT_RETRIES		3		
+
+/* exclusive access to the bus */
+#define I2C_LOCK(adap) down(&adap->lock)
+#define I2C_UNLOCK(adap) up(&adap->lock)
+
+static int i2c_scan = 1;
+
+/* First the I2C 'algorithm' driver code: */
+
+/*
+ * Description: acquire exclusive access (if needed), select the mux,
+ * perform the transfer on the real i2c adapter, deselect mux and drop
+ * exclusive access.
+ */
+static int
+virt_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct i2c_virt_priv 	*priv = (void*)adap->data;
+	struct i2c_adapter 	*real = priv->real_adap;
+	int ret, ret2;
+
+
+	/* Acquire exclusive access to a shared I2C bus _before_ taking the local I2C lock
+	 * to prevent stalling local I2C transactions while waiting for exclusive access.
+	 */
+	if(real->algo->acquire_exclusive) 
+		if ((ret = real->algo->acquire_exclusive(real)) < 0)
+			return ret;
+
+	/* Grab the lock for the _real_ adapter.  We already hold the lock for the
+	 * virtual adapter.  Then select the right mux port and perform the transfer.
+	 */
+	I2C_LOCK(real);
+	priv->mux.select(real, &priv->mux);
+	ret = real->algo->master_xfer(real, msgs, num);
+	priv->mux.deselect(real, &priv->mux);
+	I2C_UNLOCK(real);
+
+	/* Release exclusive bus access */
+	if(real->algo->release_exclusive) 
+		if ((ret2 = real->algo->release_exclusive(real)) < 0)
+			return ret2;
+
+	return ret;
+}
+
+/*
+ * Description: Implements device specific ioctls.  
+ * We don't support any yet.
+ */
+static int
+virt_algo_control(struct i2c_adapter *adap, unsigned int cmd, unsigned long arg)
+{
+	int ret = 0;
+	return ret;
+}
+
+static u32
+virt_i2c_func(struct i2c_adapter *adap)
+{
+	/* FIXME : we should probably return the functionality of the 
+	 * real adapter...
+	 */
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
+	    I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+static struct i2c_algorithm virt_i2c_algo = {
+	"Virtual I2C algorithm driver",
+	I2C_ALGO_MPC8XX,
+	virt_i2c_xfer,		/* master_xfer		*/
+	NULL,
+	NULL,			/* slave_xmit           */
+	NULL,			/* slave_recv           */
+	virt_algo_control,	/* ioctl                */
+	virt_i2c_func,		/* functionality        */
+};
+
+/*
+ * Description: Register bus structure
+ */
+static int
+i2c_virt_add_bus(struct i2c_adapter *adap)
+{
+	adap->id |= virt_i2c_algo.id;
+	adap->algo = &virt_i2c_algo;
+	adap->timeout = VIRT_TIMEOUT;
+	adap->retries = VIRT_RETRIES;
+
+	i2c_add_adapter(adap);
+
+	/* scan the I2C bus for valid 7 bit addresses
+	 * (ie things that ACK on 1byte read)
+	 * TODO: check for 10-bit mode and never run as a slave.
+	 */
+
+	if (i2c_scan) {
+
+		int found = 0;
+		int i;
+		printk(KERN_INFO "i2c%d: scanning bus. Found ",
+		       i2c_adapter_id(adap));
+		for (i = 0; i < 0x7f; i++) {
+			int ret;
+			struct i2c_msg msg;
+			char data[1];
+			msg.addr = i;
+			msg.buf = data;
+			msg.len = 1;
+			msg.flags = I2C_M_RD;
+			if ((ret = virt_i2c_xfer(adap, &msg, 1)) = 1) {
+				printk("0x%02x ", i);
+				found++;
+			}
+		}
+		
+		if (found)
+			printk("\n");
+		else
+			printk("Nothing\n");
+
+	}
+	return 0;
+}
+
+static int
+i2c_virt_del_bus(struct i2c_adapter *adap)
+{
+	int ret;
+	if ((ret = i2c_del_adapter(adap)) < 0)
+		return ret;
+	return 0;
+}
+
+/* The 'adapter' driver code: */
+
+static int
+i2c_virt_reg(struct i2c_client *client)
+{
+	return 0;
+}
+static int
+i2c_virt_unreg(struct i2c_client *client)
+{
+	return 0;
+}
+static void
+i2c_virt_inc_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+}
+static void
+i2c_virt_dec_use(struct i2c_adapter *adap)
+{
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+}
+
+/*
+ * Called to create a 'virtual' i2c bus which represents a multiplexed bus
+ * segment.  Mux_addr and mux_val are passed to the select and deselect
+ * callback functions to perform hardware-specific mux control.
+ */
+struct i2c_adapter *register_virtual_i2c_adap(struct i2c_adapter *real_adap, 
+					unsigned long mux_addr, 
+					unsigned long mux_val, 
+					void *select_cb,
+					void *deselect_cb)
+{
+	struct i2c_adapter *adap;
+	struct i2c_virt_priv *priv;
+
+	if (!(adap = kmalloc(sizeof (struct i2c_adapter) + sizeof(struct i2c_virt_priv), 
+			GFP_KERNEL))) {
+		printk("register_virtual_i2c_adap: Failed allocation\n");
+		return NULL;
+	}
+
+	memset(adap, 0, sizeof(struct i2c_adapter) + sizeof(struct i2c_virt_priv));
+
+	snprintf(adap->name, sizeof(adap->name)-1,
+		"Virtual I2C (i2c%d, mux %02lx:%02lx)",
+		i2c_adapter_id(real_adap), mux_addr, mux_val);
+	adap->name[sizeof(adap->name)-1] = 0;
+
+	adap->data = priv = (void*) (adap+1);	/* point to first byte of i2c_virt_priv */
+	adap->id = I2C_HW_VIRT;
+	adap->algo = NULL;
+	adap->inc_use = i2c_virt_inc_use;
+	adap->dec_use = i2c_virt_dec_use;
+	adap->client_register = i2c_virt_reg;
+	adap->client_unregister = i2c_virt_unreg;
+
+	priv->real_adap = real_adap;
+	priv->mux.addr = mux_addr;
+	priv->mux.value = mux_val;
+	priv->mux.select = select_cb;
+	priv->mux.deselect = deselect_cb;
+
+	if (i2c_virt_add_bus(adap) < 0)
+		return NULL;
+
+	printk(KERN_NOTICE "i2c%d: Virtual I2C bus "
+		"(Physical bus i2c%d, multiplexor %02lx port %ld)\n",
+		i2c_adapter_id(adap), i2c_adapter_id(real_adap), 
+		mux_addr, mux_val);
+
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+	return adap;
+}
+
+int unregister_virtual_i2c_adap(struct i2c_adapter *adap)
+{
+	int ret;
+	if((ret = i2c_virt_del_bus(adap)) != 0) 
+		return ret;
+
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+	return 0;
+}
+
+EXPORT_SYMBOL(register_virtual_i2c_adap);
+EXPORT_SYMBOL(unregister_virtual_i2c_adap);
+
+MODULE_AUTHOR("B Kuschak <www.yahoo.com>");
+MODULE_DESCRIPTION("Virual I2C driver for multiplexed I2C busses");
+MODULE_LICENSE("GPL");
+
+
diff -urN linux-2.4.19/drivers/i2c/i2c-virtual_cb.c linux-2.4.19.new/drivers/i2c/i2c-virtual_cb.c
--- linux-2.4.19/drivers/i2c/i2c-virtual_cb.c	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19.new/drivers/i2c/i2c-virtual_cb.c	Tue Nov 11 09:54:38 2003
@@ -0,0 +1,335 @@
+/*
+ *    Description:
+ *	This file implements the mux control callback functions fr the
+ *	virtual i2c adapter.
+ *	See Documentation/i2c/virtual_i2c for details.
+ *	Brian Kuschak <bkuschak@yahoo.com>
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-adap-virt.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <asm/delay.h>
+#include <asm/io.h>
+
+//#define		DBG(x)		x
+#define		DBG(x)		{}
+
+#ifndef elemof
+#define elemof(a)	(sizeof(a) / sizeof((a)[0]))
+#endif
+
+#define	REQUIRE_ARBITRATION		/* some bladed systems need this */
+
+/* pointer to the list of i2c_bus_mappings */
+static LIST_HEAD(i2c_map_list);
+struct i2c_bus_mapping {
+	struct i2c_adapter	*real;	
+	struct i2c_adapter	*virt;
+	unsigned long		mux_addr;	
+	unsigned long		mux_val;
+	struct list_head	list; 
+};
+
+static struct i2c_adapter *add_virt_bus(struct i2c_adapter *real, 
+                                        unsigned long mux_addr,
+                                        unsigned long mux_val,
+                                        void *select_cb,
+                                        void *deselect_cb);
+
+/********************************************************************************************
+ * These functions are allowed to block.  At this point we have acquired the local I2C_LOCK
+ * semaphore.  Select the proper mux values.                                
+ * 
+ ********************************************************************************************/
+
+/* PCA9544 and PCA9548 I2C-controlled bus switches are similar.  Try to 
+ * share code for these two different parts.  '44 is four port mux, '48 is eight port.
+ */
+static void pca954x_select_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux,
+				unsigned long value)
+{
+	struct i2c_msg msg;
+	int i2c_switch_addr = mux->addr;
+	char buf[1];
+	int ret;
+
+	/* send I2C commands to the bus switch(es) to select the right path */
+	if (adap->algo->master_xfer) {
+		msg.addr	= i2c_switch_addr;
+		msg.flags	= 0;
+		msg.len		= 1;
+		buf[0] 		= value;
+		msg.buf 	= buf;
+		
+		if((ret = adap->algo->master_xfer(adap,&msg,1)) < 0)
+			printk(KERN_ERR "%s: Failed to select the I2C multiplexor "
+					"(addr=%02hx, val=%02hx, err=%d)!\n", 
+					__FUNCTION__,
+					i2c_switch_addr, value, ret);
+		else 
+			DBG(printk("I2C mux selected [i2c addr: %hX, port: %d]!\n", 
+				i2c_switch_addr, value));
+	}
+	else {
+		printk(KERN_ERR "%s: no master_xfer??\n", __FUNCTION__);
+	}
+}
+
+static void pca954x_deselect(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux,
+				unsigned long value) 
+{
+	struct i2c_msg msg;
+	int i2c_switch_addr = mux->addr; 
+	char buf[1];
+	int ret;
+
+	/* send I2C commands to the bus switch(es) to select the right path */
+	if (adap->algo->master_xfer) {
+		msg.addr	= i2c_switch_addr;
+		msg.flags	= 0;
+		msg.len		= 1;
+		buf[0] 		= 0;	/* select nothing */
+		msg.buf 	= buf;
+
+		if((ret = adap->algo->master_xfer(adap,&msg,1)) < 0)
+			printk(KERN_ERR "Failed to deselect the I2C multiplexor "
+					"(addr=%02hx, val=%02hx, err=%d)!\n", 
+					i2c_switch_addr, 0, ret);
+		else
+			DBG(printk("I2C mux deselected [i2c addr: %hX]!\n", 
+				i2c_switch_addr));
+	}
+	else {
+		printk(KERN_ERR "%s: no master_xfer??\n", __FUNCTION__);
+	}
+}
+
+/* The 9544 and 9548 use different register definitions, hence these two functions */
+static void pca9544_select_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux)
+{
+	int i2c_mux_sel     = mux->value;
+	return(pca954x_select_mux(adap, mux, ((i2c_mux_sel & 0x3) + 4)));
+}
+
+static void pca9548_select_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux)
+{
+	int i2c_mux_sel     = mux->value;
+	return(pca954x_select_mux(adap, mux, 1<<(i2c_mux_sel & 0x7)));	
+}
+
+/* Disabling the mux is the same for both 9544 and 9548 */
+static void pca954x_deselect_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux)
+{
+	return(pca954x_deselect_mux(adap, mux, 0));
+}
+
+static void pca954x_deselect_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux)
+{
+	return(pulsar_deselect_mux(adap, mux, 0));
+}
+
+#if 0
+/* Multiplexors controlled by a memory-mapped register
+ */
+static void mmreg_select_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux)
+{
+	char data;
+
+	data = (mux->value & MUX_SELECT_MASK);
+	cpld_write_register(I2C_SELECT_REG, data);
+
+	DBG(printk("I2C mux selected [port: %d]!\n", mux->value));
+}
+
+static void mmreg_deselect_mux(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux)
+{
+	char data;
+
+	/* Last position is reserved as 'disconnected' */
+	data = MUX_SELECT_MASK;
+	cpld_write_register(I2C_SELECT_REG, data);
+
+	DBG(printk("I2C mux deselected!\n"));
+}
+#endif
+
+/********************************************************************************************
+ * Here we have the arbitration functions for bladed systems, where multiple blades
+ * access a shared I2C bus.  Arbitrate for and acquire exclusive access to the bus.
+ * This code is called from the i2c-core driver _without_ the I2C_LOCK held.
+ * 
+ ********************************************************************************************/
+
+static int acquire_shared_bus(struct i2c_adapter *adap)
+{
+	/* Only bus 1 (global I2C bus) requires arbitrating with the other CP */
+	if(i2c_adapter_id(adap) != 1)
+		return 0;
+
+	/* FIXME: Do hardware-specific arbitration here (may block) */
+
+	return 0;
+}
+
+static int release_shared_bus(struct i2c_adapter *adap)
+{
+	/* Only bus 1 (global I2C bus) requires arbitrating with the other CP */
+	if(i2c_adapter_id(adap) != 1)
+		return 0;
+
+	/* FIXME: Do hardware-specific arbitration here (may block) */
+
+	return 0;
+}
+
+/* This fn is called once for each adapter. We use this to add our platform-specific
+ * callback functions.
+ */
+static int attach_adapter(struct i2c_adapter *adap)
+{
+	int i;
+	struct i2c_adapter *virt;
+	int index = i2c_adapter_id(adap);
+	
+#ifdef REQURE_ARBITRATION
+	adap->algo->acquire_exclusive = &acquire_shared_bus;
+	adap->algo->release_exclusive = &release_shared_bus;
+#endif
+
+	/* The first level mux has 4 outputs.  It uses 0x76 slave address.
+	 * Register a virtual bus for each output.
+	 */
+	virt = add_virt_bus(adap, 0x76, 0, &pca9544_select_mux, &pca9544_deselect_mux);
+	add_virt_bus(adap, 0x76, 1, &pca9544_select_mux, &pca9544_deselect_mux);
+	add_virt_bus(adap, 0x76, 2, &pca9544_select_mux, &pca9544_deselect_mux);
+	add_virt_bus(adap, 0x76, 3, &pca9544_select_mux, &pca9544_deselect_mux);
+	
+	/* There are 2nd level virtual buses at slave addresses 0x70, 0x71, 0x72 */
+	if(!virt) 
+		break;
+
+	/* first 2nd level mux */
+	sfpidx = 0;
+	for(i=0; i<7; i++) 
+		add_virt_bus(virt, 0x70, i, &pca9548_select_mux, &pca9548_deselect_mux);
+
+	/* second 2nd level mux */
+	for(i=0; i<7; i++) 
+		add_virt_bus(virt, 0x71, i, &pca9548_select_mux, &pca9548_deselect_mux);
+
+	/* third 2nd level mux */
+	for(i=0; i<7; i++) 
+		add_virt_bus(virt, 0x72, i, &pca9548_select_mux, &pca9548_deselect_mux);
+	
+	printk("iic%d: Registered I2C mux callbacks\n", index);
+	return 0;
+}
+
+/* Register a virtual bus and also store some information about this bus that will be useful to
+ * clients.
+ */
+static struct i2c_adapter *add_virt_bus(struct i2c_adapter *real, 
+                                        unsigned long mux_addr,
+                                        unsigned long mux_val,
+                                        void *select_cb,
+                                        void *deselect_cb)
+{
+	struct i2c_bus_mapping *pmap;
+	struct i2c_adapter *virt;
+
+	if((virt = register_virtual_i2c_adap(real, mux_addr, mux_val, select_cb, deselect_cb)) = NULL)
+		return virt;
+
+	if((pmap = kmalloc(sizeof(struct i2c_bus_mapping), GFP_KERNEL)) = NULL) {
+		printk(KERN_ERR "%s: Failed to allocate bus mapping\n", __FUNCTION__);
+		return -1;
+	}
+	pmap->real = real;
+	pmap->mux_addr = mux_addr;
+	pmap->mux_val = mux_val;
+	pmap->virt = virt;
+	list_add_tail(&pmap->list, &i2c_map_list);
+	return virt;
+}
+
+/* Called to find out which i2c bus to use to get to a specific bus segment.
+ */
+struct i2c_adapter *i2c_lookup_adapter(struct i2c_adapter *base, unsigned long mux_addr, 
+					unsigned long mux_val)
+{	
+	struct list_head *l;
+	struct i2c_bus_mapping *pmap;
+
+	list_for_each(l, &i2c_map_list) {
+		pmap = list_entry(l, struct i2c_bus_mapping, list);
+		if(pmap->real = base && pmap->mux_addr = mux_addr && pmap->mux_val = mux_val)
+			return pmap->virt;
+	}
+	return NULL;	/* none found */
+}
+
+static int i2c_read_proc(char *page, char **start, off_t off,
+                         int count, int *eof, void *data)
+{
+	int len;
+	char *buf = page;
+	struct list_head *l;
+	struct i2c_bus_mapping *pmap;
+
+        buf += sprintf(buf, "i2c bus_mapping\n");
+
+	list_for_each(l, &i2c_map_list) {
+		pmap = list_entry(l, struct i2c_bus_mapping, list);
+
+		if(pmap)
+        		buf += sprintf(buf, "base=iic%d  mux_addr=%02hx, mux_val=%02hx  =>  iic%d\n", 
+				i2c_adapter_id(pmap->real), pmap->mux_addr, pmap->mux_val, 
+				i2c_adapter_id(pmap->virt));
+	}
+
+        len = buf - page;
+        if (len <= off+count) *eof = 1;
+        *start = page + off;
+        len -= off;
+        if (len>count) len = count;
+        if (len<0) len = 0;
+        return len;
+}
+
+static int __init i2c_mux_init(void)
+{
+	int status, i;
+	struct i2c_adapter *adap;
+
+	/* Iterate through the _real_ adapters */
+	for(i=0; i<I2C_ADAP_MAX; i++) {
+
+		if((adap = i2c_get_adapter(i)) != NULL && 
+		   (adap->id & 0xff) = I2C_HW_OCP) {	/* we have ibm_ocp adapters */
+			attach_adapter(adap);
+		}
+	}
+
+	create_proc_read_entry("driver/i2c/virtual_i2c_map", 0, NULL, &i2c_read_proc, NULL);
+	return (status);
+}
+
+static void __exit i2c_mux_exit(void)
+{
+}
+
+module_init(i2c_mux_init);
+module_exit(i2c_mux_exit);
+
+EXPORT_SYMBOL(i2c_lookup_adapter);
+
+MODULE_DESCRIPTION("I2C multiplexor callbacks");
+
diff -urN linux-2.4.19/include/linux/i2c-virtual.h linux-2.4.19.new/include/linux/i2c-virtual.h
--- linux-2.4.19/include/linux/i2c-virtual.h	Wed Dec 31 16:00:00 1969
+++ linux-2.4.19.new/include/linux/i2c-virtual.h	Tue Nov 11 09:54:39 2003
@@ -0,0 +1,38 @@
+/* This is the header files for the 'virtual i2c' adapter driver.
+ * See Documentation/i2c/virtual_i2c for usage information.
+ */
+#ifndef __I2C_VIRTUAL_H
+#define __I2C_VIRTUAL_H
+
+#include <linux/i2c.h>
+
+struct i2c_mux_ctrl {
+	unsigned long	addr;		
+	unsigned long	value;
+
+	/* fn which enables the mux */
+	void (*select)(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux);	
+
+	/* fn which disables the mux */
+	void (*deselect)(struct i2c_adapter *adap, struct i2c_mux_ctrl *mux);	
+};
+
+/* This has to be exposed, since the code which assigns the callbacks must use it. */
+struct i2c_virt_priv {
+	struct i2c_adapter	*real_adap;		/* pointer to our 'real' adapter */
+	struct i2c_mux_ctrl	mux;			/* MUX settings for this adapter */
+};
+
+
+static inline struct i2c_adapter *i2c_get_real_adap(struct i2c_adapter *adap)
+{
+	struct i2c_virt_priv *priv;
+
+	if((adap->id & 0xff) != I2C_HW_VIRT)
+		return NULL;
+	
+	priv = (void*) adap->data;
+	return(priv->real_adap);
+}
+
+#endif /* __I2C_VIRTUAL_H */
diff -urN linux-2.4.19/include/linux/i2c.h linux-2.4.19.new/include/linux/i2c.h
--- linux-2.4.19/include/linux/i2c.h	Thu Oct 11 08:05:47 2001
+++ linux-2.4.19.new/include/linux/i2c.h	Tue Nov 11 09:54:39 2003
@@ -58,7 +58,7 @@
 /* --- General options ------------------------------------------------	*/
 
 #define I2C_ALGO_MAX	4		/* control memory consumption	*/
-#define I2C_ADAP_MAX	16
+#define I2C_ADAP_MAX	48
 #define I2C_DRIVER_MAX	16
 #define I2C_CLIENT_MAX	32
 #define I2C_DUMMY_MAX 4
@@ -184,6 +184,7 @@
 	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/
 					/* _LOWER_ 7 bits of this char	*/
+
 	/* addr: unsigned int to make lm_sensors i2c-isa adapter work
 	  more cleanly. It does not take any more memory space, due to
 	  alignment considerations */
@@ -224,6 +225,12 @@
 
 	/* To determine what the adapter supports */
 	u32 (*functionality) (struct i2c_adapter *);
+
+	/* Some chassis/bladed systems must arbitrate with another CPU to
+	 * get exclusive access to the I2C bus.  Set NULL if not used.
+	 */
+	int (*acquire_exclusive)(struct i2c_adapter *adap);
+	int (*release_exclusive)(struct i2c_adapter *adap);
 };
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,29)
@@ -367,7 +374,8 @@
  */
 extern int i2c_adapter_id(struct i2c_adapter *adap);
 
-
+/* Return a pointer to the i2c_adapter */
+extern struct i2c_adapter* i2c_get_adapter(int index);
 
 /* Return the functionality mask */
 extern u32 i2c_get_functionality (struct i2c_adapter *adap);
diff -urN linux-2.4.19/include/linux/i2c-id.h linux-2.4.19.new/include/linux/i2c-id.h
--- linux-2.4.19/include/linux/i2c-id.h	Thu Oct 11 08:05:47 2001
+++ linux-2.4.19.new/include/linux/i2c-id.h	Tue Nov 11 10:30:51 2003
@@ -189,6 +189,8 @@
 /* --- MPC8xx PowerPC adapters						*/
 #define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
 
+#define I2C_HW_VIRT	0x01 	/* Virtualized adapter                  */
+
 /* --- SMBus only adapters						*/
 #define I2C_HW_SMBUS_PIIX4	0x00
 #define I2C_HW_SMBUS_ALI15X3	0x01
