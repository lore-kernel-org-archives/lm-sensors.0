From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Nov 2014 17:59:58 +0000
Subject: [lm-sensors] [PATCH 1/2] sensors-detect: Nuvoton chip updates
Message-Id: <1416333599-12717-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add reference to nct6883 driver.
Show that nct6775 driver supports NCT6792D.
Show that NCT6102D/6104D/6106D are supported by nct6775 driver
NCT5573D is compatible to NCT6776F and has the same chip ID.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    | 4 ++++
 prog/detect/sensors-detect | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/CHANGES b/CHANGES
index 27cfa4d..62cfd24 100644
--- a/CHANGES
+++ b/CHANGES
@@ -17,6 +17,10 @@ SVN HEAD
                   Add detection of NCT7802Y
                   Print kernel version and processor information
                   Add detection of NCT6792D 
+                  Add reference to nct6883 driver
+                  Show that NCT6102D/6104D/6106D are supported by nct6775 driver
+                  Show that NCT5573D is compatible to NCT6776F and has the same
+                  chip ID.
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index bb233e2..610338b 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2096,7 +2096,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		driver => "not-a-sensor",
 		devid => 0x61,
 	}, {
-		name => "Nuvoton NCT5577D/NCT6776F Super IO Sensors",
+		name => "Nuvoton NCT5573D/NCT5577D/NCT6776F Super IO Sensors",
 		driver => "nct6775",
 		devid => 0xC330,
 		devid_mask => 0xFFF0,
@@ -2111,7 +2111,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
 		name => "Nuvoton NCT6683D eSIO",
-		driver => "to-be-written",
+		driver => "nct6883",
 		devid => 0xC730,
 		devid_mask => 0xFFF0,
 		logdev => 0x0b,
@@ -2132,7 +2132,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
 		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
-		driver => "to-be-written",	# nct6775
+		driver => "nct6775",
 		devid => 0xC450,
 		devid_mask => 0xFFF0,
 		logdev => 0x0b,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
