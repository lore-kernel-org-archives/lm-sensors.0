From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 06 Aug 2014 00:20:45 +0000
Subject: [lm-sensors] [PATCH 02/10] hwmon: (adm1026) Fix vrm write operation
Message-Id: <1407284445.4924.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is an u8, so the written value needs to be limited to [0, 255].

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/adm1026.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
index ca8430f..e67b9a5 100644
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -1085,6 +1085,9 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 	if (err)
 		return err;
 
+	if (val > 255)
+		return -EINVAL;
+
 	data->vrm = val;
 	return count;
 }
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
