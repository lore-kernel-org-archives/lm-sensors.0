From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jun 2014 13:28:14 +0000
Subject: [lm-sensors] [PATCH v2] sensors-detect: Add detection of NCT7802Y
Message-Id: <1403789294-17025-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DDE1CFF.1020906@appeartv.com>
In-Reply-To: <4DDE1CFF.1020906@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Don't attempt to detect chip if register bank 1 is selected.
    Document all used registers.

 CHANGES                    |  1 +
 prog/detect/sensors-detect | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/CHANGES b/CHANGES
index 3390942..a16e7be 100644
--- a/CHANGES
+++ b/CHANGES
@@ -13,6 +13,7 @@ SVN HEAD
                   Add detection of ITE IT8620E and IT8623E
                   Add detection of TMP441, TMP442, LM95233, LM95234,
                   and LM95235
+                  Add detection of NCT7802Y
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 1208f4d..719c6dc 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -733,6 +733,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x2c..0x2f],
 		i2c_detect => sub { w83795_detect(@_); },
 	}, {
+		name => "Nuvoton NCT7802Y",
+		driver => "to-be-written",
+		i2c_addrs => [0x28..0x2f],
+		i2c_detect => sub { nct7802_detect(@_); },
+	}, {
 		name => "Winbond W83627HF",
 		driver => "use-isa-instead",
 		i2c_addrs => [0x28..0x2f],
@@ -5483,6 +5488,47 @@ sub w83795_detect
 }
 
 # Registers used:
+#   0x00: Bank selection (Bank 0, 1)
+#   0x05: Temperature readout register LSB (Bank 0)
+#   0x08: PECI temperature readout register LSB (Bank 0)
+#   0x0f: Voltage readout register LSB (Bank 0)
+#   0xfd: Vendor ID (Bank 0)
+#   0xfe: Device ID (Bank 0)
+#   0xff: Device Revision (Bank 0)
+#
+# Note that identification registers are not accessible in bank 1,
+# and there is no usable other means to identify the chip if bank 1
+# is selected. Only detect chip if bank 0 is selected.
+sub nct7802_detect
+{
+	my ($bank, $reg);
+	my ($file, $addr) = @_;
+
+	$bank = i2c_smbus_read_byte_data($file, 0x00);
+	return unless $bank = 0x00;
+
+	$reg = i2c_smbus_read_byte_data($file, 0xfd);
+	return unless $reg = 0x50;
+
+	$reg = i2c_smbus_read_byte_data($file, 0xfe);
+	return unless $reg = 0xc3;
+
+	$reg = i2c_smbus_read_byte_data($file, 0xff);
+	return unless ($reg & 0xf0) = 0x20;
+
+	$reg = i2c_smbus_read_byte_data($file, 0x05);
+	return unless ($reg & 0x1f) = 0x00;
+
+	$reg = i2c_smbus_read_byte_data($file, 0x08);
+	return unless ($reg & 0x3f) = 0x00;
+
+	$reg = i2c_smbus_read_byte_data($file, 0x0f);
+	return unless ($reg & 0x3f) = 0x00;
+
+	return 8;
+}
+
+# Registers used:
 #   0x48: Full I2C Address
 #   0x4e: Vendor ID byte selection
 #   0x4f: Vendor ID
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
