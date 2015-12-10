From: Huang Rui <ray.huang@amd.com>
Date: Thu, 10 Dec 2015 03:56:10 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (fam15h_power) Add support for AMD new 15h processors
Message-Id: <1449719771-12837-2-git-send-email-ray.huang@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1449719771-12837-1-git-send-email-ray.huang@amd.com>
In-Reply-To: <1449719771-12837-1-git-send-email-ray.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, Andreas Herrmann <herrmann.der.user@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>

AMD Family 15h Models 70h-7fh processors also support TDP power
reporting interface.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/hwmon/fam15h_power.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 5f7067d..f77eb97 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -47,6 +47,8 @@ MODULE_LICENSE("GPL");
 
 #define MSR_F15H_CU_MAX_PWR_ACCUMULATOR	0xc001007b
 
+#define PCI_DEVICE_ID_AMD_15H_M70H_NB_F4 0x15b4
+
 struct fam15h_power_data {
 	struct pci_dev *pdev;
 	unsigned int tdp_to_watts;
@@ -124,7 +126,7 @@ static int fam15h_power_init_attrs(struct pci_dev *pdev,
 
 	if (c->x86 = 0x15 &&
 	    (c->x86_model <= 0xf ||
-	     (c->x86_model >= 0x60 && c->x86_model <= 0x6f)))
+	     (c->x86_model >= 0x60 && c->x86_model <= 0x7f)))
 		n += 1;
 
 	fam15h_power_attrs = devm_kcalloc(&pdev->dev, n,
@@ -138,7 +140,7 @@ static int fam15h_power_init_attrs(struct pci_dev *pdev,
 	fam15h_power_attrs[n++] = &dev_attr_power1_crit.attr;
 	if (c->x86 = 0x15 &&
 	    (c->x86_model <= 0xf ||
-	     (c->x86_model >= 0x60 && c->x86_model <= 0x6f)))
+	     (c->x86_model >= 0x60 && c->x86_model <= 0x7f)))
 		fam15h_power_attrs[n++] = &dev_attr_power1_input.attr;
 
 	data->group.attrs = fam15h_power_attrs;
@@ -296,6 +298,7 @@ static const struct pci_device_id fam15h_power_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M30H_NB_F4) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M60H_NB_F4) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_M70H_NB_F4) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
 	{}
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
