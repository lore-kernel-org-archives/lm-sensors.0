From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 18 Jan 2015 18:34:21 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of IT8780F
Message-Id: <1421606061-645-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The chip does not seem to be widely used, but its datasheet is available,
and superiotool has basic support for it, so it makes sense to detect it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    | 1 +
 prog/detect/sensors-detect | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/CHANGES b/CHANGES
index 03eb7fb..9304ce2 100644
--- a/CHANGES
+++ b/CHANGES
@@ -27,6 +27,7 @@ SVN HEAD
                   Document driver support for TMP431 and TMP432
                   Add detection of TMP400 and TMP435
                   Add detection of IT8786E
+                  Add detection of IT8780F
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 9b7ba8f..c5a49f5 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2371,6 +2371,12 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x04,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
+		name => "ITE IT8780F Super IO Sensors",
+		driver => "to-be-written",	# it87
+		devid => 0x8780,
+		logdev => 0x04,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "ITE IT8781F Super IO Sensors",
 		driver => "to-be-written",	# it87
 		devid => 0x8781,
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
