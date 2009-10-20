From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 20 Oct 2009 11:38:30 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020133830.7a67c850@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Tue, 20 Oct 2009 09:35:43 +1000, Simon Wilson wrote:
> Quoting Simon Wilson <simon@simonandkate.net>:
> 
> > I have a GA-P35-DS3P motherboard, with an E6850 Core 2 Duo  
> > processor. The machine is running CentOS 5.3. It has an it8718  
> > sensors chip.
> >
> > I have installed lm_sensors 2.10.8 and the kmod-it87 driver from  
> > elrepo.org (needed because of the 'old' CentOS 2.6.18 kernel), and  
> > all is basically working. A clear sensors output reads:
> >
> > it8718-isa-0290
> > Adapter: ISA adapter
> > in0:       +1.12 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > in1:       +1.87 V  (min =  +1.71 V, max =  +1.89 V)
> > in2:       +3.22 V  (min =  +3.14 V, max =  +3.47 V)
> > in3:       +2.91 V  (min =  +2.83 V, max =  +3.12 V)
> > in4:       +0.85 V  (min =  +2.85 V, max =  +3.15 V)   ALARM
> > in5:       +0.05 V  (min =  +0.85 V, max =  +1.09 V)   ALARM
> > in6:       +0.03 V  (min =  +1.12 V, max =  +1.28 V)   ALARM
> > in7:       +3.12 V  (min =  +2.85 V, max =  +3.15 V)
> > in8:       +3.30 V
> > fan1:     1424 RPM  (min =  600 RPM)
> > fan2:        0 RPM  (min = 3994 RPM)
> > fan3:        0 RPM  (min =    0 RPM)
> > fan4:        0 RPM  (min =    0 RPM)
> > temp1:       +30°C  (low  =   +10°C, high =   +60°C) sensor = thermistor
> > temp2:       +26°C  (low  =   +10°C, high =   +70°C) sensor = diode
> > temp3:        -2°C  (low  =  +127°C, high =  +127°C) sensor = disabled
> > vid:      +0.000 V
> >
> > Using the configuration from  
> > http://www.lm-sensors.org/wiki/Configurations/Gigabyte/G33-DS3R  
> > which also uses the 8718 I am now at this:
> >
> > it8718-isa-0290
> > Adapter: ISA adapter
> > Vcore:     +1.04 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > Vram:      +1.87 V  (min =  +1.71 V, max =  +1.89 V)
> > +3.3V:     +3.22 V  (min =  +3.14 V, max =  +3.47 V)
> > +5V:       +4.89 V  (min =  +4.76 V, max =  +5.24 V)
> > +12V:     +12.48 V  (min = +11.39 V, max = +12.61 V)
> > Vbat:      +3.30 V
> > CPU Fan:  1421 RPM  (min =  600 RPM)
> > NBr Temp:    +30°C  (low  =   +10°C, high =   +60°C) sensor = thermistor
> > CPU Temp:    +26°C  (low  =   +10°C, high =   +70°C) sensor = diode
> > vid:      +0.000 V
> >
> > Which is perfect apart from one thing - the 0.000 V value for VID,  
> > which is then also throwing off Vcore (in0) as that is calculated  
> > from VID (>95 <105%).
> >
> > Can anyone help me work out why VID is reading 0.000?
> >
> > Thanks
> 
> This is the same issue as noted in this thread here:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025018.html
> 
> Setting /sys/class/hwmon/hwmon0/device/vrm to 100 instead of 110  
> "fixes" this issue. Or I should say, it means I get a value - 1.088 V  
> - at VID. Whether it is right or not... ?
> 
> Running "isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7" as asked in that  
> thread gives me:
> 
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 7 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 07 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 18 04 10 00 80 df 3f 43 89 00 00 1d 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 c2 00 00 00 00 00 00
> c0: 80 1d 3f 43 09 00 00 00 00 19 00 03 08 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 7e
> f0: 10 40 00 00 00 00 11 00 00 00 00 00 3f 00 00 00

The raw VID value is at 0xfc, value is 0x3f, which means all VID pins
are high. Which means they are not wired to the CPU, otherwise at least
one of them would be low.

Now, looking at register 0x27, it appears that all VID input pins have
been configured for their alternative function (GPIO.) This is not the
default value for this register, which means that the motherboard
vendor decided to not use these pins for VID input but for another
function.

BTW... the pins in question are in input mode. So who knows... maybe
they ARE used for VID monitoring, and GPIO was preferred over true VID
for obscure reasons (incompatible voltage levels?) You may want to run,
as root:

isadump -f 0x800 16

and see if the 3rd value would make sense as a VID value for your CPU.

>  From reading that thread I wonder if this is a version of hwmon-vid issue?

Not, it's not. The VID input pins apparently aren't wired on your
motherboard, or wired in a weird way. Ask the manufacturer to confirm
this, and if they do, blame it on them. There's nothing hwmon-vid can
do about it.

One thing we could do is teach the it87 driver to not export the VID
value if any of VID pins 0-3 are configured for GPIO function. That
wouldn't be too difficult, but would you be able to test a kernel patch?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
