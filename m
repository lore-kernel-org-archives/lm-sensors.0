From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 15 Feb 2013 16:57:12 +0000
Subject: [lm-sensors] [PATCH 3/9] hwmon: (adt7410) Use the SIMPLE_DEV_PM_OPS helper macro
Message-Id: <1360947438-2550-3-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Use the SIMPLE_DEV_PM_OPS macro to declare the driver's pm_ops.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7410.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index ae80815..4ae16e0 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -437,10 +437,8 @@ static int adt7410_resume(struct device *dev)
 	return ret;
 }
 
-static const struct dev_pm_ops adt7410_dev_pm_ops = {
-	.suspend	= adt7410_suspend,
-	.resume		= adt7410_resume,
-};
+static SIMPLE_DEV_PM_OPS(adt7410_dev_pm_ops, adt7410_suspend, adt7410_resume);
+
 #define ADT7410_DEV_PM_OPS (&adt7410_dev_pm_ops)
 #else
 #define ADT7410_DEV_PM_OPS NULL
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
