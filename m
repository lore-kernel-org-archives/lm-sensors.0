From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Apr 2013 21:13:51 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: Add myself as maintainer for the NCT6775 driver
Message-Id: <1365023631-9279-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
To be applied to my -next branch, together with the driver itself.

 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 836a618..6abd5ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5406,6 +5406,13 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/NCR_D700.*
 
+NCT6775 HARDWARE MONITOR DRIVER
+M:	Guenter Roeck <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/nct6775
+F:	drivers/hwmon/nct6775.c
+
 NETEFFECT IWARP RNIC DRIVER (IW_NES)
 M:	Faisal Latif <faisal.latif@intel.com>
 L:	linux-rdma@vger.kernel.org
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
