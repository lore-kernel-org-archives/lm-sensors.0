From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <1079391393684@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913933600@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1608.74.6, 2004/03/09 15:29:26-08:00, khali@linux-fr.org

[PATCH] I2C: fix i2c adapters class for now

Please accept this temporary fix for the class issue. I'd like users of
the i2c-ali1535, i2c-sis5595 and i2c-via driver to be able to use
sensors as soon as possible, even if we have not yet determined what our
policy WRT classes should be.

Thanks.

BTW, don't you think I2C_ADAP_CLASS_SMBUS is a misnomer? It's about
hardware monitoring, not the SMBus protocol. I'd say
I2C_ADAP_CLASS_HWMON or I2C_ADAP_CLASS_SENSORS would have been more
appropriate (although it may be a bit late for a change...)


 drivers/i2c/busses/i2c-ali1535.c |    1 +
 drivers/i2c/busses/i2c-sis5595.c |    1 +
 drivers/i2c/busses/i2c-via.c     |    1 +
 3 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:34:50 2004
+++ b/drivers/i2c/busses/i2c-ali1535.c	Mon Mar 15 14:34:50 2004
@@ -484,6 +484,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:34:50 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:34:50 2004
@@ -364,6 +364,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	Mon Mar 15 14:34:50 2004
+++ b/drivers/i2c/busses/i2c-via.c	Mon Mar 15 14:34:50 2004
@@ -92,6 +92,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };

