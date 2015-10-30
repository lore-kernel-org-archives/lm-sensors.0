From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Oct 2015 14:36:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) NCT6791D and NCT6792D have an additional temperature source
Message-Id: <1446215802-15097-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Both NCT6791D and NCT6792D permit selection of a 'virtual' temperature
register as temperature source. The virtual temperature registers are
registers 0xea to 0xef in bank 0 and can be written by software.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 8b4fa55e46c6..724401a368f7 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -515,16 +515,24 @@ static const char *const nct6779_temp_label[] = {
 	"PCH_DIM1_TEMP",
 	"PCH_DIM2_TEMP",
 	"PCH_DIM3_TEMP",
-	"BYTE_TEMP"
+	"BYTE_TEMP",
+	"",
+	"",
+	"",
+	"",
+	"Virtual_TEMP"
 };
 
-static const u16 NCT6779_REG_TEMP_ALTERNATE[ARRAY_SIZE(nct6779_temp_label) - 1]
+#define NCT6779_NUM_LABELS	(ARRAY_SIZE(nct6779_temp_label) - 5)
+#define NCT6791_NUM_LABELS	ARRAY_SIZE(nct6779_temp_label)
+
+static const u16 NCT6779_REG_TEMP_ALTERNATE[NCT6791_NUM_LABELS - 1]
 	= { 0x490, 0x491, 0x492, 0x493, 0x494, 0x495, 0, 0,
 	    0, 0, 0, 0, 0, 0, 0, 0,
 	    0, 0x400, 0x401, 0x402, 0x404, 0x405, 0x406, 0x407,
 	    0x408, 0 };
 
-static const u16 NCT6779_REG_TEMP_CRIT[ARRAY_SIZE(nct6779_temp_label) - 1]
+static const u16 NCT6779_REG_TEMP_CRIT[NCT6791_NUM_LABELS - 1]
 	= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x709, 0x70a };
 
 /* NCT6791 specific data */
@@ -3605,7 +3613,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->speed_tolerance_limit = 63;
 
 		data->temp_label = nct6779_temp_label;
-		data->temp_label_num = ARRAY_SIZE(nct6779_temp_label);
+		data->temp_label_num = NCT6779_NUM_LABELS;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
@@ -3683,7 +3691,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->speed_tolerance_limit = 63;
 
 		data->temp_label = nct6779_temp_label;
-		data->temp_label_num = ARRAY_SIZE(nct6779_temp_label);
+		data->temp_label_num = NCT6791_NUM_LABELS;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
 		data->REG_VBAT = NCT6775_REG_VBAT;
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
