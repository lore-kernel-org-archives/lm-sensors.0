From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 17 Sep 2008 22:24:08 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: applesmc: Allow for variable ALV0
Message-Id: <48D18388.601@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

On some recent Macbooks, the package length for the light sensors ALV0
and ALV1 has changed from 6 to 10. This patch allows for a variable
package length encompassing both variants.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 9a43c4b..de696b6 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -57,8 +57,8 @@

 #define KEY_COUNT_KEY		"#KEY" /* r-o ui32 */

-#define LIGHT_SENSOR_LEFT_KEY	"ALV0" /* r-o {alv (6 bytes) */
-#define LIGHT_SENSOR_RIGHT_KEY	"ALV1" /* r-o {alv (6 bytes) */
+#define LIGHT_SENSOR_LEFT_KEY	"ALV0" /* r-o {alv (6-10 bytes) */
+#define LIGHT_SENSOR_RIGHT_KEY	"ALV1" /* r-o {alv (6-10 bytes) */
 #define BACKLIGHT_KEY		"LKSB" /* w-o {lkb (2 bytes) */

 #define CLAMSHELL_KEY		"MSLD" /* r-o ui8 (unused) */
@@ -543,17 +543,27 @@ out:
 static ssize_t applesmc_light_show(struct device *dev,
 				struct device_attribute *attr, char *sysfsbuf)
 {
+	static int data_length;
 	int ret;
 	u8 left = 0, right = 0;
-	u8 buffer[6];
+	u8 buffer[10], query[6];

 	mutex_lock(&applesmc_lock);

-	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, 6);
+	if (!data_length) {
+		ret = applesmc_get_key_type(LIGHT_SENSOR_LEFT_KEY, query);
+		if (ret)
+			goto out;
+		data_length = clamp_val(query[0], 0, 10);
+		printk(KERN_INFO "applesmc: light sensor data length set to "
+			"%d\n", data_length);
+	}
+
+	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, data_length);
 	left = buffer[2];
 	if (ret)
 		goto out;
-	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, 6);
+	ret = applesmc_read_key(LIGHT_SENSOR_RIGHT_KEY, buffer, data_length);
 	right = buffer[2];

 out:
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
