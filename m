From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Thu, 12 Jun 2008 18:37:54 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080612203754.4c9e0d34@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, 12 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> Hi Bruno,
> 
> On Wed, 11 Jun 2008 23:09:49 +0200, Bruno Prémont wrote:
> > On Wed, 11 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > > 55 Hz would be 1650 RPM. If the IT8712F reports 4600 RPM then it's
> > > indeed certainly wrong. Can you check what speed is reported in
> > > the BIOS? Please also test with another fan if you can. I'd like
> > > to know if that's a problem with this specific fan (in which case
> > > there's probably not much we can do) or not. I suspect not (see
> > > below.)
> > 
> > I've not checked the BIOS yet but increasing divider helps - see
> > also below
> 
> Your chip doesn't actually have these dividers. Changing them appears
> to work because the driver _thinks_ the dividers exist and it somehow
> compensates with the missing support for 16-bit counter registers. But
> the value you get is still wrong!

At least writing to the divider touches something and influences the result

> > By the way, how does this behave with S3 (suspend to RAM), are all
> > values reprogrammed by the kernel or is it userspace's job (can't
> > test because of the graphics chips... no resume support yet in
> > kernel for ATI/AMD graphics)
> > I know that on older nforce-based PC did forget pwm settings on
> > resume (never cared about the divider so would have to verify for
> > that one)
> 
> I've never thought about S3 support, so I'd say it is unsupported and
> you are lucky if it works at all.

Eventually I will look into this in the future, would be nice to keep/restore
alarms, divider, pwm settings and other configurations of chips on
resume (be it from S3/Suspend to RAM or from suspend to disk)


> > > Please remember that the divisor value does _not_ divide the speed
> > > value. It only affects the range of measurable values. For a fan
> > > that could run as slow as 1000 RPM, you want to set the divider
> > > to 8.
> > 
> > Changing the divider to 8 makes the IT8712F report a likely speed
> > around 1500 RPM, so the divider was the cause of the bad value.
> 
> No, it wasn't (not directly at least). That's two errors roughly
> compensating themselves, so the end result looks acceptable, but it's
> still wrong. I can explain it to you when you provide a dump of your
> chip.

So on my system the interpretation seems to change around div=3 or div=4
(at least for fan's current speed)

> Please also tell me which of fan1, fan2 and fan3 is the case fan and
> which is the CPU fan. Seeing the output of "sensors" on this machine
> would help.

# isadump 0xe85 0xe86
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 10 00 00 00 00 00 00 00 80 40 1b 07 32 6c 02 
10: ff ff ff 33 83 01 02 40 00 00 00 ff ff ff ff ff 
20: 49 33 bc b6 4e 6f 5c b8 cc 14 2f 19 ba f1 f1 f1 
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 
40: 7f ff 7f ff 7f ff ff ff 2d ff ff ff ff ff ff ff 
50: ff 23 7f 7f 7f 00 60 63 90 56 fd 12 00 00 00 00 
60: 7f 7f 7f 00 00 64 ff ff 7f 7f 7f 00 00 64 ff ff 
70: 7f 7f 7f 00 00 64 ff ff ff ff ff ff ff ff ff ff 
80: 00 00 00 00 ff ff ff ff 00 00 ff c0 02 00 99 99 
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff 
a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 

#sensors
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +38.0°C                                    
Core1 Temp:  +25.0°C                                    

it8712-isa-0e80
Adapter: ISA adapter
VCore 1:     +1.17 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:     +0.82 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:       +3.01 V  (min =  +0.00 V, max =  +4.08 V)
+5V:         +4.89 V  (min =  +0.00 V, max =  +6.85 V)
+12V:        +4.99 V  (min =  +0.00 V, max = +16.32 V)
-12V:       -13.74 V  (min = -27.36 V, max =  +3.93 V)
-5V:         -1.10 V  (min = -13.64 V, max =  +4.03 V)
Stdby:       +4.92 V  (min =  +0.00 V, max =  +6.85 V)
VBat:        +3.26 V
fan1:       3375 RPM  (min =    0 RPM, div = 8)
fan2:       1548 RPM  (min =    0 RPM, div = 8)
M/B Temp:    +20.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermal diode
CPU Temp:    +46.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = thermal diode
Temp3:       +25.0°C  (low  =  -1.0°C, high = +127.0°C)  sensor = transistor
cpu0_vid:   +1.550 V

fan1 = CPU fan
  (pwm1=2, pwm1_enable=1, pwm1_freq7500)
fan2 = artic cooling themperature controlled FAN
  (note: a drive-bay fan is controlled by pwm2 but has no
   tachometer - just in case the chip would make an assumption)
no fan 3 though pwm3 files exist

# sensors3.conf (only relevant part)
    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    compute in5 (7.67 * @) - 27.36  ,  (@ + 27.36) / 7.67
    compute in6 (4.33 * @) - 13.64  ,  (@ + 13.64) / 4.33
    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    label temp1       "M/B Temp"
    label temp2       "CPU Temp"
    label temp3       "Temp3"
    set fan1_div 8
    set fan2_div 8

# Values reported by BIOS
CPU Temp: 33°C
System temp: 45°C
CPU FAN: 5769 RPM   (at max speed sensors driver says 5625 (peak 5818) with div=8)
Sys FAN: 1496 RPM   (sensors say 1520 with div=8)

CPU Core: 1.1V
+1.2V:   1.168V
+3.3V:   3.008V
+5V:     4.992V
+1.8V:   1.76V

> > > Recent IT8712F chips have 16-bit tachometer registers, but the
> > > it87 driver doesn't support this mode for that chip yet. We
> > > received a patch adding support for that 4 months ago:
> > >   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-February/022460.html
> > > I reviewed it, it needed some more work, but the author never
> > > followed up. If you need this, I guess we'll have to revive it.
> > 
> > I could help testing that patch though test-responsiveness may not
> > be optimal knowing that this host is actively used and freeing a
> > timeslot for testing is not that easy (usually only possible at
> > night during weekend)
> 
> I've asked the original author for an update, let's see if he sends
> something.

I've seen the ping, lets see if he will answer

-
Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
