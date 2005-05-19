From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [PATCH 2.6] I2C: Fix amd756 name
Message-Id: <20041016200019.3962f8a4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This sets the proper name for busses supported by the i2c-amd756 driver.
So far, all busses were named AMD756 regardless of the real hardware.
Setting the real name is certainly less confusing for the user, and the
sensors-detect script expects this too.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756.c.orig	2004-10-12 19:44:25.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756.c	2004-10-16 19:53:21.000000000 +0200
@@ -310,6 +310,10 @@
 };
 
 enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111 };
+static const char* chipname[] = {
+	"AMD756", "AMD766", "AMD768",
+	"nVidia nForce", "AMD8111",
+};
 
 static struct pci_device_id amd756_ids[] = {
 	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
@@ -372,8 +376,8 @@
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
 
-	snprintf(amd756_adapter.name, I2C_NAME_SIZE,
-		"SMBus AMD756 adapter at %04x", amd756_ioport);
+	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
+		chipname[id->driver_data], amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_adapter);
 	if (error) {


-- 
Jean Delvare
http://khali.linux-fr.org/
