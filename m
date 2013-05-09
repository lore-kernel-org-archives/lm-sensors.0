From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:51:10 +0000
Subject: Re: [lm-sensors] [nct6775] Asus P8Z77-M Pro (#8)
Message-Id: <20130509175110.GB30549@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130509172045.GA7593@roeck-us.net>
In-Reply-To: <20130509172045.GA7593@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, May 09, 2013 at 10:20:45AM -0700, Guenter Roeck wrote:
> Hi Andre,
>=20
[ ... ]
> > CPUTIN:                 +27.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=
=B0C)  sensor =3D thermistor
> > AUXTIN0:               +101.0=B0C  (high =3D  +0.0=B0C, hyst =3D +64.0=
=B0C)  sensor =3D thermistor
> > AUXTIN1:               +105.0=B0C  (high =3D +75.0=B0C, hyst =3D  +0.0=
=B0C)  sensor =3D thermistor
> > AUXTIN2:               +105.0=B0C  (high =3D +64.0=B0C, hyst =3D +26.0=
=B0C)  sensor =3D thermistor
> > AUXTIN3:                +16.0=B0C  (high =3D  +0.0=B0C, hyst =3D +27.0=
=B0C)  sensor =3D thermal diode

[ ... ]
>=20
> > * `AUXTIN0/1/2` has unrealistic values (i don't know what AUXTIN is)
>=20
> AUXTINx are temperature sensor input pins on the NCT6779.
>=20
> Most likely you see odd values because the sensors are not connected to a=
nything
> on the board. I'll have a look into the driver to make sure the limit reg=
isters
> are correct; I am a bit concerned about the odd values for both "high" an=
d "hyst".
>=20
Followup: Turs out there should be no "high" and "hyst" attributes for AUXT=
IN[0-3].
I pushed a patch into the stand-alone driver a couple of minutes ago.
Can you give it a try to make sure it works ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
