From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 06 Mar 2012 05:21:14 +0000
Subject: [lm-sensors] [PATCH] Add detection of IDT TSE2002GB2, TS3000GB2, Microchip MCP9804, and Atmel AT30TS
Message-Id: <1331011274-24650-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

More JC42 compliant chips .. to consider after the other JC42 related patch is committed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---

 CHANGES                    |    2 ++
 prog/detect/sensors-detect |   27 +++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/CHANGES b/CHANGES
index 8981e69..9839aa2 100644
--- a/CHANGES
+++ b/CHANGES
@@ -22,6 +22,8 @@ SVN HEAD
                   Add detection of ITE IT8771E
                   Add detection of ITE IT8781F, IT8782F and IT8783F
                   Add detection of ITE IT8510E/TE/G, IT8511E/TE/G, IT8513E/F/G, and IT8518E
+                  Add detection of IDT TSE2002GB2, TS3000GB2, Microchip MCP9804,
+                  and Atmel AT30TS00
 
 3.3.1 (2011-07-21)
   isadump: Add support for word (16-bit) and long (32-bit) reads
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 93621ad..9015e5b 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1375,6 +1375,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 5); },
 	}, {
+		name => "Microchip MCP9804",
+		driver => "jc42",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 13); },
+	}, {
 		name => "Microchip MCP98242",
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
@@ -1394,6 +1399,11 @@ use vars qw(@i2c_adapter_names);
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 9); },
+	}, {
+		name => "Atmel AT30TS00",
+		driver => "jc42",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 14); },
 	}
 );
 
@@ -5985,7 +5995,8 @@ sub max6655_detect
 # Chip to detect: 0 = STTS424, 1 = SE97/SE97B, 2 = SE98, 3 = ADT7408,
 #                 4 = TS3000/TSE2002, 5 = MAX6604, 6 = MCP98242,
 #                 7 = MCP98243, 8 = MCP9843, 9 = CAT6095 / CAT34TS02,
-#                 10 = STTS424E
+#                 10 = STTS424E,
+#                 13 = MCP9804, 14 = AT030TS00
 # Registers used:
 #   0x00: Capabilities
 #   0x01: Configuration
@@ -6042,6 +6053,12 @@ sub jedec_JC42_4_detect
 	} elsif ($chip = 10) {
 		return unless $manid = 0x10;		# STMicrolectronics
 		return unless $devid = 0x00;		# STTS424E02
+	} elsif ($chip = 13) {
+		return unless $manid = 0x00;		# MCP
+		return unless $devid = 02;		# MCP9804
+	} elsif ($chip = 14) {
+		return unless $manid = 0x00;		# Atmel
+		return unless $devid = 0x82;		# AT30TS00
 	}
 
 	# Now, do it all again with words. Note that we get
@@ -6068,7 +6085,7 @@ sub jedec_JC42_4_detect
 		return unless $devid = 0x0108;		# ADT7408
 	} elsif ($chip = 4) {
 		return unless $manid = 0xb300;		# IDT
-		return unless $devid = 0x0329;		# TS3000/TSE2002
+		return unless $devid = 0x0329 || $devid = 0x1229; # TS3000/TSE2002
 	} elsif ($chip = 5) {
 		return unless $manid = 0x4d00;		# MAXIM
 		return unless $devid = 0x003e;		# MAX6604
@@ -6087,6 +6104,12 @@ sub jedec_JC42_4_detect
 	} elsif ($chip = 10) {
 		return unless $manid = 0x4a10;		# STMicrolectronics
 		return unless ($devid & 0xfeff) = 0x0000; # STTS424E02
+	} elsif ($chip = 13) {
+		return unless $manid = 0x5400;		# MCP
+		return unless ($devid & 0xfcff) = 0x0002; # MCP9804
+	} elsif ($chip = 14) {
+		return unless $manid = 0x1f00;		# Atmel
+		return unless ($devid & 0xfeff) = 0x0082; # STTS424E02
 	}
 
 	return 5;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
