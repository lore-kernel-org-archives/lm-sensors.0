From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 05 Oct 2014 00:12:06 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (iio_hwmon) Add support for humidity sensors
Message-Id: <1412467926-26478-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The iio subsystem supports humidity sensors, so it makes sense
to support it in the iio-hwmon bridge as well.

Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Only add humidity sensor support for now.

 drivers/hwmon/iio_hwmon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index 14c82da..9801756 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -63,7 +63,7 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 	struct iio_hwmon_state *st;
 	struct sensor_device_attribute *a;
 	int ret, i;
-	int in_i = 1, temp_i = 1, curr_i = 1;
+	int in_i = 1, temp_i = 1, curr_i = 1, humidity_i = 1;
 	enum iio_chan_type type;
 	struct iio_channel *channels;
 	const char *name = "iio_hwmon";
@@ -123,6 +123,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 							  "curr%d_input",
 							  curr_i++);
 			break;
+		case IIO_HUMIDITYRELATIVE:
+			a->dev_attr.attr.name = kasprintf(GFP_KERNEL,
+							  "humidity%d_input",
+							  humidity_i++);
+			break;
 		default:
 			ret = -EINVAL;
 			goto error_release_channels;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
