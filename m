From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:27 +0000
Subject: [lm-sensors] [PATCH 04/17] drivers/hwmon/smm665.c: fix checkpatch
Message-Id: <1326039820-11147-4-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/smm665.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index 4116381..1b4301f 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -376,7 +376,7 @@ static ssize_t smm665_show_input(struct device *dev,
 }
 
 #define SMM665_SHOW(what) \
-  static ssize_t smm665_show_##what(struct device *dev, \
+static ssize_t smm665_show_##what(struct device *dev, \
 				    struct device_attribute *da, char *buf) \
 { \
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da); \
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
