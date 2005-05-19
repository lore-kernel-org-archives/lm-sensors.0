From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <200406251137.i5PBbGWk014837@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>Things definitely got more interesting here:
># sensors
>pc87366-isa-6620
>Adapter: ISA adapter
>in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
>in1:       +2.24 V  (min =  +0.00 V, max =   2.95 V)
>in2:       +2.78 V  (min =  +0.00 V, max =   2.95 V)
>in3:       +0.80 V  (min =  +0.00 V, max =   2.95 V)
>in4:       +2.75 V  (min =  +0.00 V, max =   2.95 V)
>in5:       +2.77 V  (min =  +0.00 V, max =   2.95 V)
>in6:       +0.00 V  (min =  +0.00 V, max =   2.95 V)
>Vsb:       +3.66 V  (min =  +0.00 V, max =   5.91 V)
>Vdd:       +3.66 V  (min =  +0.00 V, max =   5.91 V)
>Vbat:      +2.95 V  (min =  +0.00 V, max =   2.95 V)
>AVdd:      +3.64 V  (min =  +0.00 V, max =   5.91 V)

Yeah, these look good. in6 is obviously unused. in0 doesn't seem to fit
within the range the chip can natively measure when running on internal
vref (could be caused by an improper resistor combination).

You should now be able to use your tweaked configuration file again,
including voltage limits (set using "sensors -s").

>fan1:        0 RPM  (min =    0 RPM, div = 0)
>fan2:        0 RPM  (min =    0 RPM, div = 0)
>fan3:        0 RPM  (min =    0 RPM, div = 1819)

BTW this shows there's a bug in my driver when the fan logical device is
disabled. The value returned for dividers is undefined (thus the
mysterious "1819"). I'll fix that this evening.

>CPU0 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
>CPU0 Crit:  +127 C ALARM
>CPU1 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
>CPU1 Crit:  +127 C ALARM
>S-IO Temp:   +83 C  (low  =   -55 C, high =  +127 C)   ALARM
>S-IO Crit:  +127 C

This clearly means that your system doesn't use thermal diodes. It would
be interesting to try thermistors. The driver relies on a Super-I/O
configuration bit to decide what to use. Unfortunately it says "thermal
diodes" here, which is why the driver decided to enable these. My
driver may need a parameter to force the use of thermistors.

For now, let's try to do it manually.

First of all we want to disable temp1 and temp2 (thermal diode channels).
First unload the driver, then:

isaset -f 0x6649 0
isaset -f 0x664a 0
isaset -f 0x6649 1
isaset -f 0x664a 0

Then we'll try to reconfigure the Super-I/O chip:

isaset 0x2e 0x2f 0x2b 0x50

If isaset complains that readback didn't match, don't go any further.
Else, simply reload the driver with init=2, and it should forcibly
enable temp4, temp5 and temp6 (thermistor based measurements). Now, if
they will actually work, I can't say.

>The temperature reading is obviously way high.

Agreed. I hope that reconfiguring the chip will change that, if the chip
is confused by trying to handle thermistors like thermal diodes.

>The voltages seem more reasonable. At the very least, they're different
> than they were before.

They look fine to me, except in0 and maybe in3. We'll now more when you
use your configuration file again.

>> Thanks and sorry for the bad information.
>
>No prob at all... do I need to worry about what the previous commands
>might have done/changed, or does that all get cleared after a reboot?

Nothing to worry about, or I would of course have told you so
immediately. The commands simply set the logical devices in stand-by
mode. Loading the driver reenables them anyway, so even rebooting was
not necessary at all.

I'll do a few fixes to the driver this evening, including more debugging
messages, this should help us deal with the temperatures. I'll let you
know when I have something for you to test.

Thanks,
Jean Delvare
