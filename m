From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 09 Nov 2010 08:41:48 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (gpio-fan) Fix fan_ctrl_init error
Message-Id: <1289292108.28671.1.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Simon Guinot <sguinot@lacie.com>, lm-sensors@lm-sensors.org

In current implementation, the sysfs entries is not removed before return -ENODEV.

Creating the sysfs attribute should be the last thing done by the function,
after all the rest has been successful.
Otherwise there is a small window during which user-space can access the attribute
but the driver isn't ready to deal with the requests.

Fix it by moving sysfs_create_group to be the last thing done by the function.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/gpio-fan.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index aa701a1..f141a1d 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -376,10 +376,6 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 		}
 	}
 
-	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
-	if (err)
-		goto err_free_gpio;
-
 	fan_data->num_ctrl = num_ctrl;
 	fan_data->ctrl = ctrl;
 	fan_data->num_speed = pdata->num_speed;
@@ -391,6 +387,10 @@ static int fan_ctrl_init(struct gpio_fan_data *fan_data,
 		goto err_free_gpio;
 	}
 
+	err = sysfs_create_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
+	if (err)
+		goto err_free_gpio;
+
 	return 0;
 
 err_free_gpio:
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
