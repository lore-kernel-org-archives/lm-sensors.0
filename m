From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Nov 2005 15:52:13 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <7JVLKU4w.1132757517.4798480.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Daniel,

On 2005-11-23, Daniel Nilsson wrote:
> (...) Should I attempt
> to write arbitrary values to all writeable files under
> /sys/bus/i2c/devices/0-002c/ ?

Yes, one at a time.

I would start by writing safe values to the limit files: 0 to min voltage
limits, 10000 to max voltage limits (the driver will automatically trim
down to the max possible limit), 100000 to max temperature limits,
etc... The idea is to find out whether the write transactions themselves
are causing problems (unlikely) or if the problem is triggered by an
alarm condition which results from setting some limits too tight. If the
safe writes seem to work OK, try more dangerous ones and see when it
breaks.

I seem to understand that "sensors -s" does not always hang. This will
probably make the investigation harder. I admit I don't have much idea
what we are trying to demonstrate at this point, just trying to gather
enough data to have better ideas.

If you could try an older kernel (for example 2.6.13.4) and see if you
have the problem there too, that would be interesting. Just because the
i2c-i801 driver didn't change doesn't mean that nothing in the kernel
did change. If the monitoring chip is generating some hardware interrupt
on alarm conditions, the i2c-i801 driver may not be involved at all.

Oh, another thing to try I forgot to mention (for Keith too) would be to
run an UP kernel on the same hardware and see if the problem disappears.
It would be nice if we can at least assert that SMP is one triggering
factor.

>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX UU XX XX XX
> 30: XX 31 XX 33 XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX 44 XX XX XX UU XX XX XX UU XX XX XX
> 50: XX UU XX UU XX XX XX XX XX XX XX XX XX XX XX XX
> 60: 60 61 XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX

SMBus 2.0, nothing unusual here.

> (...) What I can tell though is that sensors-detect
> suggested to insert the it87 driver as well. If I do, I get the
> message:
>
> it87: Found IT8712F chip at 0x290, revision 7
>
> in the kernel log. The output of sensors then reads:
>
> oden:~# sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.26 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> VCore 2:   +1.47 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> +3.3V:     +6.59 V  (min =  +8.16 V, max =  +8.16 V)   ALARM
> +5V:       +6.85 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> +12V:     +11.58 V  (min = +16.32 V, max = +16.32 V)   ALARM
> -12V:     -13.86 V  (min =  +3.93 V, max =  +3.93 V)   ALARM
> -5V:       -8.51 V  (min =  +4.03 V, max =  +4.03 V)   ALARM
> Stdby:     +5.56 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
> VBat:      +3.17 V
> fan1:        0 RPM  (min =    0 RPM, div = 8)
> fan2:        0 RPM  (min =    0 RPM, div = 8)
> fan3:       -1 RPM  (min =    0 RPM, div = 8)
> M/B Temp:    +80?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
> CPU Temp:    +64?C  (low  =    -1?C, high =    -1?C)   sensor = diode
> Temp3:       +75?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
>
> I'm not sure if there is a second I2C master on the bus or if the same
> master is also mapped to the ISA bus address space somehow? Except for
> that, I don't know how to answer the question...

No, the IT8712F is essentially a Super-I/O chip with a flash interface
and some legacy I/O functions (serial ports, floppy disk drive
controller etc...) which happens to incorporate hardware monitoring
functions. But the presence of a Winbond W83792D chip and the totally
bogus values you get from the IT8712F chip make it clear that the
motherboard manufacturer decided to add a dedicated chip for hardware
monitoring rather than to use the IT8712F features. Just don't load the
it87 driver at all.

Can you please just provide the output of "isadump 0x295 0x296" to rule
out the possibility that the IT8712F chips was connected to the SMBus
with the same address the W83792D chip uses? Unlikely, but you never
know...

--
Jean Delvare
