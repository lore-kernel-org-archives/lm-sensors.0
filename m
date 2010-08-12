From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Aug 2010 18:25:49 +0000
Subject: Re: [lm-sensors] [PATCH 1/6] hwmon: (pc87427) Handle disabled fan
Message-Id: <20100812202549.5261db81@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100811170809.284a0a17@hyperion.delvare>
In-Reply-To: <20100811170809.284a0a17@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 12 Aug 2010 10:04:34 -0700, Guenter Roeck wrote:
> On Wed, 2010-08-11 at 11:08 -0400, Jean Delvare wrote:
> > Most fan input pins of the PC87427 can have alternate functions.
> > Update the driver to check the configuration register and only support
> > fan inputs which are really used for fan monitoring.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks for the review.

> > ---
> >  drivers/hwmon/pc87427.c |   67 ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 58 insertions(+), 9 deletions(-)
> > 
> > --- linux-2.6.32-rc3.orig/drivers/hwmon/pc87427.c	2009-10-02 16:11:15.000000000 +0200
> > +++ linux-2.6.32-rc3/drivers/hwmon/pc87427.c	2009-10-11 14:27:30.000000000 +0200
> > @@ -1,7 +1,7 @@
> >  /*
> >   *  pc87427.c - hardware monitoring driver for the
> >   *              National Semiconductor PC87427 Super-I/O chip
> > - *  Copyright (C) 2006 Jean Delvare <khali@linux-fr.org>
> > + *  Copyright (C) 2006, 2008  Jean Delvare <khali@linux-fr.org>
> >   *
> 2010 ?

This patch was written back in 2008, but was never committed due to
lack of tester. The first significant patch which I wrote in 2010 adds
this year to the copyright statement.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
