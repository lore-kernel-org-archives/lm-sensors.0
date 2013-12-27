From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 27 Dec 2013 06:22:13 +0000
Subject: [lm-sensors] [PATCH 1/1] hwmon: (s3c) Trivial cleanup in hwmon-s3c.h
Message-Id: <1388124613-22407-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 include/linux/platform_data/hwmon-s3c.h |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/platform_data/hwmon-s3c.h b/include/linux/platform_data/hwmon-s3c.h
index c167e4429bc7..0e3cce130fe2 100644
--- a/include/linux/platform_data/hwmon-s3c.h
+++ b/include/linux/platform_data/hwmon-s3c.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c/include/plat/hwmon.h
- *
+/*
  * Copyright 2005 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
@@ -11,8 +10,8 @@
  * published by the Free Software Foundation.
 */
 
-#ifndef __ASM_ARCH_ADC_HWMON_H
-#define __ASM_ARCH_ADC_HWMON_H __FILE__
+#ifndef __HWMON_S3C_H__
+#define __HWMON_S3C_H__
 
 /**
  * s3c_hwmon_chcfg - channel configuration
@@ -47,5 +46,4 @@ struct s3c_hwmon_pdata {
  */
 extern void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd);
 
-#endif /* __ASM_ARCH_ADC_HWMON_H */
-
+#endif /* __HWMON_S3C_H__ */
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
