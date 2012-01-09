From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Jan 2012 00:21:22 +0000
Subject: [lm-sensors] [PATCH 1/3] sensors-detect: Add detection of ITE
Message-Id: <1326068484-1898-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |    1 +
 prog/detect/sensors-detect |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/CHANGES b/CHANGES
index 3ae863c..ce04e54 100644
--- a/CHANGES
+++ b/CHANGES
@@ -10,6 +10,7 @@ SVN HEAD
                   Fix loading of the cpuid module
                   Make LM73 detection less problematic
                   Add detection of National Semiconductor LM96163
+                  Add detection of ITE IT8510E
 
 3.3.1 (2011-07-21)
   isadump: Add support for word (16-bit) and long (32-bit) reads
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 31a4619..1beb66b 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -2076,6 +2076,12 @@ use constant FEAT_SMBUS	=> (1 << 7);
 
 @superio_ids_ite = (
 	{
+		name => "ITE IT8510E Super IO Sensors",
+		driver => "to-be-written",
+		devid => 0x8510,
+		logdev => 0x04,
+		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
+	}, {
 		name => "ITE IT8702F Super IO Fan Sensors",
 		driver => "to-be-written",
 		devid => 0x8702,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
