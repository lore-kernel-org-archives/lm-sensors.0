From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 17:30:14 +0000
Subject: [lm-sensors] [PATCH 07/14] i8k: Drop driver version number and info message at startup
Message-Id: <1387042221-3671-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1387042221-3671-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

The driver version number is long since obsolete, so drop it.
Also, drop the info message at driver startup to reduce boot noise.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/char/i8k.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/char/i8k.c b/drivers/char/i8k.c
index 5b3682c..ad0acef 100644
--- a/drivers/char/i8k.c
+++ b/drivers/char/i8k.c
@@ -34,8 +34,6 @@
 
 #include <linux/i8k.h>
 
-#define I8K_VERSION		"1.14 21/02/2005"
-
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
 #define I8K_SMM_SET_FAN		0x01a3
@@ -755,9 +753,6 @@ static int __init i8k_init(void)
 	if (err)
 		goto exit_remove_proc;
 
-	pr_info("Dell laptop SMM driver v%s Massimo Dal Zotto (dz@debian.org)\n",
-		I8K_VERSION);
-
 	return 0;
 
  exit_remove_proc:
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
