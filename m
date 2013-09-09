From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 09 Sep 2013 10:53:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: (hwmon-vid) Add __maybe_unused attribute to dummy variable
Message-Id: <1378724001-9199-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This gets rid of this warning:

drivers/hwmon/hwmon-vid.c: In function 'get_via_model_d_vrm':
drivers/hwmon/hwmon-vid.c:249:27: warning: variable 'dummy' set but not used
[-Wunused-but-set-variable]

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon-vid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 89cfd64..ef91b8a 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -246,7 +246,7 @@ static struct vrm_model vrm_models[] = {
  */
 static u8 get_via_model_d_vrm(void)
 {
-	unsigned int vid, brand, dummy;
+	unsigned int vid, brand, __maybe_unused dummy;
 	static const char *brands[4] = {
 		"C7-M", "C7", "Eden", "C7-D"
 	};
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
