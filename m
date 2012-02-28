From: Nikolaus Schulz <mail@microschulz.de>
Date: Tue, 28 Feb 2012 21:15:52 +0000
Subject: [lm-sensors] [PATCH v2 2/4] hwmon: (f75375s) Make pwm*_mode writable for the F75387
Message-Id: <1330463755-5763-3-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
---
 drivers/hwmon/f75375s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 1c26652..29c0d06 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -794,7 +794,7 @@ static int f75375_probe(struct i2c_client *client,
 	if (err)
 		goto exit_free;
 
-	if (data->kind = f75375) {
+	if (data->kind != f75373) {
 		err = sysfs_chmod_file(&client->dev.kobj,
 			&sensor_dev_attr_pwm1_mode.dev_attr.attr,
 			S_IRUGO | S_IWUSR);
-- 
1.7.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
