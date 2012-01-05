From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Thu, 05 Jan 2012 18:50:17 +0000
Subject: [lm-sensors] [PATCH 3/4] drivers/hwmon: use DEFINE_PCI_DEVICE_TABLE
Message-Id: <1325789418-11276-3-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fix all checkpatch warnings about DEFINE_PCI_DEVICE_TABLE

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/k10temp.c |    2 +-
 drivers/hwmon/k8temp.c  |    2 +-
 drivers/hwmon/sis5595.c |    2 +-
 drivers/hwmon/via686a.c |    2 +-
 drivers/hwmon/vt8231.c  |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 41aa6a3..aba29d6 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -205,7 +205,7 @@ static void __devexit k10temp_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
-static const struct pci_device_id k10temp_id_table[] = {
+static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index b923bc2..d985ae3 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -136,7 +136,7 @@ static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static const struct pci_device_id k8temp_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(k8temp_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ 0 },
 };
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 47d7ce9..3324245 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -699,7 +699,7 @@ static struct sis5595_data *sis5595_update_device(struct device *dev)
 	return data;
 }
 
-static const struct pci_device_id sis5595_pci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(sis5595_pci_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ 0, }
 };
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index 25e9166..1424f0a 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -777,7 +777,7 @@ static struct via686a_data *via686a_update_device(struct device *dev)
 	return data;
 }
 
-static const struct pci_device_id via686a_pci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(via686a_pci_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
 	{ 0, }
 };
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index db3b2e8..11d6a39 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -699,7 +699,7 @@ static struct platform_driver vt8231_driver = {
 	.remove	= __devexit_p(vt8231_remove),
 };
 
-static const struct pci_device_id vt8231_pci_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(vt8231_pci_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4) },
 	{ 0, }
 };
-- 
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
