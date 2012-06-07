From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 07 Jun 2012 08:54:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (applesmc) Limit key length in warning messages
Message-Id: <1339059269-383-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Key lookups may call read_smc() with a fixed-length key string,
and if the lookup fails, trailing stack content may appear in the
kernel log. Fixed with this patch.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index f082e48..70d62f5 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -215,7 +215,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 	int i;
 
 	if (send_command(cmd) || send_argument(key)) {
-		pr_warn("%s: read arg fail\n", key);
+		pr_warn("%.4s: read arg fail\n", key);
 		return -EIO;
 	}
 
@@ -223,7 +223,7 @@ static int read_smc(u8 cmd, const char *key, u8 *buffer, u8 len)
 
 	for (i = 0; i < len; i++) {
 		if (__wait_status(0x05)) {
-			pr_warn("%s: read data fail\n", key);
+			pr_warn("%.4s: read data fail\n", key);
 			return -EIO;
 		}
 		buffer[i] = inb(APPLESMC_DATA_PORT);
-- 
1.7.10.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
