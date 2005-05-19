From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <1088157745.5xdxb70sh3i8@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri 25 Jun 2004 04:37:39 AM CDT Jean Delvare <khali@linux-fr.org> said:
>
> Hi Andrew,
>
> (Shouldn't you be sleeping at 4:30am? ;))

Ha, I probably should be, but I do tend to keep some strange hours.

> Please do:
>
> isaset -f 0x6628 0x00
> isaset -f 0x6648 0x00
>
> (i.e. 0x00 instead of 0x03)
>
> It *should* switch the chip to internal ref.
>
> Please dump the chip's contents again after that. for comparison.

Ok, see attachments.

Things definitely got more interesting here:
# sensors
pc87366-isa-6620
Adapter: ISA adapter
in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
in1:       +2.24 V  (min =  +0.00 V, max =   2.95 V)
in2:       +2.78 V  (min =  +0.00 V, max =   2.95 V)
in3:       +0.80 V  (min =  +0.00 V, max =   2.95 V)
in4:       +2.75 V  (min =  +0.00 V, max =   2.95 V)
in5:       +2.77 V  (min =  +0.00 V, max =   2.95 V)
in6:       +0.00 V  (min =  +0.00 V, max =   2.95 V)
Vsb:       +3.66 V  (min =  +0.00 V, max =   5.91 V)
Vdd:       +3.66 V  (min =  +0.00 V, max =   5.91 V)
Vbat:      +2.95 V  (min =  +0.00 V, max =   2.95 V)
AVdd:      +3.64 V  (min =  +0.00 V, max =   5.91 V)
fan1:        0 RPM  (min =    0 RPM, div = 0)
fan2:        0 RPM  (min =    0 RPM, div = 0)
fan3:        0 RPM  (min =    0 RPM, div = 1819)
CPU0 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
CPU0 Crit:  +127 C ALARM
CPU1 Temp:  +127 C  (low  =   -55 C, high =  +127 C)   OPEN
CPU1 Crit:  +127 C ALARM
S-IO Temp:   +83 C  (low  =   -55 C, high =  +127 C)   ALARM
S-IO Crit:  +127 C

The temperature reading is obviously way high. The voltages seem more
reasonable. At the very least, they're different than they were before.

> Thanks and sorry for the bad information.

No prob at all... do I need to worry about what the previous commands might have
done/changed, or does that all get cleared after a reboot?

Thanks,

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
