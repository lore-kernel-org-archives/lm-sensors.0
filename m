From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 16:14:45 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add driver for AMD family 15h
Message-Id: <20110406161445.GB25724@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110404160733.GA11818@alberich.amd.com>
 <20110405144536.GA5054@alberich.amd.com>
 <20110406161401.1c0ab6de@endymion.delvare>
 <20110406151901.GE2177@alberich.amd.com>
 <20110406173543.7308ba93@endymion.delvare>
In-Reply-To: <20110406173543.7308ba93@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>, Thomas Renninger <trenn@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 06, 2011 at 11:35:43AM -0400, Jean Delvare wrote:
> On Wed, 6 Apr 2011 17:19:01 +0200, Andreas Herrmann wrote:
> > On Wed, Apr 06, 2011 at 04:14:01PM +0200, Jean Delvare wrote:
> > > On Tue, 5 Apr 2011 16:45:36 +0200, Andreas Herrmann wrote:
> > > > +static ssize_t show_power(struct device *dev,
> > > > +			  struct device_attribute *attr, char *buf)
> > > > +{
> > > > +	u32 val, btdp, tdpl, tdp2w, arange;
> > > > +	s32 acap;
> > > > +	u64 ctdp;
> > > 
> > > These variable names aren't easy to understand.
> > 
> > Just random names which eventually map to the spec:
> > 
> > btdp - base_tdp
> > tdpl - tdp_limit
> > tdp2w - tdp_to_watt
> > acap - average_accumulator_capture (or even worse how about "processor_tdp_running_average_accumulator":(
> > arange - average_range
> 
> avg_cap and avg_range would do, respectively, for the last two.
> 
> > I don't think that changing the names make it much easier to
> > reconstruct the calculation but if you insist in changing it I'll
> > adapt it.
> 
> I do prefer the "extended" names, really. Sure, this doesn't change the
> calculations, but it helps the reader understand what's going on. Which
> will be useful if one ever has to fix a bug in the code or extend it
> for a different CPU family.
> 
> But maybe this is just me. Guenter, do you have an opinion?
> 
I agree. base_tdp is definitely much better than btdp. Same for the others.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
