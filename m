From: Chris Lesiak <chris.lesiak@licor.com>
Date: Tue, 26 May 2015 20:41:42 +0000
Subject: [lm-sensors] [PATCH] hwmon: ntc: Don't assume a 12 bit ADC
Message-Id: <1432672902-28185-1-git-send-email-chris.lesiak@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The function ntc_adc_iio_read was using iio_read_channel_raw and
converting to microVolts using the assumption of a 12 bit ADC.  If a
converter with different precision was used, the result was in error.

Instead, use iio_read_channel_processed, which does the conversion to
microVolts itself.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/hwmon/ntc_thermistor.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 6880011..0d3a686 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -190,20 +190,15 @@ struct ntc_data {
 static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 {
 	struct iio_channel *channel = pdata->chan;
-	s64 result;
 	int val, ret;
 
-	ret = iio_read_channel_raw(channel, &val);
+	ret = iio_read_channel_processed(channel, &val);
 	if (ret < 0) {
 		pr_err("read channel() error: %d\n", ret);
 		return ret;
 	}
 
-	/* unit: mV */
-	result = pdata->pullup_uv * (s64) val;
-	result >>= 12;
-
-	return (int)result;
+	return val;
 }
 
 static const struct of_device_id ntc_match[] = {
-- 
1.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
