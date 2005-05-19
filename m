From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: ticket 1599 explanation
Message-Id: <20040306095143.3b638f47.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040306020526.50077.qmail@home.pl>
In-Reply-To: <20040306020526.50077.qmail@home.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> the problem is, that I have ONLY mainboard sensors output. GeForce
> card sensors are detected by sensors-detect but not visible after
> runing "sensors".

Looks like rivatv doesn't declare bus classes correctly.

Here is a patch that should fix your problem:

--- rivatv-0.8.4/src/i2c-riva.c.orig	Sat Mar  6 09:48:13 2004
+++ rivatv-0.8.4/src/i2c-riva.c	Sat Mar  6 09:47:58 2004
@@ -249,7 +249,7 @@
 	.owner             = THIS_MODULE,
 #endif
 #ifdef I2C_ADAP_CLASS_TV_ANALOG
-        .class             = I2C_ADAP_CLASS_TV_ANALOG,
+        .class             = I2C_ADAP_CLASS_TV_ANALOG | I2C_ADAP_CLASS_DDC,
 #endif
 };
 
@@ -265,7 +265,7 @@
 	.owner             = THIS_MODULE,
 #endif
 #ifdef I2C_ADAP_CLASS_TV_ANALOG
-        .class             = I2C_ADAP_CLASS_TV_ANALOG,
+        .class             = I2C_ADAP_CLASS_TV_ANALOG | I2C_ADAP_CLASS_SMBUS,
 #endif
 };
 
Let me know if it works. If it does I'll send it to the rivatv team.

BTW, "No i2c-bus specified!" on i2cdetect simply means that i2cdetect
expects a bus number as its first argument, which you had not being
suplying. Try "i2cdetect 2" for example, and it'll scan the i2c bus 2
for devices.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
