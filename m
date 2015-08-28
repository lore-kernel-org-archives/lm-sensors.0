From: Christian Fetzer <fetzer.ch@gmail.com>
Date: Fri, 28 Aug 2015 08:31:25 +0000
Subject: [lm-sensors] [PATCH 4/4] i2c-piix4: Add adapter port name support for SB800 chipset
Message-Id: <1440750685-19172-5-git-send-email-fetzer.ch@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for port names for the SB800 chipset.
Since the chipset supports a multiplexed main SMBus controller, adding
the channel name to the adapter name is necessary to differentiate the
ports better (for example in sensors output).

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index e344abd..366878e 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -131,6 +131,10 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 
 /* SB800 globals */
 DEFINE_MUTEX(piix4_mutex_sb800);
+static const char *piix4_main_port_names_sb800[4] = {
+	"SDA0", "SDA2", "SDA3", "SDA4"
+};
+static const char *piix4_aux_port_name_sb800 = "SDA1";
 
 struct i2c_piix4_adapdata {
 	unsigned short smba;
@@ -626,7 +630,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     struct i2c_adapter **padap)
+			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
 	struct i2c_piix4_adapdata *adapdata;
@@ -655,7 +659,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	adap->dev.parent = &dev->dev;
 
 	snprintf(adap->name, sizeof(adap->name),
-		"SMBus PIIX4 adapter at %04x", smba);
+		"SMBus PIIX4 adapter %s at %04x", name, smba);
 
 	i2c_set_adapdata(adap, adapdata);
 
@@ -679,7 +683,9 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
 	struct i2c_piix4_adapdata *adapdata;
 
 	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
-		retval = piix4_add_adapter(dev, smba, &piix4_main_adapters[port]);
+		retval = piix4_add_adapter(dev, smba,
+					   piix4_main_port_names_sb800[port],
+					   &piix4_main_adapters[port]);
 		if (retval < 0)
 			goto ERROR;
 
@@ -729,7 +735,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, &piix4_main_adapters[0]);
+		retval = piix4_add_adapter(dev, retval, "",
+					   &piix4_main_adapters[0]);
 	}
 
 	/* If no main SMBus found, give up */
@@ -757,7 +764,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, &piix4_aux_adapter);
+		piix4_add_adapter(dev, retval, piix4_aux_port_name_sb800,
+				  &piix4_aux_adapter);
 	}
 
 	return 0;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
