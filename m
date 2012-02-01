From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:12 +0000
Subject: [lm-sensors] [PATCH 24/24] hwmon: (hwmon-vid) Drop optional API function parameters
Message-Id: <1328123472-27816-25-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Now that all callers of vid_from_reg() and vid_to_reg() have been converted
to not pass the obsolete parameter anymore, drop it from the API.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/hwmon-vid.c |    4 ++--
 include/linux/hwmon-vid.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
index 2029256..96a74a2 100644
--- a/drivers/hwmon/hwmon-vid.c
+++ b/drivers/hwmon/hwmon-vid.c
@@ -85,7 +85,7 @@ MODULE_PARM_DESC(vrm, "VRM/VRD version");
  *
  * Returns -EINVAL if vrm is not supported or unknown.
  */
-int vid_from_reg(int val, ...)
+int vid_from_reg(int val)
 {
 	int vid;
 
@@ -162,7 +162,7 @@ int vid_from_reg(int val, ...)
 }
 EXPORT_SYMBOL(vid_from_reg);
 
-int vid_to_reg(int val, ...)
+int vid_to_reg(int val)
 {
 	switch (vrm) {
 	case 91:		/* VRM 9.1 */
diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
index 7e08ce4..64e819c 100644
--- a/include/linux/hwmon-vid.h
+++ b/include/linux/hwmon-vid.h
@@ -23,8 +23,8 @@
 #ifndef _LINUX_HWMON_VID_H
 #define _LINUX_HWMON_VID_H
 
-int vid_from_reg(int val, ...);
+int vid_from_reg(int val);
 u8 vid_which_vrm(void);
-int vid_to_reg(int val, ...);
+int vid_to_reg(int val);
 
 #endif /* _LINUX_HWMON_VID_H */
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
