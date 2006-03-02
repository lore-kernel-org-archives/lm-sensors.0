From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 02 Mar 2006 09:04:15 +0000
Subject: [lm-sensors] Need help, all temps are displaying -48.0C
Message-Id: <U4IedQKu.1141290255.2891660.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
In-Reply-To: <20060302041617.7762.qmail@web32514.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pat,

On 2006-03-02, Pat wrote:
> I'm running Centos 4.2 x86_64 on a SuperMicro X6DHI-G2 mobo
> (http://www.supermicro.com/products/motherboard/Xeon800/E7520/X6DHi-G2.cfm).
> I have installed the latest version of lm_sensors but my temps reported
> back are all -48.0C which is incorrect of course, my BIOS reports temps of
> 44/44/43C.
>
> Any ideas on what I'm doing wrong or is my setup just not supported?
> Thanks for any help.
>
> Log of sensors-detect below (I pressed enter at all prompts):
>
> [root at localhost ~]# sensors-detect
> Hexadecimal number > 0xffffffff non-portable at /usr/local/sbin/sensors-detect l ine 2108, <INPUTFILE> line 15.
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)

Hm, this is an odd error message, I've never seen it before. Can you
please provide the contents of your /proc/bus/pci/devices file? I don't
think this is related to your problem, but let's fix the error if we
can.

> Client found at address 0x2f
> (...)
> Probing for `Winbond W83792D'... Success!
>     (confidence 7, driver `w83792d')

This is most certainly where your temperatures are.

> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Success!
>     (confidence 8, driver `w83781d')
> (...)
> Probing for `Winbond W83627HF Super IO Sensors'
>   Success... found at address 0x0295

This is weird. Although address 0x295 is the one we write to in order to
drive the chip, the chip address is supposed to be 0x290. In fact, you
can see above that sensors-detect already probed address 0x290 and found
the W83627HF chip (using a legacy detection method), so this different
address confuses it a lot as it now pretends there are two different
chips, one at 0x290 and one at 0x295. In fact this is the same chip.

I consider it a BIOS bug which should be reported to Supermicro. I wonder
why they did that, we never had any report about something like this
before.

This incorrect address setting will confuse the w83627hf driver, which is
usually prefered over the w83781d driver for the W83627HF chip. The
w83627hf driver expects address 0x290 and adds an offset of 5 by itself
to find the address to which it must write. With your BIOS
configuration, the driver will attempt to write to address 0x295 + 5 0x29a, which is not correct, so it won't work.

You should check for BIOS updates from Supermicro. If it doesn't help,
you should complain to them. That being said, your temperature issue is
something different from that issue.

> # Warning: the required module w83792d is not currently installed on your system.
> # For status of 2.6 kernel ports see http://secure.netroedge.com/~lm78/supported.html
> # If driver is built-in to the kernel, or unavailable, comment out the following line.
> modprobe w83792d

As just suggested by Yuan Mu, this is your real hardware monitoring chip,
so you need the w83792d driver. Which kernel are you using? You didn't
tell us. The w83792d driver was added in version 2.6.14.

> [root at localhost ~]# ./lm_sensors-2.10.0/prog/sensors/sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +3.98 V  (min =  +0.00 V, max =  +0.00 V)
> VCore 2:   +4.00 V  (min =  +0.00 V, max =  +0.00 V)
> +3.3V:     +3.98 V  (min =  +3.14 V, max =  +3.46 V)
> +5V:       +5.08 V  (min =  +4.73 V, max =  +5.24 V)
> +12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)
> -12V:      +0.80 V  (min = -13.18 V, max = -10.88 V)
> -5V:       +1.94 V  (min =  -5.25 V, max =  -4.75 V)
> V5SB:      +5.54 V  (min =  +4.73 V, max =  +5.24 V)
> VBat:      +0.13 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min = 2848 RPM, div = 2)
> fan2:     4687 RPM  (min = 2848 RPM, div = 2)
> fan3:     4687 RPM  (min =  712 RPM, div = 8)
> temp1:       -48?C  (high =   -37?C, hyst =   +59?C)   sensor = thermistor
> temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
> temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
> vid:      +0.000 V  (VRM Version 9.0)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled

The W83627HF Super-I/O chip seems to be used as a secondary hardware
monitoring chip. The temperature sensors are most likely wired to the
primary chip (W83792D), not W83627HF displayed above. -48 degrees C is a
typical value for unconnected thermal sensors.

The W83627HF is probably used for monitoring the extra fans though (your
board is advertised to monitor a total of 8 fans, and the W83792D alone
cannot monitor that many fans), as a matter of fact you have two valid
readings (although suspiciously similar.)

Maybe some voltages will make sense as well, but they will most certainly
be redundant with the ones displayed by the w83792d driver once you get
it to work.

--
Jean Delvare

