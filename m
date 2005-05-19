From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH 2.6] Lowercase chips name
Message-Id: <20040221091410.33e37296.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch brings the name field of adm1021.c, it87.c and via686a.c in
conformance with the defined standard ("all lowercase, as simple as the
driver name itself"). Please apply.

Thanks.

--- linux-2.6.3/drivers/i2c/chips/via686a.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3/drivers/i2c/chips/via686a.c	Sat Feb 21 09:06:11 2004
@@ -653,7 +653,7 @@
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "VIA686A",
+	.name		= "via686a",
 	.id		= I2C_DRIVERID_VIA686A,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= via686a_attach_adapter,
--- linux-2.6.3/drivers/i2c/chips/adm1021.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3/drivers/i2c/chips/adm1021.c	Sat Feb 21 09:09:29 2004
@@ -148,7 +148,7 @@
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "ADM1021-MAX1617",
+	.name		= "adm1021",
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
--- linux-2.6.3/drivers/i2c/chips/it87.c.orig	Wed Feb 18 20:56:10 2004
+++ linux-2.6.3/drivers/i2c/chips/it87.c	Sat Feb 21 09:09:14 2004
@@ -231,7 +231,7 @@
 
 static struct i2c_driver it87_driver = {
 	.owner		= THIS_MODULE,
-	.name		= "IT87xx",
+	.name		= "it87",
 	.id		= I2C_DRIVERID_IT87,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= it87_attach_adapter,


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
