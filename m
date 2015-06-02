From: Chris Lesiak <chris.lesiak@licor.com>
Date: Tue, 02 Jun 2015 18:48:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: ntc: improve precision of resistance calculation
Message-Id: <1433270907-24933-1-git-send-email-chris.lesiak@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The function get_ohm_of_thermistor has both the measured voltage and the
pullup voltage available in microvolts.  But it was promptly converting
both to millivolts before using them to calculate the thermistor
resistance.  That conversion unnecessarily hurt the precision of the
calculation.

For example, take the ncpXXwb473 connected to 5000 mV and pulled down
through a 47000 ohm resistor.  At 25 C, the resistance of the thermistor
is 47000 ohms.  The measured voltage will be 2500 mV.  If we measure
instead 2501 mV, then the calculated resistance will be 46962 ohms --
a difference of 38 ohms.  So the precision of the resistance estimate
could be increased by 38X by doing the calculations in microvolts.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/hwmon/ntc_thermistor.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index e08ed47..e112814 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -310,30 +310,27 @@ static inline u64 div64_u64_safe(u64 dividend, u64 divisor)
 static int get_ohm_of_thermistor(struct ntc_data *data, unsigned int uv)
 {
 	struct ntc_thermistor_platform_data *pdata = data->pdata;
-	u64 mv = uv / 1000;
-	u64 pmv = pdata->pullup_uv / 1000;
+	u32 puv = pdata->pullup_uv;
 	u64 n, puo, pdo;
 	puo = pdata->pullup_ohm;
 	pdo = pdata->pulldown_ohm;
 
-	if (mv = 0) {
-		if (pdata->connect = NTC_CONNECTED_POSITIVE)
-			return INT_MAX;
-		return 0;
-	}
-	if (mv >= pmv)
+	if (uv <= 0)
+		return (pdata->connect = NTC_CONNECTED_POSITIVE) ?
+			INT_MAX : 0;
+	if (uv >= puv)
 		return (pdata->connect = NTC_CONNECTED_POSITIVE) ?
 			0 : INT_MAX;
 
 	if (pdata->connect = NTC_CONNECTED_POSITIVE && puo = 0)
-		n = div64_u64_safe(pdo * (pmv - mv), mv);
+		n = div_u64(pdo * (puv - uv), uv);
 	else if (pdata->connect = NTC_CONNECTED_GROUND && pdo = 0)
-		n = div64_u64_safe(puo * mv, pmv - mv);
+		n = div_u64(puo * uv, puv - uv);
 	else if (pdata->connect = NTC_CONNECTED_POSITIVE)
-		n = div64_u64_safe(pdo * puo * (pmv - mv),
-				puo * mv - pdo * (pmv - mv));
+		n = div64_u64_safe(pdo * puo * (puv - uv),
+				puo * uv - pdo * (puv - uv));
 	else
-		n = div64_u64_safe(pdo * puo * mv, pdo * (pmv - mv) - puo * mv);
+		n = div64_u64_safe(pdo * puo * uv, pdo * (puv - uv) - puo * uv);
 
 	if (n > INT_MAX)
 		n = INT_MAX;
-- 
1.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
