From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Mar 2012 17:35:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (w83627ehf) Fix writing into fan_stop_time for NCT6775F/NCT6776F
Message-Id: <1331573702.32717.4.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331567005-13734-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331567005-13734-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-03-12 at 13:23 -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 12 Mar 2012 08:43:24 -0700, Guenter Roeck wrote:
> > NCT6775F and NCT6776F have their own set of registers for FAN_STOP_TIME. The
> > correct registers were used to read FAN_STOP_TIME, but writes used the wrong
> > registers. Fix it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83627ehf.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> > index 57a31a0..378142c 100644
> > --- a/drivers/hwmon/w83627ehf.c
> > +++ b/drivers/hwmon/w83627ehf.c
> > @@ -1622,7 +1622,7 @@ store_##reg(struct device *dev, struct device_attribute *attr, \
> >  	val = step_time_to_reg(val, data->pwm_mode[nr]); \
> >  	mutex_lock(&data->update_lock); \
> >  	data->reg[nr] = val; \
> > -	w83627ehf_write_value(data, W83627EHF_REG_##REG[nr], val); \
> > +	w83627ehf_write_value(data, data->REG_##REG[nr], val); \
> >  	mutex_unlock(&data->update_lock); \
> >  	return count; \
> >  } \
> 
> Good catch.
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> This would seem like a candidate for stable, hm?
> 
Yes, definitely.

> As a side note, someone's got to explain to me why these functions are
> macro-generated when the macro is called only once. It would be a good
> idea to unfold that code to make it easier to read.
> 
I don't know. Historic, maybe ? I thought about unfolding it, but
concluded that it would not be appropriate to do that for a bug fix.

I don't like those macro functions anyway ...

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
