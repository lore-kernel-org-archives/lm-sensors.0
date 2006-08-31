From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 31 Aug 2006 20:09:28 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 3] hwmon: new vt1211 driver
Message-Id: <20060831220928.7d814891.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
In-Reply-To: <191fb4ca0608292235s3494ddecp2276c5d9841ac775@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Juerg,

> > > +             vt1211_write8(data, VT1211_REG_PWM_CTL,
> > > +                           ((data->pwm_ctl[1] << 4) |
> > > +                             data->pwm_ctl[0]));
> > > +             vt1211_write8(data, VT1211_REG_FAN_DIV,
> > > +                           ((data->fan_div[1] << 6) |
> > > +                            (data->fan_div[0] << 4) |
> > > +                             data->fan_ctl));
> >
> > BTW, here you don't actually care about the values of fan_div, all you
> > need is to make sure you don't overwrite them in the register. In that
> > case it isn't very efficient to decode them and store them in the
> > cache, then shift and merge them again to recreate the register value.
> > Instead you could store the upper nibble of the register value in a
> > temporary variable, it'd be more efficient, and IMHO clearer.
> 
> But if I don't update the cache I could end up with stale data on a
> following read. If there is a back-to-back read-write-read sequence,
> the 2nd read could return the cached value from the 1st read rather
> then the updated value from the write.

Sorry, I don't follow you here. Do you have a concrete example please?

At any rate, this is only an optimization. If you don't feel
comfortable with it, you can go on with your method which will still
work.

Thanks,
-- 
Jean Delvare

