From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Feb 2013 02:19:30 +0000
Subject: [lm-sensors] [PATCH v2 2/7] hwmon: (pmbus/ltc2978) Update datasheet links
Message-Id: <1361585975-5604-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Links to datasheets are no longer valid. Provide links to product information
instead (which provides links to the datasheets and is hopefully more
persistent).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Point to product information pages

 Documentation/hwmon/ltc2978 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index 1642348..e4d75c6 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -5,11 +5,11 @@ Supported chips:
   * Linear Technology LTC2978
     Prefix: 'ltc2978'
     Addresses scanned: -
-    Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
+    Datasheet: http://www.linear.com/product/ltc2978
   * Linear Technology LTC3880
     Prefix: 'ltc3880'
     Addresses scanned: -
-    Datasheet: http://cds.linear.com/docs/Datasheet/3880f.pdf
+    Datasheet: http://www.linear.com/product/ltc3880
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
