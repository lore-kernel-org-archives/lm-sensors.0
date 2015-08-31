From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Aug 2015 03:57:54 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of Novoton NCT6793D
Message-Id: <1440993474-17196-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    | 1 +
 prog/detect/sensors-detect | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/CHANGES b/CHANGES
index af4ee59..95fed99 100644
--- a/CHANGES
+++ b/CHANGES
@@ -6,6 +6,7 @@ SVN HEAD
   sensors-detect: Fix systemd paths
                   Add detection of Fintek F81768
                   Only probe I/O ports on x86
+                  Add detection of Nuvoton NCT6793D
 
 3.4.0 (2015-06-25)
   documentation: Update the note about libsensors license
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 3a44141..234dc39 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2171,6 +2171,13 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "Nuvoton NCT6793D Super IO Sensors",
+		driver => "nct6775",
+		devid => 0xD110,
+		devid_mask => 0xFFF0,
+		logdev => 0x0b,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "Nuvoton NCT6102D/NCT6104D/NCT6106D Super IO Sensors",
 		driver => "nct6775",
 		devid => 0xC450,
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
