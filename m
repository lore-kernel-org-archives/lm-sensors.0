From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 06 Aug 2014 00:27:11 +0000
Subject: [lm-sensors] [PATCH 08/10] hwmon: (w83627hf) Fix vrm write operation
Message-Id: <1407284831.4924.14.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is an u8, so the written value needs to be limited to [0, 255].

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/w83627hf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index c1726be..2f55973 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -820,6 +820,9 @@ store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
+
+	if (val > 255)
+		return -EINVAL;
 	data->vrm = val;
 
 	return count;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
