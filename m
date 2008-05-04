From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 04 May 2008 16:30:48 +0000
Subject: [lm-sensors] [PATCH] i2c-piix4: Blacklist two mainboards
Message-Id: <20080504183048.177fc0b4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We had a report that running sensors-detect on a Sapphire AM2RD790
motherbord killed the CPU. While the exact cause is still unknown,
I'd rather play it safe and prevent any access to the SMBus on that
machine by not letting the i2c-piix4 driver attach to the SMBus host
device on that machine. Also blacklist a similar board made by DFI.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Previous version was broken, sorry.

 drivers/i2c/busses/i2c-piix4.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

--- linux-2.6.25.orig/drivers/i2c/busses/i2c-piix4.c	2008-04-19 11:11:56.000000000 +0200
+++ linux-2.6.25/drivers/i2c/busses/i2c-piix4.c	2008-05-04 09:56:00.000000000 +0200
@@ -108,7 +108,27 @@ static unsigned short piix4_smba;
 static struct pci_driver piix4_driver;
 static struct i2c_adapter piix4_adapter;
 
-static struct dmi_system_id __devinitdata piix4_dmi_table[] = {
+static struct dmi_system_id __devinitdata piix4_dmi_blacklist[] = {
+	{
+		.ident = "Sapphire AM2RD790",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "SAPPHIRE Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "PC-AM2RD790"),
+		},
+	},
+	{
+		.ident = "DFI Lanparty UT 790FX",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "DFI Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "LP UT 790FX"),
+		},
+	},
+	{ }
+};
+
+/* The IBM entry is in a separate table because we only check it
+   on Intel-based systems */
+static struct dmi_system_id __devinitdata piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
 		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
@@ -123,8 +143,16 @@ static int __devinit piix4_setup(struct 
 
 	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
 
+	/* On some motherboards, it was reported that accessing the SMBus
+	   caused severe hardware problems */
+	if (dmi_check_system(piix4_dmi_blacklist)) {
+		dev_err(&PIIX4_dev->dev,
+			"Accessing the SMBus on this system is unsafe!\n");
+		return -EPERM;
+	}
+
 	/* Don't access SMBus on IBM systems which get corrupted eeproms */
-	if (dmi_check_system(piix4_dmi_table) &&
+	if (dmi_check_system(piix4_dmi_ibm) &&
 			PIIX4_dev->vendor = PCI_VENDOR_ID_INTEL) {
 		dev_err(&PIIX4_dev->dev, "IBM system detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
