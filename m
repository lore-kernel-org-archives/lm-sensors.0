From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 18 Apr 2011 20:49:41 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (max16064) Add driver documentation
Message-Id: <1303159782-2687-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MAX16064 has its own driver, thus should have its own documentation instead of
being mentioned in the generic PMBus driver documentation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/max16064 |   62 ++++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/pmbus    |    5 ---
 2 files changed, 62 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/hwmon/max16064

diff --git a/Documentation/hwmon/max16064 b/Documentation/hwmon/max16064
new file mode 100644
index 0000000..4172899
--- /dev/null
+++ b/Documentation/hwmon/max16064
@@ -0,0 +1,62 @@
+Kernel driver max16064
+===========
+
+Supported chips:
+  * Maxim MAX16064
+    Prefix: 'max16064'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16064.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for Maxim MAX16064 Quad Power-Supply
+Controller with Active-Voltage Output Control and PMBus Interface.
+
+The driver is a client driver to the core PMBus driver.
+Please see Documentation/hwmon/pmbus for details on PMBus client drivers.
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
+in[1-4]_label		"vout[1-4]"
+in[1-4]_input		Measured voltage. From READ_VOUT register.
+in[1-4]_min		Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
+in[1-4]_max		Maximum voltage. From VOUT_OV_WARN_LIMIT register.
+in[1-4]_lcrit		Critical minumum Voltage. VOUT_UV_FAULT_LIMIT register.
+in[1-4]_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in[1-4]_min_alarm	Voltage low alarm. From VOLTAGE_UV_WARNING status.
+in[1-4]_max_alarm	Voltage high alarm. From VOLTAGE_OV_WARNING status.
+in[1-4]_lcrit_alarm	Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
+in[1-4]_crit_alarm	Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+
+temp1_input		Measured temperature. From READ_TEMPERATURE_1 register.
+temp1_max		Maximum temperature. From OT_WARN_LIMIT register.
+temp1_crit		Critical high temperature. From OT_FAULT_LIMIT register.
+temp1_max_alarm		Chip temperature high alarm. Set by comparing
+			READ_TEMPERATURE_1 with OT_WARN_LIMIT if TEMP_OT_WARNING
+			status is set.
+temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
+			READ_TEMPERATURE_1 with OT_FAULT_LIMIT if TEMP_OT_FAULT
+			status is set.
diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index 2a3049e..8c78fea 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -13,11 +13,6 @@ Supported chips:
     Prefix: 'ltc2978'
     Addresses scanned: -
     Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
-  * Maxim MAX16064
-    Quad Power-Supply Controller
-    Prefix: 'max16064'
-    Addresses scanned: -
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16064.pdf
   * Maxim MAX34440
     PMBus 6-Channel Power-Supply Manager
     Prefixes: 'max34440'
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
