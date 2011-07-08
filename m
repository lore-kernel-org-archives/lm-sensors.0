From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 08 Jul 2011 16:25:45 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add code to detect LM95245
Message-Id: <20110708162545.GA30598@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110406072137.GB23562@ericsson.com>
In-Reply-To: <20110406072137.GB23562@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5983)
+++ prog/detect/sensors-detect	(working copy)
@@ -1008,6 +1008,11 @@
 		i2c_addrs => [0x2b, 0x19, 0x2a],
 		i2c_detect => sub { lm95231_detect(@_, 1); },
 	}, {
+		name => "National Semiconductor LM95245",
+		driver => "lm95245",
+		i2c_addrs => [0x2b, 0x19, 0x2a],
+		i2c_detect => sub { lm95231_detect(@_, 2); },
+	}, {
 		name => "National Semiconductor LM63",
 		driver => "lm63",
 		i2c_addrs => [0x4c],
@@ -4540,7 +4545,7 @@
 	return 5;
 }
 
-# Chip to detect: 0 = LM95231, 1 = LM95241
+# Chip to detect: 0 = LM95231, 1 = LM95241, 2 = LM95245
 # Registers used:
 #   0x02: Status (3 unused bits)
 #   0x03: Configuration (3 unused bits)
@@ -4557,6 +4562,7 @@
 	return if $mid != 0x01;				# National Semiconductor
 	return if $chip = 0 && $cid != 0xa1;		# LM95231
 	return if $chip = 1 && $cid != 0xa4;		# LM95241
+	return if $chip = 2 && $cid != 0xb3;		# LM95245
 
 	return if i2c_smbus_read_byte_data($file, 0x02) & 0x70;
 	return if i2c_smbus_read_byte_data($file, 0x03) & 0x89;
Index: CHANGES
=================================--- CHANGES	(revision 5983)
+++ CHANGES	(working copy)
@@ -17,6 +17,7 @@
                   Add detection of ITE IT8772E
                   Don't advertise the ipmisensors driver
                   Add detection of SA56004
+                  Add detection of LM95245
 
 3.3.0 (2011-03-28)
   Makefile: Check for bison and flex

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
