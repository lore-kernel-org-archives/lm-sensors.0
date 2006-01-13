From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 13 Jan 2006 04:30:00 +0000
Subject: [lm-sensors] Incorrect SiS chipset detection?
Message-Id: <20060113043000.GB7036@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <43C6762C.3040001@quintic.co.uk>
In-Reply-To: <43C6762C.3040001@quintic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus:

* Marcus Williams <marcus at quintic.co.uk> [2006-01-12 15:30:52 +0000]:
> I'm trying to monitor my CPU temp to track down what looks like an 
> overheating problem. I've install lm-sensors (debian sarge, 
> 2.9.1-1sarge2) and I'm using kernel 2.4.27 (debian 2.4.27-2-686-smp)
> 
> Motherboard manual claims chipsets are SiS 963L, SiS 661FX, IT8705 
> although I'm not sure which ones are relevant...
> 
> I cant make sense of any of the readings though as they pretty much all 
> seem wrong:
> 
> --------------------
> 
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.34 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
> VCore 2:   +2.69 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
> +3.3V:     +6.56 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
> +5V:       +3.12 V  (min =  +4.74 V, max =  +5.24 V)   ALARM
> +12V:     +11.60 V  (min = +11.40 V, max = +12.60 V)
> -12V:     -12.02 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:       -4.98 V  (min =  -5.24 V, max =  -4.76 V)   ALARM
> Stdby:     +4.84 V  (min =  +4.74 V, max =  +5.24 V)
> VBat:      +4.08 V
> fan1:     7336 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min = 3013 RPM, div = 8)
> fan3:        0 RPM  (min = 3013 RPM, div = 8)
> M/B Temp:     +8?C  (low  =   +15?C, high =   +40?C)   sensor = 
> thermistor   ALARM
> CPU Temp:    +37?C  (low  =   +15?C, high =   +45?C)   sensor = diode
> Temp3:        +9?C  (low  =   +15?C, high =   +45?C)   sensor = diode 
> ALARM

The above output looks OK.  You still need to edit /etc/sensors.conf
to taste and then run 'sensors -s'.  Please read the FAQ.

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html

> sis5595-isa-8008
> Adapter: ISA adapter
> VCore 1:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> VCore 2:   +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +3.3V:     +4.08 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> +12V:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> fan1:        0 RPM  (min =    0 RPM, div = 8)          ALARM
> fan2:        0 RPM  (min =    0 RPM, div = 8)          ALARM
> temp:        +51?C  (high =   +51?C, hyst =   +51?C)   ALARM
> alarms:   Board temperature input (usually LM75 chips) ALARM

I'm pretty sure you don't have this chip.  Just make sure you don't load
that module and you should be all set.

<note to other lm-sensors devs>

Argh, I thought I fixed sensors-detect to DTRT with these SiS chipsets a
long time ago.  (/me checks code...) 

OK, the 661 host bridge is new enough that it's not in sensors-detect.
Why can't SiS just use unique PCI IDs for all of their chipsets, instead
of just abusing 1039:0008 over and over again?  BTW: I'm never again 
buying another board with a SiS chipset.  *Never*.

</note>

> --------------------
> 
> Output from lspci:
> 
> 0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 
> 661FX/M661FX/M661MX Host (rev 11)
> 0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown 
> device 0003
> 0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 
> (LPC Bridge) (rev 25)
> 0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
> 0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
> Controller (rev 0f)
> 0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
> Controller (rev 0f)
> 0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
> Controller
> 0000:00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] 
> SiS900 PCI Fast Ethernet (rev 90)
> 0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
> 661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP

Could you please send the output from 'lspci -n' ?

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


