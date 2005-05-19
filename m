From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Problems with Tyan Thunder LE-T
Message-Id: <20031208153700.GZ912@stop.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
In-Reply-To: <Pine.LNX.4.50.0312052212300.7299-100000@trottelkunde.amd.co.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Dec 06, 2003 at 08:41:55AM +0100, Jean Delvare wrote:

> > I was trying to get I2C/lm_sensors running on one of our "refurbished"
> > servers, but ran into freezes while loading the i2c-piix driver.
> 
> This known bug was introduced in 2.8.1 while trying to workaround a few
> buggy piix4-compatible chipsets. The workaround, although tested, turned
> out to confuse some others piix4-compatible chipsets (OSB4 and OSB5 if I
> remember correctly), so it has been reversed. (Well it is still present
> but not enabled by default.)
> 
> Get an updated lm_sensors2 from CVS and it should work OK. Sorry for the
> trouble.

And if you would, can you apply the following patch and let me know what
the output (in dmesg) is?  Thanks:
--- kernel/busses/i2c-piix4.c	6 Dec 2003 21:48:32 -0000	1.60
+++ kernel/busses/i2c-piix4.c	8 Dec 2003 16:06:44 -0000
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
@@ -182,20 +181,22 @@
 		error_return = -ENODEV;
 		goto END;
 	}
-
-	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
-
+	
 	/* Some BIOS will set up the chipset incorrectly and leave a register
-	   in an undefined state (causing I2C to act very strangely). */
-	if (temp & 0x02) {
-		if (fix_hstcfg) {
+	   in an undefined state (causing I2C to act very strangely).  Others
+	   become unhappy if you change this. */
+	if (fix_hstcfg) {
+		unsigned char temp;
+
+		pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
+		if (temp & 0x02) {
+#if 0
 			printk(KERN_INFO "i2c-piix4.o: Working around buggy BIOS (I2C)\n");
 			temp &= 0xfd;
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
-		} else {
-			printk(KERN_INFO "i2c-piix4.o: Unusual config register value "
-			       "(0x%02x)\n", temp);
-			printk(KERN_INFO "i2c-piix4.o: Please report!\n");
+#else
+			printk(KERN_INFO "temp: %x\n", temp);
+#endif
 		}
 	}
 

-- 
Tom Rini
http://gate.crashing.org/~trini/
