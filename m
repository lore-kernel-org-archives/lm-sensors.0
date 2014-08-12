From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Aug 2014 23:05:57 +0000
Subject: [lm-sensors] [PATCH v2] sensors-detect: Nuvoton chip updates
Message-Id: <1407884757-8752-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add reference to nct6883 driver
Add detection of NCT6792D
Show that NCT6102D/6104D/6106D are supported by nct6775 driver
NCT5573D is compatible to NCT6776F and has the same chip ID.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added NCT5573D

 CHANGES                    |  4 ++++
 prog/detect/sensors-detect | 13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/CHANGES b/CHANGES
index a16e7be..99f3004 100644
--- a/CHANGES
+++ b/CHANGES
@@ -14,6 +14,10 @@ SVN HEAD
                   Add detection of TMP441, TMP442, LM95233, LM95234,
                   and LM95235
                   Add detection of NCT7802Y
+                  Add reference to nct6883 driver
+                  Add detection of NCT6792D
+                  Show that NCT6102D/6104D/6106D are supported by nct6775 driver
+		  Show that NCT5573D is compatible to NCT6776F and has the same chip ID.
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 9ce0cf2..b457e65 100755
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
@@ -2124,8 +2124,15 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
+		name => "Nuvoton NCT6792D Super IO Sensors",
 		driver => "to-be-written",	# nct6775
+		devid => 0xC910,
+		devid_mask => 0xFFF0,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
+		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
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
