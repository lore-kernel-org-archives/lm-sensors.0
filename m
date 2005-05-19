From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: [PATCH] typo in drivers/i2c/busses/i2c-ixp4xx.c
Message-Id: <1108642776.3324.82.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Deepak,

I was looking at your ixp4xx gpio i2c driver for inspiration (for a
similar pxa2xx one) and I just happened to notice a tiny typo.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/i2c/busses/i2c-ixp4xx.c
=================================--- 2.6.orig/drivers/i2c/busses/i2c-ixp4xx.c	2004-10-18 22:54:31.000000000 +0100
+++ 2.6/drivers/i2c/busses/i2c-ixp4xx.c	2005-02-17 12:13:01.777210214 +0000
@@ -133,8 +133,8 @@
 	drv_data->algo_data.mdelay = 10;
 	drv_data->algo_data.timeout = 100;
 
-	drv_data->adapter.id = I2C_HW_B_IXP4XX,
-	drv_data->adapter.algo_data = &drv_data->algo_data,
+	drv_data->adapter.id = I2C_HW_B_IXP4XX;
+	drv_data->adapter.algo_data = &drv_data->algo_data;
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
 

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200
