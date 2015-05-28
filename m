From: Chris Lesiak <chris.lesiak@licor.com>
Date: Thu, 28 May 2015 13:57:51 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: ntc: use iio_read_channel_processed if possible
Message-Id: <1432821471-17373-1-git-send-email-chris.lesiak@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The function ntc_adc_iio_read (now ntc_adc_iio_read_raw) assumes
both a 12 bit ADC and that pullup_uv is the same as the ADC reference
voltage.  If either assumption is false, then the result is incorrect.

For iio channels supporting either IIO_CHAN_INFO_PROCESSED or
IIO_CHAN_INFO_SCALE, the new ntc_adc_iio_read will be used.  It gets
microvolts directly with a call to iio_read_channel_processed.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---

Changes in v2
======- Rename existing ntc_adc_iio_read to ntc_adc_iio_read_raw so that
  the name ntc_adc_iio_read can be used for the new behavior.

- Fixed issue related to coding style.

 drivers/hwmon/ntc_thermistor.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 6880011..2cbdf72 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -187,7 +187,7 @@ struct ntc_data {
 };
 
 #if defined(CONFIG_OF) && IS_ENABLED(CONFIG_IIO)
-static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
+static int ntc_adc_iio_read_raw(struct ntc_thermistor_platform_data *pdata)
 {
 	struct iio_channel *channel = pdata->chan;
 	s64 result;
@@ -206,6 +206,20 @@ static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
 	return (int)result;
 }
 
+static int ntc_adc_iio_read(struct ntc_thermistor_platform_data *pdata)
+{
+	struct iio_channel *channel = pdata->chan;
+	int val, ret;
+
+	ret = iio_read_channel_processed(channel, &val);
+	if (ret < 0) {
+		pr_err("read channel() error: %d\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
 static const struct of_device_id ntc_match[] = {
 	{ .compatible = "murata,ncp15wb473",
 		.data = &ntc_thermistor_id[0] },
@@ -275,7 +289,12 @@ ntc_thermistor_parse_dt(struct platform_device *pdev)
 		pdata->connect = NTC_CONNECTED_GROUND;
 
 	pdata->chan = chan;
-	pdata->read_uv = ntc_adc_iio_read;
+
+	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED) ||
+	    iio_channel_has_info(chan->channel, IIO_CHAN_INFO_SCALE))
+		pdata->read_uv = ntc_adc_iio_read;
+	else
+		pdata->read_uv = ntc_adc_iio_read_raw;
 
 	return pdata;
 }
-- 
1.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
