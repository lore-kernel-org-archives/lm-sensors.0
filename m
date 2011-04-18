From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 18 Apr 2011 20:49:42 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (max34440) Add driver documentation
Message-Id: <1303159782-2687-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MAX34440 and MAX34441 have their own driver, thus there should be explicit
documentation instead of mentioning the chips in the generic PMBus driver
documentation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/max34440 |   79 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/pmbus    |   10 -----
 2 files changed, 79 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/hwmon/max34440

diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
new file mode 100644
index 0000000..6c525dd
--- /dev/null
+++ b/Documentation/hwmon/max34440
@@ -0,0 +1,79 @@
+Kernel driver max34440
+===========
+
+Supported chips:
+  * Maxim MAX34440
+    Prefixes: 'max34440'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34440.pdf
+  * Maxim MAX34441
+    PMBus 5-Channel Power-Supply Manager and Intelligent Fan Controller
+    Prefixes: 'max34441'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34441.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for Maxim MAX34440 PMBus 6-Channel
+Power-Supply Manager and MAX34441 PMBus 5-Channel Power-Supply Manager
+and Intelligent Fan Controller.
+
+The driver is a client driver to the core PMBus driver. Please see
+Documentation/hwmon/pmbus for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported. Limits are read-write; all other
+attributes are read-only.
+
+in[1-6]_label		"vout[1-6]".
+in[1-6]_input		Measured voltage. From READ_VOUT register.
+in[1-6]_min		Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
+in[1-6]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
+in[1-6]_lcrit		Critical minumum Voltage. VOUT_UV_FAULT_LIMIT register.
+in[1-6]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[1-6]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
+in[1-6]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
+in[1-6]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
+in[1-6]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+
+curr[1-6]_label		"iout[1-6]".
+curr[1-6]_input		Measured current. From READ_IOUT register.
+curr[1-6]_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
+curr[1-6]_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr[1-6]_max_alarm	Current high alarm. From IOUT_OC_WARNING status.
+curr[1-6]_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
+
+			in6 and curr6 attributes only exist for MAX34440.
+
+temp[1-8]_input		Measured temperatures. From READ_TEMPERATURE_1 register.
+			temp1 is the chip's internal temperature. temp2..temp5
+			are remote I2C temperature sensors. For MAX34441, temp6
+			is a remote thermal-diode sensor. For MAX34440, temp6..8
+			are remote I2C temperature sensors.
+temp[1-8]_max		Maximum temperature. From OT_WARN_LIMIT register.
+temp[1-8]_crit		Critical high temperature. From OT_FAULT_LIMIT register.
+temp[1-8]_max_alarm	Temperature high alarm.
+temp[1-8]_crit_alarm	Temperature critical high alarm.
+
+			temp7 and temp8 attributes only exist for MAX34440.
diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index 8c78fea..f86d274 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -13,16 +13,6 @@ Supported chips:
     Prefix: 'ltc2978'
     Addresses scanned: -
     Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
-  * Maxim MAX34440
-    PMBus 6-Channel Power-Supply Manager
-    Prefixes: 'max34440'
-    Addresses scanned: -
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34440.pdf
-  * Maxim MAX34441
-    PMBus 5-Channel Power-Supply Manager and Intelligent Fan Controller
-    Prefixes: 'max34441'
-    Addresses scanned: -
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34441.pdf
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
