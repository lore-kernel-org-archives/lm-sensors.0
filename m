From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all.  On some boards with an Intel PIIX4 the BIOS (such as the one
found on a Force CPCI-735) will incorrectly configure the chipset, and
leaves a register in an undefined state causing i2c to behave strangley.
The following patches (first vs lm_sensors-2.8.0 and then vs
2.6.0-test3)  fixes the issue.

--- lm_sensors-2.8.0/kernel/busses/i2c-piix4.c.orig	2003-06-09 18:07:54.000000000 -0700
+++ lm_sensors-2.8.0/kernel/bussses/i2c-piix4.c	2003-08-11 10:58:19.000000000 -0700
@@ -180,6 +180,15 @@
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
+
+	/* Some BIOS will set up the chipset incorrectly and leave a register
+	   in an undefined state (causing I2C to act very strangely). */
+	if (temp & 0x02) {
+		printk("Fixed I2C problem on Force CPCI735\n");
+		temp = temp & 0xfd;
+		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+	}
+
 /* If force_addr is set, we program the new address here. Just to make
    sure, we disable the PIIX4 first. */
 	if (force_addr) {

=== i2c-piix4.c 1.13 vs edited ==--- 1.13/drivers/i2c/busses/i2c-piix4.c	Fri Aug  8 16:15:03 2003
+++ edited/drivers/i2c/busses/i2c-piix4.c	Mon Aug 11 10:57:39 2003
@@ -160,6 +160,15 @@
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
+
+	/* Some BIOS will set up the chipset incorrectly and leave a register
+	   in an undefined state (causing I2C to act very strangely). */
+	if (temp & 0x02) {
+		printk("Fixed I2C problem on Force CPCI735\n");
+		temp = temp & 0xfd;
+		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp);
+	}
+ 
 	/* If force_addr is set, we program the new address here. Just to make
 	   sure, we disable the PIIX4 first. */
 	if (force_addr) {


-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030811/b97c52f5/attachment.bin
