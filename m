From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 10 Nov 2009 12:41:03 +0000
Subject: [lm-sensors] [PATCH v2 01/10] LIS3LV02D: Send sync event
Message-Id: <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, daniel@caiaq.de, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Samu Onkalo <samu.p.onkalo@nokia.com>

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
