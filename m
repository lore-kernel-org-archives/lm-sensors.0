From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <10482950921680@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10482950873871@kroah.com>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1195, 2003/03/21 16:39:04-08:00, greg@kroah.com

[PATCH] i2c: fix up the chip driver names to play nice with sysfs


 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/lm75.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Mar 21 16:52:40 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Mar 21 16:52:40 2003
@@ -144,7 +144,7 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "ADM1021, MAX1617 sensor driver",
+	.name		= "ADM1021-MAX1617",
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Fri Mar 21 16:52:40 2003
+++ b/drivers/i2c/chips/lm75.c	Fri Mar 21 16:52:40 2003
@@ -82,7 +82,7 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "LM75 sensor chip driver",
+	.name		= "LM75 sensor",
 	.id		= I2C_DRIVERID_LM75,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,
