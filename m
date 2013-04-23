From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 23 Apr 2013 09:06:43 +0000
Subject: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Fix missing iio_channel_release_all call if devm_kzalloc fai
Message-Id: <1366708003.10246.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/iio_hwmon.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index aafa453..368497f 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -84,8 +84,10 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		return PTR_ERR(channels);
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
-	if (st = NULL)
-		return -ENOMEM;
+	if (st = NULL) {
+		ret = -ENOMEM;
+		goto error_release_channels;
+	}
 
 	st->channels = channels;
 
-- 
1.7.10.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
