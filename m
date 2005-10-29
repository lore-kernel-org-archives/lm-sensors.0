From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:10:55 +0000
Subject: [lm-sensors] [PATCH] i2c: Add missing i2c-ixp2000/4xx adapter name
Message-Id: <11305336593514@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Add missing i2c-ixp2000/4xx adapter name

The ixp4xx and ixp2000 i2c bus drivers omit to fill the required
i2c_adapter name field. Copy the device driver name field there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8a1b028bca95b5af36e94a660c4d284fe3313f74
tree 8fc0193e66117776b4112cb9484e61a51bf48a21
parent ca68f1193e8fc86470d4222d563d13b5584dc4f8
author Jean Delvare <khali@linux-fr.org> Fri, 07 Oct 2005 23:04:48 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:08 -0700

 drivers/i2c/busses/i2c-ixp2000.c |    4 ++++
 drivers/i2c/busses/i2c-ixp4xx.c  |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index 1956af3..9dee505 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -36,6 +36,8 @@
 #include <asm/hardware.h>	/* Pick up IXP2000-specific bits */
 #include <asm/arch/gpio.h>
 
+static struct device_driver ixp2000_i2c_driver;
+
 static inline int ixp2000_scl_pin(void *data)
 {
 	return ((struct ixp2000_i2c_pins*)data)->scl_pin;
@@ -121,6 +123,8 @@ static int ixp2000_i2c_probe(struct devi
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP2000,
+	strlcpy(drv_data->adapter.name, ixp2000_i2c_driver.name,
+		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data,
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
index f6f5ca3..013981d 100644
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -35,6 +35,8 @@
 
 #include <asm/hardware.h>	/* Pick up IXP4xx-specific bits */
 
+static struct device_driver ixp4xx_i2c_driver;
+
 static inline int ixp4xx_scl_pin(void *data)
 {
 	return ((struct ixp4xx_i2c_pins*)data)->scl_pin;
@@ -129,6 +131,8 @@ static int ixp4xx_i2c_probe(struct devic
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	strlcpy(drv_data->adapter.name, ixp4xx_i2c_driver.name,
+		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data;
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;

