From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:28 +0000
Subject: [lm-sensors] [PATCH 05/12] hwmon: (pmbus) Don't unnecessarily crash the kernel
Message-Id: <1379147615-7703-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pmbus code currently crashes the kernel if it detects an internal
implementation error. While the detected condition suggests that there
is a bug in the code, it is hardly fatal. Therefore, it should not
trigger a crash. Replace BUG() with WARN().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 9319fcf..871cf64 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -686,7 +686,7 @@ static int pmbus_get_boolean(struct pmbus_data *data, struct pmbus_boolean *b,
 	if (!s1 && !s2) {
 		ret = !!regval;
 	} else if (!s1 || !s2) {
-		BUG();
+		WARN(1, "Bad boolean descriptor %p: s1=%p, s2=%p\n", b, s1, s2);
 		return 0;
 	} else {
 		long v1, v2;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
