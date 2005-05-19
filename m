From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.6] Add ported sensor chip driver: asb100
Message-Id: <20040114040456.GM894@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040106051203.GK30841@earth.solarsys.private>
In-Reply-To: <20040106051203.GK30841@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-01-09 22:58:58 +0100]:

> Shouldn't the asb100 be listed first, the same way the w83781d is, since
> it has subclients? I would even put asb100 before w83781d, since for now
> the w83781d driver will try to handle ASB100 chips too, thus preventing
> the asb100 driver from being used if both drivers are built-in.

You're right, thanks.  Greg, please apply...

* * * * *

This patch fixes the link order for asb100 sensors chip driver.

--- linux-2.6.1-rc1-mmh/drivers/i2c/chips/Makefile.orig	2003-12-31 18:07:45.000000000 -0500
+++ linux-2.6.1-rc1-mmh/drivers/i2c/chips/Makefile	2004-01-13 22:52:16.000000000 -0500
@@ -2,11 +2,11 @@
 # Makefile for the kernel hardware sensors chip drivers.
 #
 
-# w83781d goes first, as it can override other driver's addresses.
+# asb100, then w83781d go first, as they can override other drivers' addresses.
+obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
 
 obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
-obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_LM75)	+= lm75.o

-- 
Mark M. Hoffman
mhoffman@lightlink.com
