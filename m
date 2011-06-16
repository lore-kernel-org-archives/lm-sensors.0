From: Clemens Ladisch <clemens@ladisch.de>
Date: Thu, 16 Jun 2011 11:45:55 +0000
Subject: [lm-sensors] hwmon: (k10temp) update documentation
Message-Id: <4DF9ECF3.20700@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Add some CPU series IDs and links to the Fam12h datasheets.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

--- a/Documentation/hwmon/k10temp
+++ b/Documentation/hwmon/k10temp
@@ -9,8 +9,8 @@ Supported chips:
   Socket S1G3: Athlon II, Sempron, Turion II
 * AMD Family 11h processors:
   Socket S1G2: Athlon (X2), Sempron (X2), Turion X2 (Ultra)
-* AMD Family 12h processors: "Llano"
-* AMD Family 14h processors: "Brazos" (C/E/G-Series)
+* AMD Family 12h processors: "Llano" (E2/A4/A6/A8-Series)
+* AMD Family 14h processors: "Brazos" (C/E/G/Z-Series)
 * AMD Family 15h processors: "Bulldozer"
 
   Prefix: 'k10temp'
@@ -20,12 +20,16 @@ Supported chips:
     http://support.amd.com/us/Processor_TechDocs/31116.pdf
   BIOS and Kernel Developer's Guide (BKDG) for AMD Family 11h Processors:
     http://support.amd.com/us/Processor_TechDocs/41256.pdf
+  BIOS and Kernel Developer's Guide (BKDG) for AMD Family 12h Processors:
+    http://support.amd.com/us/Processor_TechDocs/41131.pdf
   BIOS and Kernel Developer's Guide (BKDG) for AMD Family 14h Models 00h-0Fh Processors:
     http://support.amd.com/us/Processor_TechDocs/43170.pdf
   Revision Guide for AMD Family 10h Processors:
     http://support.amd.com/us/Processor_TechDocs/41322.pdf
   Revision Guide for AMD Family 11h Processors:
     http://support.amd.com/us/Processor_TechDocs/41788.pdf
+  Revision Guide for AMD Family 12h Processors:
+    http://support.amd.com/us/Processor_TechDocs/44739.pdf
   Revision Guide for AMD Family 14h Models 00h-0Fh Processors:
     http://support.amd.com/us/Processor_TechDocs/47534.pdf
   AMD Family 11h Processor Power and Thermal Data Sheet for Notebooks:

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
