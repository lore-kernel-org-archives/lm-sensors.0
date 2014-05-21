From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 21 May 2014 12:58:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ntc_thermistor) Fix OF device ID mapping
Message-Id: <20140521145822.56a3195e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The mapping from OF device IDs to platform device IDs is wrong.
TYPE_NCPXXWB473 is 0, TYPE_NCPXXWL333 is 1, so
ntc_thermistor_id[TYPE_NCPXXWB473] is { "ncp15wb473", TYPE_NCPXXWB473 }
while
ntc_thermistor_id[TYPE_NCPXXWL333] is { "ncp18wb473", TYPE_NCPXXWB473 }.

So the name is wrong for all but the "ntc,ncp15wb473" entry, and the
type is wrong for the "ntc,ncp15wl333" entry.

So map the entries by index, it is neither elegant nor robust but at
least it is correct.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 9e8269de hwmon: (ntc_thermistor) Add DT with IIO support to NTC thermistor driver
Cc: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Doug Anderson <dianders@chromium.org>
---
Again this is a candidate for stable, but maybe we don't really care
because the only in-tree user is for the only device for which the
mapping wasn't broken.

 drivers/hwmon/ntc_thermistor.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- linux-3.15-rc5.orig/drivers/hwmon/ntc_thermistor.c	2014-05-21 13:31:04.781217589 +0200
+++ linux-3.15-rc5/drivers/hwmon/ntc_thermistor.c	2014-05-21 14:12:48.408410951 +0200
@@ -44,6 +44,7 @@ struct ntc_compensation {
 	unsigned int	ohm;
 };
 
+/* Order matters, ntc_match references the entries by index */
 static const struct platform_device_id ntc_thermistor_id[] = {
 	{ "ncp15wb473", TYPE_NCPXXWB473 },
 	{ "ncp18wb473", TYPE_NCPXXWB473 },
@@ -163,15 +164,15 @@ static int ntc_adc_iio_read(struct ntc_t
 
 static const struct of_device_id ntc_match[] = {
 	{ .compatible = "ntc,ncp15wb473",
-		.data = &ntc_thermistor_id[TYPE_NCPXXWB473] },
+		.data = &ntc_thermistor_id[0] },
 	{ .compatible = "ntc,ncp18wb473",
-		.data = &ntc_thermistor_id[TYPE_NCPXXWB473] },
+		.data = &ntc_thermistor_id[1] },
 	{ .compatible = "ntc,ncp21wb473",
-		.data = &ntc_thermistor_id[TYPE_NCPXXWB473] },
+		.data = &ntc_thermistor_id[2] },
 	{ .compatible = "ntc,ncp03wb473",
-		.data = &ntc_thermistor_id[TYPE_NCPXXWB473] },
+		.data = &ntc_thermistor_id[3] },
 	{ .compatible = "ntc,ncp15wl333",
-		.data = &ntc_thermistor_id[TYPE_NCPXXWL333] },
+		.data = &ntc_thermistor_id[4] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ntc_match);


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
