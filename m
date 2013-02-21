From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 21 Feb 2013 10:32:39 +0000
Subject: [lm-sensors] [PATCH v3 1/3] ab8500_btemp: make get_temp interface public
Message-Id: <1361442761-2690-2-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make ab8500_btemp_get_temp() public, so that ab8500 hwmon driver can use it.

Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
---
 drivers/power/ab8500_btemp.c         | 2 +-
 include/linux/mfd/abx500/ab8500-bm.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 20e2a7d..e0e55e8 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -727,7 +727,7 @@ static void ab8500_btemp_periodic(struct ab8500_btemp *di,
  *
  * Returns battery temperature
  */
-static int ab8500_btemp_get_temp(struct ab8500_btemp *di)
+int ab8500_btemp_get_temp(struct ab8500_btemp *di)
 {
 	int temp = 0;
 
diff --git a/include/linux/mfd/abx500/ab8500-bm.h b/include/linux/mfd/abx500/ab8500-bm.h
index 44310c9..4dd79f6 100644
--- a/include/linux/mfd/abx500/ab8500-bm.h
+++ b/include/linux/mfd/abx500/ab8500-bm.h
@@ -427,6 +427,7 @@ void ab8500_fg_reinit(void);
 void ab8500_charger_usb_state_changed(u8 bm_usb_state, u16 mA);
 struct ab8500_btemp *ab8500_btemp_get(void);
 int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp);
+int ab8500_btemp_get_temp(struct ab8500_btemp *btemp);
 struct ab8500_fg *ab8500_fg_get(void);
 int ab8500_fg_inst_curr_blocking(struct ab8500_fg *dev);
 int ab8500_fg_inst_curr_start(struct ab8500_fg *di);
@@ -451,6 +452,10 @@ static int ab8500_btemp_get_batctrl_temp(struct ab8500_btemp *btemp)
 {
 	return 0;
 }
+static int ab8500_btemp_get_temp(struct ab8500_btemp *btemp)
+{
+	return 0;
+}
 struct ab8500_fg *ab8500_fg_get(void)
 {
 	return NULL;
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
