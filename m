From: Matthew Garrett <mjg@redhat.com>
Date: Tue, 09 Aug 2011 16:14:42 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: Fix applesmc temperature handling
Message-Id: <1312906483-3046-2-git-send-email-mjg@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The temperature registers in the applesmc hardware are signed. It's likely
that a negative value is invalid, so trigger on that and return an error
rather than an erroneous value.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/hwmon/applesmc.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 62e2493..4540bb1 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -781,6 +781,10 @@ static ssize_t applesmc_show_temperature(struct device *dev,
 		return ret;
 
 	if (entry->len = 2) {
+		if (buffer[0] >= 0x80) {
+			/* The two byte format is signed - ignore negative */
+			return -EINVAL;
+		}
 		temp = buffer[0] * 1000;
 		temp += (buffer[1] >> 6) * 250;
 	} else {
-- 
1.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
