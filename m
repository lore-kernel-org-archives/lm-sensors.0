From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Tue, 01 Jul 2014 06:05:52 +0000
Subject: [lm-sensors] PATCH 2/2 v2] Adds support for the ntc thermistor B57330V2103 from EPCOS
Message-Id: <1714701.bPhuGb1mhL@lenovobook>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com> <53AD7F8F.7070501@roeck-us.net> <1591178.8bErWY6Byk@lenovobook>
In-Reply-To: <1591178.8bErWY6Byk@lenovobook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

This patch adds support for the ntc thermistor B57330V2103 from EPCOS.

Change since v1:
1. Rearranged compatible node values alphabetically
2. Fixed wrapped line

Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
---
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |  1 +
 Documentation/hwmon/ntc_thermistor                 |  5 +++
 drivers/hwmon/Kconfig                              |  2 +-
 drivers/hwmon/ntc_thermistor.c                     | 50 +++++++++++++++++++++-
 include/linux/platform_data/ntc_thermistor.h       |  1 +
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
index b117b2e..2391e5c 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
+++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
@@ -3,6 +3,7 @@ NTC Thermistor hwmon sensors
 
 Requires node properties:
 - "compatible" value : one of
+	"epcos,b57330v2103"
 	"murata,ncp15wb473"
 	"murata,ncp18wb473"
 	"murata,ncp21wb473"
diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_thermistor
index 057b770..c5e05e2 100644
--- a/Documentation/hwmon/ntc_thermistor
+++ b/Documentation/hwmon/ntc_thermistor
@@ -6,6 +6,11 @@ Supported thermistors from Murata:
   Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473', 'ncp15wl333'
   Datasheet: Publicly available at Murata
 
+Supported thermistors from EPCOS:
+* EPCOS NTC Thermistors B57330V2103
+  Prefixes: b57330v2103
+  Datasheet: Publicly available at EPCOS
+
 Other NTC thermistors can be supported simply by adding compensation
 tables; e.g., NCP15WL333 support is added by the table ncpXXwl333.
 
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 02d3d85..b34d673 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1061,7 +1061,7 @@ config SENSORS_NTC_THERMISTOR
 
 	  Currently, this driver supports
 	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333
-	  from Murata.
+	  from Murata and B57330V2103 from EPCOS.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ntc-thermistor.
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index bdfbe91..25c8deb 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -51,6 +51,7 @@ static const struct platform_device_id ntc_thermistor_id[] = {
 	{ "ncp21wb473", TYPE_NCPXXWB473 },
 	{ "ncp03wb473", TYPE_NCPXXWB473 },
 	{ "ncp15wl333", TYPE_NCPXXWL333 },
+	{ "b57330v2103", TYPE_B57330V2103},
 	{ },
 };
 
@@ -133,6 +134,47 @@ static const struct ntc_compensation ncpXXwl333[] = {
 	{ .temp_c	= 125, .ohm	= 707 },
 };
 
+/*
+ * The following compensation table is from the specification of EPCOS NTC
+ * Thermistors Datasheet
+ */
+static const struct ntc_compensation b57330v2103[] = {
+	{ .temp_c	= -40, .ohm	= 190030 },
+	{ .temp_c	= -35, .ohm	= 145360 },
+	{ .temp_c	= -30, .ohm	= 112060 },
+	{ .temp_c	= -25, .ohm	= 87041 },
+	{ .temp_c	= -20, .ohm	= 68104 },
+	{ .temp_c	= -15, .ohm	= 53665 },
+	{ .temp_c	= -10, .ohm	= 42576 },
+	{ .temp_c	= -5, .ohm	= 34001 },
+	{ .temp_c	= 0, .ohm	= 27326 },
+	{ .temp_c	= 5, .ohm	= 22096 },
+	{ .temp_c	= 10, .ohm	= 17973 },
+	{ .temp_c	= 15, .ohm	= 14703 },
+	{ .temp_c	= 20, .ohm	= 12090 },
+	{ .temp_c	= 25, .ohm	= 10000 },
+	{ .temp_c	= 30, .ohm	= 8311 },
+	{ .temp_c	= 35, .ohm	= 6941 },
+	{ .temp_c	= 40, .ohm	= 5825 },
+	{ .temp_c	= 45, .ohm	= 4911 },
+	{ .temp_c	= 50, .ohm	= 4158 },
+	{ .temp_c	= 55, .ohm	= 3536 },
+	{ .temp_c	= 60, .ohm	= 3019 },
+	{ .temp_c	= 65, .ohm	= 2588 },
+	{ .temp_c	= 70, .ohm	= 2227 },
+	{ .temp_c	= 75, .ohm	= 1924 },
+	{ .temp_c	= 80, .ohm	= 1668 },
+	{ .temp_c	= 85, .ohm	= 1451 },
+	{ .temp_c	= 90, .ohm	= 1266 },
+	{ .temp_c	= 95, .ohm	= 1108 },
+	{ .temp_c	= 100, .ohm	= 973 },
+	{ .temp_c	= 105, .ohm	= 857 },
+	{ .temp_c	= 110, .ohm	= 757 },
+	{ .temp_c	= 115, .ohm	= 671 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
+};
+
 struct ntc_data {
 	struct device *hwmon_dev;
 	struct ntc_thermistor_platform_data *pdata;
@@ -173,6 +215,8 @@ static const struct of_device_id ntc_match[] = {
 		.data = &ntc_thermistor_id[3] },
 	{ .compatible = "murata,ncp15wl333",
 		.data = &ntc_thermistor_id[4] },
+	{ .compatible = "epcos,b57330v2103",
+		.data = &ntc_thermistor_id[5]},
 
 	/* Usage of vendor name "ntc" is deprecated */
 	{ .compatible = "ntc,ncp15wb473",
@@ -490,6 +534,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 		data->comp = ncpXXwl333;
 		data->n_comp = ARRAY_SIZE(ncpXXwl333);
 		break;
+	case TYPE_B57330V2103:
+		data->comp = b57330v2103;
+		data->n_comp = ARRAY_SIZE(b57330v2103);
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
 				pdev_id->driver_data, pdev_id->name);
@@ -546,7 +594,7 @@ static struct platform_driver ntc_thermistor_driver = {
 
 module_platform_driver(ntc_thermistor_driver);
 
-MODULE_DESCRIPTION("NTC Thermistor Driver from Murata");
+MODULE_DESCRIPTION("NTC Thermistor Driver");
 MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:ntc-thermistor");
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/platform_data/ntc_thermistor.h
index c7285b5..0a6de4c 100644
--- a/include/linux/platform_data/ntc_thermistor.h
+++ b/include/linux/platform_data/ntc_thermistor.h
@@ -26,6 +26,7 @@ struct iio_channel;
 enum ntc_thermistor_type {
 	TYPE_NCPXXWB473,
 	TYPE_NCPXXWL333,
+	TYPE_B57330V2103,
 };
 
 struct ntc_thermistor_platform_data {
-- 
2.0.1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
