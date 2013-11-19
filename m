From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Nov 2013 16:28:23 +0000
Subject: Re: [lm-sensors] question
Message-Id: <20131119162823.GA30481@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020214113146.O24643@Stimpy.netroedge.com>
In-Reply-To: <20020214113146.O24643@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Nov 19, 2013 at 04:38:25PM +0100, Ari Illikainen wrote:
> Could someone explain which sensor is for what and if you might think
> something is wrong.
> For me it seems strange that something at 22=B0C has a critical limit
> +112.0=B0C, while something at 70.0=B0C has a limit 90.0=B0C.
> In my logic the two 112=B0C limits should be for CPU0 and CPU1, but the o=
ther
> two is a bit of a mystery for me.
> Anyways something feels wrong about this, please help
>=20
> Adapter: Virtual device
> temp1:        +22.0=B0C  (crit =3D +112.0=B0C)
> temp2:        +79.0=B0C  (crit =3D +112.0=B0C)
> temp3:        +70.0=B0C  (crit =3D +90.0=B0C)
> temp4:        +71.0=B0C  (crit =3D +107.0=B0C)
>=20
Unfortunately, ACPI doesn't have the habit of actually explaining such read=
ings.
Best you can do is to extract and disassemble the DSDT, and hope that enough
information is in there to determine the sensors associated with those valu=
es.

What is the system ? Is this a laptop or a PC ? Also, what is the CPU ?

Guenter

> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +72.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
> Core 1:       +72.0=B0C  (high =3D +105.0=B0C, crit =3D +105.0=B0C)
>=20
> / Ari
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
