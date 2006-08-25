From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 25 Aug 2006 06:53:12 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <20060825085312.8674afb4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Prakash,

> Hi, thx for your prompt reply. Yes I have partial success! :-)
> 
> Issues:
> 
> 1) sensor-detect tells me to inster k8temp, but I can't find it in kernel 
> tree.

It's a really new driver written by Rudolf Marek. Get the patch from
here:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-k8temp-new-driver.patch

Additionally if you want the driver to load automatically, you can
apply this patch of mine on top of the previous one:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-k8temp-autoload.patch

Both patches will soon be in -mm.

> 2) Some values are probably wrong:
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.04 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> VDDR:      +3.12 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +3.3V:     +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +5V:       +4.84 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> +12V:     +11.46 V  (min = +16.32 V, max = +16.32 V)   ALARM
> in5:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in6:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> 5VSB:      +4.70 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> VBat:      +2.86 V
> fan1:     1363 RPM  (min = 6490 RPM)                   ALARM
> fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> fan3:     1566 RPM  (min =    0 RPM)
> temp1:       +26?C  (low  =    -1?C, high =    -1?C)   sensor = diode
> temp2:       +38?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
> temp3:       +25?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
> vid:       +0.00 V
> 
> 
> I am missing my 3.3V readings ;-)

VDDR as +3.12 V is way too high, so my guess is that in1 is actually
+3.3V, and VDDR isn't monitored. So you'll need to adjust the label
lines in the configuration file, then you add ignore statements for
in3, in5 and in6.

Can you copy all the hardware monitoring data provided by your BIOS?
This is the most useful data to customize the configuration file for a
given board.

Vbat is a bit off, is your battery dead already?

> I am also pretty sure that VCore is wrong:

It looks reasonable to me.

> I set them to:
> powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x11
> powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x13
> powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x1b
> 
> If I am not mistaken, vid 0x11 is 1.2V and 0x1b is 0.9V. (Does anybody know 
> how to calc from hex to vcore?) But sensors shows me 1.04 at 2GHz and 0.8 at 
> 1GHz. Or do you think the mainboard's volt regulator is that much off?

The decoding depends on the CPU. In theory the kernel detects it and
picks the right decoding formula but if your CPU is really new, it
might use a table we don't know yet. What is your exact CPU model?

> I have to check fan speed with what the bios reports, but it looks sensible.

We had reports where the "sensors" fan speeds were twice as high as
what the BIOS reported. I am still investigating to find out which is
right. Are you affected too?

> Anyways, I am happy that I can finally read out some data. :-))

I'm glad it somewhat works. I'll try to improve things a bit, then I'll
push the patches to -mm for wider testing.

Thanks for reporting!

-- 
Jean Delvare

