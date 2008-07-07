From: Andrew Paprocki <andrew@ishiboo.com>
Date: Mon, 07 Jul 2008 10:40:09 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: it87 only create pwm1-3 sysfs files
Message-Id: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch only creates the pwmN_enable, pwmN, and pwmN_freq
sysfs interface files if the corresponding fanN is enabled by
the chip.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
---
 drivers/hwmon/it87.c |   46 +++++++++++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 30cdb09..7de4af8 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1168,25 +1168,33 @@ static int __devinit it87_probe(struct platform_device *pdev)
 	}
 
 	if (enable_pwm_interface) {
-		if ((err = device_create_file(dev,
-		     &sensor_dev_attr_pwm1_enable.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm2_enable.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm3_enable.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm1.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm2.dev_attr))
-		 || (err = device_create_file(dev,
-		     &sensor_dev_attr_pwm3.dev_attr))
-		 || (err = device_create_file(dev,
-		     &dev_attr_pwm1_freq))
-		 || (err = device_create_file(dev,
-		     &dev_attr_pwm2_freq))
-		 || (err = device_create_file(dev,
-		     &dev_attr_pwm3_freq)))
-			goto ERROR4;
+		if (data->has_fan & (1 << 0)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm1_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm1.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm1_freq)))
+				goto ERROR4;
+		}
+		if (data->has_fan & (1 << 1)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm2_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm2.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm2_freq)))
+				goto ERROR4;
+		}
+		if (data->has_fan & (1 << 2)) {
+			if ((err = device_create_file(dev,
+			     &sensor_dev_attr_pwm3_enable.dev_attr))
+			 || (err = device_create_file(dev,
+			     &sensor_dev_attr_pwm3.dev_attr))
+			 || (err = device_create_file(dev,
+			     &dev_attr_pwm3_freq)))
+				goto ERROR4;
+		}
 	}
 
 	if (data->type = it8712 || data->type = it8716
-- 
1.5.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
