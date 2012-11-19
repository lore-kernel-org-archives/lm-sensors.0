From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:24:37 +0000
Subject: [lm-sensors] [PATCH 328/493] hwmon: remove use of __devinitdata
Message-Id: <1353349642-3677-328-git-send-email-wfp5p@virginia.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jean Delvare <khali@linux-fr.org> 
Cc: Guenter Roeck <linux@roeck-us.net> 
Cc: lm-sensors@lm-sensors.org 
---
 drivers/hwmon/gpio-fan.c | 2 +-
 drivers/hwmon/i5k_amb.c  | 4 ++--
 drivers/hwmon/sis5595.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index e52856b..0f46cca 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -499,7 +499,7 @@ static int gpio_fan_get_of_pdata(struct device *dev,
 	return 0;
 }
 
-static struct of_device_id of_gpio_fan_match[] __devinitdata = {
+static struct of_device_id of_gpio_fan_match[] = {
 	{ .compatible = "gpio-fan", },
 	{},
 };
diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 0d0faf0..f3bc723 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -488,14 +488,14 @@ out:
 static struct {
 	unsigned long err;
 	unsigned long fbd0;
-} chipset_ids[] __devinitdata  = {
+} chipset_ids[]  = {
 	{ PCI_DEVICE_ID_INTEL_5000_ERR, PCI_DEVICE_ID_INTEL_5000_FBD0 },
 	{ PCI_DEVICE_ID_INTEL_5400_ERR, PCI_DEVICE_ID_INTEL_5400_FBD0 },
 	{ 0, 0 }
 };
 
 #ifdef MODULE
-static struct pci_device_id i5k_amb_ids[] __devinitdata = {
+static struct pci_device_id i5k_amb_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
 	{ 0, }
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 5adc829..e84836b 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -758,7 +758,7 @@ static DEFINE_PCI_DEVICE_TABLE(sis5595_pci_ids) = {
 
 MODULE_DEVICE_TABLE(pci, sis5595_pci_ids);
 
-static int blacklist[] __devinitdata = {
+static int blacklist[] = {
 	PCI_DEVICE_ID_SI_540,
 	PCI_DEVICE_ID_SI_550,
 	PCI_DEVICE_ID_SI_630,
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
