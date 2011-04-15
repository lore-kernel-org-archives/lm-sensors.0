From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Apr 2011 07:42:41 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Driver for MAX16065/MAX16066
Message-Id: <20110415094241.5cdba5cc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302322322-3978-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1302322322-3978-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Apr 2011 17:06:10 -0700, Guenter Roeck wrote:
> On Tue, 2011-04-12 at 05:03 -0400, Jean Delvare wrote:
> > On Fri, 8 Apr 2011 21:12:02 -0700, Guenter Roeck wrote:
> > > +
> > > +/* ADC registers have 10 bit resolution. */
> > > +static inline int ADC_TO_MV(int adc, int range)
> > > +{
> > > +     return (adc * range) / 1024;
> > > +}
> > > +
> > > +/*
> > > + * Limit registers have 8 bit resolution and match upper 8 bits of ADC
> > > + * registers.
> > > + */
> > > +static inline int LIMIT_TO_MV(int limit, int range)
> > > +{
> > > +     return DIV_ROUND_CLOSEST(limit * range, 256);
> > > +}
> > 
> > It is inconsistent to use DIV_ROUND_CLOSEST() for displaying limits and
> > not monitored values. This could cause values to look out-of-limits when
> > they aren't, or vice-versa.
> > 
> Any thought on what is better ? Use DIV_ROUND_CLOSEST for both, or
> none ? I tend to none, since the chip does not round either, but I am
> not really sure.

I'd say none. Other drivers tend to only care about rounding when
writing to limits, not reading values or limits.  I seem to understand
that the rationale is that writing limits is a rare operation so we
don't care if it's slightly slower, plus the user doesn't know the
resolution of the chip when writing limit values so it makes sense to
snap to the closest supported value.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
