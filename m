From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:38 +0000
Subject: [lm-sensors] [PATCH 12/44] [PATCH] I2C: i2c-piix4: Document the IBM
Message-Id: <11510009303684-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Properly document on which systems the i2c-piix4 SMBus driver will
refuse to load. Hopefully this will make it clearer for users, which
were often wondering why their destop or server systems were detected
as laptops.

Closes bug #6429.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/i2c/busses/i2c-piix4 |   14 ++++++++++++++
 drivers/i2c/busses/i2c-piix4.c     |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-piix4 b/Documentation/i2c/busses/i2c-piix4
index a706ae6..9214763 100644
--- a/Documentation/i2c/busses/i2c-piix4
+++ b/Documentation/i2c/busses/i2c-piix4
@@ -82,3 +82,17 @@ the SMI mode.
 
 Please note that you don't need to do that in all cases, just when the SMBus is
 not working properly.
+
+
+Hardware-specific issues
+------------------------
+
+This driver will refuse to load on IBM systems with an Intel PIIX4 SMBus.
+Some of these machines have an RFID EEPROM (24RF08) connected to the SMBus,
+which can easily get corrupted due to a state machine bug. These are mostly
+Thinkpad laptops, but desktop systems may also be affected. We have no list
+of all affected systems, so the only safe solution was to prevent access to
+the SMBus on all IBM systems (detected using DMI data.)
+
+For additional information, read:
+http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 05af7b0..8f2f65b 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -130,7 +130,7 @@ static int __devinit piix4_setup(struct 
 	/* Don't access SMBus on IBM systems which get corrupted eeproms */
 	if (dmi_check_system(piix4_dmi_table) &&
 			PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL) {
-		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
+		dev_err(&PIIX4_dev->dev, "IBM system detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");
 		return -EPERM;
-- 
1.4.0


