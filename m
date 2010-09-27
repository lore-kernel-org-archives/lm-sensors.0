From: matt mooney <mfm@muteddisk.com>
Date: Mon, 27 Sep 2010 17:23:13 +0000
Subject: Re: [lm-sensors] [PATCH 04/24] hwmon: change to new flag variable
Message-Id: <20100927172313.GC4598@haskell.muteddisk.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e0bdab5d2e8c52041c003de68ba774c3e706716c.1285355033.git.mfm@muteddisk.com>
 <9968d4260be8850200cc9c7dfe08addf611468b4.1285355033.git.mfm@muteddisk.com>
 <036514b5dd23c5af14303519d79d60d79adccbee.1285355033.git.mfm@muteddisk.com>
 <e0bdab5d2e8c52041c003de68ba774c3e706716c.1285355033.git.mfm@muteddisk.com>
 <ffbd189ef2d414ea7c87ffe2b40fce87877dc014.1285355033.git.mfm@muteddisk.com>
 <12873.1285599840@localhost>
In-Reply-To: <12873.1285599840@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valdis.Kletnieks@vt.edu
Cc: kernel-janitors@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 11:04 Mon 27 Sep     , Valdis.Kletnieks@vt.edu wrote:
> On Fri, 24 Sep 2010 12:17:14 PDT, matt mooney said:
> > Replace EXTRA_CFLAGS with ccflags-y.
> > 
> > Signed-off-by: matt mooney <mfm@muteddisk.com>
> > ---
> >  drivers/hwmon/Makefile |    4 +---
> >  1 files changed, 1 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index e3c2484..764b4db 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -109,7 +109,5 @@ obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
> >  obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
> >  obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
> >  
> > -ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
> > -EXTRA_CFLAGS += -DDEBUG
> > -endif
> > +ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
> 
> Was this series intended as := rather than += as it seems that
> overriding the entirely of a passed-in ccflags-y may not be what
> we wanted to do.

That is exactly why I changed += to :=. ccflags-y (and the older EXTRA_CFLAGS)
is a per directory variable that only has effect on the current directory, so
there is no passing in of ccflags-y.

-mfm


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
