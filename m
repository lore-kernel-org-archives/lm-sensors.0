From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Feb 2009 15:37:51 +0000
Subject: Re: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <20090218163751.1b6a5b28@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090217230215.5106b6c0@hyperion.delvare>
In-Reply-To: <20090217230215.5106b6c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

Once again I would like to ask you to reply to the list and not to me
only. This is especially important for a RFC!

On Wed, 18 Feb 2009 00:33:40 +0100, Fred . wrote:
> I am very pleased to see that you wrote a RFC. Good job.
> I am not qualified enough to state in my opinion, but it looks pretty
> good to me.
> 0 to clear the detection flag seems good to me.
> 
> A (not necessarily good) idea. If you could trigger the detection by writing to
> the file, then people who do not own a case which supports chassis intrusion,
> could still write and test scripts that works with lm-sensors.

I see your point, but I don't think I want to allow this. If the
intrusion alarm can be triggered in software, this opens the door to
false positives and exploits. This would also require extra code in all
drivers, because the sysfs file will reflect the value of a hardware
bit, which can typically be cleared by software but _not_ set by
software. Making each driver more complex only for testing purposes
doesn't sound right.

If people want to test the functionality without the hardware, the
right way to do that is using the i2c-stub driver together with an
i2c-based hwmon driver which implements the feature in question. This
is already in place and should work nicely.

> To play the devils advocate, one may argue that since temperature sensors
> are called temp1, temp2, etc and not cpu_temp, gpu_temp, then it ought to
> be called just 'intrusion' instead of 'chassis_intrusion'.

Good point. Now, the question is, is there anything else than the
chassis that can suffer from intrusion? Racked hard disks maybe? I
don't have access to high-end server hardware so I admit I don't really
know.

If we want to be really generic then we should consider that the
chassis intrusion detectors are merely micro-switches used for a
specific function. So we might as well go with switch0, switch1...
However, intrusion detection switches have semantics attached to them
(in particular the fact that they are set by hardware and cleared by
software.) They also need to be handled differently from other sensor
inputs, as discussed with Matt. "sensors --clear-chassis" (or maybe
--clear-intrusion would be preferable?) must know which chip feature it
has to access, something which being too generic will make impossible.

> You earlier mentioned keeping in mind extendibility, such as multple sensors,
> in which case it ought to be named chassis_intrusion0, chassis_intrusion1, etc.

See my reply to Matt.

> Though, I do agree with you that a 'chassis_intrusion' is a good name.
> It is very simple, clear and non confusing.
> 
> Realistically speaking, no case is ever likely to have more than one sensors,
> also I don't think any Super-I/O supports more than one sensor.

That's what I think too.

> Though, theoretically someone might have a third-party sensor on a PCI card,
> or on a USB device.

For an internal device the limitation is the number of switches on the
case itself. So I guess such a device would replace, not add to, the
one already present on the motherboard (if any).

Chassis intrusion detection on an external device is, hmm... Not
technically impossible, but I'm not sure what sense it makes from the
system's point of view. The intruder could connect the device to
another system, reset the intrusion alarm, and reconnect the device.

> Either way, I think your RFC is "down to earth" and it looks good.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
