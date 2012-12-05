From: Boris Ostrovsky <boris.ostrovsky@amd.com>
Date: Wed, 05 Dec 2012 11:12:42 +0000
Subject: [lm-sensors] [PATCH v2] x86, AMD: Power driver support for AMD's family 16h processors
Message-Id: <1354705962-5603-1-git-send-email-boris.ostrovsky@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herrmann.der.user@googlemail.com, khali@linux-fr.org, linux@roeck-us.net, bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, boris.ostrovsky@amd.com

Add family 16h PCI ID to AMD's power driver to allow it report
power consumption on these processors.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@amd.com>
---
 drivers/hwmon/fam15h_power.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 4f41104..34ab2a8 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -31,6 +31,9 @@ MODULE_DESCRIPTION("AMD Family 15h CPU processor power monitor");
 MODULE_AUTHOR("Andreas Herrmann <herrmann.der.user@googlemail.com>");
 MODULE_LICENSE("GPL");
 
+/* Family 16h Northbridge's function 4 PCI ID */
+#define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
+
 /* D18F3 */
 #define REG_NORTHBRIDGE_CAP		0xe8
 
@@ -248,6 +251,7 @@ static void __devexit fam15h_power_remove(struct pci_dev *pdev)
 
 static DEFINE_PCI_DEVICE_TABLE(fam15h_power_id_table) = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_NB_F4) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, fam15h_power_id_table);
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
