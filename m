From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test5
Message-Id: <10645266092538@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064526609700@kroah.com>
In-Reply-To: <1064526609700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ChangeSet 1.1325.4.2, 2003/09/23 14:01:39-07:00, greg@kroah.com

[PATCH] I2C: move the i2c algorithm drivers to drivers/i2c/algos


 drivers/i2c/i2c-algo-bit.c       |  567 -------------------------
 drivers/i2c/i2c-algo-ite.c       |  872 ---------------------------------------
 drivers/i2c/i2c-algo-pcf.c       |  479 ---------------------
 drivers/i2c/i2c-ite.h            |  117 -----
 drivers/i2c/i2c-pcf8584.h        |   78 ---
 drivers/i2c/Kconfig              |   38 -
 drivers/i2c/Makefile             |    5 
 drivers/i2c/algos/Kconfig        |   45 ++
 drivers/i2c/algos/Makefile       |    7 
 drivers/i2c/algos/i2c-algo-bit.c |  567 +++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-ite.c |  872 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-ite.h |  117 +++++
 drivers/i2c/algos/i2c-algo-pcf.c |  479 +++++++++++++++++++++
 drivers/i2c/algos/i2c-algo-pcf.h |   78 +++
 drivers/i2c/busses/i2c-elektor.c |    2 
 15 files changed, 2168 insertions(+), 2155 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Thu Sep 25 14:49:55 2003
+++ b/drivers/i2c/Kconfig	Thu Sep 25 14:49:55 2003
@@ -37,43 +37,7 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-dev.
 
-config I2C_ALGOBIT
-	tristate "I2C bit-banging interfaces"
-	depends on I2C
-	help
-	  This allows you to use a range of I2C adapters called bit-banging
-	  adapters.  Say Y if you own an I2C adapter belonging to this class
-	  and then say Y to the specific driver for you adapter below.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-algo-bit.
-
-config I2C_ALGOPCF
-	tristate "I2C PCF 8584 interfaces"
-	depends on I2C
-	help
-	  This allows you to use a range of I2C adapters called PCF adapters.
-	  Say Y if you own an I2C adapter belonging to this class and then say
-	  Y to the specific driver for you adapter below.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-algo-pcf.
-
-config I2C_ALGOITE
-	tristate "ITE I2C Algorithm"
-	depends on MIPS_ITE8172 && I2C
-	help
-	  This supports the use of the ITE8172 I2C interface found on some MIPS
-	  systems. Say Y if you have one of these. You should also say Y for
-	  the ITE I2C peripheral driver support below.
-
-	  This support is also available as a module.  If so, the module 
-	  will be called i2c-algo-ite.
-
-config I2C_ALGO8XX
-	tristate "MPC8xx CPM I2C interface"
-	depends on 8xx && I2C
-
+	source drivers/i2c/algos/Kconfig
 	source drivers/i2c/busses/Kconfig
 	source drivers/i2c/chips/Kconfig
 
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Thu Sep 25 14:49:55 2003
+++ b/drivers/i2c/Makefile	Thu Sep 25 14:49:55 2003
@@ -5,7 +5,4 @@
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
-obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
-obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
-obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
-obj-y				+= busses/ chips/
+obj-y				+= busses/ chips/ algos/
diff -Nru a/drivers/i2c/algos/Kconfig b/drivers/i2c/algos/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/Kconfig	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,45 @@
+#
+# Character device configuration
+#
+
+menu "I2C Algorithms"
+
+config I2C_ALGOBIT
+	tristate "I2C bit-banging interfaces"
+	depends on I2C
+	help
+	  This allows you to use a range of I2C adapters called bit-banging
+	  adapters.  Say Y if you own an I2C adapter belonging to this class
+	  and then say Y to the specific driver for you adapter below.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-bit.
+
+config I2C_ALGOPCF
+	tristate "I2C PCF 8584 interfaces"
+	depends on I2C
+	help
+	  This allows you to use a range of I2C adapters called PCF adapters.
+	  Say Y if you own an I2C adapter belonging to this class and then say
+	  Y to the specific driver for you adapter below.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-pcf.
+
+config I2C_ALGOITE
+	tristate "ITE I2C Algorithm"
+	depends on MIPS_ITE8172 && I2C
+	help
+	  This supports the use of the ITE8172 I2C interface found on some MIPS
+	  systems. Say Y if you have one of these. You should also say Y for
+	  the ITE I2C peripheral driver support below.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-ite.
+
+config I2C_ALGO8XX
+	tristate "MPC8xx CPM I2C interface"
+	depends on 8xx && I2C
+
+endmenu
+
diff -Nru a/drivers/i2c/algos/Makefile b/drivers/i2c/algos/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/Makefile	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,7 @@
+#
+# Makefile for the i2c algorithms
+#
+
+obj-$(CONFIG_I2C_ALGOBIT)	+= i2c-algo-bit.o
+obj-$(CONFIG_I2C_ALGOPCF)	+= i2c-algo-pcf.o
+obj-$(CONFIG_I2C_ALGOITE)	+= i2c-algo-ite.o
diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/i2c-algo-bit.c	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,567 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-algo-bit.c i2c driver algorithms for bit-shift adapters		     */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-2000 Simon G. Vogl
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
+   Frodo Looijaard <frodol@dds.nl> */
+
+/* $Id: i2c-algo-bit.c,v 1.44 2003/01/21 08:08:16 kmalkki Exp $ */
+
+/* #define DEBUG 1 */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+
+/* ----- global defines ----------------------------------------------- */
+#define DEB(x) if (i2c_debug>=1) x;
+#define DEB2(x) if (i2c_debug>=2) x;
+#define DEBSTAT(x) if (i2c_debug>=3) x; /* print several statistical values*/
+#define DEBPROTO(x) if (i2c_debug>=9) { x; }
+ 	/* debug the protocol by showing transferred bits */
+
+
+/* ----- global variables ---------------------------------------------	*/
+
+/* module parameters:
+ */
+static int i2c_debug;
+static int bit_test;	/* see if the line-setting functions work	*/
+
+/* --- setting states on the bus with the right timing: ---------------	*/
+
+#define setsda(adap,val) adap->setsda(adap->data, val)
+#define setscl(adap,val) adap->setscl(adap->data, val)
+#define getsda(adap) adap->getsda(adap->data)
+#define getscl(adap) adap->getscl(adap->data)
+
+static inline void sdalo(struct i2c_algo_bit_data *adap)
+{
+	setsda(adap,0);
+	udelay(adap->udelay);
+}
+
+static inline void sdahi(struct i2c_algo_bit_data *adap)
+{
+	setsda(adap,1);
+	udelay(adap->udelay);
+}
+
+static inline void scllo(struct i2c_algo_bit_data *adap)
+{
+	setscl(adap,0);
+	udelay(adap->udelay);
+}
+
+/*
+ * Raise scl line, and do checking for delays. This is necessary for slower
+ * devices.
+ */
+static inline int sclhi(struct i2c_algo_bit_data *adap)
+{
+	unsigned long start;
+
+	setscl(adap,1);
+
+	/* Not all adapters have scl sense line... */
+	if (adap->getscl = NULL )
+		return 0;
+
+	start=jiffies;
+	while (! getscl(adap) ) {	
+ 		/* the hw knows how to read the clock line,
+ 		 * so we wait until it actually gets high.
+ 		 * This is safer as some chips may hold it low
+ 		 * while they are processing data internally. 
+ 		 */
+		if (time_after_eq(jiffies, start+adap->timeout)) {
+			return -ETIMEDOUT;
+		}
+		cond_resched();
+	}
+	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
+	udelay(adap->udelay);
+	return 0;
+} 
+
+
+/* --- other auxiliary functions --------------------------------------	*/
+static void i2c_start(struct i2c_algo_bit_data *adap) 
+{
+	/* assert: scl, sda are high */
+	DEBPROTO(printk("S "));
+	sdalo(adap);
+	scllo(adap);
+}
+
+static void i2c_repstart(struct i2c_algo_bit_data *adap) 
+{
+	/* scl, sda may not be high */
+	DEBPROTO(printk(" Sr "));
+	setsda(adap,1);
+	sclhi(adap);
+	udelay(adap->udelay);
+	
+	sdalo(adap);
+	scllo(adap);
+}
+
+
+static void i2c_stop(struct i2c_algo_bit_data *adap) 
+{
+	DEBPROTO(printk("P\n"));
+	/* assert: scl is low */
+	sdalo(adap);
+	sclhi(adap); 
+	sdahi(adap);
+}
+
+
+
+/* send a byte without start cond., look for arbitration, 
+   check ackn. from slave */
+/* returns:
+ * 1 if the device acknowledged
+ * 0 if the device did not ack
+ * -ETIMEDOUT if an error occurred (while raising the scl line)
+ */
+static int i2c_outb(struct i2c_adapter *i2c_adap, char c)
+{
+	int i;
+	int sb;
+	int ack;
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+
+	/* assert: scl is low */
+	for ( i=7 ; i>=0 ; i-- ) {
+		sb = c & ( 1 << i );
+		setsda(adap,sb);
+		udelay(adap->udelay);
+		DEBPROTO(printk(KERN_DEBUG "%d",sb!=0));
+		if (sclhi(adap)<0) { /* timed out */
+			sdahi(adap); /* we don't want to block the net */
+			DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x, timeout at bit #%d\n", c&0xff, i));
+			return -ETIMEDOUT;
+		};
+		/* do arbitration here: 
+		 * if ( sb && ! getsda(adap) ) -> ouch! Get out of here.
+		 */
+		setscl(adap, 0 );
+		udelay(adap->udelay);
+	}
+	sdahi(adap);
+	if (sclhi(adap)<0){ /* timeout */
+	    DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x, timeout at ack\n", c&0xff));
+	    return -ETIMEDOUT;
+	};
+	/* read ack: SDA should be pulled down by slave */
+	ack=getsda(adap);	/* ack: sda is pulled low ->success.	 */
+	DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x , getsda() = %d\n", c & 0xff, ack));
+
+	DEBPROTO( printk(KERN_DEBUG "[%2.2x]",c&0xff) );
+	DEBPROTO(if (0=ack){ printk(KERN_DEBUG " A ");} else printk(KERN_DEBUG " NA ") );
+	scllo(adap);
+	return 0=ack;		/* return 1 if device acked	 */
+	/* assert: scl is low (sda undef) */
+}
+
+
+static int i2c_inb(struct i2c_adapter *i2c_adap) 
+{
+	/* read byte via i2c port, without start/stop sequence	*/
+	/* acknowledge is sent in i2c_read.			*/
+	int i;
+	unsigned char indata=0;
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+
+	/* assert: scl is low */
+	sdahi(adap);
+	for (i=0;i<8;i++) {
+		if (sclhi(adap)<0) { /* timeout */
+			DEB2(printk(KERN_DEBUG " i2c_inb: timeout at bit #%d\n", 7-i));
+			return -ETIMEDOUT;
+		};
+		indata *= 2;
+		if ( getsda(adap) ) 
+			indata |= 0x01;
+		scllo(adap);
+	}
+	/* assert: scl is low */
+	DEB2(printk(KERN_DEBUG "i2c_inb: 0x%02x\n", indata & 0xff));
+
+	DEBPROTO(printk(KERN_DEBUG " 0x%02x", indata & 0xff));
+	return (int) (indata & 0xff);
+}
+
+/*
+ * Sanity check for the adapter hardware - check the reaction of
+ * the bus lines only if it seems to be idle.
+ */
+static int test_bus(struct i2c_algo_bit_data *adap, char* name) {
+	int scl,sda;
+	sda=getsda(adap);
+	if (adap->getscl=NULL) {
+		printk(KERN_WARNING "i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
+		return 0;		
+	}
+	scl=getscl(adap);
+	printk(KERN_INFO "i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
+	       name,getscl(adap),getsda(adap));
+	if (!scl || !sda ) {
+		printk(KERN_INFO " i2c-algo-bit.o: %s seems to be busy.\n",name);
+		goto bailout;
+	}
+	sdalo(adap);
+	printk(KERN_DEBUG "i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 != getsda(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck high!\n",name);
+		sdahi(adap);
+		goto bailout;
+	}
+	if ( 0 = getscl(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
+			name);
+		goto bailout;
+	}		
+	sdahi(adap);
+	printk(KERN_DEBUG "i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 = getsda(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck low!\n",name);
+		sdahi(adap);
+		goto bailout;
+	}
+	if ( 0 = getscl(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
+		       name);
+	goto bailout;
+	}
+	scllo(adap);
+	printk(KERN_DEBUG "i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 != getscl(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck high!\n",name);
+		sclhi(adap);
+		goto bailout;
+	}
+	if ( 0 = getsda(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
+			name);
+		goto bailout;
+	}
+	sclhi(adap);
+	printk(KERN_DEBUG "i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 = getscl(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck low!\n",name);
+		sclhi(adap);
+		goto bailout;
+	}
+	if ( 0 = getsda(adap) ) {
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
+			name);
+		goto bailout;
+	}
+	printk(KERN_INFO "i2c-algo-bit.o: %s passed test.\n",name);
+	return 0;
+bailout:
+	sdahi(adap);
+	sclhi(adap);
+	return -ENODEV;
+}
+
+/* ----- Utility functions
+ */
+
+/* try_address tries to contact a chip for a number of
+ * times before it gives up.
+ * return values:
+ * 1 chip answered
+ * 0 chip did not answer
+ * -x transmission error
+ */
+static inline int try_address(struct i2c_adapter *i2c_adap,
+		       unsigned char addr, int retries)
+{
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	int i,ret = -1;
+	for (i=0;i<=retries;i++) {
+		ret = i2c_outb(i2c_adap,addr);
+		if (ret=1)
+			break;	/* success! */
+		i2c_stop(adap);
+		udelay(5/*adap->udelay*/);
+		if (i=retries)  /* no success */
+			break;
+		i2c_start(adap);
+		udelay(adap->udelay);
+	}
+	DEB2(if (i)
+	     printk(KERN_DEBUG "i2c-algo-bit.o: Used %d tries to %s client at 0x%02x : %s\n",
+		    i+1, addr & 1 ? "read" : "write", addr>>1,
+		    ret=1 ? "success" : ret=0 ? "no ack" : "failed, timeout?" )
+	    );
+	return ret;
+}
+
+static int sendbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
+{
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	char c;
+	const char *temp = msg->buf;
+	int count = msg->len;
+	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK; 
+	int retval;
+	int wrcount=0;
+
+	while (count > 0) {
+		c = *temp;
+		DEB2(dev_dbg(&i2c_adap->dev, "sendbytes: writing %2.2X\n", c&0xff));
+		retval = i2c_outb(i2c_adap,c);
+		if ((retval>0) || (nak_ok && (retval=0)))  { /* ok or ignored NAK */
+			count--; 
+			temp++;
+			wrcount++;
+		} else { /* arbitration or no acknowledge */
+			dev_err(&i2c_adap->dev, "sendbytes: error - bailout.\n");
+			i2c_stop(adap);
+			return (retval<0)? retval : -EFAULT;
+			        /* got a better one ?? */
+		}
+#if 0
+		/* from asm/delay.h */
+		__delay(adap->mdelay * (loops_per_sec / 1000) );
+#endif
+	}
+	return wrcount;
+}
+
+static inline int readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
+{
+	int inval;
+	int rdcount=0;   	/* counts bytes read */
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	char *temp = msg->buf;
+	int count = msg->len;
+
+	while (count > 0) {
+		inval = i2c_inb(i2c_adap);
+/*printk("%#02x ",inval); if ( ! (count % 16) ) printk("\n"); */
+		if (inval>=0) {
+			*temp = inval;
+			rdcount++;
+		} else {   /* read timed out */
+			printk(KERN_ERR "i2c-algo-bit.o: readbytes: i2c_inb timed out.\n");
+			break;
+		}
+
+		if ( count > 1 ) {		/* send ack */
+			sdalo(adap);
+			DEBPROTO(printk(" Am "));
+		} else {
+			sdahi(adap);	/* neg. ack on last byte */
+			DEBPROTO(printk(" NAm "));
+		}
+		if (sclhi(adap)<0) {	/* timeout */
+			sdahi(adap);
+			printk(KERN_ERR "i2c-algo-bit.o: readbytes: Timeout at ack\n");
+			return -ETIMEDOUT;
+		};
+		scllo(adap);
+		sdahi(adap);
+		temp++;
+		count--;
+	}
+	return rdcount;
+}
+
+/* doAddress initiates the transfer by generating the start condition (in
+ * try_address) and transmits the address in the necessary format to handle
+ * reads, writes as well as 10bit-addresses.
+ * returns:
+ *  0 everything went okay, the chip ack'ed, or IGNORE_NAK flag was set
+ * -x an error occurred (like: -EREMOTEIO if the device did not answer, or
+ *	-ETIMEDOUT, for example if the lines are stuck...) 
+ */
+static inline int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg) 
+{
+	unsigned short flags = msg->flags;
+	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK;
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+
+	unsigned char addr;
+	int ret, retries;
+
+	retries = nak_ok ? 0 : i2c_adap->retries;
+	
+	if ( (flags & I2C_M_TEN)  ) { 
+		/* a ten bit address */
+		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
+		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
+		/* try extended address code...*/
+		ret = try_address(i2c_adap, addr, retries);
+		if ((ret != 1) && !nak_ok)  {
+			printk(KERN_ERR "died at extended address code.\n");
+			return -EREMOTEIO;
+		}
+		/* the remaining 8 bit address */
+		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
+		if ((ret != 1) && !nak_ok) {
+			/* the chip did not ack / xmission error occurred */
+			printk(KERN_ERR "died at 2nd address code.\n");
+			return -EREMOTEIO;
+		}
+		if ( flags & I2C_M_RD ) {
+			i2c_repstart(adap);
+			/* okay, now switch into reading mode */
+			addr |= 0x01;
+			ret = try_address(i2c_adap, addr, retries);
+			if ((ret!=1) && !nak_ok) {
+				printk(KERN_ERR "died at extended address code.\n");
+				return -EREMOTEIO;
+			}
+		}
+	} else {		/* normal 7bit address	*/
+		addr = ( msg->addr << 1 );
+		if (flags & I2C_M_RD )
+			addr |= 1;
+		if (flags & I2C_M_REV_DIR_ADDR )
+			addr ^= 1;
+		ret = try_address(i2c_adap, addr, retries);
+		if ((ret!=1) && !nak_ok)
+			return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static int bit_xfer(struct i2c_adapter *i2c_adap,
+		    struct i2c_msg msgs[], int num)
+{
+	struct i2c_msg *pmsg;
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	
+	int i,ret;
+	unsigned short nak_ok;
+
+	i2c_start(adap);
+	for (i=0;i<num;i++) {
+		pmsg = &msgs[i];
+		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK; 
+		if (!(pmsg->flags & I2C_M_NOSTART)) {
+			if (i) {
+				i2c_repstart(adap);
+			}
+			ret = bit_doAddress(i2c_adap, pmsg);
+			if ((ret != 0) && !nak_ok) {
+			    DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device addr %2.2x msg #%d\n"
+					,msgs[i].addr,i));
+			    return (ret<0) ? ret : -EREMOTEIO;
+			}
+		}
+		if (pmsg->flags & I2C_M_RD ) {
+			/* read bytes into buffer*/
+			ret = readbytes(i2c_adap, pmsg);
+			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
+			if (ret < pmsg->len ) {
+				return (ret<0)? ret : -EREMOTEIO;
+			}
+		} else {
+			/* write bytes from buffer */
+			ret = sendbytes(i2c_adap, pmsg);
+			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
+			if (ret < pmsg->len ) {
+				return (ret<0) ? ret : -EREMOTEIO;
+			}
+		}
+	}
+	i2c_stop(adap);
+	return num;
+}
+
+static u32 bit_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
+	       I2C_FUNC_PROTOCOL_MANGLING;
+}
+
+
+/* -----exported algorithm data: -------------------------------------	*/
+
+static struct i2c_algorithm i2c_bit_algo = {
+	.name		= "Bit-shift algorithm",
+	.id		= I2C_ALGO_BIT,
+	.master_xfer	= bit_xfer,
+	.functionality	= bit_func,
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_bit_add_bus(struct i2c_adapter *adap)
+{
+	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
+
+	if (bit_test) {
+		int ret = test_bus(bit_adap, adap->name);
+		if (ret<0)
+			return -ENODEV;
+	}
+
+	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
+
+	/* register new adapter to i2c module... */
+
+	adap->id |= i2c_bit_algo.id;
+	adap->algo = &i2c_bit_algo;
+
+	adap->timeout = 100;	/* default values, should	*/
+	adap->retries = 3;	/* be replaced by defines	*/
+
+	i2c_add_adapter(adap);
+	return 0;
+}
+
+
+int i2c_bit_del_bus(struct i2c_adapter *adap)
+{
+	return i2c_del_adapter(adap);
+}
+
+EXPORT_SYMBOL(i2c_bit_add_bus);
+EXPORT_SYMBOL(i2c_bit_del_bus);
+
+MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
+MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(bit_test, "i");
+MODULE_PARM(i2c_debug,"i");
+
+MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
+MODULE_PARM_DESC(i2c_debug,
+		 "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
diff -Nru a/drivers/i2c/algos/i2c-algo-ite.c b/drivers/i2c/algos/i2c-algo-ite.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/i2c-algo-ite.c	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,872 @@
+/*
+   -------------------------------------------------------------------------
+   i2c-algo-ite.c i2c driver algorithms for ITE adapters	    
+   
+   Hai-Pao Fan, MontaVista Software, Inc.
+   hpfan@mvista.com or source@mvista.com
+
+   Copyright 2000 MontaVista Software Inc.
+
+   ---------------------------------------------------------------------------
+   This file was highly leveraged from i2c-algo-pcf.c, which was created
+   by Simon G. Vogl and Hans Berglund:
+
+
+     Copyright (C) 1995-1997 Simon G. Vogl
+                   1998-2000 Hans Berglund
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and 
+   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
+   <mbailey@littlefeet-inc.com> */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <asm/uaccess.h>
+#include <linux/ioport.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-algo-ite.h>
+#include "i2c-algo-ite.h"
+
+#define	PM_DSR		IT8172_PCI_IO_BASE + IT_PM_DSR
+#define	PM_IBSR		IT8172_PCI_IO_BASE + IT_PM_DSR + 0x04 
+#define GPIO_CCR	IT8172_PCI_IO_BASE + IT_GPCCR
+
+/* ----- global defines ----------------------------------------------- */
+#define DEB(x) if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
+#define DEBPROTO(x) if (i2c_debug>=9) x;
+ 	/* debug the protocol by showing transferred bits */
+#define DEF_TIMEOUT 16
+
+/* debugging - slow down transfer to have a look at the data .. 	*/
+/* I use this with two leds&resistors, each one connected to sda,scl 	*/
+/* respectively. This makes sure that the algorithm works. Some chips   */
+/* might not like this, as they have an internal timeout of some mils	*/
+/*
+#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
+                        cond_resched();
+*/
+
+
+/* ----- global variables ---------------------------------------------	*/
+
+#ifdef SLO_IO
+	int jif;
+#endif
+
+/* module parameters:
+ */
+static int i2c_debug=1;
+static int iic_test=0;	/* see if the line-setting functions work	*/
+static int iic_scan=0;	/* have a look at what's hanging 'round		*/
+
+/* --- setting states on the bus with the right timing: ---------------	*/
+
+#define get_clock(adap) adap->getclock(adap->data)
+#define iic_outw(adap, reg, val) adap->setiic(adap->data, reg, val)
+#define iic_inw(adap, reg) adap->getiic(adap->data, reg)
+
+
+/* --- other auxiliary functions --------------------------------------	*/
+
+static void iic_start(struct i2c_algo_iic_data *adap)
+{
+	iic_outw(adap,ITE_I2CHCR,ITE_CMD);
+}
+
+static void iic_stop(struct i2c_algo_iic_data *adap)
+{
+	iic_outw(adap,ITE_I2CHCR,0);
+	iic_outw(adap,ITE_I2CHSR,ITE_I2CHSR_TDI);
+}
+
+static void iic_reset(struct i2c_algo_iic_data *adap)
+{
+	iic_outw(adap, PM_IBSR, iic_inw(adap, PM_IBSR) | 0x80);
+}
+
+
+static int wait_for_bb(struct i2c_algo_iic_data *adap)
+{
+	int timeout = DEF_TIMEOUT;
+	short status;
+
+	status = iic_inw(adap, ITE_I2CHSR);
+#ifndef STUB_I2C
+	while (timeout-- && (status & ITE_I2CHSR_HB)) {
+		udelay(1000); /* How much is this? */
+		status = iic_inw(adap, ITE_I2CHSR);
+	}
+#endif
+	if (timeout<=0) {
+		printk(KERN_ERR "Timeout, host is busy\n");
+		iic_reset(adap);
+	}
+	return(timeout<=0);
+}
+
+/*
+ * Puts this process to sleep for a period equal to timeout 
+ */
+static inline void iic_sleep(unsigned long timeout)
+{
+	schedule_timeout( timeout * HZ);
+}
+
+/* After we issue a transaction on the IIC bus, this function
+ * is called.  It puts this process to sleep until we get an interrupt from
+ * from the controller telling us that the transaction we requested in complete.
+ */
+static int wait_for_pin(struct i2c_algo_iic_data *adap, short *status) {
+
+	int timeout = DEF_TIMEOUT;
+	
+	timeout = wait_for_bb(adap);
+	if (timeout) {
+  		DEB2(printk("Timeout waiting for host not busy\n");)
+  		return -EIO;
+	}                           
+	timeout = DEF_TIMEOUT;
+
+	*status = iic_inw(adap, ITE_I2CHSR);
+#ifndef STUB_I2C
+	while (timeout-- && !(*status & ITE_I2CHSR_TDI)) {
+	   adap->waitforpin();
+	   *status = iic_inw(adap, ITE_I2CHSR);
+	}
+#endif
+	if (timeout <= 0)
+		return(-1);
+	else
+		return(0);
+}
+
+static int wait_for_fe(struct i2c_algo_iic_data *adap, short *status)
+{
+	int timeout = DEF_TIMEOUT;
+
+	*status = iic_inw(adap, ITE_I2CFSR);
+#ifndef STUB_I2C 
+	while (timeout-- && (*status & ITE_I2CFSR_FE)) {
+		udelay(1000);
+		iic_inw(adap, ITE_I2CFSR);
+	}
+#endif
+	if (timeout <= 0) 
+		return(-1);
+	else
+		return(0);
+}
+
+static int iic_init (struct i2c_algo_iic_data *adap)
+{
+	short i;
+
+	/* Clear bit 7 to set I2C to normal operation mode */
+	i=iic_inw(adap, PM_DSR)& 0xff7f;
+	iic_outw(adap, PM_DSR, i);
+
+	/* set IT_GPCCR port C bit 2&3 as function 2 */
+	i = iic_inw(adap, GPIO_CCR) & 0xfc0f;
+	iic_outw(adap,GPIO_CCR,i);
+
+	/* Clear slave address/sub-address */
+	iic_outw(adap,ITE_I2CSAR, 0);
+	iic_outw(adap,ITE_I2CSSAR, 0);
+
+	/* Set clock counter register */
+	iic_outw(adap,ITE_I2CCKCNT, get_clock(adap));
+
+	/* Set START/reSTART/STOP time registers */
+	iic_outw(adap,ITE_I2CSHDR, 0x0a);
+	iic_outw(adap,ITE_I2CRSUR, 0x0a);
+	iic_outw(adap,ITE_I2CPSUR, 0x0a);
+
+	/* Enable interrupts on completing the current transaction */
+	iic_outw(adap,ITE_I2CHCR, ITE_I2CHCR_IE | ITE_I2CHCR_HCE);
+
+	/* Clear transfer count */
+	iic_outw(adap,ITE_I2CFBCR, 0x0);
+
+	DEB2(printk("iic_init: Initialized IIC on ITE 0x%x\n",
+		iic_inw(adap, ITE_I2CHSR)));
+	return 0;
+}
+
+
+/*
+ * Sanity check for the adapter hardware - check the reaction of
+ * the bus lines only if it seems to be idle.
+ */
+static int test_bus(struct i2c_algo_iic_data *adap, char *name) {
+#if 0
+	int scl,sda;
+	sda=getsda(adap);
+	if (adap->getscl=NULL) {
+		printk("test_bus: Warning: Adapter can't read from clock line - skipping test.\n");
+		return 0;		
+	}
+	scl=getscl(adap);
+	printk("test_bus: Adapter: %s scl: %d  sda: %d -- testing...\n",
+	name,getscl(adap),getsda(adap));
+	if (!scl || !sda ) {
+		printk("test_bus: %s seems to be busy.\n",adap->name);
+		goto bailout;
+	}
+	sdalo(adap);
+	printk("test_bus:1 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 != getsda(adap) ) {
+		printk("test_bus: %s SDA stuck high!\n",name);
+		sdahi(adap);
+		goto bailout;
+	}
+	if ( 0 = getscl(adap) ) {
+		printk("test_bus: %s SCL unexpected low while pulling SDA low!\n",
+			name);
+		goto bailout;
+	}		
+	sdahi(adap);
+	printk("test_bus:2 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 = getsda(adap) ) {
+		printk("test_bus: %s SDA stuck low!\n",name);
+		sdahi(adap);
+		goto bailout;
+	}
+	if ( 0 = getscl(adap) ) {
+		printk("test_bus: %s SCL unexpected low while SDA high!\n",
+		       adap->name);
+	goto bailout;
+	}
+	scllo(adap);
+	printk("test_bus:3 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 != getscl(adap) ) {
+
+		sclhi(adap);
+		goto bailout;
+	}
+	if ( 0 = getsda(adap) ) {
+		printk("test_bus: %s SDA unexpected low while pulling SCL low!\n",
+			name);
+		goto bailout;
+	}
+	sclhi(adap);
+	printk("test_bus:4 scl: %d  sda: %d \n",getscl(adap),
+	       getsda(adap));
+	if ( 0 = getscl(adap) ) {
+		printk("test_bus: %s SCL stuck low!\n",name);
+		sclhi(adap);
+		goto bailout;
+	}
+	if ( 0 = getsda(adap) ) {
+		printk("test_bus: %s SDA unexpected low while SCL high!\n",
+			name);
+		goto bailout;
+	}
+	printk("test_bus: %s passed test.\n",name);
+	return 0;
+bailout:
+	sdahi(adap);
+	sclhi(adap);
+	return -ENODEV;
+#endif
+	return (0);
+}
+
+/* ----- Utility functions
+ */
+
+
+/* Verify the device we want to talk to on the IIC bus really exists. */
+static inline int try_address(struct i2c_algo_iic_data *adap,
+		       unsigned int addr, int retries)
+{
+	int i, ret = -1;
+	short status;
+
+	for (i=0;i<retries;i++) {
+		iic_outw(adap, ITE_I2CSAR, addr);
+		iic_start(adap);
+		if (wait_for_pin(adap, &status) = 0) {
+			if ((status & ITE_I2CHSR_DNE) = 0) { 
+				iic_stop(adap);
+				iic_outw(adap, ITE_I2CFCR, ITE_I2CFCR_FLUSH);
+				ret=1;
+				break;	/* success! */
+			}
+		}
+		iic_stop(adap);
+		udelay(adap->udelay);
+	}
+	DEB2(if (i) printk("try_address: needed %d retries for 0x%x\n",i,
+	                   addr));
+	return ret;
+}
+
+
+static int iic_sendbytes(struct i2c_adapter *i2c_adap,const char *buf,
+                         int count)
+{
+	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
+	int wrcount=0, timeout;
+	short status;
+	int loops, remainder, i, j;
+	union {
+		char byte[2];
+		unsigned short word;
+	} tmp;
+   
+	iic_outw(adap, ITE_I2CSSAR, (unsigned short)buf[wrcount++]);
+	count--;
+	if (count = 0)
+		return -EIO;
+
+	loops =  count / 32;		/* 32-byte FIFO */
+	remainder = count % 32;
+
+	if(loops) {
+		for(i=0; i<loops; i++) {
+
+			iic_outw(adap, ITE_I2CFBCR, 32);
+			for(j=0; j<32/2; j++) {
+				tmp.byte[1] = buf[wrcount++];
+				tmp.byte[0] = buf[wrcount++];
+				iic_outw(adap, ITE_I2CFDR, tmp.word); 
+			}
+
+			/* status FIFO overrun */
+			iic_inw(adap, ITE_I2CFSR);
+			iic_inw(adap, ITE_I2CFBCR);
+
+			iic_outw(adap, ITE_I2CHCR, ITE_WRITE);	/* Issue WRITE command */
+
+			/* Wait for transmission to complete */
+			timeout = wait_for_pin(adap, &status);
+			if(timeout) {
+				iic_stop(adap);
+				printk("iic_sendbytes: %s write timeout.\n", i2c_adap->name);
+				return -EREMOTEIO; /* got a better one ?? */
+     	}
+			if (status & ITE_I2CHSR_DB) {
+				iic_stop(adap);
+				printk("iic_sendbytes: %s write error - no ack.\n", i2c_adap->name);
+				return -EREMOTEIO; /* got a better one ?? */
+			}
+		}
+	}
+	if(remainder) {
+		iic_outw(adap, ITE_I2CFBCR, remainder);
+		for(i=0; i<remainder/2; i++) {
+			tmp.byte[1] = buf[wrcount++];
+			tmp.byte[0] = buf[wrcount++];
+			iic_outw(adap, ITE_I2CFDR, tmp.word);
+		}
+
+		/* status FIFO overrun */
+		iic_inw(adap, ITE_I2CFSR);
+		iic_inw(adap, ITE_I2CFBCR);
+
+		iic_outw(adap, ITE_I2CHCR, ITE_WRITE);  /* Issue WRITE command */
+
+		timeout = wait_for_pin(adap, &status);
+		if(timeout) {
+			iic_stop(adap);
+			printk("iic_sendbytes: %s write timeout.\n", i2c_adap->name);
+			return -EREMOTEIO; /* got a better one ?? */
+		}
+#ifndef STUB_I2C
+		if (status & ITE_I2CHSR_DB) { 
+			iic_stop(adap);
+			printk("iic_sendbytes: %s write error - no ack.\n", i2c_adap->name);
+			return -EREMOTEIO; /* got a better one ?? */
+		}
+#endif
+	}
+	iic_stop(adap);
+	return wrcount;
+}
+
+
+static int iic_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count,
+	int sread)
+{
+	int rdcount=0, i, timeout;
+	short status;
+	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
+	int loops, remainder, j;
+	union {
+		char byte[2];
+		unsigned short word;
+	} tmp;
+		
+	loops = count / 32;				/* 32-byte FIFO */
+	remainder = count % 32;
+
+	if(loops) {
+		for(i=0; i<loops; i++) {
+			iic_outw(adap, ITE_I2CFBCR, 32);
+			if (sread)
+				iic_outw(adap, ITE_I2CHCR, ITE_SREAD);
+			else
+				iic_outw(adap, ITE_I2CHCR, ITE_READ);		/* Issue READ command */
+
+			timeout = wait_for_pin(adap, &status);
+			if(timeout) {
+				iic_stop(adap);
+				printk("iic_readbytes:  %s read timeout.\n", i2c_adap->name);
+				return (-1);
+			}
+#ifndef STUB_I2C
+			if (status & ITE_I2CHSR_DB) {
+				iic_stop(adap);
+				printk("iic_readbytes: %s read error - no ack.\n", i2c_adap->name);
+				return (-1);
+			}
+#endif
+
+			timeout = wait_for_fe(adap, &status);
+			if(timeout) {
+				iic_stop(adap);
+				printk("iic_readbytes:  %s FIFO is empty\n", i2c_adap->name);
+				return (-1); 
+			}
+
+			for(j=0; j<32/2; j++) {
+				tmp.word = iic_inw(adap, ITE_I2CFDR);
+				buf[rdcount++] = tmp.byte[1];
+				buf[rdcount++] = tmp.byte[0];
+			}
+
+			/* status FIFO underrun */
+			iic_inw(adap, ITE_I2CFSR);
+
+		}
+	}
+
+
+	if(remainder) {
+		remainder=(remainder+1)/2 * 2;
+		iic_outw(adap, ITE_I2CFBCR, remainder);
+		if (sread)
+			iic_outw(adap, ITE_I2CHCR, ITE_SREAD);
+		else
+		iic_outw(adap, ITE_I2CHCR, ITE_READ);		/* Issue READ command */
+
+		timeout = wait_for_pin(adap, &status);
+		if(timeout) {
+			iic_stop(adap);
+			printk("iic_readbytes:  %s read timeout.\n", i2c_adap->name);
+			return (-1);
+		}
+#ifndef STUB_I2C
+		if (status & ITE_I2CHSR_DB) {
+			iic_stop(adap);
+			printk("iic_readbytes: %s read error - no ack.\n", i2c_adap->name);
+			return (-1);
+		}
+#endif
+		timeout = wait_for_fe(adap, &status);
+		if(timeout) {
+			iic_stop(adap);
+			printk("iic_readbytes:  %s FIFO is empty\n", i2c_adap->name);
+			return (-1);
+		}         
+
+		for(i=0; i<(remainder+1)/2; i++) {
+			tmp.word = iic_inw(adap, ITE_I2CFDR);
+			buf[rdcount++] = tmp.byte[1];
+			buf[rdcount++] = tmp.byte[0];
+		}
+
+		/* status FIFO underrun */
+		iic_inw(adap, ITE_I2CFSR);
+
+	}
+
+	iic_stop(adap);
+	return rdcount;
+}
+
+
+/* This function implements combined transactions.  Combined
+ * transactions consist of combinations of reading and writing blocks of data.
+ * Each transfer (i.e. a read or a write) is separated by a repeated start
+ * condition.
+ */
+#if 0
+static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num) 
+{
+   int i;
+   struct i2c_msg *pmsg;
+   int ret;
+
+   DEB2(printk("Beginning combined transaction\n"));
+
+   for(i=0; i<(num-1); i++) {
+      pmsg = &msgs[i];
+      if(pmsg->flags & I2C_M_RD) {
+         DEB2(printk("  This one is a read\n"));
+         ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_COMBINED_XFER);
+      }
+      else if(!(pmsg->flags & I2C_M_RD)) {
+         DEB2(printk("This one is a write\n"));
+         ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_COMBINED_XFER);
+      }
+   }
+   /* Last read or write segment needs to be terminated with a stop */
+   pmsg = &msgs[i];
+
+   if(pmsg->flags & I2C_M_RD) {
+      DEB2(printk("Doing the last read\n"));
+      ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
+   }
+   else if(!(pmsg->flags & I2C_M_RD)) {
+      DEB2(printk("Doing the last write\n"));
+      ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
+   }
+
+   return ret;
+}
+#endif
+
+
+/* Whenever we initiate a transaction, the first byte clocked
+ * onto the bus after the start condition is the address (7 bit) of the
+ * device we want to talk to.  This function manipulates the address specified
+ * so that it makes sense to the hardware when written to the IIC peripheral.
+ *
+ * Note: 10 bit addresses are not supported in this driver, although they are
+ * supported by the hardware.  This functionality needs to be implemented.
+ */
+static inline int iic_doAddress(struct i2c_algo_iic_data *adap,
+                                struct i2c_msg *msg, int retries) 
+{
+	unsigned short flags = msg->flags;
+	unsigned int addr;
+	int ret;
+
+/* Ten bit addresses not supported right now */
+	if ( (flags & I2C_M_TEN)  ) { 
+#if 0
+		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
+		DEB2(printk("addr0: %d\n",addr));
+		ret = try_address(adap, addr, retries);
+		if (ret!=1) {
+			printk("iic_doAddress: died at extended address code.\n");
+			return -EREMOTEIO;
+		}
+		iic_outw(adap,msg->addr & 0x7f);
+		if (ret != 1) {
+			printk("iic_doAddress: died at 2nd address code.\n");
+			return -EREMOTEIO;
+		}
+		if ( flags & I2C_M_RD ) {
+			i2c_repstart(adap);
+			addr |= 0x01;
+			ret = try_address(adap, addr, retries);
+			if (ret!=1) {
+				printk("iic_doAddress: died at extended address code.\n");
+				return -EREMOTEIO;
+			}
+		}
+#endif
+	} else {
+
+		addr = ( msg->addr << 1 );
+
+#if 0
+		if (flags & I2C_M_RD )
+			addr |= 1;
+		if (flags & I2C_M_REV_DIR_ADDR )
+			addr ^= 1;
+#endif
+
+		if (iic_inw(adap, ITE_I2CSAR) != addr) {
+			iic_outw(adap, ITE_I2CSAR, addr);
+			ret = try_address(adap, addr, retries);
+			if (ret!=1) {
+				printk("iic_doAddress: died at address code.\n");
+				return -EREMOTEIO;
+			}
+		}
+
+  }
+
+	return 0;
+}
+
+
+/* Description: Prepares the controller for a transaction (clearing status
+ * registers, data buffers, etc), and then calls either iic_readbytes or
+ * iic_sendbytes to do the actual transaction.
+ *
+ * still to be done: Before we issue a transaction, we should
+ * verify that the bus is not busy or in some unknown state.
+ */
+static int iic_xfer(struct i2c_adapter *i2c_adap,
+		    struct i2c_msg msgs[], 
+		    int num)
+{
+	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *pmsg;
+	int i = 0;
+	int ret, timeout;
+    
+	pmsg = &msgs[i];
+
+	if(!pmsg->len) {
+		DEB2(printk("iic_xfer: read/write length is 0\n");)
+		return -EIO;
+	}
+	if(!(pmsg->flags & I2C_M_RD) && (!(pmsg->len)%2) ) {
+		DEB2(printk("iic_xfer: write buffer length is not odd\n");)
+		return -EIO; 
+	}
+
+	/* Wait for any pending transfers to complete */
+	timeout = wait_for_bb(adap);
+	if (timeout) {
+		DEB2(printk("iic_xfer: Timeout waiting for host not busy\n");)
+		return -EIO;
+	}
+
+	/* Flush FIFO */
+	iic_outw(adap, ITE_I2CFCR, ITE_I2CFCR_FLUSH);
+
+	/* Load address */
+	ret = iic_doAddress(adap, pmsg, i2c_adap->retries);
+	if (ret)
+		return -EIO;
+
+#if 0
+	/* Combined transaction (read and write) */
+	if(num > 1) {
+           DEB2(printk("iic_xfer: Call combined transaction\n"));
+           ret = iic_combined_transaction(i2c_adap, msgs, num);
+  }
+#endif
+
+	DEB3(printk("iic_xfer: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+		i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
+
+	if(pmsg->flags & I2C_M_RD) 		/* Read */
+		ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, 0);
+	else {													/* Write */ 
+		udelay(1000);
+		ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len);
+	}
+
+	if (ret != pmsg->len)
+		DEB3(printk("iic_xfer: error or fail on read/write %d bytes.\n",ret)); 
+	else
+		DEB3(printk("iic_xfer: read/write %d bytes.\n",ret));
+
+	return ret;
+}
+
+
+/* Implements device specific ioctls.  Higher level ioctls can
+ * be found in i2c-core.c and are typical of any i2c controller (specifying
+ * slave address, timeouts, etc).  These ioctls take advantage of any hardware
+ * features built into the controller for which this algorithm-adapter set
+ * was written.  These ioctls allow you to take control of the data and clock
+ * lines and set the either high or low,
+ * similar to a GPIO pin.
+ */
+static int algo_control(struct i2c_adapter *adapter, 
+	unsigned int cmd, unsigned long arg)
+{
+
+  struct i2c_algo_iic_data *adap = adapter->algo_data;
+  struct i2c_iic_msg s_msg;
+  char *buf;
+	int ret;
+
+  if (cmd = I2C_SREAD) {
+		if(copy_from_user(&s_msg, (struct i2c_iic_msg *)arg, 
+				sizeof(struct i2c_iic_msg))) 
+			return -EFAULT;
+		buf = kmalloc(s_msg.len, GFP_KERNEL);
+		if (buf= NULL)
+			return -ENOMEM;
+
+		/* Flush FIFO */
+		iic_outw(adap, ITE_I2CFCR, ITE_I2CFCR_FLUSH);
+
+		/* Load address */
+		iic_outw(adap, ITE_I2CSAR,s_msg.addr<<1);
+		iic_outw(adap, ITE_I2CSSAR,s_msg.waddr & 0xff);
+
+		ret = iic_readbytes(adapter, buf, s_msg.len, 1);
+		if (ret>=0) {
+			if(copy_to_user( s_msg.buf, buf, s_msg.len) ) 
+				ret = -EFAULT;
+		}
+		kfree(buf);
+	}
+	return 0;
+}
+
+
+static u32 iic_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
+	       I2C_FUNC_PROTOCOL_MANGLING; 
+}
+
+/* -----exported algorithm data: -------------------------------------	*/
+
+static struct i2c_algorithm iic_algo = {
+	"ITE IIC algorithm",
+	I2C_ALGO_IIC,
+	iic_xfer,		/* master_xfer	*/
+	NULL,				/* smbus_xfer	*/
+	NULL,				/* slave_xmit		*/
+	NULL,				/* slave_recv		*/
+	algo_control,			/* ioctl		*/
+	iic_func,			/* functionality	*/
+};
+
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_iic_add_bus(struct i2c_adapter *adap)
+{
+	int i;
+	short status;
+	struct i2c_algo_iic_data *iic_adap = adap->algo_data;
+
+	if (iic_test) {
+		int ret = test_bus(iic_adap, adap->name);
+		if (ret<0)
+			return -ENODEV;
+	}
+
+	DEB2(printk("i2c-algo-ite: hw routines for %s registered.\n",
+	            adap->name));
+
+	/* register new adapter to i2c module... */
+
+	adap->id |= iic_algo.id;
+	adap->algo = &iic_algo;
+
+	adap->timeout = 100;	/* default values, should	*/
+	adap->retries = 3;		/* be replaced by defines	*/
+	adap->flags = 0;
+
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+
+	i2c_add_adapter(adap);
+	iic_init(iic_adap);
+
+	/* scan bus */
+	/* By default scanning the bus is turned off. */
+	if (iic_scan) {
+		printk(KERN_INFO " i2c-algo-ite: scanning bus %s.\n",
+		       adap->name);
+		for (i = 0x00; i < 0xff; i+=2) {
+			iic_outw(iic_adap, ITE_I2CSAR, i);
+			iic_start(iic_adap);
+			if ( (wait_for_pin(iic_adap, &status) = 0) && 
+			    ((status & ITE_I2CHSR_DNE) = 0) ) { 
+				printk(KERN_INFO "\n(%02x)\n",i>>1); 
+			} else {
+				printk(KERN_INFO "."); 
+				iic_reset(iic_adap);
+			}
+			udelay(iic_adap->udelay);
+		}
+	}
+	return 0;
+}
+
+
+int i2c_iic_del_bus(struct i2c_adapter *adap)
+{
+	int res;
+	if ((res = i2c_del_adapter(adap)) < 0)
+		return res;
+	DEB2(printk("i2c-algo-ite: adapter unregistered: %s\n",adap->name));
+
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+	return 0;
+}
+
+
+int __init i2c_algo_iic_init (void)
+{
+	printk(KERN_INFO "ITE iic (i2c) algorithm module\n");
+	return 0;
+}
+
+
+void i2c_algo_iic_exit(void)
+{
+	return;
+}
+
+
+EXPORT_SYMBOL(i2c_iic_add_bus);
+EXPORT_SYMBOL(i2c_iic_del_bus);
+
+/* The MODULE_* macros resolve to nothing if MODULES is not defined
+ * when this file is compiled.
+ */
+MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
+MODULE_DESCRIPTION("ITE iic algorithm");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(iic_test, "i");
+MODULE_PARM(iic_scan, "i");
+MODULE_PARM(i2c_debug,"i");
+
+MODULE_PARM_DESC(iic_test, "Test if the I2C bus is available");
+MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
+MODULE_PARM_DESC(i2c_debug,
+        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
+
+
+/* This function resolves to init_module (the function invoked when a module
+ * is loaded via insmod) when this file is compiled with MODULES defined.
+ * Otherwise (i.e. if you want this driver statically linked to the kernel),
+ * a pointer to this function is stored in a table and called
+ * during the initialization of the kernel (in do_basic_setup in /init/main.c) 
+ *
+ * All this functionality is complements of the macros defined in linux/init.h
+ */
+module_init(i2c_algo_iic_init);
+
+
+/* If MODULES is defined when this file is compiled, then this function will
+ * resolved to cleanup_module.
+ */
+module_exit(i2c_algo_iic_exit);
diff -Nru a/drivers/i2c/algos/i2c-algo-ite.h b/drivers/i2c/algos/i2c-algo-ite.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/i2c-algo-ite.h	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,117 @@
+/*
+   --------------------------------------------------------------------
+   i2c-ite.h: Global defines for the I2C controller on board the    
+                 ITE MIPS processor.                                
+   --------------------------------------------------------------------
+   Hai-Pao Fan, MontaVista Software, Inc.
+   hpfan@mvista.com or source@mvista.com
+
+   Copyright 2001 MontaVista Software Inc.
+
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+
+ */
+
+#ifndef I2C_ITE_H
+#define I2C_ITE_H 1
+
+#include <asm/it8172/it8172.h>
+
+/* I2C Registers */
+#define ITE_I2CHCR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x30
+#define ITE_I2CHSR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x34
+#define ITE_I2CSAR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x38
+#define ITE_I2CSSAR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x3c
+#define ITE_I2CCKCNT	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x48
+#define ITE_I2CSHDR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x4c
+#define ITE_I2CRSUR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x50
+#define ITE_I2CPSUR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x54
+
+#define ITE_I2CFDR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x70
+#define ITE_I2CFBCR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x74
+#define ITE_I2CFCR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x78
+#define ITE_I2CFSR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x7c
+
+
+/* Host Control Register ITE_I2CHCR */
+#define	ITE_I2CHCR_HCE	0x01	/* Enable I2C Host Controller */
+#define	ITE_I2CHCR_IE	0x02	/* Enable the interrupt after completing
+				   the current transaction */
+#define ITE_I2CHCR_CP_W	0x00	/* bit2-4 000 - Write */
+#define	ITE_I2CHCR_CP_R	0x08	/*	  010 - Current address read */
+#define	ITE_I2CHCR_CP_S	0x10	/*	  100 - Sequential read */
+#define ITE_I2CHCR_ST	0x20	/* Initiates the I2C host controller to execute
+				   the command and send the data programmed in
+				   all required registers to I2C bus */
+#define ITE_CMD		ITE_I2CHCR_HCE | ITE_I2CHCR_IE | ITE_I2CHCR_ST
+#define ITE_WRITE	ITE_CMD | ITE_I2CHCR_CP_W
+#define ITE_READ	ITE_CMD | ITE_I2CHCR_CP_R
+#define ITE_SREAD	ITE_CMD | ITE_I2CHCR_CP_S
+
+/* Host Status Register ITE_I2CHSR */
+#define	ITE_I2CHSR_DB	0x01	/* Device is busy, receives NACK response except
+				   in the first and last bytes */
+#define	ITE_I2CHSR_DNE	0x02	/* Target address on I2C bus does not exist */
+#define	ITE_I2CHSR_TDI	0x04	/* R/W Transaction on I2C bus was completed */
+#define	ITE_I2CHSR_HB	0x08	/* Host controller is processing transactions */
+#define	ITE_I2CHSR_FER	0x10	/* Error occurs in the FIFO */
+
+/* Slave Address Register ITE_I2CSAR */
+#define	ITE_I2CSAR_SA_MASK	0xfe	/* Target I2C device address */
+#define	ITE_I2CSAR_ASO		0x0100	/* Output 1/0 to I2CAS port when the
+					   next slave address is addressed */
+
+/* Slave Sub-address Register ITE_I2CSSAR */
+#define	ITE_I2CSSAR_SUBA_MASK	0xff	/* Target I2C device sub-address */
+
+/* Clock Counter Register ITE_I2CCKCNT */
+#define	ITE_I2CCKCNT_STOP	0x00	/* stop I2C clock */
+#define	ITE_I2CCKCNT_HPCC_MASK	0x7f	/* SCL high period counter */
+#define	ITE_I2CCKCNT_LPCC_MASK	0x7f00	/* SCL low period counter */
+
+/* START Hold Time Register ITE_I2CSHDR */
+/* value is counted based on 16 MHz internal clock */
+#define ITE_I2CSHDR_FM	0x0a	/* START condition at fast mode */
+#define	ITE_I2CSHDR_SM	0x47	/* START contition at standard mode */
+
+/* (Repeated) START Setup Time Register ITE_I2CRSUR */
+/* value is counted based on 16 MHz internal clock */
+#define	ITE_I2CRSUR_FM	0x0a	/* repeated START condition at fast mode */
+#define	ITE_I2CRSUR_SM	0x50	/* repeated START condition at standard mode */
+
+/* STOP setup Time Register ITE_I2CPSUR */
+
+/* FIFO Data Register ITE_I2CFDR */
+#define	ITE_I2CFDR_MASK		0xff
+
+/* FIFO Byte Count Register ITE_I2CFBCR */
+#define ITE_I2CFBCR_MASK	0x3f
+
+/* FIFO Control Register ITE_I2CFCR */
+#define	ITE_I2CFCR_FLUSH	0x01	/* Flush FIFO and reset the FIFO point
+					   and I2CFSR */
+/* FIFO Status Register ITE_I2CFSR */
+#define	ITE_I2CFSR_FO	0x01	/* FIFO is overrun when write */
+#define	ITE_I2CFSR_FU	0x02	/* FIFO is underrun when read */
+#define	ITE_I2CFSR_FF	0x04	/* FIFO is full when write */
+#define	ITE_I2CFSR_FE	0x08	/* FIFO is empty when read */
+
+#endif  /* I2C_ITE_H */
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/i2c-algo-pcf.c	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,479 @@
+/* ------------------------------------------------------------------------- */
+/* i2c-algo-pcf.c i2c driver algorithms for PCF8584 adapters		     */
+/* ------------------------------------------------------------------------- */
+/*   Copyright (C) 1995-1997 Simon G. Vogl
+                   1998-2000 Hans Berglund
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
+/* ------------------------------------------------------------------------- */
+
+/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and 
+   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
+   <mbailey@littlefeet-inc.com> */
+
+/* Partially rewriten by Oleg I. Vdovikin <vdovikin@jscc.ru> to handle multiple
+   messages, proper stop/repstart signaling during receive,
+   added detect code */
+
+/* #define DEBUG 1 */		/* to pick up dev_dbg calls */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-pcf.h>
+#include "i2c-algo-pcf.h"
+
+
+/* ----- global defines ----------------------------------------------- */
+#define DEB(x) if (i2c_debug>=1) x
+#define DEB2(x) if (i2c_debug>=2) x
+#define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
+#define DEBPROTO(x) if (i2c_debug>=9) x;
+ 	/* debug the protocol by showing transferred bits */
+#define DEF_TIMEOUT 16
+
+/* module parameters:
+ */
+static int i2c_debug=0;
+
+/* --- setting states on the bus with the right timing: ---------------	*/
+
+#define set_pcf(adap, ctl, val) adap->setpcf(adap->data, ctl, val)
+#define get_pcf(adap, ctl) adap->getpcf(adap->data, ctl)
+#define get_own(adap) adap->getown(adap->data)
+#define get_clock(adap) adap->getclock(adap->data)
+#define i2c_outb(adap, val) adap->setpcf(adap->data, 0, val)
+#define i2c_inb(adap) adap->getpcf(adap->data, 0)
+
+/* --- other auxiliary functions --------------------------------------	*/
+
+static void i2c_start(struct i2c_algo_pcf_data *adap) 
+{
+	DEBPROTO(printk("S "));
+	set_pcf(adap, 1, I2C_PCF_START);
+}
+
+static void i2c_repstart(struct i2c_algo_pcf_data *adap) 
+{
+	DEBPROTO(printk(" Sr "));
+	set_pcf(adap, 1, I2C_PCF_REPSTART);
+}
+
+
+static void i2c_stop(struct i2c_algo_pcf_data *adap) 
+{
+	DEBPROTO(printk("P\n"));
+	set_pcf(adap, 1, I2C_PCF_STOP);
+}
+
+
+static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
+
+	int timeout = DEF_TIMEOUT;
+	int status;
+
+	status = get_pcf(adap, 1);
+#ifndef STUB_I2C
+	while (timeout-- && !(status & I2C_PCF_BB)) {
+		udelay(100); /* wait for 100 us */
+		status = get_pcf(adap, 1);
+	}
+#endif
+	if (timeout <= 0) {
+		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
+	}
+	
+	return (timeout<=0);
+}
+
+
+static inline void pcf_sleep(unsigned long timeout)
+{
+	schedule_timeout( timeout * HZ);
+}
+
+
+static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
+
+	int timeout = DEF_TIMEOUT;
+
+	*status = get_pcf(adap, 1);
+#ifndef STUB_I2C
+	while (timeout-- && (*status & I2C_PCF_PIN)) {
+		adap->waitforpin();
+		*status = get_pcf(adap, 1);
+	}
+#endif
+	if (timeout <= 0)
+		return(-1);
+	else
+		return(0);
+}
+
+/* 
+ * This should perform the 'PCF8584 initialization sequence' as described
+ * in the Philips IC12 data book (1995, Aug 29).
+ * There should be a 30 clock cycle wait after reset, I assume this
+ * has been fulfilled.
+ * There should be a delay at the end equal to the longest I2C message
+ * to synchronize the BB-bit (in multimaster systems). How long is
+ * this? I assume 1 second is always long enough.
+ *
+ * vdovikin: added detect code for PCF8584
+ */
+static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
+{
+	unsigned char temp;
+
+	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
+
+	/* S1=0x80: S0 selected, serial interface off */
+	set_pcf(adap, 1, I2C_PCF_PIN);
+	/* check to see S1 now used as R/W ctrl -
+	   PCF8584 does that when ESO is zero */
+	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
+		return -ENXIO; /* definetly not PCF8584 */
+	}
+
+	/* load own address in S0, effective address is (own << 1)	*/
+	i2c_outb(adap, get_own(adap));
+	/* check it's really written */
+	if ((temp = i2c_inb(adap)) != get_own(adap)) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
+		return -ENXIO;
+	}
+
+	/* S1=0xA0, next byte in S2					*/
+	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
+	/* check to see S2 now selected */
+	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
+		return -ENXIO;
+	}
+
+	/* load clock register S2					*/
+	i2c_outb(adap, get_clock(adap));
+	/* check it's really written, the only 5 lowest bits does matter */
+	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
+		return -ENXIO;
+	}
+
+	/* Enable serial interface, idle, S0 selected			*/
+	set_pcf(adap, 1, I2C_PCF_IDLE);
+
+	/* check to see PCF is really idled and we can access status register */
+	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
+		return -ENXIO;
+	}
+	
+	printk(KERN_DEBUG "i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
+
+	return 0;
+}
+
+
+/* ----- Utility functions
+ */
+
+static inline int try_address(struct i2c_algo_pcf_data *adap,
+		       unsigned char addr, int retries)
+{
+	int i, status, ret = -1;
+	for (i=0;i<retries;i++) {
+		i2c_outb(adap, addr);
+		i2c_start(adap);
+		status = get_pcf(adap, 1);
+		if (wait_for_pin(adap, &status) >= 0) {
+			if ((status & I2C_PCF_LRB) = 0) { 
+				i2c_stop(adap);
+				break;	/* success! */
+			}
+		}
+		i2c_stop(adap);
+		udelay(adap->udelay);
+	}
+	DEB2(if (i) printk(KERN_DEBUG "i2c-algo-pcf.o: needed %d retries for %d\n",i,
+	                   addr));
+	return ret;
+}
+
+
+static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
+                         int count, int last)
+{
+	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
+	int wrcount, status, timeout;
+    
+	for (wrcount=0; wrcount<count; ++wrcount) {
+		DEB2(dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
+				buf[wrcount]&0xff));
+		i2c_outb(adap, buf[wrcount]);
+		timeout = wait_for_pin(adap, &status);
+		if (timeout) {
+			i2c_stop(adap);
+			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
+			return -EREMOTEIO; /* got a better one ?? */
+		}
+#ifndef STUB_I2C
+		if (status & I2C_PCF_LRB) {
+			i2c_stop(adap);
+			dev_err(&i2c_adap->dev, "i2c_write: error - no ack.\n");
+			return -EREMOTEIO; /* got a better one ?? */
+		}
+#endif
+	}
+	if (last) {
+		i2c_stop(adap);
+	}
+	else {
+		i2c_repstart(adap);
+	}
+
+	return (wrcount);
+}
+
+
+static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
+                         int count, int last)
+{
+	int i, status;
+	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
+
+	/* increment number of bytes to read by one -- read dummy byte */
+	for (i = 0; i <= count; i++) {
+
+		if (wait_for_pin(adap, &status)) {
+			i2c_stop(adap);
+			dev_err(&i2c_adap->dev, "pcf_readbytes timed out.\n");
+			return (-1);
+		}
+
+#ifndef STUB_I2C
+		if ((status & I2C_PCF_LRB) && (i != count)) {
+			i2c_stop(adap);
+			dev_err(&i2c_adap->dev, "i2c_read: i2c_inb, No ack.\n");
+			return (-1);
+		}
+#endif
+		
+		if (i = count - 1) {
+			set_pcf(adap, 1, I2C_PCF_ESO);
+		} else 
+		if (i = count) {
+			if (last) {
+				i2c_stop(adap);
+			} else {
+				i2c_repstart(adap);
+			}
+		};
+
+		if (i) {
+			buf[i - 1] = i2c_inb(adap);
+		} else {
+			i2c_inb(adap); /* dummy read */
+		}
+	}
+
+	return (i - 1);
+}
+
+
+static inline int pcf_doAddress(struct i2c_algo_pcf_data *adap,
+                                struct i2c_msg *msg, int retries) 
+{
+	unsigned short flags = msg->flags;
+	unsigned char addr;
+	int ret;
+	if ( (flags & I2C_M_TEN)  ) { 
+		/* a ten bit address */
+		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
+		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
+		/* try extended address code...*/
+		ret = try_address(adap, addr, retries);
+		if (ret!=1) {
+			printk(KERN_ERR "died at extended address code.\n");
+			return -EREMOTEIO;
+		}
+		/* the remaining 8 bit address */
+		i2c_outb(adap,msg->addr & 0x7f);
+/* Status check comes here */
+		if (ret != 1) {
+			printk(KERN_ERR "died at 2nd address code.\n");
+			return -EREMOTEIO;
+		}
+		if ( flags & I2C_M_RD ) {
+			i2c_repstart(adap);
+			/* okay, now switch into reading mode */
+			addr |= 0x01;
+			ret = try_address(adap, addr, retries);
+			if (ret!=1) {
+				printk(KERN_ERR "died at extended address code.\n");
+				return -EREMOTEIO;
+			}
+		}
+	} else {		/* normal 7bit address	*/
+		addr = ( msg->addr << 1 );
+		if (flags & I2C_M_RD )
+			addr |= 1;
+		if (flags & I2C_M_REV_DIR_ADDR )
+			addr ^= 1;
+		i2c_outb(adap, addr);
+	}
+	return 0;
+}
+
+static int pcf_xfer(struct i2c_adapter *i2c_adap,
+		    struct i2c_msg msgs[], 
+		    int num)
+{
+	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
+	struct i2c_msg *pmsg;
+	int i;
+	int ret=0, timeout, status;
+    
+
+	/* Check for bus busy */
+	timeout = wait_for_bb(adap);
+	if (timeout) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
+		            "Timeout waiting for BB in pcf_xfer\n");)
+		return -EIO;
+	}
+	
+	for (i = 0;ret >= 0 && i < num; i++) {
+		pmsg = &msgs[i];
+
+		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		     pmsg->flags & I2C_M_RD ? "read" : "write",
+                     pmsg->len, pmsg->addr, i + 1, num);)
+    
+		ret = pcf_doAddress(adap, pmsg, i2c_adap->retries);
+
+		/* Send START */
+		if (i = 0) {
+			i2c_start(adap); 
+		}
+    
+		/* Wait for PIN (pending interrupt NOT) */
+		timeout = wait_for_pin(adap, &status);
+		if (timeout) {
+			i2c_stop(adap);
+			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
+				    "for PIN(1) in pcf_xfer\n");)
+			return (-EREMOTEIO);
+		}
+    
+#ifndef STUB_I2C
+		/* Check LRB (last rcvd bit - slave ack) */
+		if (status & I2C_PCF_LRB) {
+			i2c_stop(adap);
+			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
+			return (-EREMOTEIO);
+		}
+#endif
+    
+		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
+    
+		/* Read */
+		if (pmsg->flags & I2C_M_RD) {
+			/* read bytes into buffer*/
+			ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len,
+                                            (i + 1 = num));
+        
+			if (ret != pmsg->len) {
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
+					    "only read %d bytes.\n",ret));
+			} else {
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
+			}
+		} else { /* Write */
+			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
+                                            (i + 1 = num));
+        
+			if (ret != pmsg->len) {
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
+					    "only wrote %d bytes.\n",ret));
+			} else {
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+			}
+		}
+	}
+
+	return (i);
+}
+
+static u32 pcf_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
+	       I2C_FUNC_PROTOCOL_MANGLING; 
+}
+
+/* -----exported algorithm data: -------------------------------------	*/
+
+static struct i2c_algorithm pcf_algo = {
+	.name		= "PCF8584 algorithm",
+	.id		= I2C_ALGO_PCF,
+	.master_xfer	= pcf_xfer,
+	.functionality	= pcf_func,
+};
+
+/* 
+ * registering functions to load algorithms at runtime 
+ */
+int i2c_pcf_add_bus(struct i2c_adapter *adap)
+{
+	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
+	int rval;
+
+	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
+
+	/* register new adapter to i2c module... */
+
+	adap->id |= pcf_algo.id;
+	adap->algo = &pcf_algo;
+
+	adap->timeout = 100;		/* default values, should	*/
+	adap->retries = 3;		/* be replaced by defines	*/
+
+	rval = pcf_init_8584(pcf_adap);
+	if (!rval)
+		i2c_add_adapter(adap);
+	return rval;
+}
+
+
+int i2c_pcf_del_bus(struct i2c_adapter *adap)
+{
+	return i2c_del_adapter(adap);
+}
+
+EXPORT_SYMBOL(i2c_pcf_add_bus);
+EXPORT_SYMBOL(i2c_pcf_del_bus);
+
+MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
+MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
+MODULE_LICENSE("GPL");
+
+MODULE_PARM(i2c_debug,"i");
+MODULE_PARM_DESC(i2c_debug,
+        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
diff -Nru a/drivers/i2c/algos/i2c-algo-pcf.h b/drivers/i2c/algos/i2c-algo-pcf.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/algos/i2c-algo-pcf.h	Thu Sep 25 14:49:55 2003
@@ -0,0 +1,78 @@
+/* -------------------------------------------------------------------- */
+/* i2c-pcf8584.h: PCF 8584 global defines				*/
+/* -------------------------------------------------------------------- */
+/*   Copyright (C) 1996 Simon G. Vogl
+                   1999 Hans Berglund
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		*/
+/* --------------------------------------------------------------------	*/
+
+/* With some changes from Frodo Looijaard <frodol@dds.nl> */
+
+/* $Id: i2c-pcf8584.h,v 1.3 2000/01/18 23:54:07 frodo Exp $ */
+
+#ifndef I2C_PCF8584_H
+#define I2C_PCF8584_H 1
+
+/* ----- Control register bits ----------------------------------------	*/
+#define I2C_PCF_PIN	0x80
+#define I2C_PCF_ESO	0x40
+#define I2C_PCF_ES1	0x20
+#define I2C_PCF_ES2	0x10
+#define I2C_PCF_ENI	0x08
+#define I2C_PCF_STA	0x04
+#define I2C_PCF_STO	0x02
+#define I2C_PCF_ACK	0x01
+
+#define I2C_PCF_START    (I2C_PCF_PIN | I2C_PCF_ESO | I2C_PCF_STA | I2C_PCF_ACK)
+#define I2C_PCF_STOP     (I2C_PCF_PIN | I2C_PCF_ESO | I2C_PCF_STO | I2C_PCF_ACK)
+#define I2C_PCF_REPSTART (              I2C_PCF_ESO | I2C_PCF_STA | I2C_PCF_ACK)
+#define I2C_PCF_IDLE     (I2C_PCF_PIN | I2C_PCF_ESO               | I2C_PCF_ACK)
+
+/* ----- Status register bits -----------------------------------------	*/
+/*#define I2C_PCF_PIN  0x80    as above*/
+
+#define I2C_PCF_INI 0x40   /* 1 if not initialized */
+#define I2C_PCF_STS 0x20
+#define I2C_PCF_BER 0x10
+#define I2C_PCF_AD0 0x08
+#define I2C_PCF_LRB 0x08
+#define I2C_PCF_AAS 0x04
+#define I2C_PCF_LAB 0x02
+#define I2C_PCF_BB  0x01
+
+/* ----- Chip clock frequencies ---------------------------------------	*/
+#define I2C_PCF_CLK3	0x00
+#define I2C_PCF_CLK443	0x10
+#define I2C_PCF_CLK6	0x14
+#define I2C_PCF_CLK	0x18
+#define I2C_PCF_CLK12	0x1c
+
+/* ----- transmission frequencies -------------------------------------	*/
+#define I2C_PCF_TRNS90 0x00	/*  90 kHz */
+#define I2C_PCF_TRNS45 0x01	/*  45 kHz */
+#define I2C_PCF_TRNS11 0x02	/*  11 kHz */
+#define I2C_PCF_TRNS15 0x03	/* 1.5 kHz */
+
+
+/* ----- Access to internal registers according to ES1,ES2 ------------	*/
+/* they are mapped to the data port ( a0 = 0 ) 				*/
+/* available when ESO = 0 :						*/
+
+#define I2C_PCF_OWNADR	0
+#define I2C_PCF_INTREG	I2C_PCF_ES2
+#define I2C_PCF_CLKREG	I2C_PCF_ES1
+
+#endif /* I2C_PCF8584_H */
diff -Nru a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
--- a/drivers/i2c/busses/i2c-elektor.c	Thu Sep 25 14:49:55 2003
+++ b/drivers/i2c/busses/i2c-elektor.c	Thu Sep 25 14:49:55 2003
@@ -41,7 +41,7 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#include "../i2c-pcf8584.h"
+#include "../algos/i2c-algo-pcf.h"
 
 #define DEFAULT_BASE 0x330
 
diff -Nru a/drivers/i2c/i2c-algo-bit.c b/drivers/i2c/i2c-algo-bit.c
--- a/drivers/i2c/i2c-algo-bit.c	Thu Sep 25 14:49:55 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,567 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-algo-bit.c i2c driver algorithms for bit-shift adapters		     */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-2000 Simon G. Vogl
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
-   Frodo Looijaard <frodol@dds.nl> */
-
-/* $Id: i2c-algo-bit.c,v 1.44 2003/01/21 08:08:16 kmalkki Exp $ */
-
-/* #define DEBUG 1 */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-bit.h>
-
-
-/* ----- global defines ----------------------------------------------- */
-#define DEB(x) if (i2c_debug>=1) x;
-#define DEB2(x) if (i2c_debug>=2) x;
-#define DEBSTAT(x) if (i2c_debug>=3) x; /* print several statistical values*/
-#define DEBPROTO(x) if (i2c_debug>=9) { x; }
- 	/* debug the protocol by showing transferred bits */
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-/* module parameters:
- */
-static int i2c_debug;
-static int bit_test;	/* see if the line-setting functions work	*/
-
-/* --- setting states on the bus with the right timing: ---------------	*/
-
-#define setsda(adap,val) adap->setsda(adap->data, val)
-#define setscl(adap,val) adap->setscl(adap->data, val)
-#define getsda(adap) adap->getsda(adap->data)
-#define getscl(adap) adap->getscl(adap->data)
-
-static inline void sdalo(struct i2c_algo_bit_data *adap)
-{
-	setsda(adap,0);
-	udelay(adap->udelay);
-}
-
-static inline void sdahi(struct i2c_algo_bit_data *adap)
-{
-	setsda(adap,1);
-	udelay(adap->udelay);
-}
-
-static inline void scllo(struct i2c_algo_bit_data *adap)
-{
-	setscl(adap,0);
-	udelay(adap->udelay);
-}
-
-/*
- * Raise scl line, and do checking for delays. This is necessary for slower
- * devices.
- */
-static inline int sclhi(struct i2c_algo_bit_data *adap)
-{
-	unsigned long start;
-
-	setscl(adap,1);
-
-	/* Not all adapters have scl sense line... */
-	if (adap->getscl = NULL )
-		return 0;
-
-	start=jiffies;
-	while (! getscl(adap) ) {	
- 		/* the hw knows how to read the clock line,
- 		 * so we wait until it actually gets high.
- 		 * This is safer as some chips may hold it low
- 		 * while they are processing data internally. 
- 		 */
-		if (time_after_eq(jiffies, start+adap->timeout)) {
-			return -ETIMEDOUT;
-		}
-		cond_resched();
-	}
-	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
-	udelay(adap->udelay);
-	return 0;
-} 
-
-
-/* --- other auxiliary functions --------------------------------------	*/
-static void i2c_start(struct i2c_algo_bit_data *adap) 
-{
-	/* assert: scl, sda are high */
-	DEBPROTO(printk("S "));
-	sdalo(adap);
-	scllo(adap);
-}
-
-static void i2c_repstart(struct i2c_algo_bit_data *adap) 
-{
-	/* scl, sda may not be high */
-	DEBPROTO(printk(" Sr "));
-	setsda(adap,1);
-	sclhi(adap);
-	udelay(adap->udelay);
-	
-	sdalo(adap);
-	scllo(adap);
-}
-
-
-static void i2c_stop(struct i2c_algo_bit_data *adap) 
-{
-	DEBPROTO(printk("P\n"));
-	/* assert: scl is low */
-	sdalo(adap);
-	sclhi(adap); 
-	sdahi(adap);
-}
-
-
-
-/* send a byte without start cond., look for arbitration, 
-   check ackn. from slave */
-/* returns:
- * 1 if the device acknowledged
- * 0 if the device did not ack
- * -ETIMEDOUT if an error occurred (while raising the scl line)
- */
-static int i2c_outb(struct i2c_adapter *i2c_adap, char c)
-{
-	int i;
-	int sb;
-	int ack;
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-
-	/* assert: scl is low */
-	for ( i=7 ; i>=0 ; i-- ) {
-		sb = c & ( 1 << i );
-		setsda(adap,sb);
-		udelay(adap->udelay);
-		DEBPROTO(printk(KERN_DEBUG "%d",sb!=0));
-		if (sclhi(adap)<0) { /* timed out */
-			sdahi(adap); /* we don't want to block the net */
-			DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x, timeout at bit #%d\n", c&0xff, i));
-			return -ETIMEDOUT;
-		};
-		/* do arbitration here: 
-		 * if ( sb && ! getsda(adap) ) -> ouch! Get out of here.
-		 */
-		setscl(adap, 0 );
-		udelay(adap->udelay);
-	}
-	sdahi(adap);
-	if (sclhi(adap)<0){ /* timeout */
-	    DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x, timeout at ack\n", c&0xff));
-	    return -ETIMEDOUT;
-	};
-	/* read ack: SDA should be pulled down by slave */
-	ack=getsda(adap);	/* ack: sda is pulled low ->success.	 */
-	DEB2(printk(KERN_DEBUG " i2c_outb: 0x%02x , getsda() = %d\n", c & 0xff, ack));
-
-	DEBPROTO( printk(KERN_DEBUG "[%2.2x]",c&0xff) );
-	DEBPROTO(if (0=ack){ printk(KERN_DEBUG " A ");} else printk(KERN_DEBUG " NA ") );
-	scllo(adap);
-	return 0=ack;		/* return 1 if device acked	 */
-	/* assert: scl is low (sda undef) */
-}
-
-
-static int i2c_inb(struct i2c_adapter *i2c_adap) 
-{
-	/* read byte via i2c port, without start/stop sequence	*/
-	/* acknowledge is sent in i2c_read.			*/
-	int i;
-	unsigned char indata=0;
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-
-	/* assert: scl is low */
-	sdahi(adap);
-	for (i=0;i<8;i++) {
-		if (sclhi(adap)<0) { /* timeout */
-			DEB2(printk(KERN_DEBUG " i2c_inb: timeout at bit #%d\n", 7-i));
-			return -ETIMEDOUT;
-		};
-		indata *= 2;
-		if ( getsda(adap) ) 
-			indata |= 0x01;
-		scllo(adap);
-	}
-	/* assert: scl is low */
-	DEB2(printk(KERN_DEBUG "i2c_inb: 0x%02x\n", indata & 0xff));
-
-	DEBPROTO(printk(KERN_DEBUG " 0x%02x", indata & 0xff));
-	return (int) (indata & 0xff);
-}
-
-/*
- * Sanity check for the adapter hardware - check the reaction of
- * the bus lines only if it seems to be idle.
- */
-static int test_bus(struct i2c_algo_bit_data *adap, char* name) {
-	int scl,sda;
-	sda=getsda(adap);
-	if (adap->getscl=NULL) {
-		printk(KERN_WARNING "i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
-		return 0;		
-	}
-	scl=getscl(adap);
-	printk(KERN_INFO "i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
-	       name,getscl(adap),getsda(adap));
-	if (!scl || !sda ) {
-		printk(KERN_INFO " i2c-algo-bit.o: %s seems to be busy.\n",name);
-		goto bailout;
-	}
-	sdalo(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck high!\n",name);
-		sdahi(adap);
-		goto bailout;
-	}
-	if ( 0 = getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
-			name);
-		goto bailout;
-	}		
-	sdahi(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 = getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck low!\n",name);
-		sdahi(adap);
-		goto bailout;
-	}
-	if ( 0 = getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
-		       name);
-	goto bailout;
-	}
-	scllo(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck high!\n",name);
-		sclhi(adap);
-		goto bailout;
-	}
-	if ( 0 = getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
-			name);
-		goto bailout;
-	}
-	sclhi(adap);
-	printk(KERN_DEBUG "i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 = getscl(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck low!\n",name);
-		sclhi(adap);
-		goto bailout;
-	}
-	if ( 0 = getsda(adap) ) {
-		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
-			name);
-		goto bailout;
-	}
-	printk(KERN_INFO "i2c-algo-bit.o: %s passed test.\n",name);
-	return 0;
-bailout:
-	sdahi(adap);
-	sclhi(adap);
-	return -ENODEV;
-}
-
-/* ----- Utility functions
- */
-
-/* try_address tries to contact a chip for a number of
- * times before it gives up.
- * return values:
- * 1 chip answered
- * 0 chip did not answer
- * -x transmission error
- */
-static inline int try_address(struct i2c_adapter *i2c_adap,
-		       unsigned char addr, int retries)
-{
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-	int i,ret = -1;
-	for (i=0;i<=retries;i++) {
-		ret = i2c_outb(i2c_adap,addr);
-		if (ret=1)
-			break;	/* success! */
-		i2c_stop(adap);
-		udelay(5/*adap->udelay*/);
-		if (i=retries)  /* no success */
-			break;
-		i2c_start(adap);
-		udelay(adap->udelay);
-	}
-	DEB2(if (i)
-	     printk(KERN_DEBUG "i2c-algo-bit.o: Used %d tries to %s client at 0x%02x : %s\n",
-		    i+1, addr & 1 ? "read" : "write", addr>>1,
-		    ret=1 ? "success" : ret=0 ? "no ack" : "failed, timeout?" )
-	    );
-	return ret;
-}
-
-static int sendbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
-{
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-	char c;
-	const char *temp = msg->buf;
-	int count = msg->len;
-	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK; 
-	int retval;
-	int wrcount=0;
-
-	while (count > 0) {
-		c = *temp;
-		DEB2(dev_dbg(&i2c_adap->dev, "sendbytes: writing %2.2X\n", c&0xff));
-		retval = i2c_outb(i2c_adap,c);
-		if ((retval>0) || (nak_ok && (retval=0)))  { /* ok or ignored NAK */
-			count--; 
-			temp++;
-			wrcount++;
-		} else { /* arbitration or no acknowledge */
-			dev_err(&i2c_adap->dev, "sendbytes: error - bailout.\n");
-			i2c_stop(adap);
-			return (retval<0)? retval : -EFAULT;
-			        /* got a better one ?? */
-		}
-#if 0
-		/* from asm/delay.h */
-		__delay(adap->mdelay * (loops_per_sec / 1000) );
-#endif
-	}
-	return wrcount;
-}
-
-static inline int readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msg)
-{
-	int inval;
-	int rdcount=0;   	/* counts bytes read */
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-	char *temp = msg->buf;
-	int count = msg->len;
-
-	while (count > 0) {
-		inval = i2c_inb(i2c_adap);
-/*printk("%#02x ",inval); if ( ! (count % 16) ) printk("\n"); */
-		if (inval>=0) {
-			*temp = inval;
-			rdcount++;
-		} else {   /* read timed out */
-			printk(KERN_ERR "i2c-algo-bit.o: readbytes: i2c_inb timed out.\n");
-			break;
-		}
-
-		if ( count > 1 ) {		/* send ack */
-			sdalo(adap);
-			DEBPROTO(printk(" Am "));
-		} else {
-			sdahi(adap);	/* neg. ack on last byte */
-			DEBPROTO(printk(" NAm "));
-		}
-		if (sclhi(adap)<0) {	/* timeout */
-			sdahi(adap);
-			printk(KERN_ERR "i2c-algo-bit.o: readbytes: Timeout at ack\n");
-			return -ETIMEDOUT;
-		};
-		scllo(adap);
-		sdahi(adap);
-		temp++;
-		count--;
-	}
-	return rdcount;
-}
-
-/* doAddress initiates the transfer by generating the start condition (in
- * try_address) and transmits the address in the necessary format to handle
- * reads, writes as well as 10bit-addresses.
- * returns:
- *  0 everything went okay, the chip ack'ed, or IGNORE_NAK flag was set
- * -x an error occurred (like: -EREMOTEIO if the device did not answer, or
- *	-ETIMEDOUT, for example if the lines are stuck...) 
- */
-static inline int bit_doAddress(struct i2c_adapter *i2c_adap, struct i2c_msg *msg) 
-{
-	unsigned short flags = msg->flags;
-	unsigned short nak_ok = msg->flags & I2C_M_IGNORE_NAK;
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-
-	unsigned char addr;
-	int ret, retries;
-
-	retries = nak_ok ? 0 : i2c_adap->retries;
-	
-	if ( (flags & I2C_M_TEN)  ) { 
-		/* a ten bit address */
-		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
-		/* try extended address code...*/
-		ret = try_address(i2c_adap, addr, retries);
-		if ((ret != 1) && !nak_ok)  {
-			printk(KERN_ERR "died at extended address code.\n");
-			return -EREMOTEIO;
-		}
-		/* the remaining 8 bit address */
-		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
-		if ((ret != 1) && !nak_ok) {
-			/* the chip did not ack / xmission error occurred */
-			printk(KERN_ERR "died at 2nd address code.\n");
-			return -EREMOTEIO;
-		}
-		if ( flags & I2C_M_RD ) {
-			i2c_repstart(adap);
-			/* okay, now switch into reading mode */
-			addr |= 0x01;
-			ret = try_address(i2c_adap, addr, retries);
-			if ((ret!=1) && !nak_ok) {
-				printk(KERN_ERR "died at extended address code.\n");
-				return -EREMOTEIO;
-			}
-		}
-	} else {		/* normal 7bit address	*/
-		addr = ( msg->addr << 1 );
-		if (flags & I2C_M_RD )
-			addr |= 1;
-		if (flags & I2C_M_REV_DIR_ADDR )
-			addr ^= 1;
-		ret = try_address(i2c_adap, addr, retries);
-		if ((ret!=1) && !nak_ok)
-			return -EREMOTEIO;
-	}
-
-	return 0;
-}
-
-static int bit_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], int num)
-{
-	struct i2c_msg *pmsg;
-	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
-	
-	int i,ret;
-	unsigned short nak_ok;
-
-	i2c_start(adap);
-	for (i=0;i<num;i++) {
-		pmsg = &msgs[i];
-		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK; 
-		if (!(pmsg->flags & I2C_M_NOSTART)) {
-			if (i) {
-				i2c_repstart(adap);
-			}
-			ret = bit_doAddress(i2c_adap, pmsg);
-			if ((ret != 0) && !nak_ok) {
-			    DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device addr %2.2x msg #%d\n"
-					,msgs[i].addr,i));
-			    return (ret<0) ? ret : -EREMOTEIO;
-			}
-		}
-		if (pmsg->flags & I2C_M_RD ) {
-			/* read bytes into buffer*/
-			ret = readbytes(i2c_adap, pmsg);
-			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
-			if (ret < pmsg->len ) {
-				return (ret<0)? ret : -EREMOTEIO;
-			}
-		} else {
-			/* write bytes from buffer */
-			ret = sendbytes(i2c_adap, pmsg);
-			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
-			if (ret < pmsg->len ) {
-				return (ret<0) ? ret : -EREMOTEIO;
-			}
-		}
-	}
-	i2c_stop(adap);
-	return num;
-}
-
-static u32 bit_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING;
-}
-
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm i2c_bit_algo = {
-	.name		= "Bit-shift algorithm",
-	.id		= I2C_ALGO_BIT,
-	.master_xfer	= bit_xfer,
-	.functionality	= bit_func,
-};
-
-/* 
- * registering functions to load algorithms at runtime 
- */
-int i2c_bit_add_bus(struct i2c_adapter *adap)
-{
-	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
-
-	if (bit_test) {
-		int ret = test_bus(bit_adap, adap->name);
-		if (ret<0)
-			return -ENODEV;
-	}
-
-	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
-
-	/* register new adapter to i2c module... */
-
-	adap->id |= i2c_bit_algo.id;
-	adap->algo = &i2c_bit_algo;
-
-	adap->timeout = 100;	/* default values, should	*/
-	adap->retries = 3;	/* be replaced by defines	*/
-
-	i2c_add_adapter(adap);
-	return 0;
-}
-
-
-int i2c_bit_del_bus(struct i2c_adapter *adap)
-{
-	return i2c_del_adapter(adap);
-}
-
-EXPORT_SYMBOL(i2c_bit_add_bus);
-EXPORT_SYMBOL(i2c_bit_del_bus);
-
-MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
-MODULE_DESCRIPTION("I2C-Bus bit-banging algorithm");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(bit_test, "i");
-MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
-MODULE_PARM_DESC(i2c_debug,
-		 "debug level - 0 off; 1 normal; 2,3 more verbose; 9 bit-protocol");
diff -Nru a/drivers/i2c/i2c-algo-ite.c b/drivers/i2c/i2c-algo-ite.c
--- a/drivers/i2c/i2c-algo-ite.c	Thu Sep 25 14:49:55 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,872 +0,0 @@
-/*
-   -------------------------------------------------------------------------
-   i2c-algo-ite.c i2c driver algorithms for ITE adapters	    
-   
-   Hai-Pao Fan, MontaVista Software, Inc.
-   hpfan@mvista.com or source@mvista.com
-
-   Copyright 2000 MontaVista Software Inc.
-
-   ---------------------------------------------------------------------------
-   This file was highly leveraged from i2c-algo-pcf.c, which was created
-   by Simon G. Vogl and Hans Berglund:
-
-
-     Copyright (C) 1995-1997 Simon G. Vogl
-                   1998-2000 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and 
-   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
-   <mbailey@littlefeet-inc.com> */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <asm/uaccess.h>
-#include <linux/ioport.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-
-#include <linux/i2c.h>
-#include <linux/i2c-algo-ite.h>
-#include "i2c-ite.h"
-
-#define	PM_DSR		IT8172_PCI_IO_BASE + IT_PM_DSR
-#define	PM_IBSR		IT8172_PCI_IO_BASE + IT_PM_DSR + 0x04 
-#define GPIO_CCR	IT8172_PCI_IO_BASE + IT_GPCCR
-
-/* ----- global defines ----------------------------------------------- */
-#define DEB(x) if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
-#define DEBPROTO(x) if (i2c_debug>=9) x;
- 	/* debug the protocol by showing transferred bits */
-#define DEF_TIMEOUT 16
-
-/* debugging - slow down transfer to have a look at the data .. 	*/
-/* I use this with two leds&resistors, each one connected to sda,scl 	*/
-/* respectively. This makes sure that the algorithm works. Some chips   */
-/* might not like this, as they have an internal timeout of some mils	*/
-/*
-#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
-                        cond_resched();
-*/
-
-
-/* ----- global variables ---------------------------------------------	*/
-
-#ifdef SLO_IO
-	int jif;
-#endif
-
-/* module parameters:
- */
-static int i2c_debug=1;
-static int iic_test=0;	/* see if the line-setting functions work	*/
-static int iic_scan=0;	/* have a look at what's hanging 'round		*/
-
-/* --- setting states on the bus with the right timing: ---------------	*/
-
-#define get_clock(adap) adap->getclock(adap->data)
-#define iic_outw(adap, reg, val) adap->setiic(adap->data, reg, val)
-#define iic_inw(adap, reg) adap->getiic(adap->data, reg)
-
-
-/* --- other auxiliary functions --------------------------------------	*/
-
-static void iic_start(struct i2c_algo_iic_data *adap)
-{
-	iic_outw(adap,ITE_I2CHCR,ITE_CMD);
-}
-
-static void iic_stop(struct i2c_algo_iic_data *adap)
-{
-	iic_outw(adap,ITE_I2CHCR,0);
-	iic_outw(adap,ITE_I2CHSR,ITE_I2CHSR_TDI);
-}
-
-static void iic_reset(struct i2c_algo_iic_data *adap)
-{
-	iic_outw(adap, PM_IBSR, iic_inw(adap, PM_IBSR) | 0x80);
-}
-
-
-static int wait_for_bb(struct i2c_algo_iic_data *adap)
-{
-	int timeout = DEF_TIMEOUT;
-	short status;
-
-	status = iic_inw(adap, ITE_I2CHSR);
-#ifndef STUB_I2C
-	while (timeout-- && (status & ITE_I2CHSR_HB)) {
-		udelay(1000); /* How much is this? */
-		status = iic_inw(adap, ITE_I2CHSR);
-	}
-#endif
-	if (timeout<=0) {
-		printk(KERN_ERR "Timeout, host is busy\n");
-		iic_reset(adap);
-	}
-	return(timeout<=0);
-}
-
-/*
- * Puts this process to sleep for a period equal to timeout 
- */
-static inline void iic_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-
-/* After we issue a transaction on the IIC bus, this function
- * is called.  It puts this process to sleep until we get an interrupt from
- * from the controller telling us that the transaction we requested in complete.
- */
-static int wait_for_pin(struct i2c_algo_iic_data *adap, short *status) {
-
-	int timeout = DEF_TIMEOUT;
-	
-	timeout = wait_for_bb(adap);
-	if (timeout) {
-  		DEB2(printk("Timeout waiting for host not busy\n");)
-  		return -EIO;
-	}                           
-	timeout = DEF_TIMEOUT;
-
-	*status = iic_inw(adap, ITE_I2CHSR);
-#ifndef STUB_I2C
-	while (timeout-- && !(*status & ITE_I2CHSR_TDI)) {
-	   adap->waitforpin();
-	   *status = iic_inw(adap, ITE_I2CHSR);
-	}
-#endif
-	if (timeout <= 0)
-		return(-1);
-	else
-		return(0);
-}
-
-static int wait_for_fe(struct i2c_algo_iic_data *adap, short *status)
-{
-	int timeout = DEF_TIMEOUT;
-
-	*status = iic_inw(adap, ITE_I2CFSR);
-#ifndef STUB_I2C 
-	while (timeout-- && (*status & ITE_I2CFSR_FE)) {
-		udelay(1000);
-		iic_inw(adap, ITE_I2CFSR);
-	}
-#endif
-	if (timeout <= 0) 
-		return(-1);
-	else
-		return(0);
-}
-
-static int iic_init (struct i2c_algo_iic_data *adap)
-{
-	short i;
-
-	/* Clear bit 7 to set I2C to normal operation mode */
-	i=iic_inw(adap, PM_DSR)& 0xff7f;
-	iic_outw(adap, PM_DSR, i);
-
-	/* set IT_GPCCR port C bit 2&3 as function 2 */
-	i = iic_inw(adap, GPIO_CCR) & 0xfc0f;
-	iic_outw(adap,GPIO_CCR,i);
-
-	/* Clear slave address/sub-address */
-	iic_outw(adap,ITE_I2CSAR, 0);
-	iic_outw(adap,ITE_I2CSSAR, 0);
-
-	/* Set clock counter register */
-	iic_outw(adap,ITE_I2CCKCNT, get_clock(adap));
-
-	/* Set START/reSTART/STOP time registers */
-	iic_outw(adap,ITE_I2CSHDR, 0x0a);
-	iic_outw(adap,ITE_I2CRSUR, 0x0a);
-	iic_outw(adap,ITE_I2CPSUR, 0x0a);
-
-	/* Enable interrupts on completing the current transaction */
-	iic_outw(adap,ITE_I2CHCR, ITE_I2CHCR_IE | ITE_I2CHCR_HCE);
-
-	/* Clear transfer count */
-	iic_outw(adap,ITE_I2CFBCR, 0x0);
-
-	DEB2(printk("iic_init: Initialized IIC on ITE 0x%x\n",
-		iic_inw(adap, ITE_I2CHSR)));
-	return 0;
-}
-
-
-/*
- * Sanity check for the adapter hardware - check the reaction of
- * the bus lines only if it seems to be idle.
- */
-static int test_bus(struct i2c_algo_iic_data *adap, char *name) {
-#if 0
-	int scl,sda;
-	sda=getsda(adap);
-	if (adap->getscl=NULL) {
-		printk("test_bus: Warning: Adapter can't read from clock line - skipping test.\n");
-		return 0;		
-	}
-	scl=getscl(adap);
-	printk("test_bus: Adapter: %s scl: %d  sda: %d -- testing...\n",
-	name,getscl(adap),getsda(adap));
-	if (!scl || !sda ) {
-		printk("test_bus: %s seems to be busy.\n",adap->name);
-		goto bailout;
-	}
-	sdalo(adap);
-	printk("test_bus:1 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getsda(adap) ) {
-		printk("test_bus: %s SDA stuck high!\n",name);
-		sdahi(adap);
-		goto bailout;
-	}
-	if ( 0 = getscl(adap) ) {
-		printk("test_bus: %s SCL unexpected low while pulling SDA low!\n",
-			name);
-		goto bailout;
-	}		
-	sdahi(adap);
-	printk("test_bus:2 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 = getsda(adap) ) {
-		printk("test_bus: %s SDA stuck low!\n",name);
-		sdahi(adap);
-		goto bailout;
-	}
-	if ( 0 = getscl(adap) ) {
-		printk("test_bus: %s SCL unexpected low while SDA high!\n",
-		       adap->name);
-	goto bailout;
-	}
-	scllo(adap);
-	printk("test_bus:3 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 != getscl(adap) ) {
-
-		sclhi(adap);
-		goto bailout;
-	}
-	if ( 0 = getsda(adap) ) {
-		printk("test_bus: %s SDA unexpected low while pulling SCL low!\n",
-			name);
-		goto bailout;
-	}
-	sclhi(adap);
-	printk("test_bus:4 scl: %d  sda: %d \n",getscl(adap),
-	       getsda(adap));
-	if ( 0 = getscl(adap) ) {
-		printk("test_bus: %s SCL stuck low!\n",name);
-		sclhi(adap);
-		goto bailout;
-	}
-	if ( 0 = getsda(adap) ) {
-		printk("test_bus: %s SDA unexpected low while SCL high!\n",
-			name);
-		goto bailout;
-	}
-	printk("test_bus: %s passed test.\n",name);
-	return 0;
-bailout:
-	sdahi(adap);
-	sclhi(adap);
-	return -ENODEV;
-#endif
-	return (0);
-}
-
-/* ----- Utility functions
- */
-
-
-/* Verify the device we want to talk to on the IIC bus really exists. */
-static inline int try_address(struct i2c_algo_iic_data *adap,
-		       unsigned int addr, int retries)
-{
-	int i, ret = -1;
-	short status;
-
-	for (i=0;i<retries;i++) {
-		iic_outw(adap, ITE_I2CSAR, addr);
-		iic_start(adap);
-		if (wait_for_pin(adap, &status) = 0) {
-			if ((status & ITE_I2CHSR_DNE) = 0) { 
-				iic_stop(adap);
-				iic_outw(adap, ITE_I2CFCR, ITE_I2CFCR_FLUSH);
-				ret=1;
-				break;	/* success! */
-			}
-		}
-		iic_stop(adap);
-		udelay(adap->udelay);
-	}
-	DEB2(if (i) printk("try_address: needed %d retries for 0x%x\n",i,
-	                   addr));
-	return ret;
-}
-
-
-static int iic_sendbytes(struct i2c_adapter *i2c_adap,const char *buf,
-                         int count)
-{
-	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
-	int wrcount=0, timeout;
-	short status;
-	int loops, remainder, i, j;
-	union {
-		char byte[2];
-		unsigned short word;
-	} tmp;
-   
-	iic_outw(adap, ITE_I2CSSAR, (unsigned short)buf[wrcount++]);
-	count--;
-	if (count = 0)
-		return -EIO;
-
-	loops =  count / 32;		/* 32-byte FIFO */
-	remainder = count % 32;
-
-	if(loops) {
-		for(i=0; i<loops; i++) {
-
-			iic_outw(adap, ITE_I2CFBCR, 32);
-			for(j=0; j<32/2; j++) {
-				tmp.byte[1] = buf[wrcount++];
-				tmp.byte[0] = buf[wrcount++];
-				iic_outw(adap, ITE_I2CFDR, tmp.word); 
-			}
-
-			/* status FIFO overrun */
-			iic_inw(adap, ITE_I2CFSR);
-			iic_inw(adap, ITE_I2CFBCR);
-
-			iic_outw(adap, ITE_I2CHCR, ITE_WRITE);	/* Issue WRITE command */
-
-			/* Wait for transmission to complete */
-			timeout = wait_for_pin(adap, &status);
-			if(timeout) {
-				iic_stop(adap);
-				printk("iic_sendbytes: %s write timeout.\n", i2c_adap->name);
-				return -EREMOTEIO; /* got a better one ?? */
-     	}
-			if (status & ITE_I2CHSR_DB) {
-				iic_stop(adap);
-				printk("iic_sendbytes: %s write error - no ack.\n", i2c_adap->name);
-				return -EREMOTEIO; /* got a better one ?? */
-			}
-		}
-	}
-	if(remainder) {
-		iic_outw(adap, ITE_I2CFBCR, remainder);
-		for(i=0; i<remainder/2; i++) {
-			tmp.byte[1] = buf[wrcount++];
-			tmp.byte[0] = buf[wrcount++];
-			iic_outw(adap, ITE_I2CFDR, tmp.word);
-		}
-
-		/* status FIFO overrun */
-		iic_inw(adap, ITE_I2CFSR);
-		iic_inw(adap, ITE_I2CFBCR);
-
-		iic_outw(adap, ITE_I2CHCR, ITE_WRITE);  /* Issue WRITE command */
-
-		timeout = wait_for_pin(adap, &status);
-		if(timeout) {
-			iic_stop(adap);
-			printk("iic_sendbytes: %s write timeout.\n", i2c_adap->name);
-			return -EREMOTEIO; /* got a better one ?? */
-		}
-#ifndef STUB_I2C
-		if (status & ITE_I2CHSR_DB) { 
-			iic_stop(adap);
-			printk("iic_sendbytes: %s write error - no ack.\n", i2c_adap->name);
-			return -EREMOTEIO; /* got a better one ?? */
-		}
-#endif
-	}
-	iic_stop(adap);
-	return wrcount;
-}
-
-
-static int iic_readbytes(struct i2c_adapter *i2c_adap, char *buf, int count,
-	int sread)
-{
-	int rdcount=0, i, timeout;
-	short status;
-	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
-	int loops, remainder, j;
-	union {
-		char byte[2];
-		unsigned short word;
-	} tmp;
-		
-	loops = count / 32;				/* 32-byte FIFO */
-	remainder = count % 32;
-
-	if(loops) {
-		for(i=0; i<loops; i++) {
-			iic_outw(adap, ITE_I2CFBCR, 32);
-			if (sread)
-				iic_outw(adap, ITE_I2CHCR, ITE_SREAD);
-			else
-				iic_outw(adap, ITE_I2CHCR, ITE_READ);		/* Issue READ command */
-
-			timeout = wait_for_pin(adap, &status);
-			if(timeout) {
-				iic_stop(adap);
-				printk("iic_readbytes:  %s read timeout.\n", i2c_adap->name);
-				return (-1);
-			}
-#ifndef STUB_I2C
-			if (status & ITE_I2CHSR_DB) {
-				iic_stop(adap);
-				printk("iic_readbytes: %s read error - no ack.\n", i2c_adap->name);
-				return (-1);
-			}
-#endif
-
-			timeout = wait_for_fe(adap, &status);
-			if(timeout) {
-				iic_stop(adap);
-				printk("iic_readbytes:  %s FIFO is empty\n", i2c_adap->name);
-				return (-1); 
-			}
-
-			for(j=0; j<32/2; j++) {
-				tmp.word = iic_inw(adap, ITE_I2CFDR);
-				buf[rdcount++] = tmp.byte[1];
-				buf[rdcount++] = tmp.byte[0];
-			}
-
-			/* status FIFO underrun */
-			iic_inw(adap, ITE_I2CFSR);
-
-		}
-	}
-
-
-	if(remainder) {
-		remainder=(remainder+1)/2 * 2;
-		iic_outw(adap, ITE_I2CFBCR, remainder);
-		if (sread)
-			iic_outw(adap, ITE_I2CHCR, ITE_SREAD);
-		else
-		iic_outw(adap, ITE_I2CHCR, ITE_READ);		/* Issue READ command */
-
-		timeout = wait_for_pin(adap, &status);
-		if(timeout) {
-			iic_stop(adap);
-			printk("iic_readbytes:  %s read timeout.\n", i2c_adap->name);
-			return (-1);
-		}
-#ifndef STUB_I2C
-		if (status & ITE_I2CHSR_DB) {
-			iic_stop(adap);
-			printk("iic_readbytes: %s read error - no ack.\n", i2c_adap->name);
-			return (-1);
-		}
-#endif
-		timeout = wait_for_fe(adap, &status);
-		if(timeout) {
-			iic_stop(adap);
-			printk("iic_readbytes:  %s FIFO is empty\n", i2c_adap->name);
-			return (-1);
-		}         
-
-		for(i=0; i<(remainder+1)/2; i++) {
-			tmp.word = iic_inw(adap, ITE_I2CFDR);
-			buf[rdcount++] = tmp.byte[1];
-			buf[rdcount++] = tmp.byte[0];
-		}
-
-		/* status FIFO underrun */
-		iic_inw(adap, ITE_I2CFSR);
-
-	}
-
-	iic_stop(adap);
-	return rdcount;
-}
-
-
-/* This function implements combined transactions.  Combined
- * transactions consist of combinations of reading and writing blocks of data.
- * Each transfer (i.e. a read or a write) is separated by a repeated start
- * condition.
- */
-#if 0
-static int iic_combined_transaction(struct i2c_adapter *i2c_adap, struct i2c_msg msgs[], int num) 
-{
-   int i;
-   struct i2c_msg *pmsg;
-   int ret;
-
-   DEB2(printk("Beginning combined transaction\n"));
-
-   for(i=0; i<(num-1); i++) {
-      pmsg = &msgs[i];
-      if(pmsg->flags & I2C_M_RD) {
-         DEB2(printk("  This one is a read\n"));
-         ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_COMBINED_XFER);
-      }
-      else if(!(pmsg->flags & I2C_M_RD)) {
-         DEB2(printk("This one is a write\n"));
-         ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_COMBINED_XFER);
-      }
-   }
-   /* Last read or write segment needs to be terminated with a stop */
-   pmsg = &msgs[i];
-
-   if(pmsg->flags & I2C_M_RD) {
-      DEB2(printk("Doing the last read\n"));
-      ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
-   }
-   else if(!(pmsg->flags & I2C_M_RD)) {
-      DEB2(printk("Doing the last write\n"));
-      ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len, IIC_SINGLE_XFER);
-   }
-
-   return ret;
-}
-#endif
-
-
-/* Whenever we initiate a transaction, the first byte clocked
- * onto the bus after the start condition is the address (7 bit) of the
- * device we want to talk to.  This function manipulates the address specified
- * so that it makes sense to the hardware when written to the IIC peripheral.
- *
- * Note: 10 bit addresses are not supported in this driver, although they are
- * supported by the hardware.  This functionality needs to be implemented.
- */
-static inline int iic_doAddress(struct i2c_algo_iic_data *adap,
-                                struct i2c_msg *msg, int retries) 
-{
-	unsigned short flags = msg->flags;
-	unsigned int addr;
-	int ret;
-
-/* Ten bit addresses not supported right now */
-	if ( (flags & I2C_M_TEN)  ) { 
-#if 0
-		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk("addr0: %d\n",addr));
-		ret = try_address(adap, addr, retries);
-		if (ret!=1) {
-			printk("iic_doAddress: died at extended address code.\n");
-			return -EREMOTEIO;
-		}
-		iic_outw(adap,msg->addr & 0x7f);
-		if (ret != 1) {
-			printk("iic_doAddress: died at 2nd address code.\n");
-			return -EREMOTEIO;
-		}
-		if ( flags & I2C_M_RD ) {
-			i2c_repstart(adap);
-			addr |= 0x01;
-			ret = try_address(adap, addr, retries);
-			if (ret!=1) {
-				printk("iic_doAddress: died at extended address code.\n");
-				return -EREMOTEIO;
-			}
-		}
-#endif
-	} else {
-
-		addr = ( msg->addr << 1 );
-
-#if 0
-		if (flags & I2C_M_RD )
-			addr |= 1;
-		if (flags & I2C_M_REV_DIR_ADDR )
-			addr ^= 1;
-#endif
-
-		if (iic_inw(adap, ITE_I2CSAR) != addr) {
-			iic_outw(adap, ITE_I2CSAR, addr);
-			ret = try_address(adap, addr, retries);
-			if (ret!=1) {
-				printk("iic_doAddress: died at address code.\n");
-				return -EREMOTEIO;
-			}
-		}
-
-  }
-
-	return 0;
-}
-
-
-/* Description: Prepares the controller for a transaction (clearing status
- * registers, data buffers, etc), and then calls either iic_readbytes or
- * iic_sendbytes to do the actual transaction.
- *
- * still to be done: Before we issue a transaction, we should
- * verify that the bus is not busy or in some unknown state.
- */
-static int iic_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
-		    int num)
-{
-	struct i2c_algo_iic_data *adap = i2c_adap->algo_data;
-	struct i2c_msg *pmsg;
-	int i = 0;
-	int ret, timeout;
-    
-	pmsg = &msgs[i];
-
-	if(!pmsg->len) {
-		DEB2(printk("iic_xfer: read/write length is 0\n");)
-		return -EIO;
-	}
-	if(!(pmsg->flags & I2C_M_RD) && (!(pmsg->len)%2) ) {
-		DEB2(printk("iic_xfer: write buffer length is not odd\n");)
-		return -EIO; 
-	}
-
-	/* Wait for any pending transfers to complete */
-	timeout = wait_for_bb(adap);
-	if (timeout) {
-		DEB2(printk("iic_xfer: Timeout waiting for host not busy\n");)
-		return -EIO;
-	}
-
-	/* Flush FIFO */
-	iic_outw(adap, ITE_I2CFCR, ITE_I2CFCR_FLUSH);
-
-	/* Load address */
-	ret = iic_doAddress(adap, pmsg, i2c_adap->retries);
-	if (ret)
-		return -EIO;
-
-#if 0
-	/* Combined transaction (read and write) */
-	if(num > 1) {
-           DEB2(printk("iic_xfer: Call combined transaction\n"));
-           ret = iic_combined_transaction(i2c_adap, msgs, num);
-  }
-#endif
-
-	DEB3(printk("iic_xfer: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
-		i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
-
-	if(pmsg->flags & I2C_M_RD) 		/* Read */
-		ret = iic_readbytes(i2c_adap, pmsg->buf, pmsg->len, 0);
-	else {													/* Write */ 
-		udelay(1000);
-		ret = iic_sendbytes(i2c_adap, pmsg->buf, pmsg->len);
-	}
-
-	if (ret != pmsg->len)
-		DEB3(printk("iic_xfer: error or fail on read/write %d bytes.\n",ret)); 
-	else
-		DEB3(printk("iic_xfer: read/write %d bytes.\n",ret));
-
-	return ret;
-}
-
-
-/* Implements device specific ioctls.  Higher level ioctls can
- * be found in i2c-core.c and are typical of any i2c controller (specifying
- * slave address, timeouts, etc).  These ioctls take advantage of any hardware
- * features built into the controller for which this algorithm-adapter set
- * was written.  These ioctls allow you to take control of the data and clock
- * lines and set the either high or low,
- * similar to a GPIO pin.
- */
-static int algo_control(struct i2c_adapter *adapter, 
-	unsigned int cmd, unsigned long arg)
-{
-
-  struct i2c_algo_iic_data *adap = adapter->algo_data;
-  struct i2c_iic_msg s_msg;
-  char *buf;
-	int ret;
-
-  if (cmd = I2C_SREAD) {
-		if(copy_from_user(&s_msg, (struct i2c_iic_msg *)arg, 
-				sizeof(struct i2c_iic_msg))) 
-			return -EFAULT;
-		buf = kmalloc(s_msg.len, GFP_KERNEL);
-		if (buf= NULL)
-			return -ENOMEM;
-
-		/* Flush FIFO */
-		iic_outw(adap, ITE_I2CFCR, ITE_I2CFCR_FLUSH);
-
-		/* Load address */
-		iic_outw(adap, ITE_I2CSAR,s_msg.addr<<1);
-		iic_outw(adap, ITE_I2CSSAR,s_msg.waddr & 0xff);
-
-		ret = iic_readbytes(adapter, buf, s_msg.len, 1);
-		if (ret>=0) {
-			if(copy_to_user( s_msg.buf, buf, s_msg.len) ) 
-				ret = -EFAULT;
-		}
-		kfree(buf);
-	}
-	return 0;
-}
-
-
-static u32 iic_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING; 
-}
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm iic_algo = {
-	"ITE IIC algorithm",
-	I2C_ALGO_IIC,
-	iic_xfer,		/* master_xfer	*/
-	NULL,				/* smbus_xfer	*/
-	NULL,				/* slave_xmit		*/
-	NULL,				/* slave_recv		*/
-	algo_control,			/* ioctl		*/
-	iic_func,			/* functionality	*/
-};
-
-
-/* 
- * registering functions to load algorithms at runtime 
- */
-int i2c_iic_add_bus(struct i2c_adapter *adap)
-{
-	int i;
-	short status;
-	struct i2c_algo_iic_data *iic_adap = adap->algo_data;
-
-	if (iic_test) {
-		int ret = test_bus(iic_adap, adap->name);
-		if (ret<0)
-			return -ENODEV;
-	}
-
-	DEB2(printk("i2c-algo-ite: hw routines for %s registered.\n",
-	            adap->name));
-
-	/* register new adapter to i2c module... */
-
-	adap->id |= iic_algo.id;
-	adap->algo = &iic_algo;
-
-	adap->timeout = 100;	/* default values, should	*/
-	adap->retries = 3;		/* be replaced by defines	*/
-	adap->flags = 0;
-
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-
-	i2c_add_adapter(adap);
-	iic_init(iic_adap);
-
-	/* scan bus */
-	/* By default scanning the bus is turned off. */
-	if (iic_scan) {
-		printk(KERN_INFO " i2c-algo-ite: scanning bus %s.\n",
-		       adap->name);
-		for (i = 0x00; i < 0xff; i+=2) {
-			iic_outw(iic_adap, ITE_I2CSAR, i);
-			iic_start(iic_adap);
-			if ( (wait_for_pin(iic_adap, &status) = 0) && 
-			    ((status & ITE_I2CHSR_DNE) = 0) ) { 
-				printk(KERN_INFO "\n(%02x)\n",i>>1); 
-			} else {
-				printk(KERN_INFO "."); 
-				iic_reset(iic_adap);
-			}
-			udelay(iic_adap->udelay);
-		}
-	}
-	return 0;
-}
-
-
-int i2c_iic_del_bus(struct i2c_adapter *adap)
-{
-	int res;
-	if ((res = i2c_del_adapter(adap)) < 0)
-		return res;
-	DEB2(printk("i2c-algo-ite: adapter unregistered: %s\n",adap->name));
-
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-	return 0;
-}
-
-
-int __init i2c_algo_iic_init (void)
-{
-	printk(KERN_INFO "ITE iic (i2c) algorithm module\n");
-	return 0;
-}
-
-
-void i2c_algo_iic_exit(void)
-{
-	return;
-}
-
-
-EXPORT_SYMBOL(i2c_iic_add_bus);
-EXPORT_SYMBOL(i2c_iic_del_bus);
-
-/* The MODULE_* macros resolve to nothing if MODULES is not defined
- * when this file is compiled.
- */
-MODULE_AUTHOR("MontaVista Software <www.mvista.com>");
-MODULE_DESCRIPTION("ITE iic algorithm");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(iic_test, "i");
-MODULE_PARM(iic_scan, "i");
-MODULE_PARM(i2c_debug,"i");
-
-MODULE_PARM_DESC(iic_test, "Test if the I2C bus is available");
-MODULE_PARM_DESC(iic_scan, "Scan for active chips on the bus");
-MODULE_PARM_DESC(i2c_debug,
-        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 iic-protocol");
-
-
-/* This function resolves to init_module (the function invoked when a module
- * is loaded via insmod) when this file is compiled with MODULES defined.
- * Otherwise (i.e. if you want this driver statically linked to the kernel),
- * a pointer to this function is stored in a table and called
- * during the initialization of the kernel (in do_basic_setup in /init/main.c) 
- *
- * All this functionality is complements of the macros defined in linux/init.h
- */
-module_init(i2c_algo_iic_init);
-
-
-/* If MODULES is defined when this file is compiled, then this function will
- * resolved to cleanup_module.
- */
-module_exit(i2c_algo_iic_exit);
diff -Nru a/drivers/i2c/i2c-algo-pcf.c b/drivers/i2c/i2c-algo-pcf.c
--- a/drivers/i2c/i2c-algo-pcf.c	Thu Sep 25 14:49:55 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,479 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/* i2c-algo-pcf.c i2c driver algorithms for PCF8584 adapters		     */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-1997 Simon G. Vogl
-                   1998-2000 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* ------------------------------------------------------------------------- */
-
-/* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and 
-   Frodo Looijaard <frodol@dds.nl> ,and also from Martin Bailey
-   <mbailey@littlefeet-inc.com> */
-
-/* Partially rewriten by Oleg I. Vdovikin <vdovikin@jscc.ru> to handle multiple
-   messages, proper stop/repstart signaling during receive,
-   added detect code */
-
-/* #define DEBUG 1 */		/* to pick up dev_dbg calls */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-#include <linux/i2c.h>
-#include <linux/i2c-algo-pcf.h>
-#include "i2c-pcf8584.h"
-
-
-/* ----- global defines ----------------------------------------------- */
-#define DEB(x) if (i2c_debug>=1) x
-#define DEB2(x) if (i2c_debug>=2) x
-#define DEB3(x) if (i2c_debug>=3) x /* print several statistical values*/
-#define DEBPROTO(x) if (i2c_debug>=9) x;
- 	/* debug the protocol by showing transferred bits */
-#define DEF_TIMEOUT 16
-
-/* module parameters:
- */
-static int i2c_debug=0;
-
-/* --- setting states on the bus with the right timing: ---------------	*/
-
-#define set_pcf(adap, ctl, val) adap->setpcf(adap->data, ctl, val)
-#define get_pcf(adap, ctl) adap->getpcf(adap->data, ctl)
-#define get_own(adap) adap->getown(adap->data)
-#define get_clock(adap) adap->getclock(adap->data)
-#define i2c_outb(adap, val) adap->setpcf(adap->data, 0, val)
-#define i2c_inb(adap) adap->getpcf(adap->data, 0)
-
-/* --- other auxiliary functions --------------------------------------	*/
-
-static void i2c_start(struct i2c_algo_pcf_data *adap) 
-{
-	DEBPROTO(printk("S "));
-	set_pcf(adap, 1, I2C_PCF_START);
-}
-
-static void i2c_repstart(struct i2c_algo_pcf_data *adap) 
-{
-	DEBPROTO(printk(" Sr "));
-	set_pcf(adap, 1, I2C_PCF_REPSTART);
-}
-
-
-static void i2c_stop(struct i2c_algo_pcf_data *adap) 
-{
-	DEBPROTO(printk("P\n"));
-	set_pcf(adap, 1, I2C_PCF_STOP);
-}
-
-
-static int wait_for_bb(struct i2c_algo_pcf_data *adap) {
-
-	int timeout = DEF_TIMEOUT;
-	int status;
-
-	status = get_pcf(adap, 1);
-#ifndef STUB_I2C
-	while (timeout-- && !(status & I2C_PCF_BB)) {
-		udelay(100); /* wait for 100 us */
-		status = get_pcf(adap, 1);
-	}
-#endif
-	if (timeout <= 0) {
-		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
-	}
-	
-	return (timeout<=0);
-}
-
-
-static inline void pcf_sleep(unsigned long timeout)
-{
-	schedule_timeout( timeout * HZ);
-}
-
-
-static int wait_for_pin(struct i2c_algo_pcf_data *adap, int *status) {
-
-	int timeout = DEF_TIMEOUT;
-
-	*status = get_pcf(adap, 1);
-#ifndef STUB_I2C
-	while (timeout-- && (*status & I2C_PCF_PIN)) {
-		adap->waitforpin();
-		*status = get_pcf(adap, 1);
-	}
-#endif
-	if (timeout <= 0)
-		return(-1);
-	else
-		return(0);
-}
-
-/* 
- * This should perform the 'PCF8584 initialization sequence' as described
- * in the Philips IC12 data book (1995, Aug 29).
- * There should be a 30 clock cycle wait after reset, I assume this
- * has been fulfilled.
- * There should be a delay at the end equal to the longest I2C message
- * to synchronize the BB-bit (in multimaster systems). How long is
- * this? I assume 1 second is always long enough.
- *
- * vdovikin: added detect code for PCF8584
- */
-static int pcf_init_8584 (struct i2c_algo_pcf_data *adap)
-{
-	unsigned char temp;
-
-	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
-
-	/* S1=0x80: S0 selected, serial interface off */
-	set_pcf(adap, 1, I2C_PCF_PIN);
-	/* check to see S1 now used as R/W ctrl -
-	   PCF8584 does that when ESO is zero */
-	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
-		return -ENXIO; /* definetly not PCF8584 */
-	}
-
-	/* load own address in S0, effective address is (own << 1)	*/
-	i2c_outb(adap, get_own(adap));
-	/* check it's really written */
-	if ((temp = i2c_inb(adap)) != get_own(adap)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
-		return -ENXIO;
-	}
-
-	/* S1=0xA0, next byte in S2					*/
-	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
-	/* check to see S2 now selected */
-	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
-		return -ENXIO;
-	}
-
-	/* load clock register S2					*/
-	i2c_outb(adap, get_clock(adap));
-	/* check it's really written, the only 5 lowest bits does matter */
-	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
-		return -ENXIO;
-	}
-
-	/* Enable serial interface, idle, S0 selected			*/
-	set_pcf(adap, 1, I2C_PCF_IDLE);
-
-	/* check to see PCF is really idled and we can access status register */
-	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
-		return -ENXIO;
-	}
-	
-	printk(KERN_DEBUG "i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
-
-	return 0;
-}
-
-
-/* ----- Utility functions
- */
-
-static inline int try_address(struct i2c_algo_pcf_data *adap,
-		       unsigned char addr, int retries)
-{
-	int i, status, ret = -1;
-	for (i=0;i<retries;i++) {
-		i2c_outb(adap, addr);
-		i2c_start(adap);
-		status = get_pcf(adap, 1);
-		if (wait_for_pin(adap, &status) >= 0) {
-			if ((status & I2C_PCF_LRB) = 0) { 
-				i2c_stop(adap);
-				break;	/* success! */
-			}
-		}
-		i2c_stop(adap);
-		udelay(adap->udelay);
-	}
-	DEB2(if (i) printk(KERN_DEBUG "i2c-algo-pcf.o: needed %d retries for %d\n",i,
-	                   addr));
-	return ret;
-}
-
-
-static int pcf_sendbytes(struct i2c_adapter *i2c_adap, const char *buf,
-                         int count, int last)
-{
-	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
-	int wrcount, status, timeout;
-    
-	for (wrcount=0; wrcount<count; ++wrcount) {
-		DEB2(dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
-				buf[wrcount]&0xff));
-		i2c_outb(adap, buf[wrcount]);
-		timeout = wait_for_pin(adap, &status);
-		if (timeout) {
-			i2c_stop(adap);
-			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
-			return -EREMOTEIO; /* got a better one ?? */
-		}
-#ifndef STUB_I2C
-		if (status & I2C_PCF_LRB) {
-			i2c_stop(adap);
-			dev_err(&i2c_adap->dev, "i2c_write: error - no ack.\n");
-			return -EREMOTEIO; /* got a better one ?? */
-		}
-#endif
-	}
-	if (last) {
-		i2c_stop(adap);
-	}
-	else {
-		i2c_repstart(adap);
-	}
-
-	return (wrcount);
-}
-
-
-static int pcf_readbytes(struct i2c_adapter *i2c_adap, char *buf,
-                         int count, int last)
-{
-	int i, status;
-	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
-
-	/* increment number of bytes to read by one -- read dummy byte */
-	for (i = 0; i <= count; i++) {
-
-		if (wait_for_pin(adap, &status)) {
-			i2c_stop(adap);
-			dev_err(&i2c_adap->dev, "pcf_readbytes timed out.\n");
-			return (-1);
-		}
-
-#ifndef STUB_I2C
-		if ((status & I2C_PCF_LRB) && (i != count)) {
-			i2c_stop(adap);
-			dev_err(&i2c_adap->dev, "i2c_read: i2c_inb, No ack.\n");
-			return (-1);
-		}
-#endif
-		
-		if (i = count - 1) {
-			set_pcf(adap, 1, I2C_PCF_ESO);
-		} else 
-		if (i = count) {
-			if (last) {
-				i2c_stop(adap);
-			} else {
-				i2c_repstart(adap);
-			}
-		};
-
-		if (i) {
-			buf[i - 1] = i2c_inb(adap);
-		} else {
-			i2c_inb(adap); /* dummy read */
-		}
-	}
-
-	return (i - 1);
-}
-
-
-static inline int pcf_doAddress(struct i2c_algo_pcf_data *adap,
-                                struct i2c_msg *msg, int retries) 
-{
-	unsigned short flags = msg->flags;
-	unsigned char addr;
-	int ret;
-	if ( (flags & I2C_M_TEN)  ) { 
-		/* a ten bit address */
-		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
-		/* try extended address code...*/
-		ret = try_address(adap, addr, retries);
-		if (ret!=1) {
-			printk(KERN_ERR "died at extended address code.\n");
-			return -EREMOTEIO;
-		}
-		/* the remaining 8 bit address */
-		i2c_outb(adap,msg->addr & 0x7f);
-/* Status check comes here */
-		if (ret != 1) {
-			printk(KERN_ERR "died at 2nd address code.\n");
-			return -EREMOTEIO;
-		}
-		if ( flags & I2C_M_RD ) {
-			i2c_repstart(adap);
-			/* okay, now switch into reading mode */
-			addr |= 0x01;
-			ret = try_address(adap, addr, retries);
-			if (ret!=1) {
-				printk(KERN_ERR "died at extended address code.\n");
-				return -EREMOTEIO;
-			}
-		}
-	} else {		/* normal 7bit address	*/
-		addr = ( msg->addr << 1 );
-		if (flags & I2C_M_RD )
-			addr |= 1;
-		if (flags & I2C_M_REV_DIR_ADDR )
-			addr ^= 1;
-		i2c_outb(adap, addr);
-	}
-	return 0;
-}
-
-static int pcf_xfer(struct i2c_adapter *i2c_adap,
-		    struct i2c_msg msgs[], 
-		    int num)
-{
-	struct i2c_algo_pcf_data *adap = i2c_adap->algo_data;
-	struct i2c_msg *pmsg;
-	int i;
-	int ret=0, timeout, status;
-    
-
-	/* Check for bus busy */
-	timeout = wait_for_bb(adap);
-	if (timeout) {
-		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
-		            "Timeout waiting for BB in pcf_xfer\n");)
-		return -EIO;
-	}
-	
-	for (i = 0;ret >= 0 && i < num; i++) {
-		pmsg = &msgs[i];
-
-		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
-		     pmsg->flags & I2C_M_RD ? "read" : "write",
-                     pmsg->len, pmsg->addr, i + 1, num);)
-    
-		ret = pcf_doAddress(adap, pmsg, i2c_adap->retries);
-
-		/* Send START */
-		if (i = 0) {
-			i2c_start(adap); 
-		}
-    
-		/* Wait for PIN (pending interrupt NOT) */
-		timeout = wait_for_pin(adap, &status);
-		if (timeout) {
-			i2c_stop(adap);
-			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
-				    "for PIN(1) in pcf_xfer\n");)
-			return (-EREMOTEIO);
-		}
-    
-#ifndef STUB_I2C
-		/* Check LRB (last rcvd bit - slave ack) */
-		if (status & I2C_PCF_LRB) {
-			i2c_stop(adap);
-			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
-			return (-EREMOTEIO);
-		}
-#endif
-    
-		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
-			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
-    
-		/* Read */
-		if (pmsg->flags & I2C_M_RD) {
-			/* read bytes into buffer*/
-			ret = pcf_readbytes(i2c_adap, pmsg->buf, pmsg->len,
-                                            (i + 1 = num));
-        
-			if (ret != pmsg->len) {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only read %d bytes.\n",ret));
-			} else {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
-			}
-		} else { /* Write */
-			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
-                                            (i + 1 = num));
-        
-			if (ret != pmsg->len) {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
-					    "only wrote %d bytes.\n",ret));
-			} else {
-				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
-			}
-		}
-	}
-
-	return (i);
-}
-
-static u32 pcf_func(struct i2c_adapter *adap)
-{
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING; 
-}
-
-/* -----exported algorithm data: -------------------------------------	*/
-
-static struct i2c_algorithm pcf_algo = {
-	.name		= "PCF8584 algorithm",
-	.id		= I2C_ALGO_PCF,
-	.master_xfer	= pcf_xfer,
-	.functionality	= pcf_func,
-};
-
-/* 
- * registering functions to load algorithms at runtime 
- */
-int i2c_pcf_add_bus(struct i2c_adapter *adap)
-{
-	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
-	int rval;
-
-	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
-
-	/* register new adapter to i2c module... */
-
-	adap->id |= pcf_algo.id;
-	adap->algo = &pcf_algo;
-
-	adap->timeout = 100;		/* default values, should	*/
-	adap->retries = 3;		/* be replaced by defines	*/
-
-	rval = pcf_init_8584(pcf_adap);
-	if (!rval)
-		i2c_add_adapter(adap);
-	return rval;
-}
-
-
-int i2c_pcf_del_bus(struct i2c_adapter *adap)
-{
-	return i2c_del_adapter(adap);
-}
-
-EXPORT_SYMBOL(i2c_pcf_add_bus);
-EXPORT_SYMBOL(i2c_pcf_del_bus);
-
-MODULE_AUTHOR("Hans Berglund <hb@spacetec.no>");
-MODULE_DESCRIPTION("I2C-Bus PCF8584 algorithm");
-MODULE_LICENSE("GPL");
-
-MODULE_PARM(i2c_debug,"i");
-MODULE_PARM_DESC(i2c_debug,
-        "debug level - 0 off; 1 normal; 2,3 more verbose; 9 pcf-protocol");
diff -Nru a/drivers/i2c/i2c-ite.h b/drivers/i2c/i2c-ite.h
--- a/drivers/i2c/i2c-ite.h	Thu Sep 25 14:49:55 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,117 +0,0 @@
-/*
-   --------------------------------------------------------------------
-   i2c-ite.h: Global defines for the I2C controller on board the    
-                 ITE MIPS processor.                                
-   --------------------------------------------------------------------
-   Hai-Pao Fan, MontaVista Software, Inc.
-   hpfan@mvista.com or source@mvista.com
-
-   Copyright 2001 MontaVista Software Inc.
-
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
-
- */
-
-#ifndef I2C_ITE_H
-#define I2C_ITE_H 1
-
-#include <asm/it8172/it8172.h>
-
-/* I2C Registers */
-#define ITE_I2CHCR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x30
-#define ITE_I2CHSR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x34
-#define ITE_I2CSAR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x38
-#define ITE_I2CSSAR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x3c
-#define ITE_I2CCKCNT	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x48
-#define ITE_I2CSHDR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x4c
-#define ITE_I2CRSUR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x50
-#define ITE_I2CPSUR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x54
-
-#define ITE_I2CFDR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x70
-#define ITE_I2CFBCR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x74
-#define ITE_I2CFCR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x78
-#define ITE_I2CFSR	IT8172_PCI_IO_BASE + IT_I2C_BASE + 0x7c
-
-
-/* Host Control Register ITE_I2CHCR */
-#define	ITE_I2CHCR_HCE	0x01	/* Enable I2C Host Controller */
-#define	ITE_I2CHCR_IE	0x02	/* Enable the interrupt after completing
-				   the current transaction */
-#define ITE_I2CHCR_CP_W	0x00	/* bit2-4 000 - Write */
-#define	ITE_I2CHCR_CP_R	0x08	/*	  010 - Current address read */
-#define	ITE_I2CHCR_CP_S	0x10	/*	  100 - Sequential read */
-#define ITE_I2CHCR_ST	0x20	/* Initiates the I2C host controller to execute
-				   the command and send the data programmed in
-				   all required registers to I2C bus */
-#define ITE_CMD		ITE_I2CHCR_HCE | ITE_I2CHCR_IE | ITE_I2CHCR_ST
-#define ITE_WRITE	ITE_CMD | ITE_I2CHCR_CP_W
-#define ITE_READ	ITE_CMD | ITE_I2CHCR_CP_R
-#define ITE_SREAD	ITE_CMD | ITE_I2CHCR_CP_S
-
-/* Host Status Register ITE_I2CHSR */
-#define	ITE_I2CHSR_DB	0x01	/* Device is busy, receives NACK response except
-				   in the first and last bytes */
-#define	ITE_I2CHSR_DNE	0x02	/* Target address on I2C bus does not exist */
-#define	ITE_I2CHSR_TDI	0x04	/* R/W Transaction on I2C bus was completed */
-#define	ITE_I2CHSR_HB	0x08	/* Host controller is processing transactions */
-#define	ITE_I2CHSR_FER	0x10	/* Error occurs in the FIFO */
-
-/* Slave Address Register ITE_I2CSAR */
-#define	ITE_I2CSAR_SA_MASK	0xfe	/* Target I2C device address */
-#define	ITE_I2CSAR_ASO		0x0100	/* Output 1/0 to I2CAS port when the
-					   next slave address is addressed */
-
-/* Slave Sub-address Register ITE_I2CSSAR */
-#define	ITE_I2CSSAR_SUBA_MASK	0xff	/* Target I2C device sub-address */
-
-/* Clock Counter Register ITE_I2CCKCNT */
-#define	ITE_I2CCKCNT_STOP	0x00	/* stop I2C clock */
-#define	ITE_I2CCKCNT_HPCC_MASK	0x7f	/* SCL high period counter */
-#define	ITE_I2CCKCNT_LPCC_MASK	0x7f00	/* SCL low period counter */
-
-/* START Hold Time Register ITE_I2CSHDR */
-/* value is counted based on 16 MHz internal clock */
-#define ITE_I2CSHDR_FM	0x0a	/* START condition at fast mode */
-#define	ITE_I2CSHDR_SM	0x47	/* START contition at standard mode */
-
-/* (Repeated) START Setup Time Register ITE_I2CRSUR */
-/* value is counted based on 16 MHz internal clock */
-#define	ITE_I2CRSUR_FM	0x0a	/* repeated START condition at fast mode */
-#define	ITE_I2CRSUR_SM	0x50	/* repeated START condition at standard mode */
-
-/* STOP setup Time Register ITE_I2CPSUR */
-
-/* FIFO Data Register ITE_I2CFDR */
-#define	ITE_I2CFDR_MASK		0xff
-
-/* FIFO Byte Count Register ITE_I2CFBCR */
-#define ITE_I2CFBCR_MASK	0x3f
-
-/* FIFO Control Register ITE_I2CFCR */
-#define	ITE_I2CFCR_FLUSH	0x01	/* Flush FIFO and reset the FIFO point
-					   and I2CFSR */
-/* FIFO Status Register ITE_I2CFSR */
-#define	ITE_I2CFSR_FO	0x01	/* FIFO is overrun when write */
-#define	ITE_I2CFSR_FU	0x02	/* FIFO is underrun when read */
-#define	ITE_I2CFSR_FF	0x04	/* FIFO is full when write */
-#define	ITE_I2CFSR_FE	0x08	/* FIFO is empty when read */
-
-#endif  /* I2C_ITE_H */
diff -Nru a/drivers/i2c/i2c-pcf8584.h b/drivers/i2c/i2c-pcf8584.h
--- a/drivers/i2c/i2c-pcf8584.h	Thu Sep 25 14:49:55 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,78 +0,0 @@
-/* -------------------------------------------------------------------- */
-/* i2c-pcf8584.h: PCF 8584 global defines				*/
-/* -------------------------------------------------------------------- */
-/*   Copyright (C) 1996 Simon G. Vogl
-                   1999 Hans Berglund
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		*/
-/* --------------------------------------------------------------------	*/
-
-/* With some changes from Frodo Looijaard <frodol@dds.nl> */
-
-/* $Id: i2c-pcf8584.h,v 1.3 2000/01/18 23:54:07 frodo Exp $ */
-
-#ifndef I2C_PCF8584_H
-#define I2C_PCF8584_H 1
-
-/* ----- Control register bits ----------------------------------------	*/
-#define I2C_PCF_PIN	0x80
-#define I2C_PCF_ESO	0x40
-#define I2C_PCF_ES1	0x20
-#define I2C_PCF_ES2	0x10
-#define I2C_PCF_ENI	0x08
-#define I2C_PCF_STA	0x04
-#define I2C_PCF_STO	0x02
-#define I2C_PCF_ACK	0x01
-
-#define I2C_PCF_START    (I2C_PCF_PIN | I2C_PCF_ESO | I2C_PCF_STA | I2C_PCF_ACK)
-#define I2C_PCF_STOP     (I2C_PCF_PIN | I2C_PCF_ESO | I2C_PCF_STO | I2C_PCF_ACK)
-#define I2C_PCF_REPSTART (              I2C_PCF_ESO | I2C_PCF_STA | I2C_PCF_ACK)
-#define I2C_PCF_IDLE     (I2C_PCF_PIN | I2C_PCF_ESO               | I2C_PCF_ACK)
-
-/* ----- Status register bits -----------------------------------------	*/
-/*#define I2C_PCF_PIN  0x80    as above*/
-
-#define I2C_PCF_INI 0x40   /* 1 if not initialized */
-#define I2C_PCF_STS 0x20
-#define I2C_PCF_BER 0x10
-#define I2C_PCF_AD0 0x08
-#define I2C_PCF_LRB 0x08
-#define I2C_PCF_AAS 0x04
-#define I2C_PCF_LAB 0x02
-#define I2C_PCF_BB  0x01
-
-/* ----- Chip clock frequencies ---------------------------------------	*/
-#define I2C_PCF_CLK3	0x00
-#define I2C_PCF_CLK443	0x10
-#define I2C_PCF_CLK6	0x14
-#define I2C_PCF_CLK	0x18
-#define I2C_PCF_CLK12	0x1c
-
-/* ----- transmission frequencies -------------------------------------	*/
-#define I2C_PCF_TRNS90 0x00	/*  90 kHz */
-#define I2C_PCF_TRNS45 0x01	/*  45 kHz */
-#define I2C_PCF_TRNS11 0x02	/*  11 kHz */
-#define I2C_PCF_TRNS15 0x03	/* 1.5 kHz */
-
-
-/* ----- Access to internal registers according to ES1,ES2 ------------	*/
-/* they are mapped to the data port ( a0 = 0 ) 				*/
-/* available when ESO = 0 :						*/
-
-#define I2C_PCF_OWNADR	0
-#define I2C_PCF_INTREG	I2C_PCF_ES2
-#define I2C_PCF_CLKREG	I2C_PCF_ES1
-
-#endif /* I2C_PCF8584_H */

