From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 21 Apr 2014 17:42:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ltc2945) Don't crash the kernel unnecessarily
Message-Id: <1398102121-24822-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

An implementation error should not crash the kernel if it is avoidable.
Replace BUG() with WARN_ONCE().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ltc2945.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index c104cc3..c9cddf5 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -1,4 +1,4 @@
-/*
+    /*
  * Driver for Linear Technology LTC2945 I2C Power Monitor
  *
  * Copyright (c) 2014 Guenter Roeck
@@ -314,8 +314,8 @@ static ssize_t ltc2945_reset_history(struct device *dev,
 		reg = LTC2945_MAX_ADIN_H;
 		break;
 	default:
-		BUG();
-		break;
+		WARN_ONCE(1, "Bad register: 0x%x\n", reg);
+		return -EINVAL;
 	}
 	/* Reset maximum */
 	ret = regmap_bulk_write(regmap, reg, buf_max, num_regs);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
