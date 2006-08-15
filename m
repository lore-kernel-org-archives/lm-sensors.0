From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 19:34:17 +0000
Subject: [lm-sensors] error in mkpatch.pl of lm_sensors 2.10.0
Message-Id: <20060815213417.ea688d2c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <002301c6c096$3cb72220$d620a8c0@pcw_hans.hnsasd.lan>
In-Reply-To: <002301c6c096$3cb72220$d620a8c0@pcw_hans.hnsasd.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> I found an error in the mkpatch.pl script of lm_sensors 2.10.0,
> causing the build of a patched 2.4.32/33 kernel to fail.
> The following mini-patch corrects the error:
> %<---------------------------------------------->%
> --- mkpatch.pl.orig     2006-02-15 02:46:48.000000000 +0100
> +++ mkpatch.pl  2006-08-15 19:51:34.000000000 +0200
> @@ -1027,7 +1027,7 @@
>  obj-$(CONFIG_SENSORS_DDCMON)   += ddcmon.o
>  obj-$(CONFIG_SENSORS_DS1621)   += ds1621.o
>  obj-$(CONFIG_SENSORS_EEPROM)   += eeprom.o
> -obj-$(CONFIG_SENSORS_FSCHER)   += f71085f.o
> +obj-$(CONFIG_SENSORS_F71805F)  += f71805f.o
>  obj-$(CONFIG_SENSORS_FSCHER)   += fscher.o
>  obj-$(CONFIG_SENSORS_FSCPOS)   += fscpos.o
>  obj-$(CONFIG_SENSORS_FSCSCY)   += fscscy.o
> %<---------------------------------------------->%

Already fixed in lm_sensors SVN since February 2006.

-- 
Jean Delvare

