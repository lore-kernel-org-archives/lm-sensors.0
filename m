From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Apr 2010 15:02:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sht15) Fix sht15_calc_temp
Message-Id: <20100401170239.3c745577@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>

I discovered two issues.
First the previous sht15_calc_temp() loop did not iterate through the
temppoints array since the (data->supply_uV > temppoints[i - 1].vdd)
test is always true in this direction.

Also the two-points linear interpolation function was returning biased
values due to a stray division by 1000 which shouldn't be there.

[JD: Also change the default value for d1 from 0 to something saner.]

Signed-off-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@kernel.org
---
 drivers/hwmon/sht15.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.34-rc3.orig/drivers/hwmon/sht15.c	2010-04-01 16:24:33.000000000 +0200
+++ linux-2.6.34-rc3/drivers/hwmon/sht15.c	2010-04-01 16:49:45.000000000 +0200
@@ -302,13 +302,13 @@ error_ret:
  **/
 static inline int sht15_calc_temp(struct sht15_data *data)
 {
-	int d1 = 0;
+	int d1 = temppoints[0].d1;
 	int i;
 
-	for (i = 1; i < ARRAY_SIZE(temppoints); i++)
+	for (i = ARRAY_SIZE(temppoints) - 1; i > 0; i--)
 		/* Find pointer to interpolate */
 		if (data->supply_uV > temppoints[i - 1].vdd) {
-			d1 = (data->supply_uV/1000 - temppoints[i - 1].vdd)
+			d1 = (data->supply_uV - temppoints[i - 1].vdd)
 				* (temppoints[i].d1 - temppoints[i - 1].d1)
 				/ (temppoints[i].vdd - temppoints[i - 1].vdd)
 				+ temppoints[i - 1].d1;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
