From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 23:05:24 +0000
Subject: [lm-sensors] [PATCH 01/16] i2c: Add missing i2c-ixp2000/4xx adapter
Message-Id: <20051007230448.595f1993.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ixp4xx and ixp2000 i2c bus drivers omit to fill the required
i2c_adapter name field. Copy the device driver name field there.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

 drivers/i2c/busses/i2c-ixp2000.c |    4 ++++
 drivers/i2c/busses/i2c-ixp4xx.c  |    4 ++++
 2 files changed, 8 insertions(+)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ixp4xx.c	2005-10-07 20:08:17.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ixp4xx.c	2005-10-07 20:15:52.000000000 +0200
@@ -35,6 +35,8 @@
 
 #include <asm/hardware.h>	/* Pick up IXP4xx-specific bits */
 
+static struct device_driver ixp4xx_i2c_driver;
+
 static inline int ixp4xx_scl_pin(void *data)
 {
 	return ((struct ixp4xx_i2c_pins*)data)->scl_pin;
@@ -129,6 +131,8 @@
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	strlcpy(drv_data->adapter.name, ixp4xx_i2c_driver.name,
+		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data;
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-ixp2000.c	2005-10-07 20:08:17.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-ixp2000.c	2005-10-07 20:15:52.000000000 +0200
@@ -36,6 +36,8 @@
 #include <asm/hardware.h>	/* Pick up IXP2000-specific bits */
 #include <asm/arch/gpio.h>
 
+static struct device_driver ixp2000_i2c_driver;
+
 static inline int ixp2000_scl_pin(void *data)
 {
 	return ((struct ixp2000_i2c_pins*)data)->scl_pin;
@@ -121,6 +123,8 @@
 	drv_data->algo_data.timeout = 100;
 
 	drv_data->adapter.id = I2C_HW_B_IXP2000,
+	strlcpy(drv_data->adapter.name, ixp2000_i2c_driver.name,
+		I2C_NAME_SIZE);
 	drv_data->adapter.algo_data = &drv_data->algo_data,
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;

-- 
Jean Delvare
