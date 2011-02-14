From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 Feb 2011 19:35:38 +0000
Subject: [lm-sensors] [PATCH v5 05/10] hwmon: (w83627ehf) Remove references
Message-Id: <1297712143-7431-6-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/w83627ehf |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
index 0643019..b634e98 100644
--- a/Documentation/hwmon/w83627ehf
+++ b/Documentation/hwmon/w83627ehf
@@ -5,13 +5,11 @@ Supported chips:
   * Winbond W83627EHF/EHG (ISA access ONLY)
     Prefix: 'w83627ehf'
     Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet:
-        http://www.nuvoton.com.tw/NR/rdonlyres/A6A258F0-F0C9-4F97-81C0-C4D29E7E943E/0/W83627EHF.pdf
+    Datasheet: not available
   * Winbond W83627DHG
     Prefix: 'w83627dhg'
     Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet:
-        http://www.nuvoton.com.tw/NR/rdonlyres/7885623D-A487-4CF9-A47F-30C5F73D6FE6/0/W83627DHG.pdf
+    Datasheet: not available
   * Winbond W83627DHG-P
     Prefix: 'w83627dhg'
     Addresses scanned: ISA address retrieved from Super I/O registers
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
