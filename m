From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-patch2.4.22 => pb with alsa driver
Message-Id: <20040302113857.GA32158@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040301155624.GA30793@cereve.enpc.fr>
In-Reply-To: <20040301155624.GA30793@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Mar 01, 2004 at 05:06:44PM +0100, Jean Delvare wrote:
> Quoting Edouard Debry <debry@cereve.enpc.fr>:
>=20
> > so I patched the original kernel 2.4.22 source with that patch, and
> > recompiled with same options that went well before,
> > the kernel booted correctly, I re-installed alsa driver (v0.9.6), as
> > there are not in kernel 2.4.xx by default, but when running 'depmod
> > -a' I had plenty of unresolved symbols which were dealing only with
> > alsa drivers !!!
>=20
> I don't think it is related to the i2c patch. I use alsa myself and
> never had any problem since the first i2c patch.
>=20

hhmmm, so I do not know what the problem is, what means unresolved
symbols ?

> > so I wonder if this is due to the patch, which means incompatibility
> > between i2c 2.8.4 and alsa v0.9.6, or I did not choose right options
> > !!
>=20
> More likely, you forgot to enable soundcore in your kernel.
>=20

I succesfully loaded the i810_audio module and the soundcore one
so this is not the pb

> --=20
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

thanks for your answeer
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
