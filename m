From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 03 Nov 2009 12:09:36 +0000
Subject: [lm-sensors] [RFC PATCH 01/10] LIS3LV02D: Send sync event
Message-Id: <1257250185-7929-2-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Send input_sync after each measurement round. This helps userspace to
detect which reported values belongs to the same measurement.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index cf5afb9..7f43a3b 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -276,6 +276,7 @@ static void lis3lv02d_joystick_poll(struct input_polled_dev *pidev)
 	input_report_abs(pidev->input, ABS_X, x - lis3_dev.xcalib);
 	input_report_abs(pidev->input, ABS_Y, y - lis3_dev.ycalib);
 	input_report_abs(pidev->input, ABS_Z, z - lis3_dev.zcalib);
+	input_sync(pidev->input);
 }
 
 
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
