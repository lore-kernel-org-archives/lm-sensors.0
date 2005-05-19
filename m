From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030814051347.GB15093@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com> <20030802095518.4c5630ef.khali@linux-fr.org> <20030802165638.GF11038@kroah.com> <20030803052728.GC5202@earth.solarsys.private> <20030804160630.GB3395@kroah.com> <20030805034921.GB11605@earth.solarsys.private>
In-Reply-To: <20030805034921.GB11605@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

This is a resend of a patch to the i2c-nforce2.c I2C bus driver.
The start of the relevant thread was here:
http://archives.andrew.net.au/lm-sensors/msg03820.html

[comment]
This patch restores a line that was wrongly removed.  There are also some
trivial cleanups.  It applies & compiles vs. 2.6.0-test3.  It's untested
(no hardware here).
[/comment]

--- linux-2.6.0-test3/drivers/i2c/busses/i2c-nforce2.c.orig	2003-08-14 00:53:00.000000000 -0400
+++ linux-2.6.0-test3/drivers/i2c/busses/i2c-nforce2.c	2003-08-14 01:05:31.000000000 -0400
@@ -51,10 +51,6 @@
 #ifndef PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
 #endif
-/* TODO: sync with lm-sensors */
-#ifndef I2C_HW_SMBUS_NFORCE2
-#define I2C_HW_SMBUS_NFORCE2	0x0c
-#endif
 
 
 struct nforce2_smbus {
@@ -128,20 +124,10 @@
 	.name   	= "unset",
 };
 
-
-#if 0
-/* Internally used pause function */
-static void nforce2_do_pause(unsigned int amount)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(amount);
-}
-#endif
-
 /* Return -1 on error. See smbus.h for more information */
-static s32 nforce2_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
-		char read_write, u8 command, int size,
-		union i2c_smbus_data * data)
+static s32 nforce2_access(struct i2c_adapter * adap, u16 addr,
+		unsigned short flags, char read_write,
+		u8 command, int size, union i2c_smbus_data * data)
 {
 	struct nforce2_smbus *smbus = adap->algo_data;
 	unsigned char protocol, pec, temp;
@@ -249,7 +235,7 @@
 
 #if 0
 	do {
-		nforce2_do_pause(1);
+		i2c_do_pause(1);
 		temp = inb_p(NVIDIA_SMB_STS);
 	} while (((temp & NVIDIA_SMB_STS_DONE) = 0) && (timeout++ < MAX_TIMEOUT));
 #endif
@@ -332,13 +318,8 @@
 			smbus->base, smbus->base+smbus->size-1, name);
 		return -1;
 	}
-/*
-	smbus->adapter.owner = THIS_MODULE;
-	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2;
-	smbus->adapter.algo = &smbus_algorithm;
-	smbus->adapter.algo_data = smbus;
-*/
 	smbus->adapter = nforce2_adapter;
+	smbus->adapter.algo_data = smbus;
 	smbus->adapter.dev.parent = &dev->dev;
 	snprintf(smbus->adapter.name, DEVICE_NAME_SIZE,
 		"SMBus nForce2 adapter at %04x", smbus->base);

-- 
Mark M. Hoffman
mhoffman@lightlink.com
