From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Apr 2011 17:32:18 +0000
Subject: [lm-sensors] [PATCH] hwmon/f71882fg: Actually read registers for
Message-Id: <1303925538-3661-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 61ffab5..a4a94a0 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -1266,7 +1266,13 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 			data->pwm[nr]  			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
 		}
-		/* The f8000 can monitor 1 more fan, but has no pwm for it */
+		/* Some models have 1 more fan with limited capabilities */
+		if (data->type = f71808a) {
+			data->fan[2] = f71882fg_read16(data,
+						F71882FG_REG_FAN(2));
+			data->pwm[2] = f71882fg_read8(data,
+							F71882FG_REG_PWM(2));
+		}
 		if (data->type = f8000)
 			data->fan[3] = f71882fg_read16(data,
 						F71882FG_REG_FAN(3));
-- 
1.7.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
