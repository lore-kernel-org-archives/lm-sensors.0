From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Jan 2013 04:40:48 +0000
Subject: [lm-sensors] [PATCH 2/2] sensors-detect: Add detection of MCP98244
Message-Id: <1359434448-21181-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MCP98244 is a JC42 temperature sensor.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |    3 ++-
 prog/detect/sensors-detect |   13 ++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/CHANGES b/CHANGES
index 465bd61..90e1e89 100644
--- a/CHANGES
+++ b/CHANGES
@@ -4,7 +4,8 @@ lm-sensors CHANGES file
 SVN HEAD
   sensors.conf.5: Mention "sensors -u" to get the raw feature names
   sensors: Clarify what option -u is good for
-  sensors-detect: Add detection of IT8752F
+  sensors-detect: Add detection of MCP98244
+                  Add detection of IT8752F
                   Add detection of AMD family 16h power sensors
                   Map IT8771E, IT8772E, IT8782F and IT8783F to it87
                   Use /sys/module instead of /proc/modules where available
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 59378c2..7db4812 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1400,6 +1400,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 7); },
 	}, {
+		name => "Microchip MCP98244",
+		driver => "jc42",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 15); },
+	}, {
 		name => "Microchip MCP9843",
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
@@ -6058,7 +6063,7 @@ sub max6655_detect
 #                 4 = TS3000/TSE2002, 5 = MAX6604, 6 = MCP98242,
 #                 7 = MCP98243, 8 = MCP9843, 9 = CAT6095 / CAT34TS02,
 #                 10 = STTS424E, 11 = STTS2002, 12 = STTS3000
-#                 13 = MCP9804, 14 = AT30TS00
+#                 13 = MCP9804, 14 = AT30TS00, 15 = MCP98244
 # Registers used:
 #   0x00: Capabilities
 #   0x01: Configuration
@@ -6127,6 +6132,9 @@ sub jedec_JC42_4_detect
 	} elsif ($chip = 14) {
 		return unless $manid = 0x00;		# Atmel
 		return unless $devid = 0x82;		# AT30TS00
+	} elsif ($chip = 15) {
+		return unless $manid = 0x00;		# MCP
+		return unless $devid = 0x22;		# MCP98244
 	}
 
 	# Now, do it all again with words. Note that we get
@@ -6184,6 +6192,9 @@ sub jedec_JC42_4_detect
 	} elsif ($chip = 14) {
 		return unless $manid = 0x1f00;		# Atmel
 		return unless ($devid & 0xfeff) = 0x0082; # AT30TS00
+	} elsif ($chip = 15) {
+		return unless $manid = 0x5400;		# MCP
+		return unless ($devid & 0xfcff) = 0x0022; # MCP98244
 	}
 
 	return 5;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
