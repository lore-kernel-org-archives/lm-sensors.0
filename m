From: lupe@lupe-christoph.de (Lupe Christoph)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dell 650 still not working (2.8.3)
Message-Id: <20040406060033.GO1823@lupe-christoph.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119181743.GA1625@lupe-christoph.de>
In-Reply-To: <20040119181743.GA1625@lupe-christoph.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday, 2004-04-04 at 16:04:41 +0200, Jean Delvare wrote:

> > 2.8.3 gives me a clue:
> >   i2c-piix4.o: Host SMBus controller not enabled!

> > When I forcefully enable it, i2cdetect -l lists an SMBus:
> > i2c-0	smbus    	SMBus PIIX4 adapter at 0580     	Non-I2C SMBus
> > adapter           

> How did you get the address value of 0x0580? On your ticket it was
> 0x6000. Basically, unless Dell tells you the correct address, or there's
> nothing we can do for you.

That 0x0580 was detected by i2cdetect. Dell gave me a different address
that did not work. Maybe it's from a different system.

> > But as soon as I let sensors-detect scan it, the machine locks up:

> > Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
> > Do you want to scan it? (YES/no/selectively): 
> > Client found at address 0x00
> > <hangs>

> It may not be the problem (more likely you didn't force the correct
> address) but we recently fixed i2cdetect and sensors-detect so that they
> don't scan special addresses anymore. This includes 0x00 (this is a
> broadcast address).

I will see that I can try that.

> > I have no desire to repeat the crash-and-burn for all 127 remaining
> > adresses. Is there a way to use dmidecode to find the sensor chips?

> Not that I know of.

Sigh. Would be too easy, hum?

> > Those handles look like this:

> > Handle 0xDD02
> >         DMI type 221, 19 bytes.
> >         OEM-specific Type
> >                 Header and Data:
> >                         DD 13 02 DD 00 00 00 3A F0 04 FC 00 00 00 00
> >                         00 00 62 F0

> > Maybe a recipe to gain access to that data.

> > Any ideas or hints?

> Not really. All I can decode are the four first bytes: DD is the type
> (221) and 13 is the length (19 bytes), 02 DD is the handle reference. So
> the real data starts after that. But as said it is OEM-specific so
> unless Dell tells you how to decode these bytes, it doesn't help in any
> way.

.. and they aren't being helpful. I also tried the Dell mailing list with
this qestion. Deafening silence.

Thanks for your information!
Lupe Christoph
-- 
| lupe@lupe-christoph.de       |           http://www.lupe-christoph.de/ |
| "Violence is the resort of the violent" Lu Tze                         |
| "Thief of Time", Terry Pratchett                                       |
