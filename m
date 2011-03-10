From: Robert Kaiser <kairo@kairo.at>
Date: Thu, 10 Mar 2011 20:08:28 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan RPM
Message-Id: <ilbb3t$sbb$1@dough.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Robert Kaiser schrieb:
> nct6775-isa-0290

> in1: +1.11 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
> in4: +1.02 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
> in5: +1.05 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
> in6: +1.08 V (min =3D +0.00 V, max =3D +0.00 V) ALARM

So I guess we don't know what they are and therefore they have the=20
default names and probably "bogus" values, right?

> fan2: 1110 RPM (min =3D 0 RPM, div =3D 32) ALARM

This is the CPU fan here, FWIW.

> SYSTIN: +39.0=B0C (high =3D +0.0=B0C, hyst =3D +0.0=B0C) ALARM sensor =3D=
 diode
> CPUTIN: +38.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C) sensor =3D dio=
de
> SMBUSMASTER 1: +54.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C) sensor =
=3D diode
> PCH_CHIP_CPU_MAX_TEMP: +65.0=B0C
> SMBUSMASTER 2: +0.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C)

What do those actually mean? Is there some doc about them that an=20
non-wizard like me can understand?

Robert Kaiser



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
