From: prakash@punnoor.de (Prakash Punnoor)
Date: Fri, 25 Aug 2006 18:04:46 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608252004.46703.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Am Freitag 25 August 2006 19:50 schrieb Jean Delvare:
> Hi Prakash,
>
> > I set them to:
> > powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x11
> > powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x13
> > powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x1b
>
> The K8 family uses the VID conversion table described in AMD document
> 26094 (Table 74). Inside the kernel it is known as VRM version "2.4.
> This table leads me to the following values:

Ah nice to know, thx!


> (2000 MHz), vid 0x11 -> 1.125 V
> (1800 MHz), vid 0x13 -> 1.075 V
> (1000 MHz), vid 0x1b -> 0.875 V
>
> These values are significantly lower than the ones I am used to (1.40
> V, 1.35 V and 1.10 V, respectively). I am surprised by your words: "I
> set them to"... Do you mean that you somehow _decided_ to use these
> values instead of the standard ones?

Yes, I used a hack with which I can override the default vids. Of course I did 
stability tests and ALU and FPU (->prime95) seems stable so far. (Using 
gentoo I would have nonoticed if the compiler creates junk. ;-) So, by your 
values given above, I have got a EE SFF version for the price of a regular 
one. :-)

> Please check that the value of /sys/class/hwmon/hwmon0/device/vrm is
> 8.2 as expected.

It gives 24.
>
> converting the values properly. This could be caused by a device
> misconfiguration, or maybe by the IT8716F chip itself being
> underpowered?

I don't think the chip is responsible for it, if I do it on purpose, or do you 
think it also causes some deviation?


> The driver should print some messages in the log when you load it, can
> you please copy them here?

it87: Found IT8716F chip at 0x290, revision 0
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V)
it87: fan4 is enabled
it87: fan5 is enabled

Not too interesting, it seems, or is it?


> If temp2 is taken on the northbridge, and if you have no northbridge
> fan, and if your CPU is underpowered and has a good fan, it may make
> sense. I used to tell users that CPU temperature must always be above
> motherboard temperature, but I seem to be proven wrong more frequently.

> The best way to differenciate between CPU temperature and motherboard
> temperature is to put some load on the CPU, and see which temperature
> raises faster. A simple "md5sum /dev/zero" makes the trick.

Yes, I also concluded it this way, as the chipset is cooled passively and if I 
stress the CPU temp1 goes up fast and when going idle again, it goes down 
fast, as well. :-)


> Yeah, there are interesting similarities between your report and this
> one. Same motherboard manufacturer... I have had other reports for
> IT8716F chips where the voltages were in line with what the BIOS said.
> I wonder if these motherboards could be voluntarily underpowering all
> the devices, instead of only the CPU, to same power? That would be
> weird.
>
> One way to test this is as follows:
> Reboot your system, and make sure that the it87 driver will not be
> loaded at boot time.
> Dump the contents of the chip:
>   isadump -y 0x295 0x296 > /tmp/before.dump
> Load the it87 driver, run sensors once.
> Dump the contents of the chip again:
>   isadump -y 0x295 0x296 > /tmp/after.dump
> Send both files here.

Do you still want me to get the dumps, if you know now that I underpower on 
purpose?


> If the voltage registers in both dumps are the same, it means the it87
> driver has nothing to do with it.
>
> > > The decoding depends on the CPU. In theory the kernel detects it and
> > > picks the right decoding formula but if your CPU is really new, it
> > > might use a table we don't know yet. What is your exact CPU model?
> >
> > cpu family      : 15
> > model           : 75
> > model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
> > stepping        : 2
> >
> > It is the new AM2 "regular" version.
>
> Do you know where I can get technical documentation for your
> processor? My reference document for K8 CPUs was AMD document 30430 so
> far, but I can't find your CPU revision there.
>
> > > > CPU: 780
> > > > POWER: 777
> > > >
> > > > wheres sensors reports too high values
> > > > fan1:     1323 RPM  (min = 6490 RPM)                   ALARM
> > > > fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> > > > fan3:     1564 RPM  (min =    0 RPM)
> > >
> > > So you are affected by the problem too...
> > >
> > > What do you think are the correct values for your fans, the BIOS' ones,
> > > or sensors' ones?
> >
> > I think the bios ones are right, as if I disable fan management, it shows
> > CPU fan at 2335 which fits well enough to Artcic Cooling Freezer 64 specs
> > at 2200rpm.
>
> Almost all reporters seem to agree on that fact, and one ITE tech guy
> just confirmed it to me... I'll fix the driver.
>
> > (Yes my machine is "ultra silent", so it is possible that fans run
> > at ~800 rpm when idle. It also just consumes 50Watt when idle...)
>
> Nice. I tried something similar for my home server, except that it's
> using old hardware (Pentium III 800 MHz...) It is somewhere around 50 W
> too, and pretty silent as well (mostly thanks to the Fortron PSU and the
> Seagate hard disk drive.)
>
> > On the other hand, when I disable fan management, the fan makes quite
> > some noise which might be too high for a 2200rpm fan, but maybe I am just
> > used to silence. ;-)
>
> Depends on the size of the fan. A 120 mm fan at 2200 RPM should be
> almost silent. A 60 mm fan at 2200 RPM can already make some noise,
> although it should be acceptable.
>
> > > > fan1:     46551 RPM  (min = 6490 RPM)                   ALARM
> > > > fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> > > > fan3:     1551 RPM  (min =    0 RPM)
> > >
> > > Very strange. Are you using fan speed control? This could induce some
> > > noise in the speed sensing.
> >
> > Yes Asus' so called "q-fan2".
>
> I guess you won't observe the phenomenon with it disabled.
>
> > > Do you have similar effects when looking at
> > > the values in the BIOS?
> >
> > Well, I haven't observed the bios long enough, as such values usually
> > just appear for short times. But I noticed at times the bios also shows
> > wrong values, as it shows "0" instead of ~800. Perhaps here the same
> > thing hapens, but the bios clips the value correctly?
>
> I'm not sure about the "correctly" but yet the BIOS is most certainly
> trimming the values it considers too high to be relistic. But I am
> reluctant to do this in our drivers. It's up to the hardware to improve
> to make it possible to control fans and still monitor them. I think
> that's where we are going with 4-wire fans.

-- 
(?=                 =?)
//\ Prakash Punnoor /\\
V_/                 \_V
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060825/a1c7eef6/attachment.bin 
