From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 02 Mar 2009 21:05:05 +0000
Subject: [lm-sensors] [PATCH] lm85: Add VRM10 support for adt7468 chip
Message-Id: <20090302210505.GF6550@plum>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

The adt7468 chip supports VRM10 sensors just like the adt7463; add a missing
check for it.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/lm85.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index cf1422e..b251d86 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -410,7 +410,8 @@ static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
 	struct lm85_data *data = lm85_update_device(dev);
 	int vid;
 
-	if (data->type = adt7463 && (data->vid & 0x80)) {
+	if ((data->type = adt7463 || data->type = adt7468) &&
+	    (data->vid & 0x80)) {
 		/* 6-pin VID (VRM 10) */
 		vid = vid_from_reg(data->vid & 0x3f, data->vrm);
 	} else {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
