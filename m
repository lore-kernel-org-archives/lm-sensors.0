From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:36 +0000
Subject: [lm-sensors] [PATCH 13/17] drivers/hwmon/w83l785ts.c: fix
Message-Id: <1326039820-11147-13-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/w83l785ts.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index 20781de..edfc1ec 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -86,7 +86,7 @@ static struct w83l785ts_data *w83l785ts_update_device(struct device *dev);
 /*
  * Driver data (common to all clients)
  */
- 
+
 static const struct i2c_device_id w83l785ts_id[] = {
 	{ "w83l785ts", 0 },
 	{ }
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
