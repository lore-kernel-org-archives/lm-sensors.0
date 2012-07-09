From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Mon, 09 Jul 2012 10:28:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (fam15h_power) Fix unintentional integer overflow
Message-Id: <20120709102829.GE30674@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340287015-14008-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340287015-14008-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 08, 2012 at 09:52:55AM +0200, Jean Delvare wrote:
> On Sat, 7 Jul 2012 21:57:47 -0700, Guenter Roeck wrote:
> > On Sat, Jul 07, 2012 at 05:03:09PM +0200, Jean Delvare wrote:
> > > On Thu, 21 Jun 2012 06:56:54 -0700, Guenter Roeck wrote:
> > > > @@ -67,7 +67,8 @@ static ssize_t show_power(struct device *dev,
> > > >  				  REG_TDP_LIMIT3, &val);
> > > >  
> > > >  	tdp_limit = val >> 16;
> > > > -	curr_pwr_watts = (tdp_limit + data->base_tdp) << running_avg_range;
> > > > +	curr_pwr_watts = ((u64)(tdp_limit +
> > > > +				data->base_tdp)) << running_avg_range;
> > > 
> > > Even then, "tdp_limit + data->base_tdp" could overflow already, on
> > > 32-bit architectures [1]. So I think what you really want is:
> > > 
> > > 	curr_pwr_watts = ((u64)tdp_limit + data->base_tdp) << running_avg_range;
> > > 
> > Both tdp_limit and data->base_tdp can not be larger than 65535, so I figured
> > that the "inner" overflow is not an issue.
> 
> Ah, right, I could have easily figured that out by myself, had I taken
> the time to read the code. Sorry for the noise, and this patch of yours
> is:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> > > And BTW, this might be good to push to stable trees, as we've had real
> > > problems with overflows in this driver in the past. I don't know the
> > > realistic values for tdp_limit, base_tdp and running_avg_range so I'm
> > > not sure.
> >
> > Max: (65535 + 65535) << 16 = 8589803520 = 0x1FFFE0000. No idea if this is can
> > happen in the real world.
> 
> No idea either. Maybe Andreas can tell. But if we have no reason to
> believe this can't happen, I'd say we play it safe and push the fix to
> stable trees.

A typical value for base_tdp is 0x3f which would translate to about
14-15 Watts.

Yes in theory the computation can overflow. But that would mean
hardware reports senseless values for base_tdp.

I don't see an issue with current hardware but of course the
computation should be fixed. (I don't think that this fix is required
for stable trees but feel free to push it there.)

Acked-by: Andreas Herrmann <andreas.herrmann3@amd.com>


Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
