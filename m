From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: S3C2410 missing I2C_CLASS_HWMON
Message-Id: <11099685971397@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685961021@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: ben-linux@fluff.org

ChangeSet 1.2109, 2005/03/02 15:02:43-08:00, ben-linux@fluff.org

[PATCH] I2C: S3C2410 missing I2C_CLASS_HWMON

None of the standard sensor drivers currently recognise the s3c24xx
I2C controller as it does not have I2C_CLASS_HWMON set in the
adapter class field.

The attached patch initialises the adapter class to I2C_CLASS_HWMON

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/i2c-s3c2410.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
--- a/drivers/i2c/busses/i2c-s3c2410.c	2005-03-04 12:23:28 -08:00
+++ b/drivers/i2c/busses/i2c-s3c2410.c	2005-03-04 12:23:28 -08:00
@@ -569,6 +569,7 @@
 		.name			= "s3c2410-i2c",
 		.algo			= &s3c24xx_i2c_algorithm,
 		.retries		= 2,
+		.class			= I2C_CLASS_HWMON,
 	},
 };
 

