From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Thu, 20 Sep 2012 10:34:08 +0000
Subject: [lm-sensors] [PATCH v2] hwmon, fam15h_power: Tweak runavg_range on resume
Message-Id: <20120920103408.GD4602@alberich>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


The quirk introduced with commit
00250ec90963b7ef6678438888f3244985ecde14 (hwmon: fam15h_power: fix
bogus values with current BIOSes) is not only required during driver
load but also when system resumes from suspend. The BIOS might set the
previously recommended (but unsuitable) initilization value for the
running average range register during resume.

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/fam15h_power.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Hi Jean,

Thanks for spotting the issues.
Here's a new patch version, esp. to fix the section mismatch.

Please apply.


Thanks,

Andreas

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 2764b78a784b..af69073b3fe8 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -129,12 +129,12 @@ static bool __devinit fam15h_power_is_internal_node0(struct pci_dev *f4)
  * counter saturations resulting in bogus power readings.
  * We correct this value ourselves to cope with older BIOSes.
  */
-static DEFINE_PCI_DEVICE_TABLE(affected_device) = {
+static const struct pci_device_id affected_device[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
 	{ 0 }
 };
 
-static void __devinit tweak_runavg_range(struct pci_dev *pdev)
+static void tweak_runavg_range(struct pci_dev *pdev)
 {
 	u32 val;
 
@@ -158,6 +158,16 @@ static void __devinit tweak_runavg_range(struct pci_dev *pdev)
 		REG_TDP_RUNNING_AVERAGE, val);
 }
 
+#ifdef CONFIG_PM
+static int fam15h_power_resume(struct pci_dev *pdev)
+{
+	tweak_runavg_range(pdev);
+	return 0;
+}
+#else
+#define fam15h_power_resume NULL
+#endif
+
 static void __devinit fam15h_power_init_data(struct pci_dev *f4,
 					     struct fam15h_power_data *data)
 {
@@ -256,6 +266,7 @@ static struct pci_driver fam15h_power_driver = {
 	.id_table = fam15h_power_id_table,
 	.probe = fam15h_power_probe,
 	.remove = __devexit_p(fam15h_power_remove),
+	.resume = fam15h_power_resume,
 };
 
 module_pci_driver(fam15h_power_driver);
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
