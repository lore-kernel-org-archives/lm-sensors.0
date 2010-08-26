From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Aug 2010 15:54:45 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add tempX_emergency to sysfs ABI
Message-Id: <1282838085-7210-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-doc@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
tempX_emergency will be used by max6696. It can also be used for other chips
supporting three upper temperature limits.

 Documentation/hwmon/sysfs-interface |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index ff45d1f..1ceb2b9 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -310,6 +310,12 @@ temp[1-*]_crit_hyst
 		from the critical value.
 		RW
 
+temp[1-*]_emergency
+		Temperature emergency value, typically greater than
+		corresponding temp_crit values.
+		Unit: millidegree Celsius
+		RW
+
 temp[1-*]_lcrit	Temperature critical min value, typically lower than
 		corresponding temp_min values.
 		Unit: millidegree Celsius
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
