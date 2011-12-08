From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 18:31:09 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (f75375s) Initialize pwmX_mode and
Message-Id: <1323369069-26203-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

pwmX_mode and pwmX_enable are not initialized if no platform data is provided to
the driver. Read chip configuration at driver initialization time and initialize
attributes to reflect chip configuration.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/f75375s.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 777a665..9c3f078 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -652,6 +652,31 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 		struct f75375s_platform_data *f75375s_pdata)
 {
 	int nr;
+
+	if (!f75375s_pdata) {
+		u8 conf, mode;
+		int nr;
+
+		conf = f75375_read8(client, F75375_REG_CONFIG1);
+		mode = f75375_read8(client, F75375_REG_FAN_TIMER);
+		for (nr = 0; nr < 2; nr++) {
+			if (!(conf & (1 << FAN_CTRL_LINEAR(nr))))
+				data->pwm_mode[nr] = 1;
+			switch ((mode >> FAN_CTRL_MODE(nr)) & 3) {
+			case 0:		/* speed */
+				data->pwm_enable[nr] = 3;
+				break;
+			case 1:		/* automatic */
+				data->pwm_enable[nr] = 2;
+				break;
+			default:	/* manual */
+				data->pwm_enable[nr] = 1;
+				break;
+			}
+		}
+		return;
+	}
+
 	set_pwm_enable_direct(client, 0, f75375s_pdata->pwm_enable[0]);
 	set_pwm_enable_direct(client, 1, f75375s_pdata->pwm_enable[1]);
 	for (nr = 0; nr < 2; nr++) {
@@ -703,8 +728,7 @@ static int f75375_probe(struct i2c_client *client,
 		goto exit_remove;
 	}
 
-	if (f75375s_pdata != NULL)
-		f75375_init(client, data, f75375s_pdata);
+	f75375_init(client, data, f75375s_pdata);
 
 	return 0;
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
