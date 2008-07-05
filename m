From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 05 Jul 2008 15:49:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080705174923.6c57b226@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sat, 05 July 2008 Jean Delvare <khali@linux-fr.org> wrote:
> On Sat, 5 Jul 2008 16:22:45 +0200, Bruno Prémont wrote:
> > On Sat, 05 July 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > > I don't remember any change in the voltage computations. More
> > > likely you simply need to tweak your configuration file to match
> > > your motherboard wiring, as is the case with all motherboards.
> > > This includes changing the labels and adjusting the compute
> > > statements as well. We can help you a bit with this if you tell
> > > us all the voltage labels and values displayed by your BIOS, and
> > > the voltages values reported by "sensors -c /dev/null".
> > 
> > Raw sensors readings:
> > 
> >   it8712-isa-0e80
> >   Adapter: ISA adapter
> >   in0:         +1.17 V  (min =  +0.00 V, max =  +4.08 V)
> >   in1:         +0.82 V  (min =  +0.00 V, max =  +4.08 V)
> >   in2:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> >   in3:         +2.93 V  (min =  +0.00 V, max =  +4.08 V)
> >   in4:         +1.25 V  (min =  +0.00 V, max =  +4.08 V)
> >   in5:         +1.76 V  (min =  +0.00 V, max =  +4.08 V)
> >   in6:         +1.60 V  (min =  +0.00 V, max =  +4.08 V)
> >   in7:         +2.94 V  (min =  +0.00 V, max =  +4.08 V)
> >   in8:         +3.26 V
> >   fan1:       3245 RPM  (min =    0 RPM, div = 8)
> >   fan2:       1520 RPM  (min =    0 RPM, div = 8)
> >   temp1:       +20.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor > > thermal diode temp2:       +48.0°C  (low  =  -1.0°C, high > > +127.0°C)  sensor = thermal diode temp3:       +25.0°C  (low  > > -1.0°C, high = +127.0°C)  sensor = transistor cpu0_vid:   +1.550 V
> > 
> > Bios readings:
> > 
> >   CPU Temp: 33°C
> >   System temp: 45°C
> >   CPU FAN: 5769 RPM
> >   Sys FAN: 1496 RPM
> > 
> >   CPU Core: 1.1V
> >   +1.2V:   1.168V
> >   +3.3V:   3.008V
> >   +5V:     4.992V
> >   +1.8V:   1.76V
> > 
> > Looking at those values there could be:
> >   in0 = +1.2V
> 
> Unlikely. Vcore is almost always in0, and it seems to be the case
> here. +1.2V would rather be in4.
> 
> >   in2 = +3.3V
> >   in5 = +1.8V
> > 
> > For the other voltages which do seem to be wired somehow even tough
> > far less are mentionned in BIOS monitoring section it's hard to
> > tell what they could match...
> 
> The IT8712F can only measure voltages up to 4.08V directly. Other
> voltages need scaling resistors. The nominal voltage after scaling is
> typically 3V (3/4 of the full scale). in3 and in7 are almost 3V so
> they are most probably voltages > 4V scaled down. I would guess in3
> is +5V and in7 maybe 5VSB. Now you have to figure out the scaling
> factor. 4.992/2.93 = 1.703. Typical factors for +5V are 1.666 and
> 1.68, the later is the standard for the IT8712F so I'd say that's
> what you have.
> 
> in8 is normally the battery voltage, unscaled.
> 
> So my guess for the configuration of your board would be:
> 
>    label in0 "Vcore"
>    label in2 "+3.3V"
>    label in3 "+5V"
>    label in4 "+1.2V"
>    label in5 "+1.8V"
>    label in7 "5VSB"
>    label in8 "Vbat"
> 
>    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>    compute in8 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
for second compute you were thinking in7

Why are the compute lines that complex for just multiplying/dividing
with 1.68? Is this a workaround for floating-point precision issues?

> It's a bit strange that +12V isn't monitored. And this leaves in1 and
> in6 without labels. Maybe they aren't wired at all. Ideally you would
> ask your motherboard manufacturer and they would tell you. The above
> is just guesswork based on my personal experience, I might as well be
> plain wrong ;)
I was also surprised that there was no 12V listed in the BIOS! This
especially as the board has standard ATX connector and also has at
least FANs to feed with 12V (and probably also PCI and PCI-Express)

I will try to get that info from IEI though their account system does
not seem to work very well (or I'm not using the right browser for it)
Alternatively I can try to get the info through the reseller through
whom I got the mainboard.

> > For temperatures:
> > - temp1 is related to CPU temp (no idea what's the right formula,
> > looks like combination of offset and multiplier when compared to
> > value reported by k8temp-pci-00c3)
> > - temp2 is system temp
> > - temp3 is constant at 25°C and probably not wired at all
> 
> Indeed, 25°C constant for a thermistor usually means that there is no
> thermistor but a dumb resistor instead. I've seen this many times...

Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
