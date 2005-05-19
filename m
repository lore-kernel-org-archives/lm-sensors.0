From: marcelo.tosatti@cyclades.com (Marcelo Tosatti)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave (4/8)
Message-Id: <Pine.LNX.4.58L.0401151431170.16886@logos.cnet>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111155027.6e1e2b42.khali@linux-fr.org>
In-Reply-To: <20040111155027.6e1e2b42.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jean,

On Sun, 11 Jan 2004, Jean Delvare wrote:

> This patch doesn't really focus on the i2c subsystem, but is still
> i2c-related. It concerns the media/video subsystem, where I discovered a
> few incorrectnesses as I was working on my i2c patches.
>
> * i2c-old.c contains old init stuff, obviously inherted from the times
> of linux 2.2, which should be cleared. The BUZ and LML33 drivers are now
> i2c drivers, not i2c-old ones.
> * The Makefile needs a few adjustements.
> * saa7146.h should include i2c-old.h, not i2c.h.
>
> The thin part of this patch that also applies to linux 2.6 has been sent
> to Greg KH.

> diff -ruN linux-2.4.24-pre3/drivers/media/video/Makefile linux-2.4.24-pre3-k3/drivers/media/video/Makefile
> --- linux-2.4.24-pre3/drivers/media/video/Makefile	2003-12-31 14:51:01.000000000 +0100
> +++ linux-2.4.24-pre3-k3/drivers/media/video/Makefile	2004-01-06 14:01:14.000000000 +0100
> @@ -40,7 +40,7 @@
>
>  obj-$(CONFIG_VIDEO_ZR36120) += zoran.o i2c-old.o
>  obj-$(CONFIG_I2C_PARPORT) += i2c-parport.o i2c-old.o
> -obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o i2c-old.o
> +obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o
>  obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o
>  obj-$(CONFIG_VIDEO_BWQCAM) += bw-qcam.o
>  obj-$(CONFIG_VIDEO_W9966) += w9966.o
> @@ -48,11 +48,10 @@
>  obj-$(CONFIG_VIDEO_ZORAN_BUZ) += saa7111.o saa7185.o
>  obj-$(CONFIG_VIDEO_ZORAN_DC10) += saa7110.o adv7175.o
>  obj-$(CONFIG_VIDEO_ZORAN_LML33) += bt819.o bt856.o
> -obj-$(CONFIG_VIDEO_LML33) += bt856.o bt819.o
>  obj-$(CONFIG_VIDEO_PMS) += pms.o
>  obj-$(CONFIG_VIDEO_PLANB) += planb.o
>  obj-$(CONFIG_VIDEO_VINO) += saa7191.o indycam.o vino.o
> -obj-$(CONFIG_VIDEO_STRADIS) += stradis.o
> +obj-$(CONFIG_VIDEO_STRADIS) += stradis.o i2c-old.o

This is the only strictly necessary Makefile bugfix from this patch yes?
(add i2c-old.o to CONFIG_VIDEO_STRADIS).

I have merged the saa7146.h fix.

>  obj-$(CONFIG_VIDEO_CPIA) += cpia.o
>  obj-$(CONFIG_VIDEO_CPIA_PP) += cpia_pp.o
>  obj-$(CONFIG_VIDEO_CPIA_USB) += cpia_usb.o
> @@ -81,8 +80,8 @@
>
>  fastdep:
>
> -zoran.o: zr36120.o zr36120_i2c.o zr36120_mem.o
> -	$(LD) $(LD_RFLAG) -r -o $@ zr36120.o zr36120_i2c.o zr36120_mem.o
> +zoran.o: $(zoran-objs)
> +	$(LD) $(LD_RFLAG) -r -o $@ $(zoran-objs)
>
>  bttv.o: $(bttv-objs)
>  	$(LD) $(LD_RFLAG) -r -o $@ $(bttv-objs)
