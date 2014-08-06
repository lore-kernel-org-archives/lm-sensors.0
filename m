From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 06 Aug 2014 00:21:49 +0000
Subject: [lm-sensors] [PATCH 03/10] hwmon: (asb100) Fix vrm write operation
Message-Id: <1407284509.4924.7.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is an u8, so the written value needs to be limited to [0, 255].

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/asb100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
index f960636..272fcc8 100644
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -510,6 +510,10 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
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
