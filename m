From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Tue, 13 Jan 2009 01:11:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: applesmc: Fix light sensor readings on
Message-Id: <1231809082-11165-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Murray <murray.alex@gmail.com>, Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

From: Alex Murray <murray.alex@gmail.com>

The light sensors ALV0 and ALV1 on newer MacBooks (early 2008 and
later) changed to report 10 bytes instead the earlier 6, and the
sensor encoding subsequently changed. As a result, the reported light
sensors readings are much too low.

From experiments leading up to this patch, it seems only the ALV0 is
reporting data, and the most useful value therein is a 10-bit
big-endian value at offset 6. This suggests that a new protocol was
added as a backward-compatible replacement on top of the old one.

This patch makes applesmc report the improved light sensor reading for
the new machines, on a scale in conformance with earlier ones.

Signed-off-by: Alex Murray <murray.alex@gmail.com>
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index dca47a5..e301862 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -590,6 +590,11 @@ static ssize_t applesmc_light_show(struct device *dev,
 	}
 
 	ret = applesmc_read_key(LIGHT_SENSOR_LEFT_KEY, buffer, data_length);
+	/* newer macbooks report a single 10-bit bigendian value */
+	if (data_length = 10) {
+		left = be16_to_cpu(*(__be16 *)(buffer + 6)) >> 2;
+		goto out;
+	}
 	left = buffer[2];
 	if (ret)
 		goto out;
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
