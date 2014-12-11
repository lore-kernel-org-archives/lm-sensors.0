From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Dec 2014 14:14:08 +0000
Subject: [lm-sensors] [PATCH v4] sensors-detect: Add code to detect TMP400 and TMP435
Message-Id: <1418307248-1533-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Also strengthen chip detection for other TMP4xx chips,
and update driver support status for TMP431 and TMP432.

Write new function for various TMP4xx chips and separate
from lm90 detection.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Rename tmp4xx_detect -> tmp401_detect
    Rename limit1/2/3 -> rtemp/rhigh/rlow
    Strenghten TMP451 detection
v3: Move chip detection for various TMP4xx chips to its own function
    Add TMP400 detection

The new detection function was tested with TMP401, TMP411A, TMP431, TMP432,
TMP435, and TMP451.

 CHANGES                    |   2 +
 prog/detect/sensors-detect | 127 ++++++++++++++++++++++++++++++---------------
 2 files changed, 88 insertions(+), 41 deletions(-)

diff --git a/CHANGES b/CHANGES
index 638a8bf..e462aea 100644
--- a/CHANGES
+++ b/CHANGES
@@ -24,6 +24,8 @@ SVN HEAD
                   Document support for EMC1402, EMC1404, and EMC1424
                   Detect new revisions of EMC14xx
                   Add detection of EMC1422
+                  Document driver support for TMP431 and TMP432
+                  Add detection of TMP400 and TMP435
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 448cf22..ebdc439 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1003,15 +1003,30 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x4c],
 		i2c_detect => sub { lm90_detect(@_, 11); },
 	}, {
+		name => "Texas Instruments TMP400",
+		driver => "to-be-written",	# tmp401
+		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
+		i2c_detect => sub { tmp401_detect(@_, 0); },
+	}, {
 		name => "Texas Instruments TMP401",
 		driver => "tmp401",
 		i2c_addrs => [0x4c],
-		i2c_detect => sub { lm90_detect(@_, 9); },
+		i2c_detect => sub { tmp401_detect(@_, 1); },
+	}, {
+		name => "Texas Instruments TMP411A",
+		driver => "tmp401",
+		i2c_addrs => [0x4c],
+		i2c_detect => sub { tmp401_detect(@_, 2); },
 	}, {
-		name => "Texas Instruments TMP411",
+		name => "Texas Instruments TMP411B",
 		driver => "tmp401",
-		i2c_addrs => [0x4c..0x4e],
-		i2c_detect => sub { lm90_detect(@_, 10); },
+		i2c_addrs => [0x4d],
+		i2c_detect => sub { tmp401_detect(@_, 3); },
+	}, {
+		name => "Texas Instruments TMP411C",
+		driver => "tmp401",
+		i2c_addrs => [0x4e],
+		i2c_detect => sub { tmp401_detect(@_, 4); },
 	}, {
 		name => "Texas Instruments TMP421",
 		driver => "tmp421",
@@ -1029,14 +1044,19 @@ use vars qw(@i2c_adapter_names);
 		i2c_detect => sub { tmp42x_detect(@_, 2); },
 	}, {
 		name => "Texas Instruments TMP431",
-		driver => "to-be-written",		# tmp401
+		driver => "tmp401",
 		i2c_addrs => [0x4c, 0x4d],
-		i2c_detect => sub { lm90_detect(@_, 16); },
+		i2c_detect => sub { tmp401_detect(@_, 5); },
 	}, {
 		name => "Texas Instruments TMP432",
-		driver => "to-be-written",		# tmp401
+		driver => "tmp401",
 		i2c_addrs => [0x4c, 0x4d],
-		i2c_detect => sub { lm90_detect(@_, 17); },
+		i2c_detect => sub { tmp401_detect(@_, 6); },
+	}, {
+		name => "Texas Instruments TMP435",
+		driver => "tmp401",
+		i2c_addrs => [0x37, 0x48..0x4f],
+		i2c_detect => sub { tmp401_detect(@_, 7); },
 	}, {
 		name => "Texas Instruments TMP441",
 		driver => "tmp421",
@@ -1051,7 +1071,7 @@ use vars qw(@i2c_adapter_names);
 		name => "Texas Instruments TMP451",
 		driver => "lm90",
 		i2c_addrs => [0x4c],
-		i2c_detect => sub { lm90_detect(@_, 18); },
+		i2c_detect => sub { tmp401_detect(@_, 8); },
 	}, {
 		name => "Texas Instruments AMC6821",
 		driver => "amc6821",
@@ -4671,10 +4691,10 @@ sub max6680_95_detect
 # Chip to detect: 0 = LM90, 1 = LM89/LM99, 2 = LM86, 3 = ADM1032,
 #		  4 = MAX6654, 5 = ADT7461,
 #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
-#		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
+#		  8 = W83L771W/G,
 #		  11 = W83L771AWG/ASG, 12 = MAX6690,
 #		  13 = ADT7461A/NCT1008, 14 = SA56004,
-#		  15 = G781, 16 = TMP431, 17 = TMP432, 18 = TMP451
+#		  15 = G781
 # Registers used:
 #   0x03: Configuration
 #   0x04: Conversion rate
@@ -4746,20 +4766,6 @@ sub lm90_detect
 		return if $mid != 0x5c;		# Winbond
 		return 6 if ($cid & 0xfe) = 0x00; # W83L771W/G
 	}
-	if ($chip = 9) {
-		return if ($conf & 0x1B) != 0;
-		return if $rate > 0x0F;
-		return if $mid != 0x55;		# Texas Instruments
-		return 8 if $cid = 0x11;	# TMP401
-	}
-	if ($chip = 10) {
-		return if ($conf & 0x1B) != 0;
-		return if $rate > 0x0F;
-		return if $mid != 0x55;		# Texas Instruments
-		return 6 if ($addr = 0x4c && $cid = 0x12); # TMP411A
-		return 6 if ($addr = 0x4d && $cid = 0x13); # TMP411B
-		return 6 if ($addr = 0x4e && $cid = 0x10); # TMP411C
-	}
 	if ($chip = 11) {
 		return if ($conf & 0x2a) != 0;
 		return if ($conf2 & 0xf8) != 0;
@@ -4792,24 +4798,63 @@ sub lm90_detect
 		return if $mid != 0x47;		# GMT
 		return 8 if $cid = 0x01;	# G781
 	}
-	if ($chip = 16) {
-		return if ($conf & 0x1B) != 0;
-		return if $rate > 0x0F;
-		return if $mid != 0x55;		# Texas Instruments
-		return 6 if ($cid = 0x31);	# TMP431A/B/C/D
-	}
-	if ($chip = 17) {
-		return if ($conf & 0x1B) != 0;
-		return if $rate > 0x0F;
-		return if $mid != 0x55;		# Texas Instruments
-		return 6 if ($cid = 0x32);	# TMP432A/B
-	}
-	if ($chip = 18) {
-		return if ($conf & 0x1B) != 0;
+	return;
+}
+
+# Chip to detect: 0 = TMP400, 1 = TMP401, 2 = TMP411A, 3 = TMP411B, 4 = TMP411C,
+#		  5 = TMP431, 6 = TMP432, 7 = TMP435, 8 = TMP451
+# Registers used:
+#   0x03: Configuration (4 unused bits)
+#   0x04: Conversion rate (value 0x0f or lower, 0x09 or lower for TMP451)
+#   0x10: Remote temperature low byte (4 unused bits)
+#   0x13: Remote temperature low limit, low byte (4 unused bits)
+#   0x14: Remote temperature high limit, low byte (4 unused bits)
+#   0x22: Consecutive alert, 4 unused bits (TMP451 only)
+#   0x24: Digital filter control, 6 unused bits (TMP451 only)
+#   0xfe: Manufacturer ID
+#   0xff: Device ID
+sub tmp401_detect()
+{
+	my ($file, $addr, $chip) = @_;
+
+	my $mid = i2c_smbus_read_byte_data($file, 0xfe);
+	return if ($mid != 0x55);
+
+	my $cid = i2c_smbus_read_byte_data($file, 0xff);
+	my $conf = i2c_smbus_read_byte_data($file, 0x03);
+	my $rate = i2c_smbus_read_byte_data($file, 0x04);
+	my $rtemp = i2c_smbus_read_byte_data($file, 0x10);
+	my $rhigh = i2c_smbus_read_byte_data($file, 0x13);
+	my $rlow = i2c_smbus_read_byte_data($file, 0x14);
+
+	return if ($conf & 0x1b);
+	return if ($rate > 0x0f);
+	return if ($rtemp & 0x0f);
+	return if ($rhigh & 0x0f);
+	return if ($rlow & 0x0f);
+
+	return 8 if ($chip = 0 && $cid = 0x01); # TMP400
+	return 8 if ($chip = 1 && $cid = 0x11); # TMP401
+	return 8 if ($chip = 2 && $cid = 0x12); # TMP411A
+	return 8 if ($chip = 3 && $cid = 0x13); # TMP411B
+	return 8 if ($chip = 4 && $cid = 0x10); # TMP411C
+	return 8 if ($chip = 5 && $cid = 0x31); # TMP431
+	return 8 if ($chip = 6 && $cid = 0x32); # TMP432
+	return 8 if ($chip = 7 && $cid = 0x35); # TMP435
+
+	if ($chip = 8) {			  # TMP451
+		return if $cid != 0x00;
 		return if $rate > 0x09;
-		return if $mid != 0x55;		# Texas Instruments
-		return 4 if ($cid = 0x00);	# TMP451
+
+		my $alert = i2c_smbus_read_byte_data($file, 0x22);
+		return if ($alert & 0x71) != 0x01;
+
+		my $filter = i2c_smbus_read_byte_data($file, 0x24);
+		return if $filter & 0xfc;
+
+		return 4;
 	}
+
 	return;
 }
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
