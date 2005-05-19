From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <20031126164500.GG2541@stop.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 22, 2003 at 06:40:48PM +0100, Jean Delvare wrote:
> 
> > > This is the very same as Martin's (except that he seems to have USB
> > > disabled), so if there is a way to differenciate the two of them,
> > > it's not by using the PCI data. I think we'll have to disable the
> > > workaround by default. We might consider adding a module parameter
> > > to reenable it. If you can provide another way to automatically
> > > detect when that workaround is needed, we would implement it.
> > 
> > What are the contents of the register on his board?
> 
> How would I know? ;) I don't even know how to see this. Please explain,
> so that Martin can answer.

Okay, here's a patch against the current lm_sensors2 module that should
be able to get me started on this:
Index: i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.59
diff -u -u -r1.59 i2c-piix4.c
--- i2c-piix4.c	21 Nov 2003 22:57:38 -0000	1.59
+++ i2c-piix4.c	26 Nov 2003 17:13:07 -0000
@@ -100,7 +100,7 @@
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-static int fix_hstcfg = 0;
+static int fix_hstcfg = 1;
 MODULE_PARM(fix_hstcfg, "i");
 MODULE_PARM_DESC(fix_hstcfg,
 		 "Fix config register. Needed on some boards (Force CPCI735).");
@@ -143,7 +143,6 @@
 static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
 {
 	int error_return = 0;
-	unsigned char temp;
 
 	/* match up the function */
 	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
@@ -182,15 +181,23 @@
 		error_return = -ENODEV;
 		goto END;
 	}
-
-	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
-
+	
 	/* Some BIOS will set up the chipset incorrectly and leave a register
-	   in an undefined state (causing I2C to act very strangely). */
-	if (fix_hstcfg && (temp & 0x02)) {
-		printk("Worked around buggy BIOS (I2C)\n");
-		temp &= 0xfd;
-		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+	   in an undefined state (causing I2C to act very strangely).  Others become
+	   unhappy if you change this. */
+	if (fix_hstcfg) {
+		unsigned char temp;
+
+		pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
+		if (temp & 0x02) {
+#if 0
+			printk("Worked around buggy BIOS (I2C)\n");
+			temp &= 0xfd;
+			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+#else
+			printk("temp: %x\n", temp);
+#endif
+		}
 	}
 
 /* If force_addr is set, we program the new address here. Just to make

-- 
Tom Rini
http://gate.crashing.org/~trini/
