From: Masanari Iida <standby24x7@gmail.com>
Date: Sun, 28 Feb 2016 03:57:57 +0000
Subject: [lm-sensors] [PATCH] [linux-next] Doc: hwmon: Fix typo "montoring" in hwmon
Message-Id: <1456631877-31890-1-git-send-email-standby24x7@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fix typos found in files within Documentation/hwmon.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/hwmon/adm1275  | 2 +-
 Documentation/hwmon/lm25066  | 2 +-
 Documentation/hwmon/max16064 | 2 +-
 Documentation/hwmon/max34440 | 2 +-
 Documentation/hwmon/max8688  | 2 +-
 Documentation/hwmon/pmbus    | 2 +-
 Documentation/hwmon/zl6100   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index d697229..04e8e4a 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -25,7 +25,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for Analog Devices ADM1075, ADM1275,
+This driver supports hardware monitoring for Analog Devices ADM1075, ADM1275,
 ADM1276, ADM1293, and ADM1294 Hot-Swap Controller and Digital Power Monitors.
 
 ADM1075, ADM1275, ADM1276, ADM1293, and ADM1294 are hot-swap controllers that
diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
index b34c3de..2cb20eb 100644
--- a/Documentation/hwmon/lm25066
+++ b/Documentation/hwmon/lm25066
@@ -36,7 +36,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for National Semiconductor / TI LM25056,
+This driver supports hardware monitoring for National Semiconductor / TI LM25056,
 LM25063, LM25066, LM5064, and LM5066 Power Management, Monitoring, Control, and
 Protection ICs.
 
diff --git a/Documentation/hwmon/max16064 b/Documentation/hwmon/max16064
index d59cc78..265370f 100644
--- a/Documentation/hwmon/max16064
+++ b/Documentation/hwmon/max16064
@@ -13,7 +13,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for Maxim MAX16064 Quad Power-Supply
+This driver supports hardware monitoring for Maxim MAX16064 Quad Power-Supply
 Controller with Active-Voltage Output Control and PMBus Interface.
 
 The driver is a client driver to the core PMBus driver.
diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
index 0276332..9ba6587 100644
--- a/Documentation/hwmon/max34440
+++ b/Documentation/hwmon/max34440
@@ -33,7 +33,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for Maxim MAX34440 PMBus 6-Channel
+This driver supports hardware monitoring for Maxim MAX34440 PMBus 6-Channel
 Power-Supply Manager, MAX34441 PMBus 5-Channel Power-Supply Manager
 and Intelligent Fan Controller, and MAX34446 PMBus Power-Supply Data Logger.
 It also supports the MAX34460 and MAX34461 PMBus Voltage Monitor & Sequencers.
diff --git a/Documentation/hwmon/max8688 b/Documentation/hwmon/max8688
index e780786..ca233be 100644
--- a/Documentation/hwmon/max8688
+++ b/Documentation/hwmon/max8688
@@ -13,7 +13,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for Maxim MAX8688 Digital Power-Supply
+This driver supports hardware monitoring for Maxim MAX8688 Digital Power-Supply
 Controller/Monitor with PMBus Interface.
 
 The driver is a client driver to the core PMBus driver. Please see
diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index b397675..dfd9c65 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -43,7 +43,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for various PMBus compliant devices.
+This driver supports hardware monitoring for various PMBus compliant devices.
 It supports voltage, current, power, and temperature sensors as supported
 by the device.
 
diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index 33908a4..477a94b 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -60,7 +60,7 @@ Author: Guenter Roeck <linux@roeck-us.net>
 Description
 -----------
 
-This driver supports hardware montoring for Intersil / Zilker Labs ZL6100 and
+This driver supports hardware monitoring for Intersil / Zilker Labs ZL6100 and
 compatible digital DC-DC controllers.
 
 The driver is a client driver to the core PMBus driver. Please see
-- 
2.8.0.rc0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
