From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 25 Jan 2014 17:54:51 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of TI ADC128D818
Message-Id: <1390672491-27069-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |    3 +++
 prog/detect/sensors-detect |   26 +++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

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
index a2093f3..2136b76 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -547,6 +547,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x28..0x2f],
 		i2c_detect => sub { lm80_detect(@_, 1); },
 	}, {
+		name => "TI / National Semiconductor ADC128D818",
+		driver => "adc128d818",
+		i2c_addrs => [0x1d, 0x1e, 0x1f, 0x2d, 0x2e, 0x2f, 0x35, 0x36, 0x37],
+		i2c_detect => sub { lm80_detect(@_, 2); },
+	}, {
 		name => "National Semiconductor LM85",
 		driver => "lm85",
 		i2c_addrs => [0x2c..0x2e],
@@ -4436,11 +4441,13 @@ sub lm92_detect
 # Chip to detect: 0 = LM80, 1 = LM96080
 # Registers used:
 #   0x00: Configuration register
-#   0x02: Interrupt state register
-#   0x07: Converstion rate register (LM96080 only)
+#   0x02: Interrupt state register (LM80, LM96080 only)
+#   0x07: Converstion rate register (LM96080, ADC128D818 only)
+#   0x08: Oneshot register (ADC128D818 only)
+#   0x09: Shutdown register (ADC128D818 only)
 #   0x2a-0x3d: Limits registers (LM80 only)
-#   0x3e: Manufacturer's ID register (LM96080 only)
-#   0x3f: Stepping/die revision ID register (LM96080 only)
+#   0x3e: Manufacturer's ID register (LM96080, ADC128D818 only)
+#   0x3f: Stepping/die revision ID register (LM96080, ADC128D818 only)
 # The LM80 is easily misdetected since it doesn't provide identification
 # registers. So we have to use some tricks:
 #   - 6-bit addressing, so limits readings modulo 0x40 should be unchanged
@@ -4458,9 +4465,9 @@ sub lm80_detect
 	my ($i, $reg);
 
 	return if (i2c_smbus_read_byte_data($file, 0x00) & 0x80) != 0;
-	return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
 
 	if ($chip = 0) {
+		return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
 		for ($i = 0x2a; $i <= 0x3d; $i++) {
 			$reg = i2c_smbus_read_byte_data($file, $i);
 			return if i2c_smbus_read_byte_data($file, $i+0x40) != $reg;
@@ -4493,11 +4500,20 @@ sub lm80_detect
 		return unless $confidence > 0;
 		return $confidence;
 	} elsif ($chip = 1) {
+		return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
 		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
 		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
 		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x08;
 
 		return 6;
+	} elsif ($chip = 2) {
+		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
+		return if (i2c_smbus_read_byte_data($file, 0x08) & 0xfe) != 0;
+		return if (i2c_smbus_read_byte_data($file, 0x09) & 0xfe) != 0;
+		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
+		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x09;
+
+		return 6;
 	}
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
