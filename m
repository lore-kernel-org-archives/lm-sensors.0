From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 01 May 2012 15:19:53 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Increase CPU core limit
Message-Id: <1335885593-15231-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

CPU core ID is used to index the core_data[] array. The core ID is, however, not
sequential; 10-core CPUS can have a core ID as high as 25. Increase the limit to
32 to be able to deal with current CPUs.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: stable@vger.kernel.org # 3.0+
---
 drivers/hwmon/coretemp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 54a70fe..b9d5123 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -52,7 +52,7 @@ module_param_named(tjmax, force_tjmax, int, 0444);
 MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		16	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-- 
1.7.9.48.g85da4d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
