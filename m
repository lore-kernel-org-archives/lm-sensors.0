From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Jun 2007 19:05:44 +0000
Subject: Re: [lm-sensors] [PATCH] Add temperature-tracking mode to f71805f
Message-Id: <20070627210544.7519348d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182285507009@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182285507009@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 26 Jun 2007 15:54:55 -0700, Juerg Haefliger wrote:
> On 6/25/07, Jean Delvare <khali@linux-fr.org> wrote:
> > > @@ -931,6 +1029,58 @@
> > >                         show_pwm_freq, set_pwm_freq, 2);
> > >  static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
> > >
> > > +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO,
> > > +                                     show_pwm_auto_channels, NULL, 0);
> > > +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IRUGO,
> > > +                                     show_pwm_auto_channels, NULL, 1);
> > > +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IRUGO,
> > > +                                     show_pwm_auto_channels, NULL, 2);
> > > +static SENSOR_DEVICE_ATTR(pwm1_auto_channels_fan, S_IRUGO,
> > > +                                     show_pwm_auto_channels, NULL, 0);
> > > +static SENSOR_DEVICE_ATTR(pwm2_auto_channels_fan, S_IRUGO,
> > > +                                     show_pwm_auto_channels, NULL, 1);
> > > +static SENSOR_DEVICE_ATTR(pwm3_auto_channels_fan, S_IRUGO,
> > > +                                     show_pwm_auto_channels, NULL, 2);
> >
> > Not sure what others think about this (Mark? Juerg?) but this (pwm1 to
> > fan1 and to temp1, etc.) seems to be the usual mapping for chips where
> > the mappings can't be changed, so I wonder what's the benefit of
> > creating read-only sysfs files to express it. I think I'd be just as
> > happy with no channel files at all (and it's cheaper.) No strong
> > opinion though.
> 
> I don't find them particularly useful.

So we agree. Good. 

>                                         The static mapping should be
> documented in the chip doc.

Yes, and they already are.

Phil, please exclude the channel sysfs files from the next iteration of
your patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
