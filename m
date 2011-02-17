From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 17 Feb 2011 19:56:40 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of AMD family
Message-Id: <20110217195640.GA20934@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: CHANGES
=================================--- CHANGES	(revision 5932)
+++ CHANGES	(working copy)
@@ -27,6 +27,7 @@
                         EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424
                   Fixed address ranges checked for SMSC EMC1403 and EMC1404.
                   Fix detection of SPD EEPROM on DDR3 memory modules
+                  Add detection of AMD family 12h and 14h thermal sensors
 
 3.2.0 (2010-10-10)
   libsensors: Increase MAX_SENSORS_PER_TYPE to 24
Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5932)
+++ prog/detect/sensors-detect	(working copy)
@@ -2128,6 +2128,10 @@
 		driver => "k10temp",
 		detect => \&fam11h_pci_detect,
 	}, {
+		name => "AMD Family 12h and 14h thermal sensors",
+		driver => "k10temp",
+		detect => \&fam12h_14h_pci_detect,
+	}, {
 		name => "Intel digital thermal sensor",
 		driver => "coretemp",
 		detect => \&coretemp_detect,
@@ -6028,6 +6032,12 @@
 	return 9;
 }
 
+sub fam12h_14h_pci_detect
+{
+	return unless exists $pci_list{'1022:1703'};
+	return 9;
+}
+
 sub intel_amb_detect
 {
 	if ((exists $pci_list{'8086:25f0'}) ||	# Intel 5000

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
