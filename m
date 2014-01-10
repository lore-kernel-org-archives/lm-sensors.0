From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Fri, 10 Jan 2014 21:44:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max197) add include guard
Message-Id: <1389390286-6287-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

Add include guard to include/linux/platform_data/max197.h to prevent
multiple inclusion.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 include/linux/platform_data/max197.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/platform_data/max197.h b/include/linux/platform_data/max197.h
index e2a41dd..8da8f94 100644
--- a/include/linux/platform_data/max197.h
+++ b/include/linux/platform_data/max197.h
@@ -11,6 +11,9 @@
  * For further information, see the Documentation/hwmon/max197 file.
  */
 
+#ifndef _PDATA_MAX197_H
+#define _PDATA_MAX197_H
+
 /**
  * struct max197_platform_data - MAX197 connectivity info
  * @convert:	Function used to start a conversion with control byte ctrl.
@@ -19,3 +22,5 @@
 struct max197_platform_data {
 	int (*convert)(u8 ctrl);
 };
+
+#endif /* _PDATA_MAX197_H */
-- 
1.8.5.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
