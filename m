From: Andre Przywara <andre.przywara@amd.com>
Date: Sat, 07 Apr 2012 23:07:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: fam15h_power: fix bogus values with current BIOSes
Message-Id: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Newer BKDG[1] versions recommend a different initialization value for
the running average range register in the northbridge. This improves
the power reading by avoiding counter saturations resulting in bogus
values for anything below about 80% of TDP power consumption.
Updated BIOSes will have this new value set up from the beginning,
but meanwhile we correct this value ourselves.
This needs to be done on all northbridges, even on those where the
driver itself does not register at.

This fixes the driver on all current machines to provide proper
values for idle load.

[1]
http://support.amd.com/us/Processor_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf
Chapter 3.8: D18F5xE0 Processor TDP Running Average (p. 452)

Signed-off-by: Andre Przywara <andre.przywara@amd.com>
---
 drivers/hwmon/fam15h_power.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index b7494af..2aa7d9d 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -122,6 +122,39 @@ static bool __devinit fam15h_power_is_internal_node0(struct pci_dev *f4)
 	return true;
 }
 
+/*
+ * Newer BKDG versions have an updated recommendation on how to properly
+ * initialize the running average range (was: 0xE, now: 0x9). This avoids
+ * counter saturations resulting in bogus power readings.
+ * We correct this value ourselves to cope with older BIOSes.
+ */
+static int tweak_runavg_range(struct pci_dev *pdev)
+{
+	u32 val;
+	struct pci_device_id affected_device = {
+		PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) };
+
+	/*
+	 * let this quirk apply only to the current version of the
+	 * northbridge, since future versions may change the behavior
+	 */
+	if (!pci_match_id(&affected_device, pdev))
+		return 0;
+
+	pci_bus_read_config_dword(pdev->bus,
+		PCI_DEVFN(PCI_SLOT(pdev->devfn), 5),
+		REG_TDP_RUNNING_AVERAGE, &val);
+	if ((val & 0xf) != 0xe)
+		return 0;
+
+	val &= ~0x0f;
+	val |= 9;
+	pci_bus_write_config_dword(pdev->bus,
+		PCI_DEVFN(PCI_SLOT(pdev->devfn), 5),
+		REG_TDP_RUNNING_AVERAGE, val);
+	return 1;
+}
+
 static void __devinit fam15h_power_init_data(struct pci_dev *f4,
 					     struct fam15h_power_data *data)
 {
@@ -155,6 +188,13 @@ static int __devinit fam15h_power_probe(struct pci_dev *pdev,
 	struct device *dev;
 	int err;
 
+	/*
+	 * though we ignore every other northbridge, we still have to
+	 * do the tweaking on _each_ node in MCM processors as the counters
+	 * are working hand-in-hand
+	 */
+	tweak_runavg_range(pdev);
+
 	if (!fam15h_power_is_internal_node0(pdev)) {
 		err = -ENODEV;
 		goto exit;
-- 
1.7.4.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
