From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: bad vid value
Message-Id: <20040519083548.GA17267@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040519065553.GA16559@cereve.enpc.fr>
In-Reply-To: <20040519065553.GA16559@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks for replying so fast

On Wed, May 19, 2004 at 10:14:16AM +0200, Jean Delvare wrote:
>=20
> >I currently use sensors2.8.6 with kernel 2.6.6
> >
> >I use the chip 'W83627HF (ISA)', the module loaded are ( i2c_isa,
> >i2c_nforce, w83781d, i2c_sensor, i2c_core)
> >
> >all seems to work well, except that the min and max value of in0 and in1
> >are odd, approximately 1.41V for max although the average value for amd
> >duron proc is 1.5V
> >
> >to correct this I changed the vrm value as adviced ( with set vrm 9.0 )
> >but it did not change the vid value ( I did of course sensors -s after
> >each modification )
> >
> >I did not have this pb before, do you know what is going on ?
>=20
> I may have an idea.
>=20
> What lm_sensors/kernel combination were you using before? Which VRM
> version were you using?

before the combination was lm_sensors2.8.5 and kernel 2.6.4
and vrm was 9.0, min and max val were in a correct range

>=20
> >I also noticed that there is no /proc/sys/dev/../vid file,
> >for me all is located in /sys/bus/i2c/../(all files except vid)
>=20
> This file was (probably improperly) renamed in0_ref. This shoudn't be a
> problem as libsensors knows about the change and should read the value.
>=20
> lm_sensors 2.8.6 is known to have a problem with setting VRM value. This
> was fixed in CVS right after the release. Could you please try
> lm_sensors CVS and see if it helps?

I will see this

>=20
> >I noticed on your web site that the ship 'W83627HF (ISA)' has a specific
> >driver that is not the on I use, is this one better ? When running
> >'sensors-detect' I was not offered to load W83627HF ,
> >
> >can I safely replace  w83781d with W83627HF ?
>=20
> Yes, you can. The Winbond W83627HF on the ISA bus is supported by both
> drivers. Using the w83627hf driver is prefered though.

if I use only w83627hf driver ( which seems to work only through isa bus )
I think it is no longer needed to load i2c_nforce, i2c_isa should be
enough ?

>=20
> Jean
>=20
>=20
>=20
> --
> Jean "Khali" Delvare
> http://khali.linux-fr.org/

--=20
*-----------------------------------------------------------------*
|                          Edouard DEBRY                          |
| Ph-D student at E.N.P.C - C.E.R.E.A   http://www.enpc.fr/cerea/ |
|                                                                 |
| 21 Rue Nobel, Cit=E9 Descartes        TEL  : 33 1 64 15 21 52     |
| 77455 CHAMPS SUR MARNE              MAIL : debry@cerea.enpc.fr  |
|                                                                 |
| Thesis subject: MODELING OF AN ATMOSPHERIC AEROSOL DISTRIBUTION |
*-----------------------------------------------------------------*
