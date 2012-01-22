From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 22 Jan 2012 23:31:26 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of G781 and G781-1
Message-Id: <1327275086-29396-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
untested

 CHANGES                    |    1 +
 prog/detect/sensors-detect |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/CHANGES b/CHANGES
index c776e84..f5fdb57 100644
--- a/CHANGES
+++ b/CHANGES
@@ -15,6 +15,7 @@ SVN HEAD
                   Fix loading of the cpuid module
                   Make LM73 detection less problematic
                   Add detection of National Semiconductor LM96163
+                  Add detection of G781 and G781-1
 
 3.3.1 (2011-07-21)
   isadump: Add support for word (16-bit) and long (32-bit) reads
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 31a4619..e0db4a8 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -818,6 +818,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
 		i2c_detect => sub { adm1021_detect(@_, 1); },
 	}, {
+		name => "Global Mixed-mode Technology G781/G781-1",
+		driver => "lm90",
+		i2c_addrs => [0x4c, 0x4d],
+		i2c_detect => sub { lm90_detect(@_, 15); },
+	}, {
 		name => "Maxim MAX1617",
 		driver => "adm1021",
 		i2c_addrs => [0x18..0x1a, 0x29..0x2b, 0x4c..0x4e],
@@ -4364,7 +4369,8 @@ sub max6680_95_detect
 #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
 #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
 #		  11 = W83L771AWG/ASG, 12 = MAX6690,
-#		  13 = ADT7461A/NCT1008, 14 = SA56004
+#		  13 = ADT7461A/NCT1008, 14 = SA56004,
+#		  15 = GMT G781/G781-1
 # Registers used:
 #   0x03: Configuration
 #   0x04: Conversion rate
@@ -4476,6 +4482,13 @@ sub lm90_detect
 		return if $mid != 0xa1;		# NXP Semiconductor/Philips
 		return 6 if $cid = 0x00;	# SA56004
 	}
+	if ($chip = 15) {
+		return if ($conf & 0x3f) != 0;
+		return if $rate > 0x08;
+		return if $mid != 0x47;		# GMT
+		return 8 if ($addr = 0x4c && $cid = 0x01);	# G781
+		return 8 if ($addr = 0x4d && $cid = 0x03);	# G781-1
+	}
 	return;
 }
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
