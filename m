From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 30 Oct 2015 14:58:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Introduce separate temperature labels for NCT6792 and NCT6793
Message-Id: <1446217081-22863-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6792 and NCT6793 are mostly register compatible to NCT6791, but
temperature sources are different and difficult to manage with a single
temperature label array. Introduce separate temperature label arrays
for those chips to reflect the differences.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 724401a368f7..d7ebdf8651f5 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -565,6 +565,76 @@ static const u16 NCT6792_REG_TEMP_MON[] = {
 static const u16 NCT6792_REG_BEEP[NUM_REG_BEEP] = {
 	0xb2, 0xb3, 0xb4, 0xb5, 0xbf };
 
+static const char *const nct6792_temp_label[] = {
+	"",
+	"SYSTIN",
+	"CPUTIN",
+	"AUXTIN0",
+	"AUXTIN1",
+	"AUXTIN2",
+	"AUXTIN3",
+	"",
+	"SMBUSMASTER 0",
+	"SMBUSMASTER 1",
+	"SMBUSMASTER 2",
+	"SMBUSMASTER 3",
+	"SMBUSMASTER 4",
+	"SMBUSMASTER 5",
+	"SMBUSMASTER 6",
+	"SMBUSMASTER 7",
+	"PECI Agent 0",
+	"PECI Agent 1",
+	"PCH_CHIP_CPU_MAX_TEMP",
+	"PCH_CHIP_TEMP",
+	"PCH_CPU_TEMP",
+	"PCH_MCH_TEMP",
+	"PCH_DIM0_TEMP",
+	"PCH_DIM1_TEMP",
+	"PCH_DIM2_TEMP",
+	"PCH_DIM3_TEMP",
+	"BYTE_TEMP",
+	"PECI Agent 0 Calibration",
+	"PECI Agent 1 Calibration",
+	"",
+	"",
+	"Virtual_TEMP"
+};
+
+static const char *const nct6793_temp_label[] = {
+	"",
+	"SYSTIN",
+	"CPUTIN",
+	"AUXTIN0",
+	"AUXTIN1",
+	"AUXTIN2",
+	"AUXTIN3",
+	"",
+	"SMBUSMASTER 0",
+	"SMBUSMASTER 1",
+	"",
+	"",
+	"",
+	"",
+	"",
+	"",
+	"PECI Agent 0",
+	"PECI Agent 1",
+	"PCH_CHIP_CPU_MAX_TEMP",
+	"PCH_CHIP_TEMP",
+	"PCH_CPU_TEMP",
+	"PCH_MCH_TEMP",
+	"Agent0 Dimm0 ",
+	"Agent0 Dimm1",
+	"Agent1 Dimm0",
+	"Agent1 Dimm1",
+	"BYTE_TEMP0",
+	"BYTE_TEMP1",
+	"PECI Agent 0 Calibration",
+	"PECI Agent 1 Calibration",
+	"",
+	"Virtual_TEMP"
+};
+
 /* NCT6102D/NCT6106D specific data */
 
 #define NCT6106_REG_VBAT	0x318
@@ -3690,7 +3760,18 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->tolerance_mask = 0x07;
 		data->speed_tolerance_limit = 63;
 
-		data->temp_label = nct6779_temp_label;
+		switch (data->kind) {
+		default:
+		case nct6791:
+			data->temp_label = nct6779_temp_label;
+			break;
+		case nct6792:
+			data->temp_label = nct6792_temp_label;
+			break;
+		case nct6793:
+			data->temp_label = nct6793_temp_label;
+			break;
+		}
 		data->temp_label_num = NCT6791_NUM_LABELS;
 
 		data->REG_CONFIG = NCT6775_REG_CONFIG;
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
