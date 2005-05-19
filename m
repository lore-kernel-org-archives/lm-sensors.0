From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-patch2.4.22 => pb with alsa driver
Message-Id: <20040301155624.GA30793@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hello,

I currently run the slackware 9.1 ( with original kernel 2.4.22 )
I heard about the new lm_sensors release (2.8.4) and also the i2c patch
for kernel 2.4.22 in order to bring i2c system up to 2.8.4 version
"Patch set for the 2.4.22 kernel (i2c-2.8.4):"

so I patched the original kernel 2.4.22 source with that patch, and
recompiled with same options that went well before,
the kernel booted correctly, I re-installed alsa driver (v0.9.6), as
there are not in kernel 2.4.xx by default, but when running 'depmod -a'
I had plenty of unresolved symbols which were dealing only with alsa
drivers !!!

so I wonder if this is due to the patch, which means incompatibility
between i2c 2.8.4 and alsa v0.9.6, or I did not choose right options !!
that is to note I did the same with previous i2c2.8.2 patch and
everything went well ( even after re-installing alsa)

I did not know that alsa needed i2c, so I was really not expecting this kind
of pbs,

********
I have some ideas to remedy the pb, like recompiling a new version of alsa,
but before I would have liked your advices :=20
what do you think the pb is and what would you do ?

The point is that patch for i2c2.8.2 is no more available ( or I did not
notice it) so that I cannot install another version of lm_sensors !!!

best regards
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
