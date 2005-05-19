From: joerg@dorchain.net (Joerg Dorchain)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031217110547.GB1047@GreenHouse.dorchain.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 16, 2003 at 08:30:00PM +0100, Jean Delvare wrote:
> 
> As you can see the XX's moved. Also, there were no XX's on the ASB100
> dump. Conclusion: there is a communication problem over your I2C bus,
> that does only affect the W83L785TS-S chip. This was already seen:
> http://www.nforcershq.com/forum/viewtopic.php?t#918#185075
> But other users don't have the problem.

The motherboard is Ausus OEM by 4MBO. I would never buy this box again
from this vendor, for a lot of additional reasons.

> I don't know if there's anything we can do. Alex van Kaam (MBM's author)
> told us that he observed the same (which tends to demonstrate that the
> hardware, not the software, is faulty). He suggested that it could be "a
> conflict with the bios reading it", but I don't see why the BIOS would
> read it. There's a pin of the chip dedicated to this (goes low if the
> limit temperature is reached).

I had some BIOS problems with the box. As it is OEM, the Ausus provided
BIOS updated do not fit. 4MBO gives out none and deny problems (They say
it works all fine with Windows, so what? Just one of the above mentioned
reasons)
> 
> Could you please provide the following dumps:
> i2cdetect 1
 i2cdetect 1
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e XX
30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 7f

> i2cdump 1 0x2e c
 i2cdump 1 0x2e c
  WARNING! This program can confuse your I2C bus, cause data loss and
worse!
  I will probe file /dev/i2c-1, address 0x2e, mode byte consecutive read
  You have five seconds to reconsider and press CTRL-C!
 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................

> it doesn't have XX's it might be an interesting workaround (but I doubt
> it).

I am sure the XX won't help too much.

BTW, on the smbus 0, there are some clients that the sensors package
does not regognize. Are you interested in more details?

> > The EXLDFLAGS was just "there" in the main makefile. I just now
> > learned how the makefile approach for this package works, and IMHO it
> > is a great concept. A patch which works for all programs is included
> > now.
> 
> Applied, thanks.

With pleasure :-)

Bye,

Joerg
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031217/cd3b4ce7/attachment.bin
