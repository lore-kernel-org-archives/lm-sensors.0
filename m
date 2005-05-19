From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c-piix4 fix undo
Message-Id: <20031219164139.GF29266@stop.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031206221027.45ecfdea.khali@linux-fr.org>
In-Reply-To: <20031206221027.45ecfdea.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Dec 18, 2003 at 10:26:40AM -0800, Greg KH wrote:
> On Thu, Dec 18, 2003 at 11:16:12AM -0700, Tom Rini wrote:
> > On Wed, Dec 17, 2003 at 03:52:50PM -0800, Greg KH wrote:
> > > On Sat, Dec 06, 2003 at 10:10:27PM +0100, Jean Delvare wrote:
> > > > Hi Greg,
> > > > 
> > > > A few months ago, we added a workaround to i2c-piix4 to help it to work
> > > > on a few boards. The fix was ported to 2.6, the patch is here:
> > > > http://linuxusb.bkbits.net:8080/i2c-2.6/patch@1.1123.21.1
> > > > 
> > > > It since turned out that it also breaks the module for other boards, and
> > > > it even breaks more than it fixes (4 reports since lm_sensors-2.8.1 was
> > > > released). The problem is under investigation by Tom Rini, the author of
> > > > the original fix.
> > > > 
> > > > I suggest that you reverse the fix in Linux 2.6 before 2.6.0 is
> > > > released. Once we have enough information to submit a better one (could
> > > > take some time), I'll send a new patch to you.
> > > 
> > > Thanks, I've backed this patch out and will send it off to Linus.
> > 
> > If it's not too late, how about doing the current work-around (module
> > param to enable the fix) instead?
> 
> Sure, got patch?  :)

Here you go:
=== drivers/i2c/busses/i2c-piix4.c 1.19 vs edited ==--- 1.19/drivers/i2c/busses/i2c-piix4.c	Mon Sep 22 09:02:10 2003
+++ edited/drivers/i2c/busses/i2c-piix4.c	Fri Dec 19 09:40:03 2003
@@ -99,6 +99,13 @@
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
+/* If fix_hstcfg is set to anything different from 0, we reset one of the
+   registers to be a valid value. */
+static int fix_hstcfg = 0;
+MODULE_PARM(fix_hstcfg, "i");
+MODULE_PARM_DESC(fix_hstcfg,
+		"Fix config register. Needed on some boards (Force CPCI735).");
+
 static int piix4_transaction(void);
 
 
@@ -164,9 +171,17 @@
 	/* Some BIOS will set up the chipset incorrectly and leave a register
 	   in an undefined state (causing I2C to act very strangely). */
 	if (temp & 0x02) {
-		dev_info(&PIIX4_dev->dev, "Worked around buggy BIOS (I2C)\n");
-		temp = temp & 0xfd;
-		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+		if (fix_hstcfg) {
+			dev_info(&PIIX4_dev->dev, "Working around buggy BIOS "
+					"(I2C)\n");
+			temp &= 0xfd;
+			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+		} else {
+			dev_info(&PIIX4_dev->dev, "Unusual config register "
+					"value\n");
+			dev_info(&PIIX4_dev->dev, "Try using fix_hstcfg=1 if "
+					"you experience problems\n");
+		}
 	}
  
 	/* If force_addr is set, we program the new address here. Just to make

-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031219/4a2e5ede/attachment.bin
