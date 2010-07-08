From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Jul 2010 20:15:06 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add support for several JC42.4
Message-Id: <1278620106-22242-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100706222437.GA31051@ericsson.com>
In-Reply-To: <20100706222437.GA31051@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for several JC42.4 compliant temperature sensors to
sensors-detect.

---
Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5851)
+++ prog/detect/sensors-detect	(working copy)
@@ -1195,6 +1195,51 @@
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 1); },
 	}, {
+		name => "NXP SE98",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 2); },
+	}, {
+		name => "Analog Devices ADT7408",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 3); },
+	}, {
+		name => "IDT TS3000/TSE2002",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 4); },
+	}, {
+		name => "Maxim MAX6604",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 5); },
+	}, {
+		name => "Microchip MCP98242",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 6); },
+	}, {
+		name => "Microchip MCP98243",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 7); },
+	}, {
+		name => "Microchip MCP9843",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 8); },
+	}, {
+		name => "ON CAT6095/CAT34TS02",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 9); },
+	}, {
+		name => "ST STTS424E",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 10); },
+	}, {
 		name => "Smart Battery",
 		driver => "sbs", # ACPI driver, not sure if it always works
 		i2c_addrs => [0x0b],
@@ -5314,7 +5359,10 @@
 	return 6;
 }
 
-# Chip to detect: 0 = STTS424, 1 = SE97/SE97B
+# Chip to detect: 0 = STTS424, 1 = SE97/SE97B, 2 = SE98, 3 = ADT7408,
+#                 4 = TS3000/TSE2002, 5 = MAX6604, 6 = MCP98242,
+#                 7 = MCP98243, 8 = MCP9843, 9 = CAT6095 / CAT34TS02,
+#                 10 = STTS424E
 # Registers used:
 #   0x00: Capabilities
 #   0x01: Configuration
@@ -5340,10 +5388,37 @@
 
 	if ($chip = 0) {
 		return unless $manid = 0x10;		# STMicrolectronics
-		return unless $devid = 0x00;		# STTS424
+		return unless $devid = 0x01;		# STTS424
 	} elsif ($chip = 1) {
 		return unless $manid = 0x11;		# NXP
 		return unless $devid = 0xa2;		# SE97
+	} elsif ($chip = 2) {
+		return unless $manid = 0x11;		# NXP
+		return unless $devid = 0xa1;		# SE98
+	} elsif ($chip = 3) {
+		return unless $manid = 0x11;		# ADT
+		return unless $devid = 0x08;		# ADT7408
+	} elsif ($chip = 4) {
+		return unless $manid = 0x00;		# IDT
+		return unless $devid = 0x29;		# TS3000/TSE2002
+	} elsif ($chip = 5) {
+		return unless $manid = 0x00;		# MAXIM
+		return unless $devid = 0x3e;		# MAX6604
+	} elsif ($chip = 6) {
+		return unless $manid = 0x00;		# MCP
+		return unless $devid = 0x20;		# MCP98242
+	} elsif ($chip = 7) {
+		return unless $manid = 0x00;		# MCP
+		return unless $devid = 0x21;		# MCP98243
+	} elsif ($chip = 8) {
+		return unless $manid = 0x00;		# MCP
+		return unless $devid = 0x00;		# MCP9843
+	} elsif ($chip = 9) {
+		return unless $manid = 0x1b;		# ONS
+		return unless $devid = 0x08;		# CAT6095 / CAT34TS02
+	} elsif ($chip = 10) {
+		return unless $manid = 0x10;		# STMicrolectronics
+		return unless $devid = 0x00;		# STTS424E02
 	}
 
 	# Now, do it all again with words. Note that we get
@@ -5358,10 +5433,37 @@
 	return if $manid < 0 || $devid < 0;
 	if ($chip = 0) {
 		return unless $manid = 0x4a10;		# STMicrolectronics
-		return unless ($devid & 0xfeff) = 0x0000; # STTS424
+		return unless ($devid & 0xfeff) = 0x0001; # STTS424
 	} elsif ($chip = 1) {
 		return unless $manid = 0x3111;		# NXP
 		return unless ($devid & 0xfcff) = 0x00a2; # SE97
+	} elsif ($chip = 2) {
+		return unless $manid = 0x3111;		# NXP
+		return unless ($devid & 0xfcff) = 0x00a1; # SE98
+	} elsif ($chip = 3) {
+		return unless $manid = 0xd411;		# ADT
+		return unless $devid = 0x0108;		# ADT7408
+	} elsif ($chip = 4) {
+		return unless $manid = 0xb300;		# IDT
+		return unless $devid = 0x0329;		# TS3000/TSE2002
+	} elsif ($chip = 5) {
+		return unless $manid = 0x4d00;		# MAXIM
+		return unless $devid = 0x003e;		# MAX6604
+	} elsif ($chip = 6) {
+		return unless $manid = 0x5400;		# MCP
+		return unless ($devid & 0xfcff) = 0x0020; # MCP98242
+	} elsif ($chip = 7) {
+		return unless $manid = 0x5400;		# MCP
+		return unless ($devid & 0xfcff) = 0x0021; # MCP98243
+	} elsif ($chip = 8) {
+		return unless $manid = 0x5400;		# MCP
+		return unless ($devid & 0xfcff) = 0x0000; # MCP9843
+	} elsif ($chip = 9) {
+		return unless $manid = 0x091b;		# ONS
+		return unless ($devid & 0xe0ff) = 0x0008; # CAT6095 / CAT34TS02
+	} elsif ($chip = 10) {
+		return unless $manid = 0x4a10;		# STMicrolectronics
+		return unless ($devid & 0xfeff) = 0x0000; # STTS424E02
 	}
 
 	return 5;
Index: CHANGES
=================================--- CHANGES	(revision 5851)
+++ CHANGES	(working copy)
@@ -20,6 +20,7 @@
                   Add support for STMicroelectronics STTS424
                   Add support for NXP SE97 / SE97B
                   Add reference to NCT6771F/NCT6772F/NCT6775F
+                  Add support for several JC42.4 compliant temperature sensors
 
 3.1.2 (2010-02-02)
   libsensors: Support upcoming sysfs path to i2c adapters

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
