From: Chris Lesiak <chris.lesiak@licor.com>
Date: Tue, 26 May 2015 20:40:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: ntc: Ensure iio channel is of type IIO_VOLTGE
Message-Id: <1432672844-28133-1-git-send-email-chris.lesiak@licor.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When configured via device tree, the associated iio device needs to be
measuring voltage for the converstion to resistance to be correct.
Return -EINVAL if that is not the case.

Signed-off-by: Chris Lesiak <chris.lesiak@licor.com>
---
 drivers/hwmon/ntc_thermistor.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 112e4d4..6880011 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -239,8 +239,10 @@ static struct ntc_thermistor_platform_data *
 ntc_thermistor_parse_dt(struct platform_device *pdev)
 {
 	struct iio_channel *chan;
+	enum iio_chan_type type;
 	struct device_node *np = pdev->dev.of_node;
 	struct ntc_thermistor_platform_data *pdata;
+	int ret;
 
 	if (!np)
 		return NULL;
@@ -253,6 +255,13 @@ ntc_thermistor_parse_dt(struct platform_device *pdev)
 	if (IS_ERR(chan))
 		return ERR_CAST(chan);
 
+	ret = iio_get_channel_type(chan, &type);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (type != IIO_VOLTAGE)
+		return ERR_PTR(-EINVAL);
+
 	if (of_property_read_u32(np, "pullup-uv", &pdata->pullup_uv))
 		return ERR_PTR(-ENODEV);
 	if (of_property_read_u32(np, "pullup-ohm", &pdata->pullup_ohm))
-- 
1.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
