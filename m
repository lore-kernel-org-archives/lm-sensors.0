From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dell 650 still not working (2.8.3)
Message-Id: <20040404160441.283de71e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119181743.GA1625@lupe-christoph.de>
In-Reply-To: <20040119181743.GA1625@lupe-christoph.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the delay...

> This is a follow-up to ticket 1483. I'm trying every new version of
> lm_sensors on my client's Dell 650 server, and I'm still not getting
> any result.
> 
> 2.8.3 gives me a clue:
>   i2c-piix4.o: Host SMBus controller not enabled!
> 
> When I forcefully enable it, i2cdetect -l lists an SMBus:
> i2c-0	smbus    	SMBus PIIX4 adapter at 0580     	Non-I2C SMBus
> adapter           

How did you get the address value of 0x0580? On your ticket it was
0x6000. Basically, unless Dell tells you the correct address, or there's
nothing we can do for you.

> But as soon as I let sensors-detect scan it, the machine locks up:
> 
> ..
> Probing for PCI bus adapters...
> Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB6 South
> Bridge Probe succesfully concluded.
> ..
> Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x00
> <hangs>

It may not be the problem (more likely you didn't force the correct
address) but we recently fixed i2cdetect and sensors-detect so that they
don't scan special addresses anymore. This includes 0x00 (this is a
broadcast address).

> I don't think I can get any information from Dell about the hardware
> of this machine. I tried and the guy gave me a wrong address for the
> SMBus chip.
> 
> I have no desire to repeat the crash-and-burn for all 127 remaining
> adresses. Is there a way to use dmidecode to find the sensor chips?

Not that I know of.

> There are things like this in it's output:
> 
> Handle 0x1B02
>         DMI type 27, 12 bytes.
>         Cooling Device
>                 Type: Fan
>                 Status: OK
>                 OEM-specific Information: 0x0000DD02
> 
> The "OEM-specific Information" seem to be pointers to other handles.

Yes it does.

> Those handles look like this:
> 
> Handle 0xDD02
>         DMI type 221, 19 bytes.
>         OEM-specific Type
>                 Header and Data:
>                         DD 13 02 DD 00 00 00 3A F0 04 FC 00 00 00 00
>                         00 00 62 F0
> 
> Maybe a recipe to gain access to that data.
> 
> Any ideas or hints?

Not really. All I can decode are the four first bytes: DD is the type
(221) and 13 is the length (19 bytes), 02 DD is the handle reference. So
the real data starts after that. But as said it is OEM-specific so
unless Dell tells you how to decode these bytes, it doesn't help in any
way.

Sorry I can't help you more.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
