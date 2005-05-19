From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 2.6] I2C: Fix i2c-sis5595 pci configuration accesses
Message-Id: <20050123101504.79f65398.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The i2c-sis5595 bus driver has logic errors on pci configuration
accesses. It returns an error on success and vice versa. The 2.4 kernel
version of the driver, as found in the lm_sensors CVS repository, is
correct, so the problem was introducted when the driver was ported to
the 2.6 kernel tree  (in 2.6.0-test6). As odd as it sounds, the driver
has been sitting here broken and unusable for 17 months and nobody ever
reported, until yesterday.

Credits go to Sebastian Hesselbarth for discovering and analyzing the
problem.

Here is a patch that fixes the problem, succesfully tested by Aurelien
Jarno and Sebastian Hesselbarth. Please apply.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc2/drivers/i2c/busses/i2c-sis5595.c.orig	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc2/drivers/i2c/busses/i2c-sis5595.c	2005-01-22 18:55:09.000000000 +0100
@@ -181,9 +181,11 @@
 
 	if (force_addr) {
 		dev_info(&SIS5595_dev->dev, "forcing ISA address 0x%04X\n", sis5595_base);
-		if (!pci_write_config_word(SIS5595_dev, ACPI_BASE, sis5595_base))
+		if (pci_write_config_word(SIS5595_dev, ACPI_BASE, sis5595_base)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
-		if (!pci_read_config_word(SIS5595_dev, ACPI_BASE, &a))
+		if (pci_read_config_word(SIS5595_dev, ACPI_BASE, &a)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
 		if ((a & ~(SIS5595_EXTENT - 1)) != sis5595_base) {
 			/* doesn't work for some chips! */
@@ -192,13 +194,16 @@
 		}
 	}
 
-	if (!pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
+	if (pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val)
+	    != PCIBIOS_SUCCESSFUL)
 		goto error;
 	if ((val & 0x80) = 0) {
 		dev_info(&SIS5595_dev->dev, "enabling ACPI\n");
-		if (!pci_write_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, val | 0x80))
+		if (pci_write_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, val | 0x80)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
-		if (!pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
+		if (pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val)
+		    != PCIBIOS_SUCCESSFUL)
 			goto error;
 		if ((val & 0x80) = 0) {
 			/* doesn't work for some chips? */


-- 
Jean Delvare
http://khali.linux-fr.org/
