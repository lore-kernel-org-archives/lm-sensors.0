From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:24:42 +0000
Subject: [lm-sensors] Implementation of FSCSCY?
Message-Id: <440B490A.2050104@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F75216.9040309@hiereinwerfen.de>
In-Reply-To: <43F75216.9040309@hiereinwerfen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Your mail hit the list just few days before my final exams so I had no time to reply.

> I've got a FSC Dual-Mainboard (D1306) on which I'm trying to setup a
> server-system based on the actual Ubuntu ("Breezy Badger"). So the
> kernel must be a 2.6.

Is this a serverworks chipset?

> 
> The board contains a "Scylla"-chip, which is found by sensors-detect. As
> far as I found within the docs, this must be ok, because the developer
> of the required module "fscscy" notes, the driver is "beta" but
> well-tested on exactly THIS board.

> Anyway, sensors-detect wants to load "fscscy" in modules.conf, but this
> module doesn't exist!
> The only module next to piix4 ist "eeprom" which doesn't seem to be very
> useful...
> 
> I searched the whole drive, but only found the note mentioned above.
> Google didn't come out with more and I couldn't find an open bug/ticket...
> 
> Where can I get it and why is it missing?

Nobody ever port it it seems. You can do it yourself with our help, pay/donate
something to handle it for you.

> PS: Another strange thing, when installing piix4, the bootlog shows
> something about "unusual config register value" and I should set
> "fix_hstcfg=1". When I do so, sensors-detect searches longer and finds
> more... Anyway, the only new modules to load are smbus-arp (for which
> the doc reads "if you don't know what this is you don't need it"???) and
> another unsupported chip called Philips "PCA9556". :-(

This is some multiplexer device if I recall correctly. Mayebe it is just
missdetection because of the fix_hst cfg. Please write back what chipset it is
(or lspci)

Thanks

Regards
Rudolf

