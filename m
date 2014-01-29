From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Jan 2014 19:55:28 +0000
Subject: Re: [lm-sensors] Reading SPD on Intel Patsburg on Supermicro X9SRG-F board
Message-Id: <20140129205528.26841067@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
In-Reply-To: <87E51E09-C340-4A00-9DF2-1673EDF47F45@badgerous.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 29 Jan 2014 11:48:47 -0800, Alun Evans wrote:
> >> This is a big board with many DDR3 slots.
>=20
> Heh, this is a 8-DIMM board. We=92ve just ordered a 24-DIMM board, with a=
n eye to a 48-DIMM board.

Right, 8 DIMMs would normally not require multiplexing. But vendors
like to reuse designs and your 8-DIMM board is probably a "small"
version of something bigger. My Asus Z8NA-D6 has only 6 DIMMs but it
has an I2C multiplexer anyway.

> > (...)
> > I would suspect it is GPIO; the i2c muxes are typically at address 0x7x
> > which is empty in above i2cdetect log. The DSDT might give a hint if we
> > are really lucky. Not that I am any good in decoding DSDTs, though ;-).
>=20
> I followed : https://01.org/linux-acpi/utilities
>=20
> And there is this hunk:
>=20
>     OperationRegion (GPIO, SystemIO, GPBS, 0x20)
>     Field (GPIO, DWordAcc, NoLock, Preserve)
>     {
>         Offset (0x0C),=20
>         GLVL,   32,=20
>         Offset (0x18),=20
>         GBLK,   32
>     }

And can you tell us what GPBS is?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
