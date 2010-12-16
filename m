From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Dec 2010 14:59:51 +0000
Subject: Re: [lm-sensors] [Patch] Adding threshold support to coretemp
Message-Id: <20101216145951.GA7775@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1109439@bgsmsx502.gar.corp.intel.com>
 <20101214182435.GA32358@ericsson.com>
 <D6D887BA8C9DFF48B5233887EF04654105C1109A9B@bgsmsx502.gar.corp.intel.com>
 <20101215151015.GA3573@ericsson.com>
 <D6D887BA8C9DFF48B5233887EF04654105C1109F74@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654105C1109F74@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Chen Gong <gong.chen@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Dec 16, 2010 at 05:48:58AM -0500, R, Durgadoss wrote:
[ ... ]
> 
> These are thresholds only. But their corresponding documentation in sysfs-interface
> reflects completely different meaning from what these thresholds do. When we program
> these thresholds, we get an interrupt, if the current temperature goes below the
> lower threshold (thresh0) or above the upper threshold (thresh1). As per the documentation,
> none of these existing attributes generate interrupt like this. In fact, I had an
> idea to use _max and _min. Then the meaning will be contradictory. Hence I refrained,
> from using that.
> 
temp[1-*]_min   Temperature min value.
temp[1-*]_max   Temperature max value.
temp[1-*]_max_hyst
                Temperature hysteresis value for max limit.

I don't see a limitation in use here. It only says min/max/hysteresis value, nor what
that means or implies, nor if there can an interrupt be associated with it.
I don't see anything contradictory.

> Here also, the _max and _crit have already been used. Even if we redefine,
> it will not adhere to the Documentation. Since the thresh0 and thresh1 both,

Again, why ? Where would it not adhere to the documentation ?

> are lesser than _crit, I feel it's not really nice to use _emergency.
> (But if that's the only way and we all are Ok with that, I can use it,
> with a bit of change in Documentation..)
> 
Not really.

> > I don't know how the "THRESHOLD" and the "TARGET" temperature relate to each
> > other.
> > Maybe you could simply use tempX_max as upper threshold (where it exists),
> > with MSR_IA32_TEMPERATURE_TARGET as initial value, and define and use
> > tempX_max_hyst
> > to calculate the lower threshold.
> 
> The _thresh value is lower than _max, which in turn is lower than _crit.
> The newer generation of CPU's don't support the IA32_TEMP_TARGET register,
> and hence the _max is almost never used. But since it has already been used,
> as "ttarget", I can't use it for this upper threshold. Otherwise, I do not
> have any problem in using _min and _max. Though, we have to modify the
> documentation. I am proposing this idea, since you said "redefine" old ones if
> necessary. Please let me know your opinion here.
> 
As you state yourself, IA32_TEMP_TARGET is no longer supported, and it is only used
to set the value of _max (ie to instantiate ttarget). What is done with it subsequently
is another question. And if the CPUs supporting IA32_TEMP_TARGET don't support the
threshold registers, the question does not even arise.

> I understand there are available spare attributes; but seems like they have been
> defined with some other meaning. I also wanted to refrain from introducing
> new attributes as much as possible. But, because of the above-mentioned issues,
> I had to arrive at this solution.
> 
My recommendation would be to use _max as upper threshold, instantiate it with IA32_TEMP_TARGET
if supported, and make it writable. Then use _max_threshold for the lower threshold.
I don't see any problem with that. Then explain in Documentation/sysfs/coretemp what 
exactly happens if the limits are reached.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
