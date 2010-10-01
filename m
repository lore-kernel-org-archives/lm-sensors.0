From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 01 Oct 2010 11:46:52 +0000
Subject: [lm-sensors] [RFC PATCH 5/9] hwmon: lis3: Power on corrections
Message-Id: <1285933616-16044-6-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285933616-16044-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1285933616-16044-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Sometimes lis3 chip seems to fail to setup factory tuning at boot up.
This probably happens if there is some odd power ramp down ramp up sequence
for example in device restart. Set boot bit in control2 register to
trig boot sequence manually and wait until it is finished.
Also restore axis enable bits in init.

Signed-off-by: Samu O kalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c     |   19 +++++++++++--------
 drivers/hwmon/lis3lv02d.h     |    1 +
 drivers/hwmon/lis3lv02d_i2c.c |    2 +-
 drivers/hwmon/lis3lv02d_spi.c |    2 +-
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index dc777d2..81e2313 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -272,19 +272,22 @@ void lis3lv02d_poweron(struct lis3lv02d *lis3)
 
 	lis3->init(lis3);
 
-	/* LIS3 power on delay is quite long */
-	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
-
 	/*
 	 * Common configuration
 	 * BDU: (12 bits sensors only) LSB and MSB values are not updated until
 	 *      both have been read. So the value read will always be correct.
+	 * Set BOOT bit to refresh factory tuning values.
 	 */
-	if (lis3->whoami =  WAI_12B) {
-		lis3->read(lis3, CTRL_REG2, &reg);
-		reg |= CTRL2_BDU;
-		lis3->write(lis3, CTRL_REG2, reg);
-	}
+	lis3->read(lis3, CTRL_REG2, &reg);
+	if (lis3->whoami =  WAI_12B)
+		reg |= CTRL2_BDU | CTRL2_BOOT;
+	else
+		reg |= CTRL2_BOOT_8B;
+	lis3->write(lis3, CTRL_REG2, reg);
+
+	/* LIS3 power on delay is quite long */
+	msleep(lis3->pwron_delay / lis3lv02d_get_odr());
+
 	if (lis3->reg_ctrl)
 		lis3_context_restore(lis3);
 }
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index 8c19185..1522855 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -142,6 +142,7 @@ enum lis3lv02d_ctrl2 {
 enum lis302d_ctrl2 {
 	HP_FF_WU2	= 0x08,
 	HP_FF_WU1	= 0x04,
+	CTRL2_BOOT_8B   = 0x40,
 };
 
 enum lis3lv02d_ctrl3 {
diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index 0852bed..c5a60e4 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -82,7 +82,7 @@ static int lis3_i2c_init(struct lis3lv02d *lis3)
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
