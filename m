From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 22 Oct 2010 11:57:34 +0000
Subject: [lm-sensors] [PATCH 12/12] hwmon: lis3: Release resources is case
Message-Id: <1287748654-2626-13-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

If lis3lv02d_init_device fails, HW resources were not released
properly. In case of failure call release_resources if available.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d_i2c.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index 61c109b..94d5bde 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -161,7 +161,12 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
 
 	if (lis3_dev.reg_ctrl)
 		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
+
+	if (ret = 0)
+		return 0;
 fail:
+	if (pdata && pdata->release_resources)
+		pdata->release_resources();
 	return ret;
 }
 
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
