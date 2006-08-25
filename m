From: prakash@punnoor.de (Prakash Punnoor)
Date: Fri, 25 Aug 2006 10:41:08 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608251241.13802.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> > 1) sensor-detect tells me to inster k8temp, but I can't find it in kernel
> > tree.
>
> It's a really new driver written by Rudolf Marek. Get the patch from
> here:

Yes, I foundit in the mailing list archives. Works nice, unfortunately gkrellm 
doesn't support it yet.

> VDDR as +3.12 V is way too high, so my guess is that in1 is actually
> +3.3V, and VDDR isn't monitored.

Yes, later I thought the same...

> Can you copy all the hardware monitoring data provided by your BIOS?
> This is the most useful data to customize the configuration file for a
> given board.

Here we go:

Vcore 1,35 (so it show 0.05 too little, as stock vcore at 2GHz is 1.4, I 
should have set it down to 1.2 or 1.225, if I calced the hex corretly...)

3.3: 3.22
5: 5.03
12: 11.85

comparing again with sensors:

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +33?C
Core1 Temp:
             +35?C

it8716-isa-0290
Adapter: ISA adapter
VCore:     +0.80 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
VDDR:      +3.12 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+3.3V:     +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+5V:       +4.84 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
+12V:     +11.52 V  (min = +16.32 V, max = +16.32 V)   ALARM
in5:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
in6:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
5VSB:      +4.70 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
VBat:      +2.88 V
fan1:     1800 RPM  (min = 6490 RPM)                   ALARM
fan2:        0 RPM  (min = 6490 RPM)                   ALARM
fan3:     1560 RPM  (min =    0 RPM)
temp1:       +28?C  (low  =    -1?C, high =    -1?C)   sensor = diode
temp2:       +42?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
temp3:       +25?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
vid:       +0.00 V

We see that sensors reports a bit too little voltages across the board. 
Interesting that the temp sensors - though conforming to bios values - are 
giving quite ridiculous values. temp2 - motherboard temp - is way higher than 
cpu temp, but on the other hand I don't know where the 2nd sensor is and 
whether the chipset actually gets hotter


> Vbat is a bit off, is your battery dead already?

The board is pretty new and I didn't have cmos problems, so don't think so.

> > I am also pretty sure that VCore is wrong:
>
> It looks reasonable to me.

Nope, if I interpret it correctly
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017356.html

has the same problem if you compare bios vcore and sensors output.


> The decoding depends on the CPU. In theory the kernel detects it and
> picks the right decoding formula but if your CPU is really new, it
> might use a table we don't know yet. What is your exact CPU model?

cpu family      : 15
model           : 75
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2

It is the new AM2 "regular" version.


> > CPU: 780
> > POWER: 777
> >
> > wheres sensors reports too high values
> > fan1:     1323 RPM  (min = 6490 RPM)                   ALARM
> > fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> > fan3:     1564 RPM  (min =    0 RPM)
>
> So you are affected by the problem too...
>
> What do you think are the correct values for your fans, the BIOS' ones,
> or sensors' ones?

I think the bios ones are right, as if I disable fan management, it shows CPU 
fan at 2335 which fits well enough to Artcic Cooling Freezer 64 specs at 
2200rpm. (Yes my machine is "ultra silent", so it is possible that fans run 
at ~800 rpm when idle. It also just consumes 50Watt when idle...)

On the other hand, when I disable fan management, the fan makes quite some 
noise which might be too high for a 2200rpm fan, but maybe I am just used to 
silence. ;-)

> > fan1:     46551 RPM  (min = 6490 RPM)                   ALARM
> > fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> > fan3:     1551 RPM  (min =    0 RPM)
>
> Very strange. Are you using fan speed control? This could induce some
> noise in the speed sensing.

Yes Asus' so called "q-fan2".

> Do you have similar effects when looking at 
> the values in the BIOS?

Well, I haven't observed the bios long enough, as such values usually just 
appear for short times. But I noticed at times the bios also shows wrong 
values, as it shows "0" instead of ~800. Perhaps here the same thing hapens, 
but the bios clips the value correctly?

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
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060825/f44d49e1/attachment.bin 
