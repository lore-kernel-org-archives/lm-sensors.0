From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 18 Apr 2011 20:49:40 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (max8688) Add driver documentation
Message-Id: <1303159782-2687-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MAX8688 has its own driver, thus should have its own documentation instead of
being mentioned in the generic PMBus driver documentation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/max8688 |   69 +++++++++++++++++++++++++++++++++++++++++++
 Documentation/hwmon/pmbus   |    5 ---
 2 files changed, 69 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/hwmon/max8688

diff --git a/Documentation/hwmon/max8688 b/Documentation/hwmon/max8688
new file mode 100644
index 0000000..0ddd3a4
--- /dev/null
+++ b/Documentation/hwmon/max8688
@@ -0,0 +1,69 @@
+Kernel driver max8688
+==========+
+Supported chips:
+  * Maxim MAX8688
+    Prefix: 'max8688'
+    Addresses scanned: -
+    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+This driver supports hardware montoring for Maxim MAX8688 Digital Power-Supply
+Controller/Monitor with PMBus Interface.
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
+in1_label		"vout1"
+in1_input		Measured voltage. From READ_VOUT register.
+in1_min			Minumum Voltage. From VOUT_UV_WARN_LIMIT register.
+in1_max			Maximum voltage. From VOUT_OV_WARN_LIMIT register.
+in1_lcrit		Critical minumum Voltage. VOUT_UV_FAULT_LIMIT register.
+in1_crit		Critical maximum voltage. From VOUT_OV_FAULT_LIMIT register.
+in1_min_alarm		Voltage low alarm. From VOLTAGE_UV_WARNING status.
+in1_max_alarm		Voltage high alarm. From VOLTAGE_OV_WARNING status.
+in1_lcrit_alarm		Voltage critical low alarm. From VOLTAGE_UV_FAULT status.
+in1_crit_alarm		Voltage critical high alarm. From VOLTAGE_OV_FAULT status.
+
+curr1_label		"iout1"
+curr1_input		Measured current. From READ_IOUT register.
+curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
+curr1_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT register.
+curr1_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
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
index ef8555a..2a3049e 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -28,11 +28,6 @@ Supported chips:
     Prefixes: 'max34441'
     Addresses scanned: -
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX34441.pdf
-  * Maxim MAX8688
-    Digital Power-Supply Controller/Monitor
-    Prefix: 'max8688'
-    Addresses scanned: -
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
