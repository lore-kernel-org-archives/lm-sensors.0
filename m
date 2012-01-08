From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:24 +0000
Subject: [lm-sensors] [PATCH 01/17] drivers/hwmon/ad7414.c: fix checkpath
Message-Id: <1326039820-11147-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/ad7414.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index df29a7f..7c4939a 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -130,7 +130,11 @@ static ssize_t set_max_min(struct device *dev,
 	struct ad7414_data *data = i2c_get_clientdata(client);
 	int index = to_sensor_dev_attr(attr)->index;
 	u8 reg = AD7414_REG_LIMIT[index];
-	long temp = simple_strtol(buf, NULL, 10);
+	long temp;
+	int ret = kstrtol(buf, 10, &temp);
+
+	if (ret < 0)
+		return ret;
 
 	temp = SENSORS_LIMIT(temp, -40000, 85000);
 	temp = (temp + (temp < 0 ? -500 : 500)) / 1000;
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
