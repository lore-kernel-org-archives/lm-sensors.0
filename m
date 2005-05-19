From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH] I2C: Fix i2c-sis5595 pci configuration accesses
Message-Id: <11074523382465@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11074523383635@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2045, 2005/02/03 00:30:21-08:00, khali@linux-fr.org

[PATCH] I2C: Fix i2c-sis5595 pci configuration accesses

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
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-sis5595.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	2005-02-03 09:34:55 -08:00
+++ b/drivers/i2c/busses/i2c-sis5595.c	2005-02-03 09:34:55 -08:00
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

