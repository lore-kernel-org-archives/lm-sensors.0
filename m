From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 22 Oct 2010 11:57:28 +0000
Subject: [lm-sensors] [PATCH 06/12] hwmon: lis3: restore axis enabled bits
Message-Id: <1287748654-2626-7-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

All axis enable bits are set to 0 at module remove.
Restore reset default value at init.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d_i2c.c |    2 +-
 drivers/hwmon/lis3lv02d_spi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index 98983cc..36171bf 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -83,7 +83,7 @@ static int lis3_i2c_init(struct lis3lv02d *lis3)
 	if (ret < 0)
 		return ret;
 
-	reg |= CTRL1_PD0;
+	reg |= CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
 	return lis3->write(lis3, CTRL_REG1, reg);
 }
 
diff --git a/drivers/hwmon/lis3lv02d_spi.c b/drivers/hwmon/lis3lv02d_spi.c
index b9be5e3..778885d 100644
--- a/drivers/hwmon/lis3lv02d_spi.c
+++ b/drivers/hwmon/lis3lv02d_spi.c
@@ -50,7 +50,7 @@ static int lis3_spi_init(struct lis3lv02d *lis3)
 	if (ret < 0)
 		return ret;
 
-	reg |= CTRL1_PD0;
+	reg |= CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
 	return lis3->write(lis3, CTRL_REG1, reg);
 }
 
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
