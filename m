From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 May 2011 09:08:57 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Drop smart battery detection
Message-Id: <20110505110857.3db7a3dd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Drop smart battery detection. Rationale:
* The detection is unreliable, we had reports of false positives.
* Upon successful detection, the script suggests using the sbs driver,
  however this is an ACPI driver, not a native driver, so if
  sensors-detect was able to access device, most likely ACPI won't
  so the sbs driver won't work.
* The sbs driver should get loaded automatically where needed anyway.

---
 prog/detect/sensors-detect |   18 ------------------
 1 file changed, 18 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2011-05-05 10:39:55.000000000 +0200
+++ lm-sensors/prog/detect/sensors-detect	2011-05-05 10:42:39.000000000 +0200
@@ -1344,11 +1344,6 @@ use vars qw(@i2c_adapter_names);
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 9); },
-	}, {
-		name => "Smart Battery",
-		driver => "sbs", # ACPI driver, not sure if it always works
-		i2c_addrs => [0x0b],
-		i2c_detect => sub { smartbatt_detect(@_); },
 	}
 );
 
@@ -5705,19 +5700,6 @@ sub emc1403_detect
 	return 6;
 }
 
-# This checks for non-FFFF values for temperature, voltage, and current.
-# The address (0x0b) is specified by the SMBus standard so it's likely
-# that this really is a smart battery.
-sub smartbatt_detect
-{
-	my ($file, $addr) = @_;
-
-	return if i2c_smbus_read_word_data($file, 0x08) = 0xffff
-	       || i2c_smbus_read_word_data($file, 0x09) = 0xffff
-	       || i2c_smbus_read_word_data($file, 0x0a) = 0xffff;
-	return 5;
-}
-
 # Chip to detect: 0 = W83L784R/AR/G, 1 = W83L785R/G, 2 = W83L786NR/NG/R/G,
 #		  3 = W83L785TS-S
 # Registers used:


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
