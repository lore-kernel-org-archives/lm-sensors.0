From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 May 2011 20:55:11 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Drop MAX6650/51 detection
Message-Id: <20110505225511.0eb5070d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop MAX6650/51 detection. It's unreliable, and that's not the kind
of chip I expect to be seen in a PC. People who have this chip know
that they do, they don't need sensors-detect to tell them.
---
I plan to drop detection from the max6650 driver too, for the same
reason.

 prog/detect/sensors-detect |   33 ---------------------------------
 1 file changed, 33 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2011-05-05 22:46:59.000000000 +0200
+++ lm-sensors/prog/detect/sensors-detect	2011-05-05 22:51:11.000000000 +0200
@@ -848,11 +848,6 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x2c, 0x2e, 0x2f],
 		i2c_detect => sub { max6639_detect(@_); },
 	}, {
-		name => "Maxim MAX6650/MAX6651",
-		driver => "max6650",
-		i2c_addrs => [0x1b, 0x1f, 0x48, 0x4b],
-		i2c_detect => sub { max6650_detect(@_); },
-	}, {
 		name => "Maxim MAX6655/MAX6656",
 		driver => "max6655",
 		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
@@ -5776,34 +5771,6 @@ sub max6639_detect
 	return 6;
 }
 
-# The max6650 has no device ID register. However, a few registers have
-# spare bits, which are documented as being always zero on read. We read
-# all of these registers check the spare bits. Any non-zero means this
-# is not a max6650/1.
-#
-# The always zero bits are:
-#   configuration byte register (0x02) - top 2 bits
-#   gpio status register (0x14) - top 3 bits
-#   alarm enable register (0x08) - top 3 bits
-#   alarm status register (0x0A) - top 3 bits
-#   tachometer count time register (0x16) - top 6 bits
-# Additionally, not all values are possible for lower 3 bits of
-# the configuration register.
-sub max6650_detect
-{
-	my ($file, $addr) = @_;
-
-	my $conf = i2c_smbus_read_byte_data($file, 0x02);
-
-	return if i2c_smbus_read_byte_data($file, 0x16) & 0xFC;
-	return if i2c_smbus_read_byte_data($file, 0x0A) & 0xE0;
-	return if i2c_smbus_read_byte_data($file, 0x08) & 0xE0;
-	return if i2c_smbus_read_byte_data($file, 0x14) & 0xE0;
-	return if ($conf & 0xC0) or ($conf & 0x07) > 4;
-
-	return 2;
-}
-
 sub max6655_detect
 {
 	my ($file, $addr) = @_;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
