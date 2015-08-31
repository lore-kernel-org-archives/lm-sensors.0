From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Aug 2015 23:57:32 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Swap STEP_UP_TIME and STEP_DOWN_TIME registers for most ch
Message-Id: <1441065453-23896-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The STEP_UP_TIME and STEP_DOWN_TIME registers are swapped for all chips but
NCT6775.

Reported-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 0a08f776a5de..b487a55d02c0 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -252,6 +252,7 @@ static const u16 NCT6775_REG_TARGET[] = {
 	0x101, 0x201, 0x301, 0x801, 0x901, 0xa01 };
 static const u16 NCT6775_REG_FAN_MODE[] = {
 	0x102, 0x202, 0x302, 0x802, 0x902, 0xa02 };
+/* STEP_DOWN_TIME and STEP_UP_TIME regs are swapped for all chips but NCT6775 */
 static const u16 NCT6775_REG_FAN_STEP_DOWN_TIME[] = {
 	0x103, 0x203, 0x303, 0x803, 0x903, 0xa03 };
 static const u16 NCT6775_REG_FAN_STEP_UP_TIME[] = {
@@ -3536,8 +3537,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_PULSES = NCT6776_REG_FAN_PULSES;
 		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
 		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
-		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
-		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_UP_TIME;
 		data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
 		data->REG_PWM[0] = NCT6775_REG_PWM;
 		data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
@@ -3608,8 +3609,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_PULSES = NCT6779_REG_FAN_PULSES;
 		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
 		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
-		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
-		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_UP_TIME;
 		data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
 		data->REG_PWM[0] = NCT6775_REG_PWM;
 		data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
@@ -3685,8 +3686,8 @@ static int nct6775_probe(struct platform_device *pdev)
 		data->REG_FAN_PULSES = NCT6779_REG_FAN_PULSES;
 		data->FAN_PULSE_SHIFT = NCT6775_FAN_PULSE_SHIFT;
 		data->REG_FAN_TIME[0] = NCT6775_REG_FAN_STOP_TIME;
-		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_UP_TIME;
-		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_FAN_TIME[1] = NCT6775_REG_FAN_STEP_DOWN_TIME;
+		data->REG_FAN_TIME[2] = NCT6775_REG_FAN_STEP_UP_TIME;
 		data->REG_TOLERANCE_H = NCT6776_REG_TOLERANCE_H;
 		data->REG_PWM[0] = NCT6775_REG_PWM;
 		data->REG_PWM[1] = NCT6775_REG_FAN_START_OUTPUT;
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
