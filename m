From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 01 Oct 2010 11:46:51 +0000
Subject: [lm-sensors] [RFC PATCH 4/9] hwmon: lis3: Update coordinates at
Message-Id: <1285933616-16044-5-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1285933616-16044-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Call input device poll function at device open to refresh coordinates
immediately. This is needed for the case where poll interval is set to
zero and coordinate updates happens purely under interrupt control.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 483204a..dc777d2 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -311,6 +311,11 @@ static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
 
 	if (lis3_dev.pdata && lis3_dev.whoami = WAI_8B && lis3_dev.idev)
 		atomic_set(&lis3_dev.wake_thread, 1);
+	/*
+	 * Update coordinates for the case where poll interval is 0 and
+	 * the chip in running purely under interrupt control
+	 */
+	lis3lv02d_joystick_poll(pidev);
 }
 
 static void lis3lv02d_joystick_close(struct input_polled_dev *pidev)
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
