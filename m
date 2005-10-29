From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:18:47 +0000
Subject: [lm-sensors] [PATCH] i2c: kzalloc conversion, ixp bus drivers
Message-Id: <11305336621136@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: kzalloc conversion, ixp bus drivers

Use kzalloc instead of kmalloc+memzero in the ixp2000 and ixp4xx
I2C bus drivers.

Signed-off-by: Deepak Saxena <dsaxena@mvista.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2286066faf51890e49ad61e2ceab683666cd9108
tree fc9e7dc7a898e80485ea25065ff9143ec0e6407e
parent 4d4e5ce8648561b964699afb2df5e7268a84599b
author Deepak Saxena <dsaxena@plexity.net> Mon, 17 Oct 2005 23:07:05 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:12 -0700

 drivers/i2c/busses/i2c-ixp2000.c |    3 +--
 drivers/i2c/busses/i2c-ixp4xx.c  |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
index c3292dc..42016ee 100644
--- a/drivers/i2c/busses/i2c-ixp2000.c
+++ b/drivers/i2c/busses/i2c-ixp2000.c
@@ -106,11 +106,10 @@ static int ixp2000_i2c_probe(struct devi
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp2000_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp2000_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
+		kzalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
 
 	if (!drv_data)
 		return -ENOMEM;
-	memzero(drv_data, sizeof(*drv_data));
 	drv_data->gpio_pins = gpio;
 
 	drv_data->algo_data.data = gpio;
diff --git a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
index 3169280..69303ab 100644
--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -107,12 +107,11 @@ static int ixp4xx_i2c_probe(struct devic
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct ixp4xx_i2c_pins *gpio = plat_dev->dev.platform_data;
 	struct ixp4xx_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
+		kzalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
 
 	if(!drv_data)
 		return -ENOMEM;
 
-	memzero(drv_data, sizeof(struct ixp4xx_i2c_data));
 	drv_data->gpio_pins = gpio;
 
 	/*

