From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 07:21:37 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add code to detect ADT7461A /
Message-Id: <20110406072137.GB23562@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds code to detect ADT7461A / NCT1008 to sensors-detect.

---

Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5954)
+++ prog/detect/sensors-detect	(working copy)
@@ -1045,6 +1045,11 @@
 		i2c_addrs => [0x4c..0x4d],
 		i2c_detect => sub { lm90_detect(@_, 5); },
 	}, {
+		name => "Analog Devices ADT7461A, ON Semiconductor NCT1008",
+		driver => "to-be-written",	# lm90
+		i2c_addrs => [0x4c..0x4d],
+		i2c_detect => sub { lm90_detect(@_, 13); },
+	}, {
 		name => "Analog Devices ADT7481",
 		driver => "to-be-written",
 		i2c_addrs => [0x4c, 0x4b],
@@ -4317,7 +4322,8 @@
 #		  4 = MAX6654, 5 = ADT7461,
 #		  6 = MAX6646/MAX6647/MAX6648/MAX6649/MAX6692,
 #		  8 = W83L771W/G, 9 = TMP401, 10 = TMP411,
-#		  11 = W83L771AWG/ASG, 12 = MAX6690
+#		  11 = W83L771AWG/ASG, 12 = MAX6690,
+#		  13 = ADT7461A/NCT1008
 # Registers used:
 #   0x03: Configuration
 #   0x04: Conversion rate
@@ -4416,6 +4422,12 @@
 		return if $mid != 0x4d;		# Maxim
 		return 8 if $cid = 0x09;	# MAX6690
 	}
+	if ($chip = 13) {
+		return if ($conf & 0x1b) != 0;
+		return if $rate > 0x0a;
+		return if $mid != 0x41;		# Analog Devices
+		return 8 if $cid = 0x57;	# ADT7461A, NCT1008
+	}
 	return;
 }
 
Index: CHANGES
=================================--- CHANGES	(revision 5954)
+++ CHANGES	(working copy)
@@ -1,6 +1,9 @@
 lm-sensors CHANGES file
 -----------------------
 
+head
+  sensors-detect: Add detection of ADT7461A / NCT1008
+
 3.3.0 (2011-03-28)
   Makefile: Check for bison and flex
   libsensors: Add support for intrusion detection (#2370)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
