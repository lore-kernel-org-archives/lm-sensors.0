From: benoit.plessis@tuxfamily.org (Benoit Plessis)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: lm_sensors && Asus ASB100
Message-Id: <1062450328.1525.227.camel@osiris>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
In-Reply-To: <Pine.LNX.4.44.0307161343280.790-100000@anubis.univ-lemans.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

finally i got something working at least on my 2 Asus based mainboards.
i moved the as99127f support out of w83781d.c to a new as99127f.c and
added the specific part for ASB100.=20
I also added the adjusting fan_div algorithm from mbmon in init_client
but he still fail sometimes.
I started the support of Mozart-2 chip but it seems to need some=20
special fixup in the smb bus and i don't have any chip of this kind so i
can't test.

So there it is, in 3 files =20
patch-as99127f.diff.gz is to be applied to the lm_sensors2 cvs=20
patch-as99127f-i2c.diff.gz to the i2c cvs, and
as99127f.c.gz to be extracted in the directory kernel/chips from
lm_sensors2.

Le ven 18/07/2003 ? 14:35, Jean Delvare a ?crit :
> > > Why not. The first step IMHO would be to have a separated prefix for
> > > the asb100. It is currently handled as an as99127f. Then we could
> > > see what can be done to support the asb100 better.
> >=20
> > The total of our support for ASB100 right now is to pretend that it's
> > an as99127f.  If we're going to do more than that, my vote is to put
> > it into a different file altogether.  Rationale...
>=20
> Agreed. And as99127f support could even go into the new driver.
>=20
> > > One of our users, Bryan Almeda,  already made some work in this
> > > direction. His work is avilable there:
> > >   http://tynian.net/asb100/
> > > Please test his patch and tell us how it works for you.
> >=20
> > .. it breaks as99127f, as he mentioned.  Also, w83781d doesn't really
> > want to support yet another unique sensor chip. =20
> >=20
> > (BTW, I haven't looked at the patch yet.)
>=20
> I never intended to apply the patch to our sources. I just wanted to
> know how it was working on the ASB100.
--=20
Benoit Plessis					+33 6 77 42 78 32
<benoit . plessis @ tuxfamily . org>
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Ceci est une partie de message
	=3D?ISO-8859-1?Q?num=E9riquement?=3D =3D?ISO-8859-1?Q?_sign=E9e?Url : http=
://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030901/cca2849a/=
attachment.bin
