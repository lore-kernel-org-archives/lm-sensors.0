From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c adapters class
Message-Id: <20040306190034.77eebafe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Please accept this temporary fix for the class issue. I'd like users of
the i2c-ali1535, i2c-sis5595 and i2c-via driver to be able to use
sensors as soon as possible, even if we have not yet determined what our
policy WRT classes should be.

Thanks.

BTW, don't you think I2C_ADAP_CLASS_SMBUS is a misnomer? It's about
hardware monitoring, not the SMBus protocol. I'd say
I2C_ADAP_CLASS_HWMON or I2C_ADAP_CLASS_SENSORS would have been more
appropriate (although it may be a bit late for a change...)


diff -ru linux-2.6.4-rc2-g1/drivers/i2c/busses/i2c-ali1535.c linux-2.6.4-rc2-g2/drivers/i2c/busses/i2c-ali1535.c
--- linux-2.6.4-rc2-g1/drivers/i2c/busses/i2c-ali1535.c	Sat Mar  6 18:32:41 2004
+++ linux-2.6.4-rc2-g2/drivers/i2c/busses/i2c-ali1535.c	Sat Mar  6 18:54:30 2004
@@ -484,6 +484,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
diff -ru linux-2.6.4-rc2-g1/drivers/i2c/busses/i2c-sis5595.c linux-2.6.4-rc2-g2/drivers/i2c/busses/i2c-sis5595.c
--- linux-2.6.4-rc2-g1/drivers/i2c/busses/i2c-sis5595.c	Sat Mar  6 18:32:41 2004
+++ linux-2.6.4-rc2-g2/drivers/i2c/busses/i2c-sis5595.c	Sat Mar  6 18:54:11 2004
@@ -364,6 +364,7 @@
 
 static struct i2c_adapter sis5595_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.name		= "unset",
 	.algo		= &smbus_algorithm,
 };
diff -ru linux-2.6.4-rc2-g1/drivers/i2c/busses/i2c-via.c linux-2.6.4-rc2-g2/drivers/i2c/busses/i2c-via.c
--- linux-2.6.4-rc2-g1/drivers/i2c/busses/i2c-via.c	Thu Feb  5 22:24:55 2004
+++ linux-2.6.4-rc2-g2/drivers/i2c/busses/i2c-via.c	Sat Mar  6 18:53:58 2004
@@ -92,6 +92,7 @@
 
 static struct i2c_adapter vt586b_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.name		= "VIA i2c",
 	.algo_data	= &bit_data,
 };

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
