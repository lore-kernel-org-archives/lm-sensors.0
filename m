From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Thu, 26 Jan 2012 11:08:41 +0000
Subject: [lm-sensors] [PATCH] applesmc: Silence uninitialized warnings
Message-Id: <1327576121-2073-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Some error paths do not set a result, leading to the (false)
assumption that the value may be used uninitialized. Set results for
those paths as well.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b989553..11f79bb 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -344,8 +344,10 @@ static int applesmc_get_lower_bound(unsigned int *lo, const char *key)
 	while (begin != end) {
 		int middle = begin + (end - begin) / 2;
 		entry = applesmc_get_entry_by_index(middle);
-		if (IS_ERR(entry))
+		if (IS_ERR(entry)) {
+			*lo = 0;
 			return PTR_ERR(entry);
+		}
 		if (strcmp(entry->key, key) < 0)
 			begin = middle + 1;
 		else
@@ -364,8 +366,10 @@ static int applesmc_get_upper_bound(unsigned int *hi, const char *key)
 	while (begin != end) {
 		int middle = begin + (end - begin) / 2;
 		entry = applesmc_get_entry_by_index(middle);
-		if (IS_ERR(entry))
+		if (IS_ERR(entry)) {
+			*hi = smcreg.key_count;
 			return PTR_ERR(entry);
+		}
 		if (strcmp(key, entry->key) < 0)
 			end = middle;
 		else
-- 
1.7.8.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
