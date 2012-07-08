From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Jul 2012 04:57:47 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (fam15h_power) Fix unintentional integer overflow
Message-Id: <20120708045747.GB24062@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340287015-14008-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340287015-14008-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 07, 2012 at 05:03:09PM +0200, Jean Delvare wrote:
> Hi Guenter,

Hi Jean,

> 
> Adding Andreas to Cc...
> 
> On Thu, 21 Jun 2012 06:56:54 -0700, Guenter Roeck wrote:
> > Expression with two unsigned integer variables is calculated as unsigned integer
> > before it is converted to u64. This may result in an integer overflow.
> > Fix by typecasting the left operand to u64 before performing the left shift.
> > 
> > This patch addresses Coverity #402320: Unintentional integer overflow.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/fam15h_power.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
> > index 6b13f1a..2764b78 100644
> > --- a/drivers/hwmon/fam15h_power.c
> > +++ b/drivers/hwmon/fam15h_power.c
> > @@ -67,7 +67,8 @@ static ssize_t show_power(struct device *dev,
> >  				  REG_TDP_LIMIT3, &val);
> >  
> >  	tdp_limit = val >> 16;
> > -	curr_pwr_watts = (tdp_limit + data->base_tdp) << running_avg_range;
> > +	curr_pwr_watts = ((u64)(tdp_limit +
> > +				data->base_tdp)) << running_avg_range;
> 
> Even then, "tdp_limit + data->base_tdp" could overflow already, on
> 32-bit architectures [1]. So I think what you really want is:
> 
> 	curr_pwr_watts = ((u64)tdp_limit + data->base_tdp) << running_avg_range;
> 
Both tdp_limit and data->base_tdp can not be larger than 65535, so I figured
that the "inner" overflow is not an issue.

> [1] I'm not quite sure why one would run a 32-bit Linux on an AMD
> Family 15h machine, but you never know...
> 
> >  	curr_pwr_watts -= running_avg_capture;
> >  	curr_pwr_watts *= data->tdp_to_watts;
> 
> And BTW, this might be good to push to stable trees, as we've had real
> problems with overflows in this driver in the past. I don't know the
> realistic values for tdp_limit, base_tdp and running_avg_range so I'm
> not sure.
> 
Max: (65535 + 65535) << 16 = 8589803520 = 0x1FFFE0000. No idea if this is can
happen in the real world.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
