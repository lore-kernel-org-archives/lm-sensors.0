From: Beomho Seo <beomho.seo@samsung.com>
Date: Thu, 30 Apr 2015 04:07:43 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (ntc_thermistor) Add support for ncpXXwf104
Message-Id: <1430366863-22705-1-git-send-email-beomho.seo@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch adds support for the ntc thermistor NCPXXWF104 serises.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
Changes in v2
- Fix typo.
- Update Documents and Kconfig.
- Use murata instead of ntc.
- add entry to  the murata list.
---
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |    1 +
 Documentation/hwmon/ntc_thermistor                 |    6 ++-
 drivers/hwmon/Kconfig                              |    4 +-
 drivers/hwmon/ntc_thermistor.c                     |   44 ++++++++++++++++++++
 include/linux/platform_data/ntc_thermistor.h       |    1 +
 5 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
index fcca8e7..a04a80f 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
+++ b/Documentation/devicetree/bindings/hwmon/ntc_thermistor.txt
@@ -9,6 +9,7 @@ Requires node properties:
 	"murata,ncp21wb473"
 	"murata,ncp03wb473"
 	"murata,ncp15wl333"
+	"murata,ncp03wf104"
 
 /* Usage of vendor name "ntc" is deprecated */
 <DEPRECATED>	"ntc,ncp15wb473"
diff --git a/Documentation/hwmon/ntc_thermistor b/Documentation/hwmon/ntc_thermistor
index c5e05e2..1d4cc84 100644
--- a/Documentation/hwmon/ntc_thermistor
+++ b/Documentation/hwmon/ntc_thermistor
@@ -2,8 +2,10 @@ Kernel driver ntc_thermistor
 ======== 
 Supported thermistors from Murata:
-* Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333
-  Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473', 'ncp15wl333'
+* Murata NTC Thermistors NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473,
+  NCP15WL333, NCP03WF104
+  Prefixes: 'ncp15wb473', 'ncp18wb473', 'ncp21wb473', 'ncp03wb473',
+  'ncp15wl333', 'ncp03wf104'
   Datasheet: Publicly available at Murata
 
 Supported thermistors from EPCOS:
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 25d9e72..4542ffc 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1106,8 +1106,8 @@ config SENSORS_NTC_THERMISTOR
 	  send notifications about the temperature.
 
 	  Currently, this driver supports
-	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, and NCP15WL333
-	  from Murata and B57330V2103 from EPCOS.
+	  NCP15WB473, NCP18WB473, NCP21WB473, NCP03WB473, NCP15WL333,
+	  and NCP03WF104 from Murata and B57330V2103 from EPCOS.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called ntc-thermistor.
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 112e4d4..09ece61 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -53,6 +53,7 @@ static const struct platform_device_id ntc_thermistor_id[] = {
 	{ "ncp03wb473", TYPE_NCPXXWB473 },
 	{ "ncp15wl333", TYPE_NCPXXWL333 },
 	{ "b57330v2103", TYPE_B57330V2103},
+	{ "ncp03wf104", TYPE_NCPXXWF104 },
 	{ },
 };
 
@@ -135,6 +136,43 @@ static const struct ntc_compensation ncpXXwl333[] = {
 	{ .temp_c	= 125, .ohm	= 707 },
 };
 
+static const struct ntc_compensation ncpXXwf104[] = {
+	{ .temp_c	= -40, .ohm	= 4397119 },
+	{ .temp_c	= -35, .ohm	= 3088599 },
+	{ .temp_c	= -30, .ohm	= 2197225 },
+	{ .temp_c	= -25, .ohm	= 1581881 },
+	{ .temp_c	= -20, .ohm	= 1151037 },
+	{ .temp_c	= -15, .ohm	= 846579 },
+	{ .temp_c	= -10, .ohm	= 628988 },
+	{ .temp_c	= -5, .ohm	= 471632 },
+	{ .temp_c	= 0, .ohm	= 357012 },
+	{ .temp_c	= 5, .ohm	= 272500 },
+	{ .temp_c	= 10, .ohm	= 209710 },
+	{ .temp_c	= 15, .ohm	= 162651 },
+	{ .temp_c	= 20, .ohm	= 127080 },
+	{ .temp_c	= 25, .ohm	= 100000 },
+	{ .temp_c	= 30, .ohm	= 79222 },
+	{ .temp_c	= 35, .ohm	= 63167 },
+	{ .temp_c	= 40, .ohm	= 50677 },
+	{ .temp_c	= 45, .ohm	= 40904 },
+	{ .temp_c	= 50, .ohm	= 33195 },
+	{ .temp_c	= 55, .ohm	= 27091 },
+	{ .temp_c	= 60, .ohm	= 22224 },
+	{ .temp_c	= 65, .ohm	= 18323 },
+	{ .temp_c	= 70, .ohm	= 15184 },
+	{ .temp_c	= 75, .ohm	= 12635 },
+	{ .temp_c	= 80, .ohm	= 10566 },
+	{ .temp_c	= 85, .ohm	= 8873 },
+	{ .temp_c	= 90, .ohm	= 7481 },
+	{ .temp_c	= 95, .ohm	= 6337 },
+	{ .temp_c	= 100, .ohm	= 5384 },
+	{ .temp_c	= 105, .ohm	= 4594 },
+	{ .temp_c	= 110, .ohm	= 3934 },
+	{ .temp_c	= 115, .ohm	= 3380 },
+	{ .temp_c	= 120, .ohm	= 2916 },
+	{ .temp_c	= 125, .ohm	= 2522 },
+};
+
 /*
  * The following compensation table is from the specification of EPCOS NTC
  * Thermistors Datasheet
@@ -219,6 +257,8 @@ static const struct of_device_id ntc_match[] = {
 		.data = &ntc_thermistor_id[4] },
 	{ .compatible = "epcos,b57330v2103",
 		.data = &ntc_thermistor_id[5]},
+	{ .compatible = "murata,ncp03wf104",
+		.data = &ntc_thermistor_id[6] },
 
 	/* Usage of vendor name "ntc" is deprecated */
 	{ .compatible = "ntc,ncp15wb473",
@@ -558,6 +598,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 		data->comp = b57330v2103;
 		data->n_comp = ARRAY_SIZE(b57330v2103);
 		break;
+	case TYPE_NCPXXWF104:
+		data->comp = ncpXXwf104;
+		data->n_comp = ARRAY_SIZE(ncpXXwf104);
+		break;
 	default:
 		dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
 				pdev_id->driver_data, pdev_id->name);
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/platform_data/ntc_thermistor.h
index 0a6de4c..aed1705 100644
--- a/include/linux/platform_data/ntc_thermistor.h
+++ b/include/linux/platform_data/ntc_thermistor.h
@@ -27,6 +27,7 @@ enum ntc_thermistor_type {
 	TYPE_NCPXXWB473,
 	TYPE_NCPXXWL333,
 	TYPE_B57330V2103,
+	TYPE_NCPXXWF104,
 };
 
 struct ntc_thermistor_platform_data {
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
