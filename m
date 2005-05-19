From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: lm_sensors support ticket #1366
Message-Id: <20030826215125.17041e57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> > Thanks a lot for the feedback, it's very appreciated. I fixed the
> > patches in a similar way, I hope the new patches are OK. I also
> > setup a mirror of my installation guide here:
> >   http://delvare.free.fr/i2c/
> > (You've got some credit there, since you almost wrote the patch
> > yourself.)
> >=20
> > Let me know if you need further assistance.
>=20
> I'm getting a kernel exception:
>=20
> lirc_dev: lirc_unregister_plugin:plugin lirc_i2c[0] in use!<1>Unable
> to handle kernel paging request at virtual address e2a37a1c
>  printing eip:
>  e297bf12
>  *pde =3D 1ea3d067
>  *pte =3D 00000000
>  Oops: 0000
>  CPU:    0
>  EIP:    0010:[<e297bf12>]    Tainted: P=20
>  EFLAGS: 00010296
>  eax: c15ab7d8   ebx: e2a379f4   ecx: 00000246   edx: 00000008
>  esi: d4cdbfe0   edi: 00000000   ebp: 00000003   esp: d4cdbf5c
>  ds: 0018   es: 0018   ss: 0018
>  Process lirc_dev (pid: 1702, stackpage=D4cdb000)
>  Stack: c15ab780 d4cdbfe0 00000000 e29f6040 dc493b40 00000000 d4cdbfa8
>  0005295b=20
>         00000000 c02a4000 d9841080 00000000 00000246 d4cdbfa8 c01162e0
> 	e29f8190=20
>         c15ab7d8 d4cdbfb0 00000003 c15f3fc0 d4cdbfe0 0005295b
>         e29f419c c15ab780=20
>       Call Trace:    [<e29f6040>] [<c01162e0>] [<e29f8190>]
>       [<e29f419c>] [<e29f6040>]
>       [<c01070bf>] [<c01070c8>] [<e29f6040>]
>=20
>  Code: 8b 43 28 83 78 28 00 0f 84 a1 00 00 00 8b 54 24
>  40 0f b7 42=20
>=20
> This is how to reproduce:
>=20
> modprobe lirc_i2c
> /etc/init.d/lirc start
> modprobe ivtv
> rmmod ivtv
>=20
> I'm guessing something bad happens when lirc_i2c tries to unregister
> the happauge remote (from ivtv), but it's in use by the lircd daemon?
> If I don't start the lircd daemon, it works fine...
>=20
> Any hints? Could the problem lie with the ivtv driver?

I use neither ivtv nor lirc, so I don't really know who does what, and I
can't test either.=20

What if you remove MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT from
set_use_inc and set_use_dec respectively? That's almost the only idea I
have right now, and I don't really have time to work on it.

--=20
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
