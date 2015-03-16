From: Fabian Frederick <fabf@skynet.be>
Date: Mon, 16 Mar 2015 19:54:36 +0000
Subject: [lm-sensors] [PATCH 26/35 linux-next] hwmon: constify of_device_id array
Message-Id: <1426535685-25996-5-git-send-email-fabf@skynet.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1426535685-25996-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabian Frederick <fabf@skynet.be>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/hwmon/pwm-fan.c  | 2 +-
 drivers/hwmon/vexpress.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 4170728..31d793b 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -322,7 +322,7 @@ static int pwm_fan_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(pwm_fan_pm, pwm_fan_suspend, pwm_fan_resume);
 
-static struct of_device_id of_pwm_fan_match[] = {
+static const struct of_device_id of_pwm_fan_match[] = {
 	{ .compatible = "pwm-fan", },
 	{},
 };
diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
index cf1848b..8ba419d 100644
--- a/drivers/hwmon/vexpress.c
+++ b/drivers/hwmon/vexpress.c
@@ -193,7 +193,7 @@ static struct vexpress_hwmon_type vexpress_hwmon_energy = {
 	},
 };
 
-static struct of_device_id vexpress_hwmon_of_match[] = {
+static const struct of_device_id vexpress_hwmon_of_match[] = {
 #if !defined(CONFIG_REGULATOR_VEXPRESS)
 	{
 		.compatible = "arm,vexpress-volt",
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
