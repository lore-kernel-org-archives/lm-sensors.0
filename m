From: i-c-q@chaos2.dtdns.net (Tom)
Date: Fri, 24 Feb 2006 19:42:12 +0000
Subject: [lm-sensors] Implementation of FSCSCY?
Message-Id: <43FF6194.7020509@chaos2.dtdns.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F75216.9040309@hiereinwerfen.de>
In-Reply-To: <43F75216.9040309@hiereinwerfen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Noone with a hint what's going wrong? :(

Torsten schrieb:
> Hello,
> 
> I'm really new to linux, so please be patient... ;)
> 
> I've got a FSC Dual-Mainboard (D1306) on which I'm trying to setup a
> server-system based on the actual Ubuntu ("Breezy Badger"). So the
> kernel must be a 2.6.
> 
> The board contains a "Scylla"-chip, which is found by sensors-detect. As
> far as I found within the docs, this must be ok, because the developer
> of the required module "fscscy" notes, the driver is "beta" but
> well-tested on exactly THIS board.
> 
> Anyway, sensors-detect wants to load "fscscy" in modules.conf, but this
> module doesn't exist!
> The only module next to piix4 ist "eeprom" which doesn't seem to be very
> useful...
> 
> I searched the whole drive, but only found the note mentioned above.
> Google didn't come out with more and I couldn't find an open bug/ticket...
> 
> Where can I get it and why is it missing?
> 
> PS: Another strange thing, when installing piix4, the bootlog shows
> something about "unusual config register value" and I should set
> "fix_hstcfg=1". When I do so, sensors-detect searches longer and finds
> more... Anyway, the only new modules to load are smbus-arp (for which
> the doc reads "if you don't know what this is you don't need it"???) and
> another unsupported chip called Philips "PCA9556". :-(
> 
> cu/2
> Tom


