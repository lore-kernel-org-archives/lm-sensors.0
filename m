From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 10 Nov 2009 12:41:04 +0000
Subject: [lm-sensors] [PATCH v2 02/10] LIS3LV02D: Correct memory leak in
Message-Id: <1257856872-11612-3-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
 <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, daniel@caiaq.de, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Samu Onkalo <samu.p.onkalo@nokia.com>

polled input device itself was not free'd.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 7f43a3b..dbd0b05 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -333,6 +333,7 @@ void lis3lv02d_joystick_disable(void)
 	if (lis3_dev.irq)
 		misc_deregister(&lis3lv02d_misc_device);
 	input_unregister_polled_device(lis3_dev.idev);
+	input_free_polled_device(lis3_dev.idev);
 	lis3_dev.idev = NULL;
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_joystick_disable);
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
