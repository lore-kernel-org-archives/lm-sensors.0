From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: w83l950d
Message-Id: <20040914151531.M71377@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <333A0A4FF2FA7E4D9528E127824C2184DA2A0B@FITMS200MB.tcad.telia.se>
In-Reply-To: <333A0A4FF2FA7E4D9528E127824C2184DA2A0B@FITMS200MB.tcad.telia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> sensor compability list says that winbond W83L950D -chipset (aka=20
> uGuru) is unsupported, and no data sheet available. However I just=20
> browsed Winbond-page and saw datasheet as PDF.
>=20
> http://www.winbond.com/e-winbondhtm/partner/PDFResult.asp?Pname=926
>=20
> I cannot say if this is sufficient documentation for lmsensors to=20
> build a support, but it has memory maps, bit registers etc.

It is unfortunately not sufficent, and this is the problem. The W83L950D is
basically an empty box (technically, a set of GPIO pins). What it can do and
how it does it solely depends on what is wired on the pins.

As I understand it, the uGuru is a set of different chips connected to and
controlled through the W83L950D. Without details on how all this works from
Abit, there's nothing we can do.

I admit that the explanations on our New Drivers page are confusing,
especially since we pretend we don't have a datasheet for the W83L950D. I w=
ill
update the page, thanks for pointing this out.

--=20
Jean Delvare
http://khali.linux-fr.org/
