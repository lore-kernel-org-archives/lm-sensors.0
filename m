From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 16:57:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110511185728.2dc31754@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 11 May 2011 07:14:20 -0700, Guenter Roeck wrote:
> On Wed, May 11, 2011 at 08:39:12AM -0400, Jean Delvare wrote:
> > I have nothing against extending the sysfs interface to support uV
> > voltages. But this must be done in a way which doesn't break current
> > installations. Arbitrarily reporting in uV instead of the standard mV
> > isn't an option, neither for the ina209 driver alone, nor for all
> > drivers.
> > 
> > One way to do it would be to invent a brand new set of attributes for
> > uV voltages. For example volt[0-*]_input, etc. This is straightforward
> > and won't break anything, and would be transparent for applications,
> > however this would incur a lot of redundancy in the sysfs interface
> > definition document and in libsensors. If done smartly, this may be
> > bearable. The user constraints would be: you need the latest version of
> > libsensors for ina219 support, otherwise the attributes in question
> > aren't visible at all.
> > 
> > Another way would be to create a dedicated attribute for hwmon drivers
> > to advertise whether they are reporting voltages in uV or mV. For
> > example, file "unit_in" would contain -6 when the chip reports voltages
> > in uV, -3 if the chip reports voltages in mV (which would be the
> > default for backwards compatibility.) This would require very little
> > work in the sysfs-interface document and in libsensors, and would be
> > transparent to applications. The user constraints would be: you need
> > the latest version of libsensors for ina219 support, otherwise the
> > attributes in question are improperly scaled. Whether this is better or
> > worse than the constraints of the first option can be discussed... It
> > has the problem that the incorrectness is silent, but the advantage
> > that it can be corrected in sensors.conf if known (with, again, the
> > problem that a future update of libsensors will require a fix of
> > sensors.conf.)
> > 
> I would prefer something like inX_unit, ie per-sensor attributes.
> But I don't have a strong opinion about it either.

This was my initial idea as well, but then I thought of the cost both in
the kernel drivers and in libsensors if a device needs many such
attributes. As I don't expect the same device to be used to monitor
values in the kV range and values in the uV range at the same time,
per-channel scaling doesn't seem to be a required feature.

But well maybe I shouldn't worry about the cost and only look at the
cleanliness of the solution. In which case you are certainly right.

> > I don't have a strong opinion. I don't think the INA219 chip is popular
> > enough that the second option is problematic. But if we go that route,
> > we should implement the libsensors side immediately so that it starts
> > propagating to the user base.
> > 
> > Note, the second option would also have the benefit that we can switch
> > to nV or V or kV at any time if we need to support strange hardware
> > monitoring devices. I don't expect it, but I didn't expect that we'd
> > need uV either, so...
>
> I am still not sure if we need it now. As we both noticed, what is
> really measured here is current, not voltage.

You're right. But as stated above, if we ever need it, then the earlier
libsensors supports it, the better, so users who need it don't have to
upgrade libsensors in a hurry.

Also, not being a big fan of the arbitrary 0.001 Ohm approach, I
welcome every step towards an alternative, even if this sole step would
be insufficient.

> > (...)
> > Well well... If it makes everyone's life easier, I would be happy to
> > (let you) document the 0.001 Ohm rule in D/h/sysfs-interface and
> > possibly sensors.conf.5.
> > 
> I would not call it a rule ... maybe a guideline. If there is something better
> than "assume a 0.001 Ohm shunt resistor", I'd be all for it. It is just the best
> idea I was able to up with ...

My point is exactly that I would like it better (I might even call it
acceptable!) if it were a documented rule. If every driver does this,
and it is documented, then at least users won't be surprised.

> I still think that is better than reporting known current measurements as voltages
> and expecting user space to convert it to currents - especially if it is as obvious
> as it is here.

As long as we lack a proper way to deal with it in user-space, I can't
disagree.

Speaking of this, I just had an idea...

What if we create attribute curr[1-*]_resistor, which would hold the
value of the resistor used? Unit to be defined (milli-Ohm?) It would
either be initialized to 1 milli-Ohm as you've been using so far, or
left uninitialized (0) and the current value would only be returned by
the driver after user-space sets the value (through a set statement in
the configuration file.) Either way, this would let the user specify
the resistor value, as we do with the ones used for voltage input
scaling.

This would solve your concern (drivers can keep exporting curr[1-*]
attributes for current sensors) and mind (components external to the
monitoring device are specified by user-space).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
