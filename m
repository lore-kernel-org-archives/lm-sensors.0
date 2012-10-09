From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Oct 2012 21:09:00 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: (coretemp) Use model table instead of if/else to identify CPU models
Message-Id: <1349816943-17697-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the code easier to extend and easier to adjust by using a model table
listing CPU models, stepping/mask, and associated TjMax.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/coretemp.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 1937cd4..7107096 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -208,6 +208,23 @@ static const struct tjmax __cpuinitconst tjmax_table[] = {
 	{ "CPU  330", 125000 },
 };
 
+struct tjmax_model {
+	u8 model;
+	u8 mask;
+	int tjmax;
+};
+
+static const struct tjmax_model __cpuinitconst tjmax_model_table[] = {
+	{ 0x1c, 10, 100000 },	/* D4xx, N4xx, D5xx, N5xx */
+	{ 0x1c, 0, 90000 },	/* Z5xx, N2xx, 230, 330, others	*/
+	{ 0x26, 0, 90000 },	/* Atom Tunnel Creek (Exx), Lincroft (Z6xx)
+				 * Note: TjMax for E6xxT is 110C, but CPU type
+				 * is undetectable by software
+				 */
+	{ 0x27, 0, 90000 },	/* Atom Medfield (Z2460) */
+	{ 0x36, 0, 100000 },	/* Atom Cedar Trail/Cedarview (N2xxx, D2xxx) */
+};
+
 static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 				  struct device *dev)
 {
@@ -226,20 +243,11 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id,
 			return tjmax_table[i].tjmax;
 	}
 
-	/* Atom CPUs */
-
-	if (c->x86_model = 0x1c) {
-		/*
-		 * TjMax for stepping 10 CPUs (N4xx, N5xx, D4xx, D5xx)
-		 * is 100 degrees C, for all others it is 90 degrees C.
-		 */
-		if (c->x86_mask = 10)
-			return 100000;
-		return 90000;
-	} else if (c->x86_model = 0x26 || c->x86_model = 0x27) {
-		return 90000;
-	} else if (c->x86_model = 0x36) {
-		return 100000;
+	for (i = 0; i < ARRAY_SIZE(tjmax_model_table); i++) {
+		const struct tjmax_model *tm = &tjmax_model_table[i];
+		if (c->x86_model = tm->model &&
+		    (!tm->mask || c->x86_mask = tm->mask))
+			return tm->tjmax;
 	}
 
 	/* Early chips have no MSR for TjMax */
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
