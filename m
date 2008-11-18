From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Tue, 18 Nov 2008 08:46:46 +0000
Subject: [lm-sensors] [PATCH 2/2] k8temp: minor fixes for CPU families 0x10
Message-Id: <20081118084646.GE12095@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 - correct address for "Reported Temperature Control Register"
 - correct Tctl_max for family 0x11

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index a949a86..fa30f8b 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -37,7 +37,7 @@
 #define FAM_10_TEMP_FROM_REG(val)	(((val) >> 21) * 125)
 
 #define FAM_F_REG_TEMP	0xe4
-#define FAM_10_REG_TEMP	0xa5
+#define FAM_10_REG_TEMP	0xa4
 
 #define REG_CPUID	0xfc
 /* real bitpos */
@@ -196,9 +196,15 @@ static int __devinit setup_fam_10(struct pci_dev *pdev, struct k8temp_data *data
 {
 	/* we need max temp */
 	data->sensorsp = SEL_TEMPMAX;
-	data->tcontrol_max = 70000;
 
-	data->name = (data->fam  = 0x11) ? "fam11temp" : "fam10temp";
+	if (data->fam = 0x10) {
+		data->name = "fam10temp";
+		data->tcontrol_max = 70000;
+	} else if (data->fam = 0x11) {
+		data->name = "fam11temp";
+		data->tcontrol_max = 100000;
+	} else
+		BUG();
 
 	return 0;
 }
-- 
1.6.0.3





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
