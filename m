From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Dec 2013 17:20:35 +0000
Subject: Re: [lm-sensors] w83l786ng driver bug, questions, and 1st round patch
Message-Id: <529B6FE3.5010606@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
In-Reply-To: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/01/2013 01:38 AM, Jean Delvare wrote:
[ ... ]
>
>> # Note the power up default is actually mode 4, which is even more
>> # confusing (sysfs would tell you we're in mode 3, until you first
>> # touch the mode, then it would lock back into mode 1 behavior.
>> # For the above I made things less confusing for the reader by
>> # first forcing mode 1.)
>
> Mode "FAN_SET" is problematic on its own, independent of the bug you
> found and fixed. There is no room for it in our standard sysfs
> interface. It's not really an automatic fan speed mode so it shouldn't
> have value >= 2. The closest standard mode would be 0, except that 0 is
> supposed to mean "100%", not "some arbitrary initial value". Well, we
> could write 0xf to register 0x90 bits 3..0 (assuming they are writable
> as the datasheet says) to force the 100% but then this would prevent
> the user from returning to the initial state, plus I'm not sure what
> would happen at suspend/resume or reboot.
>
> OTOH, if we stick to value 4 for this mode, then there's no reason to
> not let the user switch back to it. Supporting it would be truly
> trivial.
>
> Another possibility would be to hide this mode, by transparently
> switching to the equivalent speed in manual control mode when the
> driver is loaded. Then only modes 1, 2 and 3 would be visible to the
> user. To be honest I'm not sure why the chip maker didn't implement it
> this way in the first place. I think this option has my preference.
> Guenter, what do you think? Do we have any precedent?
>
Hi Jean,

The asc7621 driver uses pwmX_enable=0 to turn the fan off, and %5 to set
it to full speed. I would not necessarily take that as good example, though.

Your proposal to hide FAN_SET underneath mode 1 would be one possibility.
I would also not mind using pwmX_enable=0 ('disabled') for that purpose,
ie let the fan speed revert to the pre-programmed speed instead of 100%
if it is set. While not following the ABI to the letter, one could argue
that it follows the idea.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
