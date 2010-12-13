From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Dec 2010 19:18:43 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Compute MAX_SUBFEATURES
Message-Id: <20101213201843.23921880@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101213135842.73b08221@endymion.delvare>
In-Reply-To: <20101213135842.73b08221@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Dec 2010 16:51:32 +0100, Jean Delvare wrote:
> But looking at sensors.h... maybe I have an idea how to solve this
> elegantly. Let me give it a try.

This is what I came up with. What do you think? This lets
MAX_MAIN_SENSOR_TYPES and MAX_OTHER_SENSOR_TYPES be computed at build
time automatically, with no additional cost at run-time. The only
drawback I see is that SENSORS_FEATURE_MAX_MAIN and
SENSORS_FEATURE_MAX_OTHER will be public, while we know their values
will change over time, by design. But I can't think of a valid reason
why an application would use them, so I'd say it is OK.

---
 lib/sensors.h |    2 ++
 lib/sysfs.c   |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- lm-sensors.orig/lib/sensors.h	2010-12-12 22:44:30.000000000 +0100
+++ lm-sensors/lib/sensors.h	2010-12-13 18:21:22.000000000 +0100
@@ -140,8 +140,10 @@ typedef enum sensors_feature_type {
 	SENSORS_FEATURE_POWER		= 0x03,
 	SENSORS_FEATURE_ENERGY		= 0x04,
 	SENSORS_FEATURE_CURR		= 0x05,
+	SENSORS_FEATURE_MAX_MAIN,
 	SENSORS_FEATURE_VID		= 0x10,
 	SENSORS_FEATURE_INTRUSION	= 0x11,
+	SENSORS_FEATURE_MAX_OTHER,
 	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
 	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
 } sensors_feature_type;
--- lm-sensors.orig/lib/sysfs.c	2010-12-13 11:40:05.000000000 +0100
+++ lm-sensors/lib/sysfs.c	2010-12-13 18:22:20.000000000 +0100
@@ -136,8 +136,8 @@ static int sysfs_foreach_busdev(const ch
 
 char sensors_sysfs_mount[NAME_MAX];
 
-#define MAX_MAIN_SENSOR_TYPES	6
-#define MAX_OTHER_SENSOR_TYPES	2
+#define MAX_MAIN_SENSOR_TYPES	(SENSORS_FEATURE_MAX_MAIN - SENSORS_FEATURE_IN)
+#define MAX_OTHER_SENSOR_TYPES	(SENSORS_FEATURE_MAX_OTHER - SENSORS_FEATURE_VID)
 #define MAX_SENSORS_PER_TYPE	24
 /* max_subfeatures is now computed dynamically */
 #define FEATURE_SIZE		(max_subfeatures * 2)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
