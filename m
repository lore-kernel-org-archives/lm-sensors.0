From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Ticket 1382 : Update
Message-Id: <20030907173122.540f1263.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Which values are you comparing with? The "idle" temperature may vary
> > from OS to OS (and from OS to BIOS setup screen), so the temperature
> > offset may be normal.
> 
> Well, there is a significant difference between the readings I get
> from the BIOS and those form sensors. I don't think that the CPU has
> enough time to cool down by over 5?C between the moment I shutdown
> Linux and I access the BIOS for example... 

Actually the system would more likely heat up than cool down. The
shutdown process is rather CPU intensive AFAIK. And BIOS things aren't
optimized for CPU idling either.

> > If you believe this is a bug in our driver and can prove it, we'll
> > of course fix it.
> 
> I think it's more related to what seems to be a common problem with
> VIA chipsets, ie the temp readings are not accurate. :(

VIA chipsets have an overall bad reputation (network adapters and
motherboards alike) for sure.

> Thanx, I hadn't noticed the patch down there, working now :)
> Although the only sensors listed on the card are eeprom, and not
> really working. I thought there was a temp reading but maybe the card
> is too old to have that (3D prophet, Geforce256 based card...)

Unload the eeprom module, and load the ddcmon module instead. That's
what most video cards want. If your monitor supports it, the module will
return some information about it.

If sensors-detect told you to use eeprom, I'd be interested in the
sensors-detect log, and in an i2cdump of the chip at address 0x50 on
that bus.

> > Note that the solution doesn't work with Linux 2.4.22 for now, but
> > I'm currently working on an update (Hopefully available within the
> > end of the day).
>
> Well that's ok, I'm sticking to 2.4.21 for now, until grsec is patched
> too.

FYI, the patches are available by now.

> If you don't mind my bothering you some more ...
> - sensors-detect says:
> Detects correctly:
>   * Bus `SMBus Via Pro adapter at 0400' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x2d
>     Chip `National Semiconductor LM80' (confidence: 3)
> However, I don't think I've got that chip anywhere on my PC. I wonder
> what chip could be misdetected like that, where to look ?

You should dump the chip contents and post the dump on this
mailing-list. We'll take a look and see if we can find out what it is.
Telling us what your motherboard is will help too. In order to dump the
chip contents, use: "i2cdump 0 0x2d". (Replace 0 with the bus number if
it's not 0). Make sure there's no chip driver loaded for that address,
or you may confuse that driver with unpredictable results.

> PS: if you like we can continue in French, unless there are other
> readers of course, I happen to be French as well :P

Noone but me reads French on this list, methinks ;) So let's stick to
English.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
