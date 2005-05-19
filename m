From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH] I2C update for 2.6.9
Message-Id: <1098231506201@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10982315063820@kroah.com>
References: <10982315042830@kroah.com>
In-Reply-To: <10982315042830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2074, 2004/10/19 15:21:48-07:00, khali@linux-fr.org

[PATCH] I2C: Fix amd756 name

This sets the proper name for busses supported by the i2c-amd756 driver.
So far, all busses were named AMD756 regardless of the real hardware.
Setting the real name is certainly less confusing for the user, and the
sensors-detect script expects this too.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-amd756.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:53:48 -07:00
+++ b/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:53:48 -07:00
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

