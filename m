From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Jan 2012 18:37:56 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of LM96080
Message-Id: <20120128193756.199ae777@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add detection of the National Semiconductor (now Texas Instruments)
LM96080. It is functionally compatible with the LM80 but detection is
completely different.
---
Frans, if you want to test this, a pre-patched version of
sensors-detect is available at:
http://khali.linux-fr.org/devel/misc/sensors-detect

 prog/detect/sensors-detect |   76 ++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2012-01-25 18:10:59.000000000 +0100
+++ lm-sensors/prog/detect/sensors-detect	2012-01-28 19:32:17.215343009 +0100
@@ -540,7 +540,12 @@ use vars qw(@i2c_adapter_names);
 		name => "National Semiconductor LM80",
 		driver => "lm80",
 		i2c_addrs => [0x28..0x2f],
-		i2c_detect => sub { lm80_detect(@_); },
+		i2c_detect => sub { lm80_detect(@_, 0); },
+	}, {
+		name => "National Semiconductor LM96080",
+		driver => "lm80",
+		i2c_addrs => [0x28..0x2f],
+		i2c_detect => sub { lm80_detect(@_, 1); },
 	}, {
 		name => "National Semiconductor LM85",
 		driver => "lm85",
@@ -4259,11 +4264,15 @@ sub ds1621_detect
 	return ($slope = 0x10 && $counter <= $slope) ? 3 : 2;
 }
 
+# Chip to detect: 0 = LM80, 1 = LM96080
 # Registers used:
 #   0x00: Configuration register
 #   0x02: Interrupt state register
-#   0x2a-0x3d: Limits registers
-# This one is easily misdetected since it doesn't provide identification
+#   0x07: Converstion rate register (LM96080 only)
+#   0x2a-0x3d: Limits registers (LM80 only)
+#   0x3e: Manufacturer's ID register (LM96080 only)
+#   0x3f: Steppind/die revision ID register (LM96080 only)
+# The LM80 is easily misdetected since it doesn't provide identification
 # registers. So we have to use some tricks:
 #   - 6-bit addressing, so limits readings modulo 0x40 should be unchanged
 #   - positive temperature limits
@@ -4276,44 +4285,51 @@ sub ds1621_detect
 # to loose comparisons did not change the score.
 sub lm80_detect
 {
-	my ($file, $addr) = @_;
+	my ($file, $addr, $chip) = @_;
 	my ($i, $reg);
 
 	return if (i2c_smbus_read_byte_data($file, 0x00) & 0x80) != 0;
 	return if (i2c_smbus_read_byte_data($file, 0x02) & 0xc0) != 0;
 
-	for ($i = 0x2a; $i <= 0x3d; $i++) {
-		$reg = i2c_smbus_read_byte_data($file, $i);
-		return if i2c_smbus_read_byte_data($file, $i+0x40) != $reg;
-		return if i2c_smbus_read_byte_data($file, $i+0x80) != $reg;
-		return if i2c_smbus_read_byte_data($file, $i+0xc0) != $reg;
-	}
+	if ($chip = 0) {
+		for ($i = 0x2a; $i <= 0x3d; $i++) {
+			$reg = i2c_smbus_read_byte_data($file, $i);
+			return if i2c_smbus_read_byte_data($file, $i+0x40) != $reg;
+			return if i2c_smbus_read_byte_data($file, $i+0x80) != $reg;
+			return if i2c_smbus_read_byte_data($file, $i+0xc0) != $reg;
+		}
 
-	# Refine a bit by checking whether limits are in the correct order
-	# (min<max for voltages, hyst<max for temperature). Since it is still
-	# possible that the chip is an LM80 with limits not properly set,
-	# a few "errors" are tolerated.
-	my $confidence = 0;
-	for ($i = 0x2a; $i <= 0x3a; $i++) {
+		# Refine a bit by checking whether limits are in the correct order
+		# (min<max for voltages, hyst<max for temperature). Since it is still
+		# possible that the chip is an LM80 with limits not properly set,
+		# a few "errors" are tolerated.
+		my $confidence = 0;
+		for ($i = 0x2a; $i <= 0x3a; $i++) {
+			$confidence++
+				if i2c_smbus_read_byte_data($file, $i) < i2c_smbus_read_byte_data($file, $i+1);
+		}
+		# hot temp<OS temp
 		$confidence++
-			if i2c_smbus_read_byte_data($file, $i) < i2c_smbus_read_byte_data($file, $i+1);
-	}
-	# hot temp<OS temp
-	$confidence++
-		if i2c_smbus_read_byte_data($file, 0x38) < i2c_smbus_read_byte_data($file, 0x3a);
+			if i2c_smbus_read_byte_data($file, 0x38) < i2c_smbus_read_byte_data($file, 0x3a);
 
-	# Negative temperature limits are unlikely.
-	for ($i = 0x3a; $i <= 0x3d; $i++) {
-		$confidence++ if (i2c_smbus_read_byte_data($file, $i) & 0x80) = 0;
-	}
+		# Negative temperature limits are unlikely.
+		for ($i = 0x3a; $i <= 0x3d; $i++) {
+			$confidence++ if (i2c_smbus_read_byte_data($file, $i) & 0x80) = 0;
+		}
 
-	# $confidence is between 0 and 14
-	$confidence = ($confidence >> 1) - 4;
-	# $confidence is now between -4 and 3
+		# $confidence is between 0 and 14
+		$confidence = ($confidence >> 1) - 4;
+		# $confidence is now between -4 and 3
 
-	return unless $confidence > 0;
+		return unless $confidence > 0;
+		return $confidence;
+	} elsif ($chip = 1) {
+		return if (i2c_smbus_read_byte_data($file, 0x07) & 0xfe) != 0;
+		return if i2c_smbus_read_byte_data($file, 0x3e) != 0x01;
+		return if i2c_smbus_read_byte_data($file, 0x3f) != 0x08;
 
-	return $confidence;
+		return 6;
+	}
 }
 
 # Registers used:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
