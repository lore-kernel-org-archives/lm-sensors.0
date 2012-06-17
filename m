From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 17 Jun 2012 04:35:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: Document the use of devres functions
Message-Id: <1339907740-3512-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

devres functions are the preferred means to allocate resources in hwmon drivers.
Document it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/submitting-patches |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/submitting-patches
index 86f42e8..790f774 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches
@@ -70,6 +70,9 @@ increase the chances of your change being accepted.
   review more difficult. It may also result in code which is more complicated
   than necessary. Use inline functions or just regular functions instead.
 
+* Use devres functions whenever possible to allocate resources. For rationale
+  and supported functions, please see Documentation/driver-model/devres.txt.
+
 * If the driver has a detect function, make sure it is silent. Debug messages
   and messages printed after a successful detection are acceptable, but it
   must not print messages such as "Chip XXX not found/supported".
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
