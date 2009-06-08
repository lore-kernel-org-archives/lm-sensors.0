From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Jun 2009 12:11:51 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <20090608141151.05c5bd6f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hleb,

On Sat, 6 Jun 2009 17:31:31 +0300, Hleb Valoshka wrote:
> On 6/5/09, Jean Delvare <khali@linux-fr.org> wrote:
> 
> >> AMD-specific functions
> >> Version 00060fb1:
> >> Family: 15 Model: 11 []
> > This is a BH-G1 core, family 0Fh, it does have 6 VID pins, so VRM
> > version "25" (in hwmon-vid's terms) is correct. Is it the value
> > returned in /sys/bus/platform/devices/it87.552/vrm? I suppose the value
> > returned in that file in kernel 2.6.26 was "24" instead?
> 
> @globus-debian:~$ cat /sys/bus/platform/devices/it87.552/vrm
> 25
> 
> yes, with 2.6.26 it was 24
> 
> 
> >> >> Module hwmon_vid (drivers/hwmon/hwmon-vid.c) from linux-2.6.29(.3)
> >> >> returns
> >> >>
> >> >> incorrect voltage for my CPU from it8716f sensor (real/2).
> >> >> With module from 2.6.26 voltage is correct.
> > What was the voltage value before, and what is it now?
> 
> cpu freq | 2.6.26 | 2.6.29
> ---------------------------------
> 1 GHz    | 1.1 V  | 0.54 V
> 2.1 GHz  | 1.25 V | 0,61 V

1.25 V is definitely correct and 0.61 V definitely not...

> > The hwmon-vid code looks correct, and I think you are the first person
> > complaining since the code was changed (while we did have success
> > reports.) It could be that VID5 pin is not properly wired on your
> > system. Or a bug in the it87 driver.
> 
> Is it wired on motherboard? It's Gigabyte GA-MA69VM-S2 (amd rs690v based)

Yes it is (or should be) wired on the motherboard. Basically, the CPU
has 6 VID (output) pins which should be routed to 6 input pins of the
IT8716F chip. The logical level of these pins is then used by the it87
and hwmon-vid drivers to tell the nominal CPU core voltage.

> > Please provide a dump of your IT8716F chip:
> >
> > isadump 0x22d 0x22e
> 
> @globus-debian:~$ sudo isadump 0x22d 0x22e
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x22d and data register 0x22e.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 10 00 00 ff ff 00 37 ff 87 32 09 07 11 ff 00

VID value is in register 0x0a. Value 0x32 is 110010 binary (0.54 V.)
Kernel 2.6.26 ignored the MSb so it decoded 0x12 -> 1.1 V, which
happened to be correct.

> 10: ff ff ff 31 d7 82 7f c2 02 ff 00 ff ff ff ff ff
> 20: 44 79 d2 bb c3 ca 46 b8 be 29 20 16 7e 8d 8d 8d
> 30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
> 40: 7f 7f 7f 7f 7f 7f 00 0d 2d ff ff ff ff ff ff ff
> 50: ff 1c 7f 7f 7f 50 eb eb 90 eb 00 12 60 00 00 00
> 60: ff 14 7f 27 90 03 ff ff 7f 7f 7f 00 00 7f ff ff
> 70: ff 14 7f 20 90 03 ff ff ff ff ff ff ff ff ff ff
> 80: 00 00 00 00 ff ff ff ff 00 00 ff c0 02 00 99 99
> 90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
> a0: 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> > As well as a dump of the Super-I/O config space:
> > isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4
> 
> @globus-debian:~$ sudo isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 4 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 87 16 00 10 1a 00 00 00 80 00 00 00 1f 00 00 00

VID input configuration looks OK, all 6 pins are configured for VID
input.

> 30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 02 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 80 00 0e 00 88 00 ff 00 00 00 00 00 00 00 00 00

For completeness, please also provide the output of:

isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

And also tell me which revision is printed when you load the it87
driver.

> 
> > Also, if you use the powernow-k8 driver, it should print the available
> > VIDs when the driver is loaded, please report what the driver says.
> 
> powernow-k8: Found 1 AMD Athlon(tm) X2 Dual Core Processor BE-2350
> processors (2 cpu cores) (version 2.20.00)
> powernow-k8:    0 : fid 0xd (2100 MHz), vid 0xc
> powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xd
> powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xf
> powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
> 
> (To make test I compiled hwmod-vid from 26 for 29 and everything was ok)

So powernow-k8 agrees that VID5 should always be 0 on your CPU.

To me it looks like wiring of VID5 on your motherboard is incorrect,
and it is always set even when the CPU says it should not. In kernel
2.6.26, hwmon-vid was working by accident, and fixing the code made the
problem appear in your case.

You could contact the motherboard vendor and tell them about the
problem (the question is "Is VID5 properly routed from CPU to
IT8716F?") and see what they have to say about this.

I don't really know how to work around this. I suspect that only the
late 0Fh family CPUs actually make use of VID5. If I am right then we
could tweak the hwmon-vid VRM selection table and use 5-pin VID (VRM
code 24) for some of the 0Fh family CPUs. I don't know where to put the
limit, and this is fixing the problem where it is not... which is
likely to cause even more problems on other systems in the future.

Frank, can you please tell us for which 0Fh family CPU model you did
need the 6th VID pin decoding originally?

Maybe we can have a DMI-based workaround either in it87 or hwmon-vid.
This is ugly and we avoid it as much as possible, but if there's no
other way... Hleb, please provide the output of dmidecode on your
system.

In the meantime you can write "24"
to /sys/bus/platform/devices/it87.552/vrm at system boot time, so that
the value of VID5 is ignored (actually forced to 0.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
