From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Nov 2010 22:07:30 +0000
Subject: Re: [lm-sensors] [PATCH] Display 3 decimal places in raw sensors
Message-Id: <20101102230730.4cd4236a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101102132644.46cf8da4@endymion.delvare>
In-Reply-To: <20101102132644.46cf8da4@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Nov 2010 13:41:06 -0500 (CDT), Jeff Rickman wrote:
> > I would like the raw output of "sensors" to display 3 decimal places
> > as most sensor types use at the sysfs interface. This will make it
> > easier for us to help users find out correct scaling factors when
> > needed. Instead of telling them to go read the raw sysfs attributes,
> > they can just report the output of "sensors -u -c /dev/null".
> >
> > Objection anyone?
> > ---
> >  prog/sensors/chips.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- lm-sensors.orig/prog/sensors/chips.c	2010-07-01 14:33:21.000000000
> > +0200
> > +++ lm-sensors/prog/sensors/chips.c	2010-11-02 13:24:12.000000000 +0100
> > @@ -58,7 +58,7 @@ void print_chip_raw(const sensors_chip_n
> >  						sub->name,
> >  						sensors_strerror(err));
> >  				else
> > -					printf("  %s: %.2f\n", sub->name, val);
> > +					printf("  %s: %.3f\n", sub->name, val);
> >  			} else
> >  				printf("(%s)\n", label);
> >  		}
> >
> >
> > --
> > Jean Delvare
> >
> 
> No objection to the concept. I appreciate the precision.

OK, I'll apply the patch tomorrow then.

Jeff, I take the opportunity to let you know that I am unable to e-mail
you directly. Your mail server keeps rejecting my attempts, and it has
been that way for months. I even tried an alternative sending server on
my end but it did not help.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
