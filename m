From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <10609724071636@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1060972406382@kroah.com>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1123.18.5, 2003/08/14 14:13:01-07:00, mhoffman@lightlink.com

[PATCH] I2C: i2c nforce2.c fixes

This patch restores a line that was wrongly removed.  There are also some
trivial cleanups.  It applies & compiles vs. 2.6.0-test3.  It's untested
(no hardware here).


 drivers/i2c/busses/i2c-nforce2.c |   29 +++++------------------------
 1 files changed, 5 insertions(+), 24 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	Fri Aug 15 11:26:57 2003
+++ b/drivers/i2c/busses/i2c-nforce2.c	Fri Aug 15 11:26:57 2003
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

