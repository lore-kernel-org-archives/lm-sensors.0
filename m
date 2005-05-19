From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <EH62wpRa.1107861787.2408510.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Ooops, sorry for the typo. It's David _W._ Madsen, not D.

--- Original Message ---
Date: 2/8/2005
From: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: I have information on Winbond W83627EHF Chip



Hi David,

> I have a new motherboard with the W83627EHF from Winbond and of course
> my sensors-detect can't find the chip.
>
> According to your site, you are looking for the data sheet for this
> chip.

That's right. What motherboard is it, BTW?

For reference, David W. Madsen (CC) already requested support some times
ago:
http://secure.netroedge.com/~lm78/readticket.cgi?ticket37
http://archives.andrew.net.au/lm-sensors/msg28595.html

> For the past 3 weeks, I have been trying to get in touch with people at
> Winbond to get the data sheet. I explained that I was working with
> people who develop drivers for monitoring sensors on open source Linux
> systems. Today, they finally sent me something along with a pretty cool
> note.
>
> Their rep wrote: "Hi David. I run Fedora core 2 over here on my
> non-work computer so I appreciate the Open Source work that is done for
> our devices.  Here is the latest data sheet on the ?627EHF.  I?m not
> sure I can answer questions past what is in the data sheet but if you
> come up with some I can give it a try."
>
> And he sent me the data file which I am attaching to this note.

That's really great :)

> I can only assume that you already have this information, and are
> already working on an update, but I am seriously hoping that this
> information is enough to get an update so that this chip can be
> recognized and I can use lm-sensors on my machine.

We didn't have it yet, so thanks a lot for the good work. With the
datasheet we can now consider extending our Winbond drivers and
user-space tools to support the W83627EHF.

> Please let me know where this stands and if this driver is in the
> works.

Nothing in the works ATM. I've read the datasheet I found that the
W83627EHF has the following differences when compared with the other
chips of the family:

* One additional voltage input.
* 8mV LSB for voltages instead of 16mV.
* Two additional fan inputs.
* I2C interface, but no subclients?
* One additional fan control output.
* Fan control can optionally operate in DC mode.
* 6-bit VID in Super-I/O space.

I'd like someone else to read the datasheet and confirm/complete this
list. Once we know exactly what the differences are, we can decide
whether it is better to add support to an existing driver or create a
new one. Some of the additional features would be trivial to add (such
as the additional voltage input), but some are more tricky (VID for
example).

David (both), which kernel are you running?

I have a patch for sensors-detect ready to start with, will commit this
evening (Europe) for you to test.

I'd also appreciate a dump of your chips (isadump 0x295 0x296 or i2cdump
<bus id> 0x2d, whichever works for you). If possible, please also
provide a sample output of hardware monitoring data provided by the BIOS
setup screen.

If any of you is willing to support the development of the W83627EHF
support, either through the donation of hardware, or by simply paying a
developer to work on it, please let us know. That's obviously the best
ways to get the support added fast.

If not, that doesn't mean we won't do it, of course, just that it'll
be one task among the various others we have for the project, so there
is no guaranteed timeline. And having a real hardware chip to test our
code on is also very convenient and typically ensures better support for
the chip, regardless of how much time we take to write the driver in the
first place.

Thanks,
--
Jean Delvare
