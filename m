From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040417154842.7215c9af.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Unfortunately, probing and detection is something we have just sort
> of 'made up' since there is nothing nice and defined in the way we
> can see what's on a bus.  It would be great to have some table like
> PCI does to see the vendor id, device id, etc.  But I2C/SMBus is,
> by design, is much simplier than that.

Correct.

OK, thanks everyone for the feedback. Here is a summary of my knowledge,
and a new, more realistic (hopefully) proposal.

1* Some chips are write-only, and will lock the bus on read attempts.
Such devices include clock chips frequently found in PCs at address
0x69. Thus probing all addresses with a "receive byte" (instead of
"quick write 0" for now) or even "quick read 1" isn't an option.

2* The AT24RF08 found in various IBM machines and possibly others has a
broken state machine. Corruption is triggered by sending "quick write 0"
to addresses 0x54-0x57 and possibly 0x5C. We worked around it by
doubling the "quick write 0", it works on most cases but isn't safe
because something could intervene inbetween these two commands.
Especially in the kernel, the first quick write is done by i2c-core and
the second is under the responsability of the chip driver. This isn't
safe, to say the least. If you take a look at the eeprom driver (both
2.4 and 2.6), you'll notice that this second quick write is issued
conditionally. It's probably wrong and I'm certain that corruptions
could still occur (without the extra IBM-detection stuff, it would). So
I don't consider it a solution.

3* Quick write is a write command in SMBus, some chips could change
states upon receiving it. It was never seen so far, but could happen. I
underline this in order to insist on the fact that our use of "quick
write 0" for probing purposes has no legitimacy. If just happens to be
the less worst solution in a majority of cases.

Now the solution I have come to is the following. It's rather simple and
I wonder why nobody proposed that yet. Once again, I expect that some of
you will explain to me why it isn't possible (I was expecting this for
my first proposal and bingo! I won ;))

My point is that there is no reason to stick to a single method to
detect devices at all addresses.

We pretty well know where the AT24RF08 lives. Why not just use "receive
byte" commands to probe these addresses, instead of a "quick write 0"
and then hurrying to send another before a corruption occurs? I've
checked, and these addresses (0x54-0x57 and 0x5C) are only used by
EEPROMs as far as we know, which will all acknoledge on a "receive byte"
command.

I would even extend the range a little bit more. Many EEPROMs have
additional addresses in the 0x30-0x37 range (typically their primary
address - 0x20), which is often refered to as "shadow eeprom". This is
actually something similar to AT24RF08's 0x5C: page protection address.
I read several datasheets this morning with Rudolf Marek, and we found
that some EEPROMs even use the 0x30-0x37 range for their primary
address. Some older EEPROMs have primary addresses at 0x58-0x5F. And
some EEPROMs could write protect themselves definitely on any write to
their page protection address (unconfirmed).

All in all I wouldn't be against using "receive byte" commands to probe
the whole 0x30-0x3F and 0x50-0x5F ranges. We know little non-EEPROM
chips living in these ranges:

LTC1710: 0x58-0x5A.
The docs say that the chip will not acknowledge on reads. I'd like to
know if it just keeps quiet or locks the bus. Phil? This is an uncommon
chip if I'm not mistaking, unlikely to be found in PCs. People who have
this probably know they do and where it is, and can use a force
parameter.

SAA1064: 0x38-0x3B
MAX6900: 0x50
These two ones will acknoledge on reads, no problem.

So I propose that we agree on which ranges should be affected by the
change, and just do that in sensors-detect, i2cdetect and i2c-core.
After that we have to remove the extra quick writes in eeprom and
ddcmon, and later the IBM detection in sensors-detect and i2c-piix4.

I have been testing with the following ranges in sensors-detect:
0x30-0x37, 0x3C-0x3F, 0x50-0x57 and 0x5C-0x5F on my two systems (which
include EEPROMs on-board and over DDC, and other chips) and it worked
OK. This set of ranges is only a proposal, I have no strong objection
against a more extended range set (0x30-0x3F and 0x50-0x5F for example)
or a shorter one (as long as at least all five addresses of the AT24RF08
are included).

Objections, comments, anyone?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
