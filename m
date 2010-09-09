From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Sep 2010 13:25:44 +0000
Subject: [lm-sensors] [PATCH v2 1/7] hwmon: Add tempX_emergency_alarm
Message-Id: <1284038750-8833-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284038750-8833-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/sysfs-interface |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 101300b..22843cb 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -513,6 +513,7 @@ fan[1-*]_max_alarm
 temp[1-*]_min_alarm
 temp[1-*]_max_alarm
 temp[1-*]_crit_alarm
+temp[1-*]_emergency_alarm
 		Limit alarm
 		0: no alarm
 		1: alarm
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
