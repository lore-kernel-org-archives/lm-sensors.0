From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 Aug 2010 09:11:49 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Add tempX_emergency attribute to
Message-Id: <1282900309-17074-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-doc@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
v2: Re-phrased attribute description

 Documentation/hwmon/sysfs-interface |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index ff45d1f..101300b 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -310,6 +310,13 @@ temp[1-*]_crit_hyst
 		from the critical value.
 		RW
 
+temp[1-*]_emergency
+		Temperature emergency max value, for chips supporting more than
+		two upper temperature limits. Must be equal or greater than
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
