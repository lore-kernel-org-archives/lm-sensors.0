From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 18:16:59 +0000
Subject: [lm-sensors] [PATCH] i2c-piix4: Blacklist the Sapphire AM2RD790
Message-Id: <20080503201659.2ab17cbc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
	<20080503091831.30cef838@hyperion.delvare>
	<1209828454.4289.1.camel@debian-9850.ag-home.muc>
	<20080503182701.58a0c146@hyperion.delvare>
In-Reply-To: <20080503182701.58a0c146-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: achim <achim-888L293l2dDzs492ZWNkEA@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>

On Sat, 3 May 2008 18:27:01 +0200, Jean Delvare wrote:
> The good news is that the motherboard DMI data is present:
> 
> Base Board Information
> 	Manufacturer: SAPPHIRE Inc.
> 	Product Name: PC-AM2RD790
> 
> So we can blacklist it from i2c-piix4. I'll prepare a patch later today.
> 

Here you go. Would you have the possibility to test the patch below?
You'll have to rebuild your kernel (or at least the i2c-piix4 driver)
with this patch applied, then try loading the i2c-piix4 driver, you
should see an error message in the logs and no i2c bus created.

* * * * *

We had a report that running sensors-detect on a Sapphire AM2RD790
motherbord killed the CPU. While the exact cause is still unknown,
I'd rather play it safe and prevent any access to the SMBus on that
machine by not letting the i2c-piix4 driver attach to the SMBus host
device on that machine.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/i2c-piix4.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- linux-2.6.25.orig/drivers/i2c/busses/i2c-piix4.c	2008-04-19 11:11:56.000000000 +0200
+++ linux-2.6.25/drivers/i2c/busses/i2c-piix4.c	2008-05-03 19:32:46.000000000 +0200
@@ -108,7 +108,20 @@ static unsigned short piix4_smba;
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
+	{ }
+};
+
+/* The IBM entry is in a separate table because we only check it
+   on Intel-based systems */
+static struct dmi_system_id __devinitdata piix4_dmi_ibm[] = {
 	{
 		.ident = "IBM",
 		.matches = { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
@@ -123,8 +136,16 @@ static int __devinit piix4_setup(struct 
 
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
