From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 06 Aug 2014 00:24:00 +0000
Subject: [lm-sensors] [PATCH 05/10] hwmon: (lm87) Fix vrm write operation
Message-Id: <1407284640.4924.10.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is an u8, so the written value needs to be limited to [0, 255].

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm87.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
index ba1d83d..a5e2958 100644
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -617,6 +617,10 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
+
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
