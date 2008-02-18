From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 18 Feb 2008 03:07:31 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add TjMax detection for
Message-Id: <20080218030731.GF2916@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <478FE918.9030804@assembler.cz>
In-Reply-To: <478FE918.9030804@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf:

* Rudolf Marek <r.marek@assembler.cz> [2008-02-17 22:59:39 +0100]:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi Jean,
>=20
> Thanks for the review. Here it comes updated. I managed to get to test th=
is on
> core2 system:
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +50.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +51.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> Seems to work ;)
>=20
> Hello,
>=20
> Following patch will finally solve the detection of Intel Mobile CPUs whi=
ch
> share same CPUID with Desktop/Server CPUs. We need this information to te=
st
> some bit so we know if TjMax is 100C or 85C. Intel claims this works for =
mobiles
> only, respect that and set for desktops the TjMax to 100C. Intel provided=
 some
> table on their wiki based on my chat with them at:
> http://softwarecommunity.intel.com/isn/Community/en-US/forums/30247249/Sh=
owThread.aspx#30247249
>=20
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Applied to hwmon-2.6.git/testing, thanks.

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
