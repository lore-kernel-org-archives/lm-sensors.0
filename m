From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 27 Aug 2006 20:06:56 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <20060827220656.1d01ca7a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060825084257.556030b7.khali@linux-fr.org>
In-Reply-To: <20060825084257.556030b7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi J?rgen,

> Hi Jean,
> i have now applied the patches you told me.
> 
> "sensors" shows now:
> 
> snip ==========
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.01 V  (min =  +0.00 V, max =  +4.08 V)
> +3.3V:     +3.22 V  (min =  +0.00 V, max =  +4.08 V)
> +5V:       +4.81 V  (min =  +0.00 V, max =  +6.85 V)
> +12V:     +11.46 V  (min =  +0.00 V, max = +16.32 V)
> 5VSB:      +4.78 V  (min =  +0.00 V, max =  +6.85 V)
> VBat:      +2.93 V
> CPU_Fan:  2102 RPM  (min =    0 RPM)
> CHA_Fan1: 1254 RPM  (min =    0 RPM)
> PWR_Fan:   920 RPM  (min =    0 RPM)
> CPU Temp:    +22?C  (low  =    -1?C, high =  +127?C)   sensor = diode
> MB Temp:     +29?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
> vid:       +1.10 V
> 
> k8temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +30?C
> temp3:       +21?C
> snap==========
> 
> Vid looks now better.

Yep, looks alright to me now :) You're lucky, out of 4 boards with the
IT8716F chip, this is the only one with valid VID readings...

> Ok now with the patches, two EEPROMS and some other devices were found...
> What devices are at address  0x08, 0x0c, 0x22, 0x2e, 0x30, 0x31 and 0x50 ??
> Is there an device for the other fan's ?

The chip at 0x2e is most certainly a second hardware monitoring chip. I
just found out that the Asus M2N32-SLI has an Analog Devices ADT7475
for the additional fans, I would suspect that your board are the same
or a very similar chip.

I added detection of a bunch of new Analog Devices chips to
sensors-detect a few minutes ago, can you please fetch it, give it a
try and report?

> # Warning: the required module k8temp is not currently installed on your system.
> # For status of 2.6 kernel ports see http://www.lm-sensors.org/wiki/SupportedDevices
> # If driver is built-in to the kernel, or unavailable, comment out the following line.
> modprobe k8temp

For this one you can pick these patches:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-k8temp-new-driver.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-k8temp-autoload.patch

Thanks,
-- 
Jean Delvare

