From: "Peter Mahlknecht" <mali100@gmx.net>
Date: Sat, 01 Nov 2008 18:47:48 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081101184748.257530@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,=20
> Please try the following workaround: blacklist the i2c-i801 driver (or
> rmmod it before loading em28xx_cx25843.)
tested this, and it works: as long as i2c-i801 isn't loaded i get the right=
 temperatures, also if I have loaded em28xx_cx25843 or lm90 (or both).=20

> It would also be great if you could give a try to kernel 2.6.27 and
> report if you see the following message in the kernel logs:
>=20
> ACPI: * resource * [0x*-0x*] conflicts with ACPI region * [0x*-0x*]
> ACPI: Device needs an ACPI driver

I will try. Hope to get the new kernel working tonight

> For reference, please also attach the output of dmidecode on this
> laptop.
I wasn't shure if attaching works, so i put it on http://stud3.tuwien.ac.at=
/~e0526314/dmidecode_log

Peter Mahlknecht

--=20
GMX Download-Spiele: Preizsturz! Alle Puzzle-Spiele Deluxe =FCber 60% billi=
ger.
http://games.entertainment.gmx.net/de/entertainment/games/download/puzzle/i=
ndex.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
