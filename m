From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:09:49 +0000
Subject: [lm-sensors] [PATCH 1/3] pm: Introduce __pm to mark power management functions and data
Message-Id: <1368119391-13837-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>, Guenter Roeck <linux@roeck-us.net>

By marking power management functions and data with __pm, #ifdef CONFIG_PM
and #ifdef CONFIG_PM_SLEEP is no longer necessary in most cases.
This ensures that the power management code still compiles even if power
management is disabled, but does not consume space in the object file.
As a side effect, drivers declaring struct dev_pm_ops unconditionally
get a bit smaller if CONFIG_PM_SLEEP is disabled.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/pm.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index fe70d9b..46df155 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -43,9 +43,11 @@ struct device;
 #ifdef CONFIG_PM
 extern const char power_group_name[];		/* = "power" */
 #define pm_ops_ptr(_ptr)	(_ptr)
+#define __pm
 #else
 #define power_group_name	NULL
 #define pm_ops_ptr(_ptr)	NULL
+#define __pm			__section(.discard)
 #endif
 
 typedef struct pm_message {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
