From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Date: Tue, 30 Mar 2010 14:00:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: sht15: Fix sht15_calc_temp
Message-Id: <1269957630-25005-1-git-send-email-jerome.oufella@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
In-Reply-To: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I discovered two issues.
First the previous sht15_calc_temp() loop did not iterate through the
temppoints array since the (data->supply_uV > temppoints[i - 1].vdd)
test is always true in this direction.

Also the two-points linear interpolation function was returning biased
values, making the temperature reading inaccurate by a non neglectable
factor. This is adressed using a a proportional factor based linear
interpolation.

Signed-off-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>
---

 drivers/hwmon/sht15.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 864a371..a6ad93b 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -303,15 +303,15 @@ error_ret:
 static inline int sht15_calc_temp(struct sht15_data *data)
 {
 	int d1 = 0;
-	int i;
+	int i, t;
 
-	for (i = 1; i < ARRAY_SIZE(temppoints); i++)
+	for (i = ARRAY_SIZE(temppoints) - 1; i > 0; i--)
 		/* Find pointer to interpolate */
-		if (data->supply_uV > temppoints[i - 1].vdd) {
-			d1 = (data->supply_uV/1000 - temppoints[i - 1].vdd)
-				* (temppoints[i].d1 - temppoints[i - 1].d1)
-				/ (temppoints[i].vdd - temppoints[i - 1].vdd)
-				+ temppoints[i - 1].d1;
+		if (data->supply_uV >= temppoints[i - 1].vdd) {
+			t = (data->supply_uV - temppoints[i-1].vdd) / 
+				((temppoints[i].vdd - temppoints[i-1].vdd) / 10000);
+
+			d1 = (temppoints[i].d1 * t + (10000 - t) * temppoints[i-1].d1) / 10000;
 			break;
 		}
 
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
