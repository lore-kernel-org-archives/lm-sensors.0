From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: ref 1501
Message-Id: <20040224205640.0a01408d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <19808.1073178613@www49.gmx.net>
In-Reply-To: <19808.1073178613@www49.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Did as you say, the values are changing so i guess the ali bus if 
> fine, i don't know how to force the w83781d using i2cdetec :P 

I think I found the problem. Here is a patch against Linux 2.6.3 that
should make it work.

Sorry it took me so long to get to it, it was very basic and lying under
my eyes, but for some reasons it was so evident that I did not see it.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
--- linux-2.6.3/drivers/i2c/busses/i2c-ali1535.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3/drivers/i2c/busses/i2c-ali1535.c	Tue Feb 24 20:54:30 2004
@@ -484,6 +484,7 @@
 
 static struct i2c_adapter ali1535_adapter = {
 	.owner		= THIS_MODULE,
+	.class          = I2C_ADAP_CLASS_SMBUS,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
