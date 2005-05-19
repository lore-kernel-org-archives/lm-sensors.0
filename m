From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: fix typo in drivers/i2c/busses/i2c-ixp4xx.c
Message-Id: <11099685961094@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685963312@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: icampbell@arcom.com

ChangeSet 1.2104, 2005/03/02 12:18:36-08:00, icampbell@arcom.com

[PATCH] I2C: fix typo in drivers/i2c/busses/i2c-ixp4xx.c

I was looking at your ixp4xx gpio i2c driver for inspiration (for a
similar pxa2xx one) and I just happened to notice a tiny typo.

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-ixp4xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- a/drivers/i2c/busses/i2c-ixp4xx.c	2005-03-04 12:24:02 -08:00
+++ b/drivers/i2c/busses/i2c-ixp4xx.c	2005-03-04 12:24:02 -08:00
@@ -133,8 +133,8 @@
 	drv_data->algo_data.mdelay = 10;
 	drv_data->algo_data.timeout = 100;
 
-	drv_data->adapter.id = I2C_HW_B_IXP4XX,
-	drv_data->adapter.algo_data = &drv_data->algo_data,
+	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.algo_data = &drv_data->algo_data;
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
 

