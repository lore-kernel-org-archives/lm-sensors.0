From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 08 Feb 2012 17:56:09 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (f75375s) Fix reading of wrong register when initializing the F75387
Message-Id: <1328723771-22163-3-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Nikolaus Schulz <schulz@macnetix.de>

Unlike the other chips supported by this driver, the F75387 stores the
pwm_mode in register F75375_REG_FAN_TIMER, not F75375_REG_CONFIG1.

Signed-off-by: Nikolaus Schulz <mail@microschulz.de>
Cc: stable@kernel.org
---
 drivers/hwmon/f75375s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index c81ad45..b3eef44 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -723,7 +723,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
 			if (data->kind = f75387) {
 				bool manu, duty;
 
-				if (!(conf & (1 << F75387_FAN_CTRL_LINEAR(nr))))
+				if (!(mode & (1 << F75387_FAN_CTRL_LINEAR(nr))))
 					data->pwm_mode[nr] = 1;
 
 				manu = ((mode >> F75387_FAN_MANU_MODE(nr)) & 1);
-- 
1.7.9


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
