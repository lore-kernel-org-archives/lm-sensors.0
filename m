From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Jun 2009 16:24:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Fix more __devexit_p glitches
Message-Id: <20090610182404.67a47f89@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090604093041.442ad394@hyperion.delvare>
In-Reply-To: <20090604093041.442ad394@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Jun 2009 10:11:49 -0600, Jim Cromie wrote:
> On Thu, Jun 4, 2009 at 1:30 AM, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > Make sure __devexit and devexit_p() match in all hwmon drivers.
> > Suggested by a similar fix from Mike Frysinger.
> >
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Jonathan Cameron <jic23@cam.ac.uk>
> > ---
> >  drivers/hwmon/f71882fg.c |    2 +-
> >  drivers/hwmon/sht15.c    |   10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > --- linux-2.6.30-rc8.orig/drivers/hwmon/f71882fg.c      2009-06-03
> > 10:55:43.000000000 +0200
> > +++ linux-2.6.30-rc8/drivers/hwmon/f71882fg.c   2009-06-04
> > 09:02:47.000000000 +0200
> > @@ -253,7 +253,7 @@ static struct platform_driver f71882fg_d
> >                .name   = DRVNAME,
> >        },
> >        .probe          = f71882fg_probe,
> > -       .remove         = __devexit_p(f71882fg_remove),
> > +       .remove         = f71882fg_remove,
> >  };
> >
> 
> 
> I think that one is reversed, certainly vs following.

This is on purpose. f71882fg_remove() is not marked with __devexit, so
there is no point in protecting references thereto with __devexit_p().

Note that, contrary to the other way, this one does not cause build
errors. It's just needlessly complex, and confusing for the reader.

> > -               .remove = sht15_remove,
> > +               .remove = __devexit_p(sht15_remove),
> >
> >


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
