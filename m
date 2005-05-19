From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: [PATCH 2.6] Add ported sensor chip driver: asb100
Message-Id: <20040109225858.32a2d4d6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040106051203.GK30841@earth.solarsys.private>
In-Reply-To: <20040106051203.GK30841@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> --- linux-2.6.1-rc1-orig/drivers/i2c/chips/Makefile
> +++ linux-2.6.1-rc1-mmh/drivers/i2c/chips/Makefile
> @@ -6,6 +6,7 @@
>  obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
>  
>  obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
> +obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
>  obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
>  obj-$(CONFIG_SENSORS_IT87)	+= it87.o
>  obj-$(CONFIG_SENSORS_LM75)	+= lm75.o

Shouldn't the asb100 be listed first, the same way the w83781d is, since
it has subclients? I would even put asb100 before w83781d, since for now
the w83781d driver will try to handle ASB100 chips too, thus preventing
the asb100 driver from being used if both drivers are built-in.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
