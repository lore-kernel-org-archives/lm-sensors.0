From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 26 Jun 2010 02:40:10 +0000
Subject: [lm-sensors] [PATCH/RFC 2/3] hwmon: LTC4261 driver documentation
Message-Id: <1277520011-29782-3-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/ltc4261 |   56 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/ltc4261

diff --git a/Documentation/hwmon/ltc4261 b/Documentation/hwmon/ltc4261
new file mode 100644
index 0000000..697c8c6
--- /dev/null
+++ b/Documentation/hwmon/ltc4261
@@ -0,0 +1,56 @@
+Kernel driver ltc4261
+==========+
+Supported chips:
+  * Linear Technology LTC4261
+    Prefix: 'ltc4261'
+    Addresses scanned: -
+    Datasheet:
+        http://cds.linear.com/docs/Datasheet/42612fb.pdf
+
+Author: Guenter Roeck <guenter.roeck@ericsson.com>
+
+
+Description
+-----------
+
+The LTC4261/LTC4261-2 negative voltage Hot Swap controllers allow a board
+to be safely inserted and removed from a live backplane.
+
+
+Usage Notes
+-----------
+
+This driver does not probe for LTC4261 devices, since there is no register
+which can be safely used to identify the chip. You will have to instantiate
+the devices explicitly.
+
+Example: the following will load the driver for an LTC4261 at address 0x23
+on I2C bus #1:
+$ modprobe ltc4261
+$ echo ltc4261 0x23 > /sys/bus/i2c/devices/i2c-1/new_device
+
+
+Sysfs entries
+-------------
+
+Voltage readings provided by this driver are reported as obtained from the ADC
+registers. If a set of voltage divider resistors is installed, calculate the
+real voltage by multiplying the reported value with (R1+R2)/R2, where R1 is the
+value of the divider resistor against the measured voltage and R2 is the value
+of the divider resistor against Ground.
+
+Current reading provided by this driver is reported as obtained from the ADC
+Current Sense register. The reported value assumes that a 1 mOhm sense resistor
+is installed. If a different sense resistor is installed, calculate the real
+current by dividing the reported value by the sense resistor value in mOhm.
+
+in1_input		ADIN input voltage (mV)
+in2_input		ADIN2 input voltage (mV)
+
+in1_min_alarm		ADIN/ADIN2 input undervoltage alarm
+in1_max_alarm		ADIN/ADIN2 input overvoltage alarm
+
+curr1_input		SENSE current (mA)
+
+curr1_alarm		SENSE overcurrent alarm
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
