From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 03:31:32 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (pmbus) Add support for Lineage
Message-Id: <1316748692-8326-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add device IDs and reference to datasheets for Lineage Power DC-DC converters.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/pmbus   |    8 ++++++++
 drivers/hwmon/pmbus/pmbus.c |    4 ++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index ce02f5d..15ac911 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -15,6 +15,14 @@ Supported chips:
 	http://www.onsemi.com/pub_link/Collateral/ADP4000-D.PDF
 	http://www.onsemi.com/pub_link/Collateral/NCP4200-D.PDF
 	http://www.onsemi.com/pub_link/Collateral/JUNE%202009-%20REV.%200.PDF
+  * Lineage Power
+    Prefixes: 'pdt003', 'pdt006', 'pdt012', 'udt020'
+    Addresses scanned: -
+    Datasheets:
+	http://www.lineagepower.com/oem/pdf/PDT003A0X.pdf
+	http://www.lineagepower.com/oem/pdf/PDT006A0X.pdf
+	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
+	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index ef5cc1e..995e873 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -206,7 +206,11 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"bmr454", 1},
 	{"ncp4200", 1},
 	{"ncp4208", 1},
+	{"pdt003", 1},
+	{"pdt006", 1},
+	{"pdt012", 1},
 	{"pmbus", 0},
+	{"udt020", 1},
 	{}
 };
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
