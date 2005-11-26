From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Sat, 26 Nov 2005 08:54:31 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051126074803.GH26906@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, Nov 23, 2005 at 03:51:57PM +0100, Jean Delvare wrote:
> On 2005-11-23, Daniel Nilsson wrote:
> > (...) Should I attempt
> > to write arbitrary values to all writeable files under
> > /sys/bus/i2c/devices/0-002c/ ?
> 
> Yes, one at a time.
> 
> I would start by writing safe values to the limit files: 0 to min voltage
> limits, 10000 to max voltage limits (the driver will automatically trim
> down to the max possible limit), 100000 to max temperature limits,
> etc... The idea is to find out whether the write transactions themselves
> are causing problems (unlikely) or if the problem is triggered by an
> alarm condition which results from setting some limits too tight. If the
> safe writes seem to work OK, try more dangerous ones and see when it
> breaks.

Ok, I've tried this manually and can't reproduce the problem. As I
mentioned in my other e-mail I will attempt to script in order to try
more combinations unless someone has any better suggestions.

> I seem to understand that "sensors -s" does not always hang. This will
> probably make the investigation harder. I admit I don't have much idea
> what we are trying to demonstrate at this point, just trying to gather
> enough data to have better ideas.

Correct, it does not always hang.

> If you could try an older kernel (for example 2.6.13.4) and see if you
> have the problem there too, that would be interesting. Just because the
> i2c-i801 driver didn't change doesn't mean that nothing in the kernel
> did change. If the monitoring chip is generating some hardware interrupt
> on alarm conditions, the i2c-i801 driver may not be involved at all.
> 
> Oh, another thing to try I forgot to mention (for Keith too) would be to
> run an UP kernel on the same hardware and see if the problem disappears.
> It would be nice if we can at least assert that SMP is one triggering
> factor.

Yes, I can try both of these once I'm able to reproduce :-)


> No, the IT8712F is essentially a Super-I/O chip with a flash interface
> and some legacy I/O functions (serial ports, floppy disk drive
> controller etc...) which happens to incorporate hardware monitoring
> functions. But the presence of a Winbond W83792D chip and the totally
> bogus values you get from the IT8712F chip make it clear that the
> motherboard manufacturer decided to add a dedicated chip for hardware
> monitoring rather than to use the IT8712F features. Just don't load the
> it87 driver at all.
> 
> Can you please just provide the output of "isadump 0x295 0x296" to rule
> out the possibility that the IT8712F chips was connected to the SMBus
> with the same address the W83792D chip uses? Unlikely, but you never
> know...

Sure, here it is:

isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 19 10 ff 00 00 00 00 00 00 00 00 5b 00 ff ff 00
10: ff ff ff 37 b0 01 01 00 ff ff 00 ff ff ff ff ff
20: ff ff ff ff ff ff ff ff c7 80 80 80 ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff
50: 00 00 7f 7f 7f ff 56 56 90 56 fe 12 00 00 00 00
60: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
70: 7f 7f 7f 00 00 7f ff ff ff ff ff ff ff ff ff ff
80: 00 00 00 00 ff ff ff ff 40 40 ff ff ff ff ff ff
90: 7f 7f 7f 00 00 7f ff ff 7f 7f 7f 00 00 7f ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


-- 
Daniel Nilsson
