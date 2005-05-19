From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: bad vid value
Message-Id: <20040524122930.GA4924@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040519065553.GA16559@cereve.enpc.fr>
In-Reply-To: <20040519065553.GA16559@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, May 19, 2004 at 11:38:08AM +0200, Jean Delvare wrote:
>=20
> >> Yes, you can. The Winbond W83627HF on the ISA bus is supported by both
> >> drivers. Using the w83627hf driver is prefered though.
> >
> >if I use only w83627hf driver ( which seems to work only through isa bus=
 )
> >I think it is no longer needed to load i2c_nforce, i2c_isa should be
> >enough ?
>=20
> Correct. Even with the w83781d driver, it was already the case. You need
> the i2c-nforce2 driver if and only if you access the hardware monitoring
> chip as an  I2C device. Since it seems that you are accessing it as an
> ISA device, i2c-isa alone is enough.
>=20
> Jean

the vid value got correct with CVS version

I tried to load w83627hf driver but it failed with  'no such device'
whereas it works well with i2c_isa and w83781d

this means that the w83627hf driver tries to access devices that
do not exist on my PC, could someone tell me which device nodes=20
have to be created ? or which option the driver need to get the right
device ?

thanks in advance
edouard

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
