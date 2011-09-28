From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 12:43:10 +0000
Subject: Re: [lm-sensors] Zotac ION ITX-G Synergy Edition
Message-Id: <20110928144310.3e490439@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
In-Reply-To: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 25 Sep 2011 11:12:08 -0700, Guenter Roeck wrote:
> On Sun, Sep 25, 2011 at 01:42:19PM -0400, Josu Lazkano wrote:
> > w83l771-i2c-0-4c
> > Adapter: SMBus nForce2 adapter at 4d00
> > temp1:       +54.0=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
> >                       (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
> > temp2:       +65.4=B0C  (low  =3D -40.0=B0C, high =3D +70.0=B0C)
> >                       (crit =3D +110.0=B0C, hyst =3D +100.0=B0C)

Glad it works :)

> > Are this temps for my GPU?
>
> No idea.

Given that the chip is on the SMBus and not the graphics chip I2C
channels, it is more likely to be monitoring come component on the main
board. That being said, with these small form factor machines, it's
hard to tell for sure. OTOH you may be able to get an answer from
Zotac, as I recall they have good technical documentation including
that kind of details.

> > I want to get USB voltage of my board, is this possible?
>
> sensors-detect did not find any known chips, so this is unlikely.=20
> The chipset seems to be NVIDIA MCP7A-ION, and Nvidia is not really
> known to publish much if anything about their chips.

If memory serves, the MCP7A embeds its own hardware monitoring sensors.
I seem to recall that someone (possibly Zotac themselves, but I'm not
sure so I won't blame anyone) was supposed to send me one of these
machines so that I can write a driver, but it never happened, so we
still don't have support.

Offer is still valid, BTW. If anyone sends me one of these Zotac
systems with the MCP7A, I'll write the driver.

> You could try to download and install linux drivers available from Zotac
> and/or from Nvidia, but I don't know if that would help. I did not find a=
=20
> linux hw monitoring driver to download anyway.

The documentation I have at hand suggests that the MCP7A only cares
about thermal management - temperatures and fans - not voltages. So
unfortunately it probably won't help Josu for USB voltage. Josu, you're
probably better off with an external voltmeter.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
