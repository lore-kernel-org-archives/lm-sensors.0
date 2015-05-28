From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 28 May 2015 15:50:35 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Skip addresses 0x37 and 0x4f on DDC channels
Message-Id: <20150528175035.0127e5d1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We already skip EDID addresses (0x50-0x57) by default on graphics card
I2C/DDC buses. Also skip 0x37 (DDC/CI) and 0x4f which was recently
reported as corrupting a laptop's display when probed.

This closes ticket #2392.
http://www.lm-sensors.org/ticket/2392
---
 prog/detect/sensors-detect |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2015-05-28 17:15:58.685620089 +0200
+++ lm-sensors/prog/detect/sensors-detect	2015-05-28 17:46:56.573270434 +0200
@@ -3943,8 +3943,10 @@ sub scan_i2c_adapter
 		chomp($input);
 		@not_to_scan = parse_not_to_scan(0x03, 0x77, $input);
 	} elsif (($class & 0xff00) = 0x0300) {
-		# Skip EDID addresses by default on graphics adapters
-		@not_to_scan = parse_not_to_scan(0x03, 0x77, "0x50-0x57");
+		# Skip EDID and DDC/CI addresses by default on graphics
+		# adapters. Also skip address 0x4f which was reported in a
+		# display corruption case.
+		@not_to_scan = parse_not_to_scan(0x03, 0x77, "0x37,0x50-0x57,0x4f");
 	}
 
 	open(local *FILE, "$dev_i2c$adapter_nr") or


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
