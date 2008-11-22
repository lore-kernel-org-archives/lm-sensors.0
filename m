From: Trent Piepho <tpiepho@freescale.com>
Date: Sat, 22 Nov 2008 00:55:29 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc7] i2c: smbalert# support
Message-Id: <Pine.LNX.4.64.0811211621340.18022@t2.domain.actdsltmp>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463811584-778172224-1227315329=:18022"
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161434.54335.laurentp@cse-semaphore.com>
 <20081119161632.2d0bde9e@hyperion.delvare> <Pine.LNX.4.64.0811201354310.11673@t2.domain.actdsltmp>
 <200811201456.36551.david-b@pacbell.net>
In-Reply-To: <200811201456.36551.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-778172224-1227315329=:18022
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 20 Nov 2008, David Brownell wrote:
> On Thursday 20 November 2008, Trent Piepho wrote:
>>>
>>> Did you actually check the size increase? struct i2c_driver is added
>>> one pointer, so 4 or 8 bytes, hardly worth mentioning. struct
>>> i2c_adapter is added 72 bytes on x86-64, to 1360 bytes initially so an
>>> increase of less than 6%. Is this really such a big issue? I doubt it.
>>> You don't have that many i2c_adapters registered on any given system
>>> for it to really matter, methinks.
>>
>> Except every other subsystem in the kernel does the same thing. =A0Each =
release
>> of 2.6 is significantly more bloated than the last and this is how it ha=
ppens.
>> One "it's not that much wasted" change at a time.
>
> I do recall the "4 MByte performance problem" morphing into the "8 MByte"
> problem, and then into the "16 MByte" version then "32 MByte" -- for UNIX
> workstations, including GUI.  Today's handhelds are more powerful than
> those!  And the embedded boards I get lately have 128 MB of RAM.
>
> The real counter-argument is that memory isn't *that* tight, especially
> since the hardware capacity is growing.

Those UNIX workstations cost thousands of dollars.  If the increase in
software inefficiency exactly matched in increase in hardware capacity, it
wouldn't be possible to run UNIX on cell phones and $200 laptops powered by=
 a
foot pedal, we'd still need expensive workstations.

If X MB memory isn't tight for a some task, then someone is going to want t=
o
do that task with X/2 MB of memory, so that they can have a cheaper, lower
power, smaller product.

The embedded board I have here has 256 MB of RAM.  But it also has a dual c=
ore
CPU that can run two copies of Linux at once.  So cut that RAM in half.  An=
d
then we have virtual machines...

So yes, hardware keeps getting better.  But you can't say, "I have twice th=
e
RAM so I can make my software twice as bloated as come out even." Because w=
e
also except to be able to do more with cheaper, lower power hardware.

Though saying hardware is getting better isn't quite true.  Compared to CPU
speed, memory latency has steadily gotten _worse_ over the last decade.=20
Making kernel data structures larger and increasing cache pressure can stil=
l
be quite costly, and that cost isn't going down, it's going up.

> That said, maybe you have a patch to propose which would address the
> problem of how to *cleanly* make this infrastructure optional?

Well, that depends on what one defines as "cleanly".  Sometimes is feels as=
 if
the definition is intentionally made so narrow that that it is quite
impossible to meet.
---1463811584-778172224-1227315329=:18022
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
---1463811584-778172224-1227315329=:18022--
