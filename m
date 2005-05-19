From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <20031206222334.726d138f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Okay, here's a patch against the current lm_sensors2 module that
> should be able to get me started on this:

I just committed a different version of the same thing. This should help
us gather enough information for you to suggest another, non-breaking
fix (at least we hope so).

Index: i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.59
diff -u -r1.59 i2c-piix4.c
--- i2c-piix4.c	21 Nov 2003 22:57:38 -0000	1.59
+++ i2c-piix4.c	6 Dec 2003 21:46:37 -0000
@@ -187,10 +187,16 @@
 
 	/* Some BIOS will set up the chipset incorrectly and leave a register
 	   in an undefined state (causing I2C to act very strangely). */
-	if (fix_hstcfg && (temp & 0x02)) {
-		printk("Worked around buggy BIOS (I2C)\n");
-		temp &= 0xfd;
-		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+	if (temp & 0x02) {
+		if (fix_hstcfg) {
+			printk(KERN_INFO "i2c-piix4.o: Working around buggy BIOS (I2C)\n");
+			temp &= 0xfd;
+			pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+		} else {
+			printk(KERN_INFO "i2c-piix4.o: Unusual config register value "
+			       "(0x%02x)\n", temp);
+			printk(KERN_INFO "i2c-piix4.o: Please report!\n");
+		}
 	}
 
 /* If force_addr is set, we program the new address here. Just to make


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
