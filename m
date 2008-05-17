From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 17 May 2008 18:08:24 +0000
Subject: [lm-sensors] [PATCH] hwmon: Update broken Winbond and NatSemi
Message-Id: <20080517200824.77abcaa8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/pc87360 |    7 +------
 Documentation/hwmon/pc87427 |    2 +-
 Documentation/hwmon/w83792d |    2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

--- linux-2.6.26-rc2.orig/Documentation/hwmon/pc87427	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc2/Documentation/hwmon/pc87427	2008-05-17 19:45:50.000000000 +0200
@@ -5,7 +5,7 @@ Supported chips:
   * National Semiconductor PC87427
     Prefix: 'pc87427'
     Addresses scanned: none, address read from Super I/O config space
-    Datasheet: http://www.winbond.com.tw/E-WINBONDHTM/partner/apc_007.html
+    Devcice information: http://www.winbond.com/hq/enu/ProductAndSales/ProductLines/ComputerLogicIC/ServerIO/AdvancedSuperIOforServers/87427.htm
 
 Author: Jean Delvare <khali@linux-fr.org>
 
--- linux-2.6.26-rc2.orig/Documentation/hwmon/w83792d	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc2/Documentation/hwmon/w83792d	2008-05-17 19:48:17.000000000 +0200
@@ -5,7 +5,7 @@ Supported chips:
   * Winbond W83792D
     Prefix: 'w83792d'
     Addresses scanned: I2C 0x2c - 0x2f
-    Datasheet: http://www.winbond.com.tw/E-WINBONDHTM/partner/PDFresult.asp?Pname35
+    Datasheet: http://www.winbond.com.tw/hq/enu/ProductAndSales/ProductLines/ComputerLogicIC/HardwareMonitor/HWMonitorforDesktopAndServer/W83792G.htm
 
 Author: Chunhao Huang
 Contact: DZShen <DZShen@Winbond.com.tw>
--- linux-2.6.26-rc2.orig/Documentation/hwmon/pc87360	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc2/Documentation/hwmon/pc87360	2008-05-17 20:00:55.000000000 +0200
@@ -5,12 +5,7 @@ Supported chips:
   * National Semiconductor PC87360, PC87363, PC87364, PC87365 and PC87366
     Prefixes: 'pc87360', 'pc87363', 'pc87364', 'pc87365', 'pc87366'
     Addresses scanned: none, address read from Super I/O config space
-    Datasheets:
-        http://www.national.com/pf/PC/PC87360.html
-        http://www.national.com/pf/PC/PC87363.html
-        http://www.national.com/pf/PC/PC87364.html
-        http://www.national.com/pf/PC/PC87365.html
-        http://www.national.com/pf/PC/PC87366.html
+    Datasheets: No longer available
 
 Authors: Jean Delvare <khali@linux-fr.org>
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
