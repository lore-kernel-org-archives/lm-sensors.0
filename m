From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave (4/8)
Message-Id: <20040115193855.72797be3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111155027.6e1e2b42.khali@linux-fr.org>
In-Reply-To: <20040111155027.6e1e2b42.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >  obj-$(CONFIG_VIDEO_ZR36120) += zoran.o i2c-old.o
> >  obj-$(CONFIG_I2C_PARPORT) += i2c-parport.o i2c-old.o
> > -obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o i2c-old.o
> > +obj-$(CONFIG_VIDEO_SAA5249) += saa5249.o
> >  obj-$(CONFIG_VIDEO_CQCAM) += c-qcam.o
> >  obj-$(CONFIG_VIDEO_BWQCAM) += bw-qcam.o
> >  obj-$(CONFIG_VIDEO_W9966) += w9966.o
> > @@ -48,11 +48,10 @@
> >  obj-$(CONFIG_VIDEO_ZORAN_BUZ) += saa7111.o saa7185.o
> >  obj-$(CONFIG_VIDEO_ZORAN_DC10) += saa7110.o adv7175.o
> >  obj-$(CONFIG_VIDEO_ZORAN_LML33) += bt819.o bt856.o
> > -obj-$(CONFIG_VIDEO_LML33) += bt856.o bt819.o
> >  obj-$(CONFIG_VIDEO_PMS) += pms.o
> >  obj-$(CONFIG_VIDEO_PLANB) += planb.o
> >  obj-$(CONFIG_VIDEO_VINO) += saa7191.o indycam.o vino.o
> > -obj-$(CONFIG_VIDEO_STRADIS) += stradis.o
> > +obj-$(CONFIG_VIDEO_STRADIS) += stradis.o i2c-old.o
> 
> This is the only strictly necessary Makefile bugfix from this patch
> yes? (add i2c-old.o to CONFIG_VIDEO_STRADIS).

You're right, it is.

The other important fix is for CONFIG_VIDEO_SAA5249, since at the time
being it adds i2c-old.o which isn't needed. But it isn't critical, just
enlarges the kernel for nothing.

The rest was simply for the beauty of the Makefile so you can leave it
apart.

> I have merged the saa7146.h fix.

OK, thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
