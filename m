From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Jan 2014 19:02:44 +0000
Subject: [lm-sensors] [PATCH v2] sensors-detect: Add detection of TI ADC128D818
Message-Id: <1390762964-29115-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use separate function to detect ADC128D818.
    Fix register addresses
    Check additional registers
    Fix typo in lm80 detection (ok, I am lazy ;-)

 CHANGES                    |    3 +++
 prog/detect/sensors-detect |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/CHANGES b/CHANGES
index e1347a6..970dd67 100644
--- a/CHANGES
+++ b/CHANGES
@@ -1,6 +1,9 @@
 lm-sensors CHANGES file
 -----------------------
 
+SVN HEAD
+  sensors-detect: Add detection of ADC128D818
+
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
               Increase MAX_SENSORS_PER_TYPE to 33
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index a2093f3..cfab2df 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -547,6 +547,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x28..0x2f],
 		i2c_detect => sub { lm80_detect(@_, 1); },
 	}, {
+		name => "TI / National Semiconductor ADC128D818",
+		driver => "adc128d818",
+		i2c_addrs => [0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f],
+		i2c_detect => sub { adc128d818_detect(@_); },
+	}, {
 		name => "National Semiconductor LM85",
 		driver => "lm85",
 		i2c_addrs => [0x2c..0x2e],
@@ -4437,7 +4442,7 @@ sub lm92_detect
 # Registers used:
 #   0x00: Configuration register
 #   0x02: Interrupt state register
-#   0x07: Converstion rate register (LM96080 only)
+#   0x07: Conversion rate register (LM96080 only)
 #   0x2a-0x3d: Limits registers (LM80 only)
 #   0x3e: Manufacturer's ID register (LM96080 only)
 #   0x3f: Stepping/die revision ID register (LM96080 only)
@@ -4502,6 +4507,32 @@ sub lm80_detect
 }
 
 # Registers used:
+#   0x00: Configuration register
+#   0x07: Conversion rate register
+#   0x09: Oneshot register
+#   0x0a: Shutdown register
+#   0x0b: Advanced Configuration register
+#   0x0c: Busy Status register
+#   0x3e: Manufacturer's ID register
+#   0x3f: Stepping/die revision ID register
+sub adc128d818_detect
+{
+	my ($file, $addr) = @_;
+
+	return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
+	return if i2c_smbus_read_byte_data($file, 0x3f) != 0x09;
+
+	return if (i2c_smbus_read_byte_data($file, 0x00) & 0xf4) != 0;
+	return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
+	return if (i2c_smbus_read_byte_data($file, 0x09) & 0xfe) != 0;
+	return if (i2c_smbus_read_byte_data($file, 0x0a) & 0xfe) != 0;
+	return if (i2c_smbus_read_byte_data($file, 0x0b) & 0xf8) != 0;
+	return if (i2c_smbus_read_byte_data($file, 0x0c) & 0xfc) != 0;
+
+	return 7;
+}
+
+# Registers used:
 #   0x02: Status 1
 #   0x03: Configuration
 #   0x04: Company ID of LM84
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
