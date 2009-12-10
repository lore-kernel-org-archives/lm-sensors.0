From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Thu, 10 Dec 2009 19:13:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: sht15: Off by one error in array index
Message-Id: <4B214861.4030906@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B2147B4.5090505@cam.ac.uk>
In-Reply-To: <4B2147B4.5090505@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Signed-off-by: Christoph Walser <walser@tik.ee.ethz.ch>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

Christoph noticed some problems with the sht15 driver and was kind enough
to send me a patch.  If no one has any issues with this, it should also go
in stable once it merges with mainline.

Sorry all. Typo in Christoph's email adress in previous version.

 drivers/hwmon/sht15.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index ebe38b6..864a371 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -305,7 +305,7 @@ static inline int sht15_calc_temp(struct sht15_data *data)
 	int d1 = 0;
 	int i;
 
-	for (i = 1; i < ARRAY_SIZE(temppoints) - 1; i++)
+	for (i = 1; i < ARRAY_SIZE(temppoints); i++)
 		/* Find pointer to interpolate */
 		if (data->supply_uV > temppoints[i - 1].vdd) {
 			d1 = (data->supply_uV/1000 - temppoints[i - 1].vdd)
@@ -332,12 +332,12 @@ static inline int sht15_calc_humid(struct sht15_data *data)
 
 	const int c1 = -4;
 	const int c2 = 40500; /* x 10 ^ -6 */
-	const int c3 = 2800; /* x10 ^ -9 */
+	const int c3 = -2800; /* x10 ^ -9 */
 
 	RHlinear = c1*1000
 		+ c2 * data->val_humid/1000
 		+ (data->val_humid * data->val_humid * c3)/1000000;
-	return (temp - 25000) * (10000 + 800 * data->val_humid)
+	return (temp - 25000) * (10000 + 80 * data->val_humid)
 		/ 1000000 + RHlinear;
 }
 
-- 
1.6.4.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
