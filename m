From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:03 +0000
Subject: [lm-sensors] [PATCH 69/82] hwmon: (ultra45_env) Fix multi-line comments
Message-Id: <1327017376-20466-70-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ultra45_env.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
index 836de7e..c315c59 100644
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -1,4 +1,5 @@
-/* ultra45_env.c: Driver for Ultra45 PIC16F747 environmental monitor.
+/*
+ * ultra45_env.c: Driver for Ultra45 PIC16F747 environmental monitor.
  *
  * Copyright (C) 2008 David S. Miller <davem@davemloft.net>
  */
@@ -82,7 +83,8 @@ static void env_write(struct env *p, u8 ireg, u8 val)
 	spin_unlock(&p->lock);
 }
 
-/* There seems to be a adr7462 providing these values, thus a lot
+/*
+ * There seems to be a adr7462 providing these values, thus a lot
  * of these calculations are borrowed from the adt7470 driver.
  */
 #define FAN_PERIOD_TO_RPM(x)	((90000 * 60) / (x))
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
