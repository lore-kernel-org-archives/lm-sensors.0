From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 13 Feb 2008 14:00:52 +0000
Subject: Re: [lm-sensors] Funky temperature readings
Message-Id: <20080213140052.GC17512@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <fostpj$q3h$2@saturn.local.net>
In-Reply-To: <fostpj$q3h$2@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello:

* Per Jessen <per@computer.org> [2008-02-12 20:58:43 +0100]:
> I've got a new Gigabyte board with the AMD 790FX chipset and an AMD Pheno=
m quad-core CPU. =20
>=20
> After having loaded it87, I get three temperature readings - but the  BIO=
S itself=20
> is only showing two.  Is this "normal" ?  The third temp reading is quite=
=20
> high - usually 84-86C.=20
>=20
> sensors
> it8718-isa-0228
> Adapter: ISA adapter
> in0:         +1.07 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +1.90 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in2:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in3:         +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in4:         +3.07 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in5:         +3.22 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in7:         +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in8:         +3.10 V
> fan1:       2566 RPM  (min =3D    0 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:       1896 RPM  (min =3D    0 RPM)
> fan5:          0 RPM  (min =3D    0 RPM)
> temp1:       +44.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> temp2:       +39.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D thermal diode
> temp3:       +84.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  senso=
r =3D transistor
> cpu0_vid:   +0.000 V
>=20
> sensors-detect reports:
>=20
> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus, address 0x228
>     Chip `ITE IT8718F Super IO Sensors' (confidence: 9)
>=20
> Driver `to-be-written' (should be inserted):
>   Detects correctly:
>   * Chip `AMD K10 thermal sensors' (confidence: 9)
>=20

Your questions are answered here:

http://lm-sensors.org/wiki/FAQ/Chapter2#DoIneedtheconfigurationfileetcsenso=
rs.conf

You will need to modify /etc/sensors.conf to suit your board.  There are
copious instructions at the top of that file.  If you get stuck, feel
free to reply again w/ specific questions.  HTH.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
