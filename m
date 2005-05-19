From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-patch2.4.22 => pb with alsa driver
Message-Id: <20040302125210.GA32322@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040301155624.GA30793@cereve.enpc.fr>
In-Reply-To: <20040301155624.GA30793@cereve.enpc.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Mar 02, 2004 at 01:17:40PM +0100, Jean Delvare wrote:
> Quoting Edouard Debry <debry@cereve.enpc.fr>:
>=20
> > > I don't think it is related to the i2c patch. I use alsa myself
> > > and never had any problem since the first i2c patch.
> >=20
> > hhmmm, so I do not know what the problem is, what means unresolved
> > symbols ?
>=20
> "depmod -ae" should tell you which symbols are missing. This should be a
> good hint to start with.

I used to run 'depmod -a' , I will try with -e option

>=20
> > I succesfully loaded the i810_audio module and the soundcore one
> > so this is not the pb
>=20
> What's the point in installing ALSA if you end up using the OSS driver
> for your audio chipset?

that is true, but at least I would like to understand what happenned
if you say it works, what was wrong with me ?

>=20
> --=20
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

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
