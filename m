From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Mon, 30 Nov 2009 06:24:54 +0000
Subject: Re: [lm-sensors] [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
Message-Id: <1259562294.5516.16.camel@falcon.domain.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
         <1259558432.5516.8.camel@falcon.domain.org>
In-Reply-To: <1259558432.5516.8.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, lm-sensors@lm-sensors.org

On Mon, 2009-11-30 at 13:20 +0800, Wu Zhangjin wrote:
> On Sat, 2009-11-28 at 21:38 +0800, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds hwmon driver for managing the temperature of battery,
> > cpu and controlling the fan.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 +
> >  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
> >  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    3 +
> >  .../loongson/lemote-2f/yeeloong_laptop/hwmon.c     |  241 ++++++++++++++++++++
> >  4 files changed, 254 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/hwmon.c
> > 
> > diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > index e284c91..56cb584 100644
> > --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > @@ -28,4 +28,13 @@ config YEELOONG_BATTERY
> >  	  This option adds APM emulated Battery Driver, which provides standard
> >  	  interface for user-space applications to manage the battery.
> >  
> > +config YEELOONG_HWMON
> > +	tristate "Hardware Monitor Driver"
> > +	select HWMON
> 
> Will use depend in the next version.
> 

Sorry, This must be select, there is no other way to select this stuff.

> Best Regards,
> 	Wu Zhangjin



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
