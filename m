From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 01 Jun 2012 02:03:27 +0000
Subject: [lm-sensors] [PATCH resend] sensors-detect: Add detection of NCT6779D and NCT6102D/NCT6106D
Message-Id: <1338516207-6072-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |    1 +
 prog/detect/sensors-detect |   12 ++++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/CHANGES b/CHANGES
index 615ed65..b08d205 100644
--- a/CHANGES
+++ b/CHANGES
@@ -6,6 +6,7 @@ SVN HEAD
   sensors: Fix libiconv linkage need detection in rare corner case
   sensors-detect: Don't choke on systems without PCI
                   Avoid probing EDID addresses on graphics cards (#2386)
+		  Add detection of NCT6779D and NCT6102D/NCT6106D
 
 3.3.2 (2012-03-14)
   libsensors: Added support for new sysfs attributes
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 58f7fd0..6bfd1e2 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2034,6 +2034,18 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "Nuvoton NCT6779D Super IO Sensors",
+		driver => "to-be-written",	# nct6775, new driver
+		devid => 0xC562,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
+		name => "Nuvoton NCT6102D/NCT6106D Super IO Sensors",
+		driver => "to-be-written",	# nct6775, new driver
+		devid => 0x1061,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "Fintek F71805F/FG Super IO Sensors",
 		driver => "f71805f",
 		devid => 0x0406,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
