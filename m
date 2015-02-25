From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Feb 2015 05:06:22 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Detect additional IDT temperature sensors
Message-Id: <1424840782-27848-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Loosen detection rules for TS3000/TSE2002 to detect additional
chip revisions. Add detection of TSE2004 and TS3001.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |  2 ++
 prog/detect/sensors-detect | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/CHANGES b/CHANGES
index ed95b66..9237506 100644
--- a/CHANGES
+++ b/CHANGES
@@ -30,6 +30,8 @@ SVN HEAD
                   Add detection of IT8780F
                   Add detection of IT8731F and IT8732F
                   Add detection of Intel 5500/5520/X58
+                  Loosen detection rules for TS3000/TSE2002
+                  Add detection of TSE2004 and TS3001
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 8becff3..8fb1ae3 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1455,6 +1455,16 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 4); },
 	}, {
+		name => "IDT TSE2004",
+		driver => "jc42",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 16); },
+	}, {
+		name => "IDT TS3001",
+		driver => "jc42",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 17); },
+	}, {
 		name => "Maxim MAX6604",
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
@@ -6370,7 +6380,8 @@ sub max6655_detect
 #                 4 = TS3000/TSE2002, 5 = MAX6604, 6 = MCP98242,
 #                 7 = MCP98243, 8 = MCP9843, 9 = CAT6095 / CAT34TS02,
 #                 10 = STTS424E, 11 = STTS2002, 12 = STTS3000
-#                 13 = MCP9804, 14 = AT30TS00, 15 = MCP98244
+#                 13 = MCP9804, 14 = AT30TS00, 15 = MCP98244,
+#                 16 = TSE2004, 17 = TS3001
 # Registers used:
 #   0x00: Capabilities
 #   0x01: Configuration
@@ -6468,7 +6479,7 @@ sub jedec_JC42_4_detect
 		return unless $devid = 0x0108;		# ADT7408
 	} elsif ($chip = 4) {
 		return unless $manid = 0xb300;		# IDT
-		return unless $devid = 0x0329 || $devid = 0x1229; # TS3000/TSE2002
+		return unless ($devid & 0x00ff) = 0x0029; # TS3000/TSE2002
 	} elsif ($chip = 5) {
 		return unless $manid = 0x4d00;		# MAXIM
 		return unless $devid = 0x003e;		# MAX6604
@@ -6502,6 +6513,12 @@ sub jedec_JC42_4_detect
 	} elsif ($chip = 15) {
 		return unless $manid = 0x5400;		# MCP
 		return unless ($devid & 0xfcff) = 0x0022; # MCP98244
+	} elsif ($chip = 16) {
+		return unless $manid = 0xb300;		# IDT
+		return unless ($devid & 0x00ff) = 0x0022; # TSE2004
+	} elsif ($chip = 17) {
+		return unless $manid = 0xb300;		# IDT
+		return unless ($devid & 0x00ff) = 0x0030; # TS3001
 	}
 
 	return 5;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
