From: Adam Nielsen <a.nielsen@shikadi.net>
Date: Mon, 12 Oct 2009 14:06:54 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <4AD337FE.2060401@shikadi.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>> If you need a value that is unique across reboots
>> then I imagine the USB vendor/device ID would be the only option - this device
>> doesn't seem to have a unique serial number as many USB devices do.
> 
> No, we already know that we can't get this in the real world.

How do you mean?  I was thinking along the lines of a new sysfs file that
could hold this value, similar to how the "name" currently holds a value used
by lm_sensors.  Then it would be up to the driver to provide some sort of
consistent ID (although I recall somewhere that IDs must be unique across the
whole system, so perhaps that wouldn't be so manageable.)

> Hey, very nice :) I'm waiting to see where the HID device names are
> going, and then I'll commit the code change.

Great!  Thanks for getting this working so quickly.

> I didn't know Gigabyte had joined the PSU business. So far I haven't
> been impressed by their motherboards, I wonder how good their PSUs will
> be. Relatively expensive models, but I'm convinced for a long time now
> that good PSUs are worth the money.

Well speaking personally I've found Gigabyte hardware in general to be rock
solid...providing you get something that works properly in the first place :-)
 Their devices seem good, but QA could use some work.  So far the PSU is fine,
but it's only been two years - I'll know for sure once it goes past the normal
three year warranty window ;-)

> It's a long time since I last bought a PSU, but I lost one - with the
> motherboard it was feeding :( - a few months ago, so I might have to
> buy a new one soon. Apparently there have been a number of improvements
> in this area lately... "modular" PSUs seems like a very good idea to
> me. And passively-cooled PSUs are now at an affordable price, although
> I don't know how reliable they are these days. Time for me to read some
> articles and reviews...

Modular PSUs are pretty good, and this one is pretty quiet too, even with the
fan.  My hard drives are still the noisiest part of my system.

> OK, if I buy it I'll let them know. How much Linux support do you have
> at the moment? Just the monitoring shown above, or also control, e.g.
> of the fan speed?

At the moment just the monitoring (only started reverse engineering a week ago
though) but I don't recall the fan speed being controllable - I think it's
automatic based on the temperature, and I can't remember if you can change it
(I do recall seeing some graphs in the Windows app that could've been temp vs
fan speed though.)  I do however intend to support everything you can do
through Windows, which includes the ability to adjust the voltages.  I don't
think I'll be testing that too thoroughly though, I like my PC when it's not
on fire :-)

> I see a huge potential for this type of PSU for the hardware monitoring
> support area. We usually have a hard time figuring out wirings and
> scaling factors for motherboard sensors. Now if we know what values we
> should find, because the PSU is reporting them already, that would be
> much easier.

That's a very good point.  One thing I discovered with the gadgetfs driver
though is that the formula used to calculate the current draw is different for
each rail - including the four 12V rails, each uses a different formula.  I
was only able to generate an accurate formula by feeding in very large and
small numbers to the fake device, and watching what the Windows app would
report.  I wouldn't have known this if the values had stayed fairly constant
as they do in normal use.

I imagine it would be a fairly large undertaking, but making a dummy I2C
device available to a guest OS like Windows (perhaps by modifying QEMU for
instance) might yield a similar result - a tweakable interface that lets you
feed in values and compare them with the manufacturer's own Windows application.

> We can also imagine that voltage sensors will disappear from
> motherboards in the future. After all, monitoring the PSU voltages
> directly makes a lot more sense, and if standardized properly, it could
> be done with a single driver and all the scaling / mapping issues would
> be solved. Dreaming :) Time will how (and where) it all goes.

Well actually I had nVidia's ESA pointed out to me the other day, and it seems
like they want to head in this direction too:
http://www.nvidia.com/object/nvidia_esa.html

It looks like they intend to use USB HID devices too, only unlike Gigabyte,
properly.  Like the Power spec for UPS devices, they appear to be defining
some standard sensor elements in part of the HID space that will allow
standard drivers to report on various elements of the system.

Perhaps adding HID bus support to lm_sensors is quite timely...!

Cheers,
Adam.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
