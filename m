From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 23 Apr 2008 21:27:52 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <480FA9D8.80400@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> 0xA is the size, 0x290 + 0xA - 1 = 0x299 is the last I/O port. Nothing
> wrong here from a mathematical point of view (but this I/O range makes
> no sense from a hardware point of view.

Aha good point. Seems I forgot about last -1. Sorry.

>> [   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI
>> region HWRE [0x290-0x299]
>>
>> The ATK driver has no extra funcs then the classic driver so I think you can use
>>  what you have right now.
> 
> You mean that without the ATK0110 driver _nothing_ will access the I/O
> range? How can you be so sure?

Yes I can be sure beacuse I checked the DSDT. There is no thermal zone, only the
proprietary ATK methods to read the chip. Nothing calls them. Gabriel could do
modprobe thermal ; acpi -V and it should not print any temperature info.

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFID6nY3J9wPJqZRNURAsmLAKCV0H/6FU4lmT3rPS4WUmwEZLtvJACgumUr
rIQsVkivjRW6vorKpRom/eo=Oos8
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
