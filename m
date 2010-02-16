From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 16 Feb 2010 11:09:31 +0000
Subject: [lm-sensors] [PATCH V2 6/6] lis3: Setup poll interval limits
Message-Id: <1266318571-31083-7-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net
Cc: pavel@ucw.cz, daniel@caiaq.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Set valid adjustment window (0 - 2000ms).

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 56a1d34..6138f03 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -41,6 +41,8 @@
 
 /* joystick device poll interval in milliseconds */
 #define MDPS_POLL_INTERVAL 50
+#define MDPS_POLL_MIN	   0
+#define MDPS_POLL_MAX	   2000
 /*
  * The sensor can also generate interrupts (DRDY) but it's pretty pointless
  * because they are generated even if the data do not change. So it's better
@@ -459,6 +461,8 @@ int lis3lv02d_joystick_enable(void)
 
 	lis3_dev.idev->poll = lis3lv02d_joystick_poll;
 	lis3_dev.idev->poll_interval = MDPS_POLL_INTERVAL;
+	lis3_dev.idev->poll_interval_min = MDPS_POLL_MIN;
+	lis3_dev.idev->poll_interval_max = MDPS_POLL_MAX;
 	input_dev = lis3_dev.idev->input;
 
 	input_dev->name       = "ST LIS3LV02DL Accelerometer";
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
