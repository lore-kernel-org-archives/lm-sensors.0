From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030805034921.GB11605@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Greg KH <greg@kroah.com> [2003-08-04 09:06:30 -0700]:
> On Sun, Aug 03, 2003 at 01:27:28AM -0400, Mark M. Hoffman wrote:
> > 
> > Done, plus most of the nforce2 patch.  This bit though... any particular
> > reason you didn't just whack all of it?
> > 
> > @@ -345,18 +334,12 @@
> >  			smbus->base, smbus->base+smbus->size-1, name);
> >  		return -1;
> >  	}
> > -
> > -	/* TODO: find a better way to find out whether this file is compiled
> > -	 * with i2c 2.7.0 of earlier
> > -	 */
> > -/*#ifdef I2C_HW_SMBUS_AMD8111
> > +/*
> >  	smbus->adapter.owner = THIS_MODULE;
> > -#endif
> > -
> >  	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_NFORCE2;
> >  	smbus->adapter.algo = &smbus_algorithm;
> > -	smbus->adapter.algo_data = smbus;*/
> > -
> > +	smbus->adapter.algo_data = smbus;
> > +*/
> 
> I didn't have the time to verify if this really should be set or not, so
> I left the main portion alone.  Does this mean I can delete all of the
> commented out area for 2.6?

With a closer look, I think this driver was broken before and after
your patch.  The algo_data field has to be set (to smbus), because it's
used in nforce2_access().  Notice the macros...

#define NVIDIA_SMB_PRTCL        (smbus->base + 0x00)    /* protocol, PEC */
#define NVIDIA_SMB_STS          (smbus->base + 0x01)    /* status */
#define NVIDIA_SMB_ADDR         (smbus->base + 0x02)    /* address */

I'm not a fan of that (I would give the macros a parameter) but whatever.

A new patch is attached; please consider...

[comment]
This patch restores a line that was wrongly removed.  There are also some
trivial cleanups.  It applies & compiles vs. 2.6.0-test2-bk4.  It's untested
(no hardware here).
[/comment]

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

-------------- next part --------------
--- linux-2.6.0-test2/drivers/i2c/busses/i2c-nforce2.c.old	2003-08-04 23:01:39.000000000 -0400
+++ linux-2.6.0-test2/drivers/i2c/busses/i2c-nforce2.c	2003-08-04 23:07:33.000000000 -0400
@@ -51,10 +51,6 @@
 #ifndef PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS
 #define PCI_DEVICE_ID_NVIDIA_NFORCE2_SMBUS   0x0064
 #endif
-/* TODO: sync with lm-sensors */
-#ifndef I2C_HW_SMBUS_NFORCE2
-#define I2C_HW_SMBUS_NFORCE2	0x0c
-#endif
 
 
 struct nforce2_smbus {
@@ -130,20 +126,10 @@
 	},
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
@@ -251,7 +237,7 @@
 
 #if 0
 	do {
-		nforce2_do_pause(1);
+		i2c_do_pause(1);
 		temp = inb_p(NVIDIA_SMB_STS);
 	} while (((temp & NVIDIA_SMB_STS_DONE) = 0) && (timeout++ < MAX_TIMEOUT));
 #endif
@@ -334,13 +320,8 @@
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
 	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
 		"SMBus nForce2 adapter at %04x", smbus->base);
