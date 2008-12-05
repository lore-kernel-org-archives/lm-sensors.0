From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 05 Dec 2008 17:52:33 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (k8temp) warn about erratum #141
Message-Id: <20081205175233.GD5581@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 894a929..102f3ad 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -167,15 +167,14 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 			goto exit;
 		}
 
-		dev_warn(&pdev->dev, "Temperature readouts might be wrong"
-			 " - check erratum #141\n");
-
-		/*
-		 * AMD NPT familys 0fh, i.e. RevF and RevG:
-		 * meaning of SEL_CORE bit is inverted
-		 */
-		if (model >= 0x40)
+		/* AMD NPT familys 0fh, i.e. RevF and RevG */
+		if (model >= 0x40) {
+			/* meaning of SEL_CORE bit is inverted */
 			data->swap_core_select = 1;
+			dev_warn(&pdev->dev, "Temperature readouts might be "
+				 "wrong - check erratum #141\n");
+		}
+
 
 		break;
 	}
-- 
1.6.0.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
