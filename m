From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 12 May 2020 14:23:08 +0000
Subject: [PATCH] sensors-detect: Move Winbond WPCD377I to the non-hwmon table
Message-Id: <20200512162308.5efc21d7@endymion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move the detection entry for the Winbond WPCD377I to the
@non_hwmon_chip_ids table, where it belongs. This saves one line, and
more importantly prevents "not-a-sensor" from being accidentally
added to the list of kernel drivers.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 prog/detect/sensors-detect |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2020-05-12 11:08:57.101496194 +0200
+++ lm-sensors/prog/detect/sensors-detect	2020-05-12 16:18:49.375617471 +0200
@@ -719,11 +719,6 @@
 		i2c_addrs => [0x2c..0x2e],
 		i2c_detect => sub { emc6w201_detect(@_); },
 	}, {
-		name => "Winbond WPCD377I",
-		driver => "not-a-sensor",
-		i2c_addrs => [0x2c..0x2e],
-		i2c_detect => sub { lm85_detect(@_, 7); },
-	}, {
 		name => "Analog Devices ADT7462",
 		driver => "adt7462",
 		i2c_addrs => [0x5c, 0x58],
@@ -1684,6 +1679,10 @@
 		i2c_addrs => [0x2c..0x2f],
 		i2c_detect => sub { w83791sd_detect(@_); },
 	}, {
+		name => "Winbond WPCD377I",
+		i2c_addrs => [0x2c..0x2e],
+		i2c_detect => sub { lm85_detect(@_, 7); },
+	}, {
 		name => "Fintek F75111R/RG/N (GPIO)",
 		i2c_addrs => [0x37, 0x4e],
 		i2c_detect => sub { fintek_detect(@_, 1); },


-- 
Jean Delvare
SUSE L3 Support
