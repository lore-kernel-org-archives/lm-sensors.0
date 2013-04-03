From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 03 Apr 2013 12:18:11 +0000
Subject: [lm-sensors] [PATCH v8 4/5] ab8500: power: export abx500_res_to_temp tables for hwmon
Message-Id: <1364991492-2421-5-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364991492-2421-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364991492-2421-1-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, khali@linux-fr.org, lm-sensors@lm-sensors.org, cbou@mail.ru, dwmw2@infradead.org
Cc: linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@linaro.org>

This patch exports the thermistor resistance-to-temperature tables, so that the
hwmon driver can access them, and also adds the corresponding table size
variables.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 drivers/power/ab8500_bmdata.c | 20 ++++++++++++++------
 include/linux/power/ab8500.h  | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/power/ab8500.h

diff --git a/drivers/power/ab8500_bmdata.c b/drivers/power/ab8500_bmdata.c
index 3cdcdcf..d298645 100644
--- a/drivers/power/ab8500_bmdata.c
+++ b/drivers/power/ab8500_bmdata.c
@@ -11,7 +11,7 @@
  * Note that the res_to_temp table must be strictly sorted by falling resistance
  * values to work.
  */
-static const struct abx500_res_to_temp temp_tbl_a_thermistor[] = {
+const struct abx500_res_to_temp ab8500_temp_tbl_a_thermistor[] = {
 	{-5, 53407},
 	{ 0, 48594},
 	{ 5, 43804},
@@ -28,8 +28,12 @@ static const struct abx500_res_to_temp temp_tbl_a_thermistor[] = {
 	{60, 13437},
 	{65, 12500},
 };
+EXPORT_SYMBOL(ab8500_temp_tbl_a_thermistor);
 
-static const struct abx500_res_to_temp temp_tbl_b_thermistor[] = {
+const int ab8500_temp_tbl_a_size = ARRAY_SIZE(ab8500_temp_tbl_a_thermistor);
+EXPORT_SYMBOL(ab8500_temp_tbl_a_size);
+
+const struct abx500_res_to_temp ab8500_temp_tbl_b_thermistor[] = {
 	{-5, 200000},
 	{ 0, 159024},
 	{ 5, 151921},
@@ -46,6 +50,10 @@ static const struct abx500_res_to_temp temp_tbl_b_thermistor[] = {
 	{60,  85461},
 	{65,  82869},
 };
+EXPORT_SYMBOL(ab8500_temp_tbl_b_thermistor);
+
+const int ab8500_temp_tbl_b_size = ARRAY_SIZE(ab8500_temp_tbl_b_thermistor);
+EXPORT_SYMBOL(ab8500_temp_tbl_b_size);
 
 static const struct abx500_v_to_cap cap_tbl_a_thermistor[] = {
 	{4171,	100},
@@ -230,8 +238,8 @@ static struct abx500_battery_type bat_type_thermistor[] = {
 		.maint_b_chg_timer_h = 200,
 		.low_high_cur_lvl = 300,
 		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl_a_thermistor),
-		.r_to_t_tbl = temp_tbl_a_thermistor,
+		.n_temp_tbl_elements = ARRAY_SIZE(ab8500_temp_tbl_a_thermistor),
+		.r_to_t_tbl = ab8500_temp_tbl_a_thermistor,
 		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl_a_thermistor),
 		.v_to_cap_tbl = cap_tbl_a_thermistor,
 		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
@@ -258,8 +266,8 @@ static struct abx500_battery_type bat_type_thermistor[] = {
 		.maint_b_chg_timer_h = 200,
 		.low_high_cur_lvl = 300,
 		.low_high_vol_lvl = 4000,
-		.n_temp_tbl_elements = ARRAY_SIZE(temp_tbl_b_thermistor),
-		.r_to_t_tbl = temp_tbl_b_thermistor,
+		.n_temp_tbl_elements = ARRAY_SIZE(ab8500_temp_tbl_b_thermistor),
+		.r_to_t_tbl = ab8500_temp_tbl_b_thermistor,
 		.n_v_cap_tbl_elements = ARRAY_SIZE(cap_tbl_b_thermistor),
 		.v_to_cap_tbl = cap_tbl_b_thermistor,
 		.n_batres_tbl_elements = ARRAY_SIZE(temp_to_batres_tbl_thermistor),
diff --git a/include/linux/power/ab8500.h b/include/linux/power/ab8500.h
new file mode 100644
index 0000000..cdbb6c2
--- /dev/null
+++ b/include/linux/power/ab8500.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) ST-Ericsson 2013
+ * Author: Hongbo Zhang <hongbo.zhang@linaro.com>
+ * License terms: GNU General Public License v2
+ */
+
+#ifndef PWR_AB8500_H
+#define PWR_AB8500_H
+
+extern const struct abx500_res_to_temp ab8500_temp_tbl_a_thermistor[];
+extern const int ab8500_temp_tbl_a_size;
+
+extern const struct abx500_res_to_temp ab8500_temp_tbl_b_thermistor[];
+extern const int ab8500_temp_tbl_b_size;
+
+#endif /* PWR_AB8500_H */
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
