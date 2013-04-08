From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Apr 2013 08:25:39 +0000
Subject: [lm-sensors] [PATCH v2] sensors-detect: Update Nuvoton chip information
Message-Id: <1365409539-17414-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT5577D datasheet says that the chip ID can be 0xC333, same as NCT6776F.
So we can not use the chip revision to detect the actual chip.
Merge entries for NCT5577D and NCT6776F into one.

List NCT5572D as another variant of W83677HG-I (NCT6775).

NCT6106D chip ID as observed on a real system is 0xC452, not 0x1061 as
claimed by the data sheet. Confirmed with Nuvoton that the correct
chip ID is 0xC452. Also list its variants NCT6102D and NCT6104D.

List NCT5532D as variant of NCT6779D. Data sheets list possible chip
IDs of 0xC561 and 0xC562, so detect and accept all chip revisions.

Point to new nct6775 driver for NCT6775, NCT6776, and NCT6779.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Chip ID for NCT6106D is 0xC452. 0x1061 was wrong.

 CHANGES                    |    1 +
 prog/detect/sensors-detect |   29 +++++++++++++----------------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/CHANGES b/CHANGES
index ba6409f..19e9b08 100644
--- a/CHANGES
+++ b/CHANGES
@@ -13,6 +13,7 @@ SVN HEAD
                   Add detection of MCP98244
                   Add detection of LM95234
                   Add detection of TMP431/TMP432
+                  Update Nuvoton chip information and NCT6106D chip detection
 
 3.3.3 "Happy Birthday Sophie" (2012-11-06)
   documentation: Update fan-divisors, fan divisors are optional
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 00e3904..e0ea2f2 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2043,7 +2043,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-		name => "Nuvoton W83677HG-I (NCT6771F/NCT6772F/NCT6775F) Super IO Sensors",
+		name => "Nuvoton W83677HG-I (NCT5572D/NCT6771F/NCT6772F/NCT6775F) Super IO Sensors",
 		driver => "w83627ehf",
 		devid => 0xB470,
 		devid_mask => 0xFFF0,
@@ -2054,27 +2054,24 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		driver => "not-a-sensor",
 		devid => 0x61,
 	}, {
-		name => "Nuvoton NCT5577D Super IO Sensors",
-		driver => "to-be-written",
-		devid => 0xC331,
-		logdev => 0x0b,
-		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
-	}, {
-		name => "Nuvoton NCT6776F Super IO Sensors",
-		driver => "w83627ehf",
-		devid => 0xC333,
+		name => "Nuvoton NCT5577D/NCT6776F Super IO Sensors",
+		driver => "nct6775",
+		devid => 0xC330,
+		devid_mask => 0xFFF0,
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-		name => "Nuvoton NCT6779D Super IO Sensors",
-		driver => "to-be-written",	# nct6775, new driver
-		devid => 0xC562,
+		name => "Nuvoton NCT5532D/NCT6779D Super IO Sensors",
+		driver => "nct6775",
+		devid => 0xC560,
+		devid_mask => 0xFFF0,
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-		name => "Nuvoton NCT6102D/NCT6106D Super IO Sensors",
-		driver => "to-be-written",	# nct6775, new driver
-		devid => 0x1061,
+		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
+		driver => "to-be-written",	# nct6775
+		devid => 0xC450,
+		devid_mask => 0xFFF0,
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
