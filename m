From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:34 +0000
Subject: [lm-sensors] [PATCH 11/12] hwmon: (f75375s) Don't crash the kernel unnecessarily
Message-Id: <1379147615-7703-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The f75375s driver crashes the kernel if it detects an an internal
implementation error. While the detected conditions suggest that
there is a bug in the code, the condition is not fatal.
Replace BUG() with WARN().

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/f75375s.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index a837b94..80c42be 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -275,7 +275,7 @@ static bool duty_mode_enabled(u8 pwm_enable)
 	case 3: /* Manual, speed mode */
 		return false;
 	default:
-		BUG();
+		WARN(1, "Unexpected pwm_enable value %d\n", pwm_enable);
 		return true;
 	}
 }
@@ -291,7 +291,7 @@ static bool auto_mode_enabled(u8 pwm_enable)
 	case 4: /* Auto, duty mode */
 		return true;
 	default:
-		BUG();
+		WARN(1, "Unexpected pwm_enable value %d\n", pwm_enable);
 		return false;
 	}
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
