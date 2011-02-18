From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Feb 2011 13:15:45 +0000
Subject: [lm-sensors] [PATCH] Add detection for EMCD103 chip revisions
Message-Id: <20110218131545.GB27355@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5933)
+++ prog/detect/sensors-detect	(working copy)
@@ -547,11 +547,16 @@
 		i2c_addrs => [0x2c..0x2e],
 		i2c_detect => sub { lm85_detect(@_, 5); },
 	}, {
-		name => "SMSC EMC6D103",
+		name => "SMSC EMC6D103 rev A0, A1",
 		driver => "lm85",
 		i2c_addrs => [0x2c..0x2e],
 		i2c_detect => sub { lm85_detect(@_, 6); },
 	}, {
+		name => "SMSC EMC6D103 rev A2",
+		driver => "to-be-written",	# lm85
+		i2c_addrs => [0x2c..0x2e],
+		i2c_detect => sub { lm85_detect(@_, 8); },
+	}, {
 		name => "Winbond WPCD377I",
 		driver => "not-a-sensor",
 		i2c_addrs => [0x2c..0x2e],
@@ -4776,7 +4781,11 @@
 		return if $verstep != 0x65;	# EMC6D102
 	} elsif ($chip = 6) {
 		return if $vendor != 0x5c;	# SMSC
-		return if $verstep != 0x68;	# EMC6D103
+		return if $verstep != 0x68	# EMC6D103 A0
+		       && $verstep != 0x69;	# EMC6D103 A1
+	} elsif ($chip = 8) {
+		return if $vendor != 0x5c;	# SMSC
+		return if $verstep != 0x6a;	# EMC6D103 A2
 	}
 
 	if ($vendor = 0x41) {			# Analog Devices

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
