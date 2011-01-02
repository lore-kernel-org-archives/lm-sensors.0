From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Sun, 02 Jan 2011 19:48:16 +0000
Subject: [lm-sensors] [PATCH] HWMON: s3c-hwmon: Fix compilation
Message-Id: <4d20d682.cc7e0e0a.6f59.4a1b@mx.google.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The owner field was removed from struct attribute in
6fd69dc578fa0b1bbc3aad70ae3af9a137211707, so don't assign it anymore.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/hwmon/s3c-hwmon.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index 05248f2..92b42db 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -234,7 +234,6 @@ static int s3c_hwmon_create_attr(struct device *dev,
 	attr->index = channel;
 	attr->dev_attr.attr.name  = attrs->in_name;
 	attr->dev_attr.attr.mode  = S_IRUGO;
-	attr->dev_attr.attr.owner = THIS_MODULE;
 	attr->dev_attr.show = s3c_hwmon_ch_show;
 
 	ret =  device_create_file(dev, &attr->dev_attr);
@@ -252,7 +251,6 @@ static int s3c_hwmon_create_attr(struct device *dev,
 		attr->index = channel;
 		attr->dev_attr.attr.name  = attrs->label_name;
 		attr->dev_attr.attr.mode  = S_IRUGO;
-		attr->dev_attr.attr.owner = THIS_MODULE;
 		attr->dev_attr.show = s3c_hwmon_label_show;
 
 		ret = device_create_file(dev, &attr->dev_attr);
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
