From: Wei Ni <wni@nvidia.com>
Date: Tue, 10 Sep 2013 06:30:13 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <522EBC75.6030500@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-1-git-send-email-wni@nvidia.com> <1378722552-10357-2-git-send-email-wni@nvidia.com> <20130909111242.GW29403@sirena.org.uk> <522DB253.6000707@roeck-us.net> <20130909135022.GZ29403@sirena.org.uk> <20130909155043.GA18975@roeck-us.net> <20130909160237.GR29403@sirena.org.uk> <20130909161735.GC18975@roeck-us.net> <20130909203910.GV29403@sirena.org.uk> <522E9A85.9050803@nvidia.com> <522EA51C.90706@roeck-us.net> <522EB0AF.9030708@nvidia.com> <522EB41E.9030005@roeck-us.net>
In-Reply-To: <522EB41E.9030005-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 09/10/2013 01:54 PM, Guenter Roeck wrote:
> On 09/09/2013 10:39 PM, Wei Ni wrote:
>> On 09/10/2013 12:50 PM, Guenter Roeck wrote:
>>> On 09/09/2013 09:05 PM, Wei Ni wrote:
>>>> On 09/10/2013 04:39 AM, Mark Brown wrote:
>>>>> * PGP Signed by an unknown key
>>>>>
>>>>> On Mon, Sep 09, 2013 at 09:17:35AM -0700, Guenter Roeck wrote:
>>>>>> On Mon, Sep 09, 2013 at 05:02:37PM +0100, Mark Brown wrote:
>>>>>
>>>>>>> It does, though it gets complicated trying to use it for a case like
>>>>>>> this since you can't really tell if the regulator was powered on
>>>>>>> immediately before the device got probed by another device on the bus.
>>>>>
>>>>>> Why not ? Just keep a timestamp.
>>>>>
>>>>> The support is a callback on state changes; we could keep a timestamp
>>>>> but there's still going to be race conditions around bootloaders.  It's
>>>>> doable though.
>>>>>
>>>>>>>> On a higher level, I wonder if such functionality should be added in the i2c
>>>>>>>> subsystem and not in i2c client drivers. Has anyone thought about this ?
>>>>>
>>>>>>> I'm not sure what the subsystem would do for such delays?  It's fairly
>>>>>>> common for things that need this to also want to do things like
>>>>>>> manipulate GPIOs as part of the power on sequence so the applicability
>>>>>>> is relatively limited, plus it's not even I2C specific, the same applies
>>>>>>> to other buses so it ought to be a driver core thing.
>>>>>
>>>>>> Possibly. I just thought about i2c since it also takes care of basic
>>>>>> devicetree bindings. Something along the line of
>>>>>> 	if devicetree bindings for this device declare one or more
>>>>>> 	regulators, enable those regulators before calling the driver
>>>>>> 	probe function.
>>>>>
>>>>> That's definitely a driver core thing, not I2C - there's nothing
>>>>> specific to I2C in there at all, needing power is pretty generic.  I
>>>>> have considered this before, something along the lines of what we have
>>>>> for pinctrl, but unfortunately the generic case isn't quite generic
>>>>> enough to make it easy.  It'd need to be an explicit list of regulators
>>>>> (partly just to make it opt in and avoid breaking things) and you'd want
>>>>> to have a way of handling the different suspend/resume behaviour that
>>>>> devices want.  There's a few patterns there.
>>>>>
>>>>> It's definitely something I think about from time to time and it would
>>>>> be useful to factor things out, the issue is getting a good enough model
>>>>> of what's going on.
>>>>>
>>>>>>> There was some work on a generic helper for power on sequences but it
>>>>>>> stalled since it wasn't accepted for the original purpose (LCD panel
>>>>>>> power ons IIRC).
>>>>>
>>>>>> Too bad. I think it could be kept quite simple, though, by handling it
>>>>>> through the regulator subsystem as suggested above. A generic binding
>>>>>> for a per-regulator and per-device poweron delay should solve that
>>>>>> and possibly even make it transparent to the actual driver code.
>>>>>
>>>>> Lots of things have a GPIO for reset too, and some want clocks too.  For
>>>>> maximum usefulness this should be cross subsystem.  I suspect the reset
>>>>> controller API may be able to handle some of it.
>>>>>
>>>>> The regulator power on delays are already handled transparently, by the
>>>>> time regulator_enable() returns the ramp should be finished.
>>>>
>>>> I think the regulator should encoded its own startup delay. Each
>>>> individual device should handle its own requirements for delay after
>>>> power is stable.
>>>> The regulator_enable() will handle the delays for the regulator device.
>>>> And adding the msleep(25) is for lm90 device. If without delay,
>>>> sometimes the device can't work properly. If read lm90 register
>>>> immediately after enabling regulator, the reading may be failed.
>>>> I'm not sure if 25ms is the right value, I read the LM90 SPEC, the max
>>>> of "SMBus Clock Low Time" is 25ms, so I supposed that it may need about
>>>> 25ms to stable after power on.
>>>>
>>>
>>> Problem is that you are always waiting, even if the same regulator was
>>> turned on already, and even if it is a dummy regulator.
>>>
>>> Imagine every driver doing that. Booting would take forever, just because of
>>> unnecessary delays all over the place. There has to be a better solution
>>> which does not include a mandatory and potentially unnecessary wait time
>>> in the driver. At a previous company we had a design with literally dozens
>>> of those chip. You really want to force such a boot delay on every user ?
>>>
>>> But essentially you don't even know if it is needed; you are just guessing.
>>> That is not an acceptable reason to add such a delay, mandatory or not.
>> I think the device need time to wait stable after power on, but it's
>> difficult to get an exact delay value, and this delay may also relate
>> with platform design, so how about to add a optional property in the DT
>> node, such as "power-on-delay-ms" ?
>>
> 
> Possibly, but that still doesn't solve the problem that you are going
> to wait even if the regulator was already turned on. Simple example:
> A system with two sensors, both of which share the same regulator.
> Each of them will require a delay after turning on power,
> but only if it was just turned on and not if it was already active.

Yes, but as Mark said, the regulator subsystem still can't know if the
regulator was powered on.
Do you have any suggestions?

> 
> Guenter
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
