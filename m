From: Trent Piepho <tpiepho@freescale.com>
Date: Sat, 22 Nov 2008 06:04:26 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <Pine.LNX.4.64.0811212122370.18022@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
 <200809231532.40083.david-b@pacbell.net> <20081118091546.421d6b78@hyperion.delvare>
 <200811181401.34809.david-b@pacbell.net> <Pine.LNX.4.64.0811190140510.11673@t2.domain.actdsltmp>
 <20081119161632.2d0bde9e@hyperion.delvare> <Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
 <20081121094218.34ecd82a@hyperion.delvare>
In-Reply-To: <20081121094218.34ecd82a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

On Fri, 21 Nov 2008, Jean Delvare wrote:
> On Thu, 20 Nov 2008 14:00:21 -0800 (PST), Trent Piepho wrote:
>>> Did you actually check the size increase? struct i2c_driver is added
>>> one pointer, so 4 or 8 bytes, hardly worth mentioning. struct
>>> i2c_adapter is added 72 bytes on x86-64, to 1360 bytes initially so an
>>> increase of less than 6%. Is this really such a big issue? I doubt it.
>>> You don't have that many i2c_adapters registered on any given system
>>> for it to really matter, methinks.
>>
>> Except every other subsystem in the kernel does the same thing.  Each release
>> of 2.6 is significantly more bloated than the last and this is how it happens.
>> One "it's not that much wasted" change at a time.
>
> You are unfair. We have been continuously cleaning up the i2c subsystem
> over the past few years, shrinking the main structures regularly,
> killing unused code, etc. And this clean-up process is going on.

The size of i2c-core, struct i2c_client and struct i2c_adapter:
v2.6.28 9718 392 500	w/ smbalert patch
v2.6.28 8878 392 472
v2.6.27 8732 368 448
v2.6.26 7877 352 440
v2.6.25 7854 376 444
v2.6.24 9060 372 444
v2.6.23 9359 404 476
v2.6.22 9330 448 520
v2.6.21 7814 464 692
v2.6.20 7896 444 672
v2.6.19 7871 444 668
v2.6.18 6857 436 660

Other than some temporary bloat in 2.6.22-2.6.24, size the size of i2c core
has been steadily increasing.  The data structures got a shrink around
2.6.23-2.6.24, mostly from removing unneeded name fields, but most other
changes have been an increase in size.

> On top of that, your proposal isn't even optimal: if you have just one
> driver that needs SMBus alert support, all adapters have their size
> increased. Taking a concrete example, on my system, there are normally

Seeing as there are currently no clients with smbalert support, this shouldn't
happen to most people for quite some time.  Forcing it on for people who don't
need smbalert (and no one has it now, so there can't be that much demand) is
clearly worse.  Maybe most distro kernels will have it on, but people who have
a reason to care about kernel size and speed can turn it off.

> The alternative, as mentioned in my initial answer, would be to let
> each driver be built with or without support for SMBus alert, depending
> on a central configuration option (which unfortunately would no longer
> be possibly hidden.) After all, just because the hardware can do it and

Some drivers could select smbalert support and only build with it.  Other
drivers could have a driver option to enable alert support, core smbalert
support would only be selected if that option was one.  It would depend on how
much bloat it adds and how complex it is to make optional.  The alarm irq code
I wrote for the lm63 driver ended up being quite complicated.

> All in all I am simply not convinced that it it worth optimizing. There
> appears to be more drawbacks than benefits. There are many different
> areas where cleanups would save a lot more memory than what you can
> hope for here. For example, completing the removal of the legacy i2c
> binding model. Want to help?

Increased efficiency in one place is not exclusive of increase efficiency
elsewhere.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
