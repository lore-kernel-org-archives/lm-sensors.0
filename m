From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: [PATCH] S3C2410 missing I2C_CLASS_HWMON
Message-Id: <20050221121745.GA7839@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

None of the standard sensor drivers currently recognise the s3c24xx
I2C controller as it does not have I2C_CLASS_HWMON set in the
adapter class field.

The attached patch initialises the adapter class to I2C_CLASS_HWMON

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
diff -urN -X ../dontdiff linux-2.6.11-rc4-bk8/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.11-rc4-bk8-tmp101/drivers/i2c/busses/i2c-s3c2410.c
--- linux-2.6.11-rc4-bk8/drivers/i2c/busses/i2c-s3c2410.c	2005-01-04 10:57:49.000000000 +0000
+++ linux-2.6.11-rc4-bk8-tmp101/drivers/i2c/busses/i2c-s3c2410.c	2005-02-21 10:52:12.000000000 +0000
@@ -569,6 +569,7 @@
 		.name			= "s3c2410-i2c",
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
+		.class			= I2C_CLASS_HWMON,
 	},
 };
 
