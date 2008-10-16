From: Ira Snyder <iws@ovro.caltech.edu>
Date: Thu, 16 Oct 2008 20:50:26 +0000
Subject: Re: [lm-sensors] [RFC v3] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081016205025.GC1357@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081015212930.GA21854@ovro.caltech.edu>
In-Reply-To: <20081015212930.GA21854@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 16, 2008 at 10:38:10PM +0200, Hans de Goede wrote:

snip

> > +/* Return the voltage from the given register in millivolts */
> > +static u32 ltc4245_get_voltage(struct device *dev, u8 reg)
> > +{
> 
> Why dont you make this an s32 (or just an int) and then ..
> 

snip

> > +	case LTC4245_VEEIN:
> > +	case LTC4245_VEEOUT:
> > +		voltage = regval * 55;
> 
> Make this * -55, and ...
> 

Great idea. I didn't even think of that. :) I'll post up a final patch
after I hear back on the stuff below.

Is it ok to have a negative power? The current value gets used to
calculate the (virtual) power in ltc4245_show_power(), but that's it.

Thanks again for the review, it has really improved this driver a lot.
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
