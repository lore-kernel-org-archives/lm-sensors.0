From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:41:03 +0000
Subject: [lm-sensors] [PATCH 13/14] k8temp: Enable automatic loading
Message-Id: <20060828144103.3e14d4b2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-k8temp-autoload.patch

Let the k8temp driver load automatically.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Rudolf Marek <r.marek at sh.cvut.cz>
---
 drivers/hwmon/k8temp.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.18-rc4.orig/drivers/hwmon/k8temp.c	2006-08-23 22:31:09.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/k8temp.c	2006-08-23 22:33:21.000000000 +0200
@@ -133,6 +133,8 @@
 	{ 0 },
 };
 
+MODULE_DEVICE_TABLE(pci, k8temp_ids);
+
 static int __devinit k8temp_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {

-- 
Jean Delvare

