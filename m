From: gregkh@suse.de (Greg KH)
Date: Thu, 23 Mar 2006 22:43:52 +0000
Subject: [lm-sensors] [PATCH 33/36] I2C: i2c-ixp4xx: Add hwmon class
Message-Id: <1143153832917-git-send-email-gregkh@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds I2C_CLASS_HWMON to the ixp4xx bus driver.

Signed-off-by: Alessandro Zummo <a.zummo at towertech.it>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/i2c/busses/i2c-ixp4xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

7cd30b26eb779b787e00e05f3e9797a97de33968
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
index e422d8b..2ed0711 100644
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -126,6 +126,7 @@ static int ixp4xx_i2c_probe(struct platf
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.class = I2C_CLASS_HWMON;
 	strlcpy(drv_data->adapter.name, plat_dev->dev.driver->name,
 		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data;
-- 
1.2.4



