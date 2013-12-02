From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 02 Dec 2013 23:10:29 +0000
Subject: [lm-sensors] [PATCH 10/39] hwmon: remove DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <001f01ceefb3$b1968820$14c39860$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
In-Reply-To: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Jean Delvare' <khali@linux-fr.org>, 'Guenter Roeck' <linux@roeck-us.net>, lm-sensors@lm-sensors.org

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is not preferred.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/fam15h_power.c |    2 +-
 drivers/hwmon/k10temp.c      |    2 +-
 drivers/hwmon/k8temp.c       |    2 +-
 drivers/hwmon/sis5595.c      |    2 +-
 drivers/hwmon/via686a.c      |    2 +-
 drivers/hwmon/vt8231.c       |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index dff8410..6040121 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -249,7 +249,7 @@ static void fam15h_power_remove(struct pci_dev *pdev)
 	sysfs_remove_group(&dev->kobj, &fam15h_power_attr_group);
 }
 
-static DEFINE_PCI_DEVICE_TABLE(fam15h_power_id_table) = {
+static const struct pci_device_id fam15h_power_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
 	{}
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index d65f3fd..e375e9f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -204,7 +204,7 @@ static void k10temp_remove(struct pci_dev *pdev)
 			   &sensor_dev_attr_temp1_crit_hyst.dev_attr);
 }
 
-static DEFINE_PCI_DEVICE_TABLE(k10temp_id_table) = {
+static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_10H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_11H_NB_MISC) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 5b50e9e..734d55d 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -135,7 +135,7 @@ static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static DEFINE_PCI_DEVICE_TABLE(k8temp_ids) = {
+static const struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
 	{ 0 },
 };
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 1404e63..05565d2d 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -752,7 +752,7 @@ static struct sis5595_data *sis5595_update_device(struct device *dev)
 	return data;
 }
 
-static DEFINE_PCI_DEVICE_TABLE(sis5595_pci_ids) = {
+static const struct pci_device_id sis5595_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_503) },
 	{ 0, }
 };
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index c9dcce8..babd732 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -824,7 +824,7 @@ static struct via686a_data *via686a_update_device(struct device *dev)
 	return data;
 }
 
-static DEFINE_PCI_DEVICE_TABLE(via686a_pci_ids) = {
+static const struct pci_device_id via686a_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
 	{ }
 };
diff --git a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
index 0e70178..48025b7 100644
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -766,7 +766,7 @@ static struct platform_driver vt8231_driver = {
 	.remove	= vt8231_remove,
 };
 
-static DEFINE_PCI_DEVICE_TABLE(vt8231_pci_ids) = {
+static const struct pci_device_id vt8231_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4) },
 	{ 0, }
 };
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
