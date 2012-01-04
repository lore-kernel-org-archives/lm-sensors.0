From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Wed, 04 Jan 2012 22:16:39 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon/lm57.h: fix checkpatch warnings
Message-Id: <1325715399-22053-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm75.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm75.h b/drivers/hwmon/lm75.h
index e547a3e..89aa909 100644
--- a/drivers/hwmon/lm75.h
+++ b/drivers/hwmon/lm75.h
@@ -1,6 +1,6 @@
 /*
     lm75.h - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
+	      monitoring
     Copyright (c) 2003 Mark M. Hoffman <mhoffman@lightlink.com>
 
     This program is free software; you can redistribute it and/or modify
@@ -37,7 +37,7 @@
 static inline u16 LM75_TEMP_TO_REG(long temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM75_TEMP_MIN, LM75_TEMP_MAX);
-	ntemp += (ntemp<0 ? -250 : 250);
+	ntemp += (ntemp < 0 ? -250 : 250);
 	return (u16)((ntemp / 500) << 7);
 }
 
@@ -47,4 +47,3 @@ static inline int LM75_TEMP_FROM_REG(u16 reg)
 	   guarantee arithmetic shift and preserve the sign */
 	return ((s16)reg / 128) * 500;
 }
-
-- 
1.7.8.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
