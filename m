From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Wed, 19 Sep 2012 10:45:53 +0000
Subject: [lm-sensors] [PATCH] hwmon, fam15h_power: Tweak runavg_range on resume
Message-Id: <20120919104553.GF4663@alberich>
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
 drivers/hwmon/fam15h_power.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 2764b78..635653f 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -48,6 +48,7 @@ struct fam15h_power_data {
 	unsigned int processor_pwr_watts;
 };
 
+
 static ssize_t show_power(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
@@ -158,6 +159,17 @@ static void __devinit tweak_runavg_range(struct pci_dev *pdev)
 		REG_TDP_RUNNING_AVERAGE, val);
 }
 
+#ifdef CONFIG_PM
+static int fam15h_power_resume(struct pci_dev *pdev)
+{
+	tweak_runavg_range(pdev);
+	return 0;
+}
+#define FAM15H_POWER_RESUME (fam15h_power_resume)
+#else
+#define FAM15H_POWER_RESUME NULL
+#endif
+
 static void __devinit fam15h_power_init_data(struct pci_dev *f4,
 					     struct fam15h_power_data *data)
 {
@@ -256,6 +268,7 @@ static struct pci_driver fam15h_power_driver = {
 	.id_table = fam15h_power_id_table,
 	.probe = fam15h_power_probe,
 	.remove = __devexit_p(fam15h_power_remove),
+	.resume = FAM15H_POWER_RESUME,
 };
 
 module_pci_driver(fam15h_power_driver);
-- 
1.7.8.6



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
