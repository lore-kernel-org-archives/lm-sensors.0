From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 11 Feb 2011 09:06:08 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: DDR3 SPD EEPROM support
Message-Id: <4D54FC00.1010600@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This adds CRC-16 calculation, needed to correctly detect DDR3 SPD EEPROMs.

--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -5265,18 +5265,43 @@
 
 # Registers used:
 #   0-63: SPD Data and Checksum
+#   0-127: SPD data and CRC (DDR3)
 sub eeprom_detect
 {
 	my ($file, $addr) = @_;
+	my $device_type = i2c_smbus_read_byte_data($file, 2);
 	my $checksum = 0;
 
 	# Check the checksum for validity (works for most DIMMs and RIMMs)
-	for (my $i = 0; $i <= 62; $i++) {
-		$checksum += i2c_smbus_read_byte_data($file, $i);
+	if ($device_type >= 1 and $device_type <= 10) {
+		for (my $i = 0; $i <= 62; $i++) {
+			$checksum += i2c_smbus_read_byte_data($file, $i);
+		}
+		$checksum &= 255;
+
+		return 8 if $checksum = i2c_smbus_read_byte_data($file, 63);
+	} elsif ($device_type = 11) {
+		# see JEDEC 21-C 4.1.2.11 2.4
+		my $crc_coverage = i2c_smbus_read_byte_data($file, 0);
+		$crc_coverage = ($crc_coverage & 0x80) ? 117 : 126;
+		for (my $i = 0; $i < $crc_coverage; $i++) {
+			$checksum ^= i2c_smbus_read_byte_data($file, $i) << 8;
+			for (my $bit = 0; $bit < 8; $bit++) {
+				if ($checksum & 0x8000) {
+					$checksum = ($checksum << 1) ^ 0x1021;
+				} else {
+					$checksum <<= 1;
+				}
+			}
+		}
+		$checksum &= 0xffff;
+
+		return 8 if ($checksum & 0xff) = i2c_smbus_read_byte_data($file, 126) and
+			    ($checksum >> 8) = i2c_smbus_read_byte_data($file, 127);
+
+		# note: if bit 7 of byte 32 is set, a jc42 sensor is at $addr-0x38
 	}
-	$checksum &= 255;
 
-	return 8 if $checksum = i2c_smbus_read_byte_data($file, 63);
 	return;
 }
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
