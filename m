From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:18:44 +0000
Subject: [lm-sensors] [PATCH 04/12] adt7470: Fix pwm*-auto-point* to be
Message-Id: <20081007011844.12701.12127.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


It turns out that Tmin/Tmax should be attached to the temperature sensors, not
to the pwm control.  Fix my misinterpretation of the datasheet.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/adt7470.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index d368d8f..656bf3d 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -888,22 +888,22 @@ static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
 		    show_pwm_max, set_pwm_max, 3);
 
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
+static SENSOR_DEVICE_ATTR(temp1_auto_point1_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_tmin, set_pwm_tmin, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
+static SENSOR_DEVICE_ATTR(temp2_auto_point1_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_tmin, set_pwm_tmin, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
+static SENSOR_DEVICE_ATTR(temp3_auto_point1_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_tmin, set_pwm_tmin, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
+static SENSOR_DEVICE_ATTR(temp4_auto_point1_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_tmin, set_pwm_tmin, 3);
 
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+static SENSOR_DEVICE_ATTR(temp1_auto_point2_temp, S_IRUGO, show_pwm_tmax,
 		    NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+static SENSOR_DEVICE_ATTR(temp2_auto_point2_temp, S_IRUGO, show_pwm_tmax,
 		    NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+static SENSOR_DEVICE_ATTR(temp3_auto_point2_temp, S_IRUGO, show_pwm_tmax,
 		    NULL, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax,
+static SENSOR_DEVICE_ATTR(temp4_auto_point2_temp, S_IRUGO, show_pwm_tmax,
 		    NULL, 3);
 
 static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
@@ -996,14 +996,14 @@ static struct attribute *adt7470_attr[]  	&sensor_dev_attr_pwm2_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm3_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm4_auto_point2_pwm.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm4_auto_point1_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
-	&sensor_dev_attr_pwm4_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp4_auto_point1_temp.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_point2_temp.dev_attr.attr,
+	&sensor_dev_attr_temp4_auto_point2_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm2_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm3_enable.dev_attr.attr,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
