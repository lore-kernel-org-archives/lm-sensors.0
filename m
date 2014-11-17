From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Nov 2014 14:47:53 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Documentation updates
Message-Id: <1416235673-26167-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Document support for NCT6791D.
Document that NCT5573D is compatible to NCT6775F with the same chip ID.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/nct6775 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
index 4e9ef60..b4cbba4 100644
--- a/Documentation/hwmon/nct6775
+++ b/Documentation/hwmon/nct6775
@@ -12,7 +12,7 @@ Supported chips:
     Prefix: 'nct6775'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
-  * Nuvoton NCT5577D/NCT6776D/NCT6776F
+  * Nuvoton NCT5573D/NCT5577D/NCT6776D/NCT6776F
     Prefix: 'nct6776'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
@@ -20,6 +20,10 @@ Supported chips:
     Prefix: 'nct6779'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet: Available from Nuvoton upon request
+  * Nuvoton NCT6791D
+    Prefix: 'nct6791'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet: Available from Nuvoton upon request
 
 Authors:
         Guenter Roeck <linux@roeck-us.net>
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
