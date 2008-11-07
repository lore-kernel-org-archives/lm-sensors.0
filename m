From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 07 Nov 2008 18:56:31 +0000
Subject: [lm-sensors] [PATCH 2/5] i5k_amb: Load automatically on all
Message-Id: <20081107185631.13022.59600.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


It turns out that we cannot create a pci_driver in this driver because PCI will
not call this module's probe function if the i5000-edac driver is already
loaded.  That said, we only want one value (AMBASE) from the PCI config space.
Neither driver alters this value, so it's safe to read it.  However, we still
want the module aliases, so provide that.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/i5k_amb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 2ede938..a3fa639 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -490,6 +490,14 @@ static unsigned long chipset_ids[] = {
 	0
 };
 
+static struct pci_device_id i5k_amb_ids[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, i5k_amb_ids);
+
 static int __devinit i5k_amb_probe(struct platform_device *pdev)
 {
 	struct i5k_amb_data *data;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
