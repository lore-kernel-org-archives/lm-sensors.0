From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 14 Mar 2006 03:47:15 +0000
Subject: [lm-sensors] using primitive i2c/parallel port method (i2c-pport)
Message-Id: <20060314034715.GA19400@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

I did a quick-n-dirty port to Linux 2.6.x of i2c-pport.c (from CVS/2.4.x)
which can be found here:

http://members.dca.net/mhoffman/sensors/temp/20060313/

That works well enough, with one hint from Jean Delvare to set "standard"
mode in the BIOS.  But clearly, this code is not suitable for merging.

So I tried to port this adapter to i2c-parport/i2c-parport-light [1].  I had
no success at all using i2c-parport... the voltages looked wrong again, as
if it puts the port back into one of the enhanced modes.

With i2c-parport-light, it almost works.  The signals look good... but
always one bit gets corrupted on reads.  My only guess is that the getscl
method is not working properly... so that the master ignores the slave's
clock stretching.

Another note: I can use i2c-pport, then remove it and insert i2c-parport-light,
then go back to i2c-pport as often as I want without rebooting... but always
the former works and the latter does not.  Whereas, if I load i2c-parport even
once, nothing works again until after a reboot.

I am no expert on PC parallel ports.  I would definitely appreciate some
advice about this.

[1] Here's the patch I am using:

--- linux-2.6.16-rc6.orig/drivers/i2c/busses/i2c-parport.h
+++ linux-2.6.16-rc6/drivers/i2c/busses/i2c-parport.h
@@ -88,6 +88,13 @@ static struct adapter_parm adapter_parm[
 		.getscl	= { 0x40, STAT, 0 },
 		.init	= { 0xfc, DATA, 0 },
 	},
+	/* type 7: Primitive +5V 'pport' adapter */
+	{
+		.setsda = { 0x02, CTRL, 1 },
+		.getsda = { 0x02, CTRL, 1 },
+		.setscl = { 0x04, CTRL, 0 },
+		.getscl = { 0x04, CTRL, 0 },
+	},
 };
 
 static int type;
@@ -101,4 +108,5 @@ MODULE_PARM_DESC(type,
 	" 4 = ADM1032 evaluation board\n"
 	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
 	" 6 = Barco LPT->DVI (K5800236) adapter\n"
+	" 7 = Primitive +5V 'pport' adapter\n"
 );

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


