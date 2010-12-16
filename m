From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Thu, 16 Dec 2010 10:50:48 +0000
Subject: Re: [lm-sensors] [Patch] Adding threshold support to coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C1109F74@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
 <20101214182435.GA32358@ericsson.com>
 <D6D887BA8C9DFF48B5233887EF04654105C1109A9B@bgsmsx502.gar.corp.intel.com>
 <20101215151015.GA3573@ericsson.com>
In-Reply-To: <20101215151015.GA3573@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Guenter,

Thanks for the suggestions.
I need clarification on some of the things you mentioned here.
Kindly help.

> > Since the Hardware supports the programming of thresholds, I added this
> support
> > in the driver. I had to add new attributes, since there are no existing
> attributes,
> > that support these thresholds.
> > Could you please suggest any better way(s) of enabling this support ?
> > I can add documentation for these attributes in Doc/hwmon/sysfs-interface.
> >
> At least two.
> 
> 1) Use existing ABI attributes. The coretemp driver doesn't use all available
> attributes
> for low/high temperatures, so you could pick unused ones (and if necessary
> redefine the ones
> already used). We have
> 	lcrit
> 	min
> 	max
> 	crit
> 	emergency
> 
> All those attributes are ultimately thresholds; no reason not to use them.

These are thresholds only. But their corresponding documentation in sysfs-interface
reflects completely different meaning from what these thresholds do. When we program
these thresholds, we get an interrupt, if the current temperature goes below the
lower threshold (thresh0) or above the upper threshold (thresh1). As per the documentation,
none of these existing attributes generate interrupt like this. In fact, I had an
idea to use _max and _min. Then the meaning will be contradictory. Hence I refrained,
from using that.

> 
> Furthermore, the two thresholds are really upper/lower temperature targets
> which
> result in requesting a specific action. As such, it is really just one (upper)
> threshold
> with an associated hysteresis value to undo the action caused by the upper
> threshold.
> So you could use
> 	tempX_max
> 	tempX_max_hyst
> or
> 	tempX_crit
> 	tempX_crit_hyst
> or
> 	tempX_emergency
> 	tempX_emergency_hyst
> instead to reflect this meaning.
> 

Here also, the _max and _crit have already been used. Even if we redefine,
it will not adhere to the Documentation. Since the thresh0 and thresh1 both,
are lesser than _crit, I feel it's not really nice to use _emergency.
(But if that's the only way and we all are Ok with that, I can use it,
with a bit of change in Documentation..)

> I don't know how the "THRESHOLD" and the "TARGET" temperature relate to each
> other.
> Maybe you could simply use tempX_max as upper threshold (where it exists),
> with MSR_IA32_TEMPERATURE_TARGET as initial value, and define and use
> tempX_max_hyst
> to calculate the lower threshold.

The _thresh value is lower than _max, which in turn is lower than _crit.
The newer generation of CPU's don't support the IA32_TEMP_TARGET register,
and hence the _max is almost never used. But since it has already been used,
as "ttarget", I can't use it for this upper threshold. Otherwise, I do not
have any problem in using _min and _max. Though, we have to modify the
documentation. I am proposing this idea, since you said "redefine" old ones if
necessary. Please let me know your opinion here.

> 
> 2) Define new attribute names which can be used as generic ABI, such as
> 	tempX_threshold
> 	tempX_threshold_hyst
> 
> Right now I don't really see the need for additional attributes, since there
> are spare ones
> available, so 2) is less likely to be accepted. You would have to make a really
> good case
> for it, and not just to me but convince Jean as well.

I understand there are available spare attributes; but seems like they have been
defined with some other meaning. I also wanted to refrain from introducing
new attributes as much as possible. But, because of the above-mentioned issues,
I had to arrive at this solution.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
