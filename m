From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Feb 2006 09:18:25 +0000
Subject: [lm-sensors] Relax probing for ds1337.c
Message-Id: <xx5XVUkb.1140686305.0366110.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43FD7385.8020304@gassner-waagen.at>
In-Reply-To: <43FD7385.8020304@gassner-waagen.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

On 2006-02-23, Michael Burian wrote:
> I'm using mainline drivers/i2c/chips/ds1337.c (Dallas RTC)
> for an embedded ep93xx board. (ARM based)
>
> Whenever I end up with an invalid date in the RTC,
> (first time boot, backup battery power failure, ...)
> I run into the following vicious circle:
>
> Invalid date -> i2c driver probing fails -> RTC driver doesn't get
> loaded, => no chance of setting a valid date with hwclock.
>
> I've looked at the probing routines and found them to be quite picky,
> especially when compared to other RTC drivers.

Just because the other drivers are too permissive doesn't mean that the
ds1337 doesn't do the right thing, for now. But see below for my future
plans.

> (...) The following patch
> relaxes the checks a bit so that the driver gets loaded even if the
> date in the RTC is invalid.

"Relaxes"? You meant to say "drops all", I guess ;) With your patch,
any device at I2C address 0x68 on any adapter will be detected as a
DS1337 chip. Unfortunately, this is hardly acceptable.

> This should not lead to problems, because startup scripts usually
> detect invalid date/time and use hwclock to set some bogus, but valid
> date. (like 1st Jan 2002). Afterwards user/ntpdate/dcf77/gps can set a
> valid date again.
>
> I've already sent this to the author, but he asked me to have it
> reviewed first.
>
> Please tell me whether this changes are acceptable, or if there is a
> better way.

Not acceptable as is due to the risk that the ds1337 driver will
accidentally attach to non-DS1337 devices. Better ways are:

* Use the force module parameter to force detection of the chip even when
in invalid state. This is no different from what your patch does, but at
least this is an optional module parameter rather than the default.

* If the "invalid state" of the DS1337 is something that can be
identified, we can add code to the driver to specifically identify this
state and accept it.

* I have some work in progress with Nathan Lutchansky and Alessandro
Zummo to make it possible to explicitely attach i2c drivers to chips
without relying on the general probing mechanism. You can look at it
here:

http://khali.linux-fr.org/devel/i2c/linux-2.6/i2c-probe-04-explicit-attach.patch

But it's really work in progress, I still have to convert a few drivers
to take benefit of it and see if the proposed interface suits the needs.
I hope to have it finished within a month now, and then real-time clock
chips should benefit greatly from that new possibility as you usually
know pretty well what kind of chip you have and where it is, right?

Thanks,
--
Jean Delvare

