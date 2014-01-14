From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Jan 2014 14:59:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Fix truncated name of alarm attributes
Message-Id: <20140114155955.7db1fa2b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When the core number exceeds 9, the size of the buffer storing the
alarm attribute name is insufficient and the attribute name is
truncated. This causes libsensors to skip these attributes as the
truncated name is not recognized.

Reported-by: Andreas Hollmann <hollmann@in.tum.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/coretemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.13-rc7.orig/drivers/hwmon/coretemp.c	2013-11-04 00:41:51.000000000 +0100
+++ linux-3.13-rc7/drivers/hwmon/coretemp.c	2014-01-14 15:54:49.719375469 +0100
@@ -52,7 +52,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in
 
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		32	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	17	/* String Length of attrs */
+#define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
