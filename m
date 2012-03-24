From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Mar 2012 15:22:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <20120324152240.GA2563@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Mar 24, 2012 at 04:37:44AM -0400, Jean Delvare wrote:
> On Fri, 23 Mar 2012 21:18:32 -0700, Guenter Roeck wrote:
> > On Fri, Mar 23, 2012 at 05:17:40PM -0400, Jean Delvare wrote:
> > > On Wed,  7 Mar 2012 20:25:39 -0800, Guenter Roeck wrote:
> > > >               else
> > > >                       return val * 12;
> > > > -     } else
> > > > -             return val * 16;
> > > > +     } else {
> > > > +             if (data->in_scaled & (1 << nr))
> > > > +                     return val * 32;
> > > > +             else
> > > > +                     return val * 16;
> > > > +     }
> > > >  }
> > > 
> > > I think both functions can then be rewritten more efficiently. I'll do
> > > some testing and send a patch later.
> >
> > I know, I was a bit lazy ;).
> > 
> > How about the following ?
> > 
> > static int adc_lsb(const struct it87_data *data)
> > {
> > 	int lsb = has_12mv_adc(data) ? 12 : 16;
> > 	if (data->in_scaled & (1 << nr))
> > 		lsb <<= 1;
> > 	return lsb;
> > }
> > 
> > and:
> > 	val = DIV_ROUND_CLOSEST(val, adc_lsb(data));
> > 
> > and:
> > 	return val * adc_lsb(data);
> 
> Except that you have to pass nr around as a parameter, but otherwise
> yes, that's what I had in mind.
> 
Yes, I noticed that when I tried to compile it. Dumb compiler, should have
known what I meant and auto-fixed it ;).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
