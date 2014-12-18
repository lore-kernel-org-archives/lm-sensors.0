From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Dec 2014 18:17:01 +0000
Subject: Re: [lm-sensors] System Monitor cannot read sensors anymore
Message-Id: <20141218181701.GA19594@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <m6bv17$gsp$1@ger.gmane.org>
In-Reply-To: <m6bv17$gsp$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Dec 18, 2014 at 05:49:19PM +0100, Jean Delvare wrote:
> Le Thursday 18 December 2014 =E0 16:33 +0000, Richard Llom a =E9crit :
> > Jean Delvare wrote:
> > > Le Thursday 18 December 2014 =E0 12:29 +0000, Richard Llom a =E9crit :
> > >> Jean Delvare wrote:
> > >>> On Thu, 11 Dec 2014 16:06:02 +0100, Richard Llom wrote:
> > >> Or ksysguard actually doesn't use libsensors at all and is looking f=
or
> > >> the information in the wrong place?
> > >=20
> > > When the libsensors API changed (from lm-sensors 2.x to 3.x), we
> > > converted ksysguard:
> > > http://www.lm-sensors.org/wiki/Libsensors4AppSupport
> > >=20
> > Aha, good to know.
> >=20
> > > So back then they certainly did use libsensors. I checked version 4.3=
.5,
> > > which is what's available on my system, and it does link against
> > > libsensors.so.4. Can you check the output of:
> > > $ ldd /usr/bin/ksysguardd
> > > (or whatever the path is on your system)?
> > >=20
> > $ ldd /usr/bin/ksysguardd
> >         linux-vdso.so.1 (0x00007fff49132000)
> >         libc.so.6 =3D> /usr/lib/libc.so.6 (0x00007f5f72de8000)
> >         /lib64/ld-linux-x86-64.so.2 (0x00007f5f7318b000)
>=20
> OK, so apparently they stopped using libsensors at some point. Which was
> a very bad idea, as you just found out. Please report to them.
>=20
On my system (Ubuntu 14.10):

ldd /usr/bin/ksysguardd
        linux-vdso.so.1 =3D>  (0x00007fffc51fe000)
	libsensors.so.4 =3D> /usr/local/lib/libsensors.so.4 (0x00007f19f8e05000)
	libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007f19f8a40000)
	libm.so.6 =3D> /lib/x86_64-linux-gnu/libm.so.6 (0x00007f19f8739000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f19f903c000)

with

/usr/bin/ksysguardd --version
ksysguardd 4
(c) 1999, 2000, 2001, 2002 Chris Schlaeger <cs@kde.org>
(c) 2001 Tobias Koenig <tokoe@kde.org>
(c) 2006-2008 Greg Martyn <greg.martyn@gmail.com>
This program is part of the KDE Project and licensed under
the GNU GPL version 2. See http://www.kde.org for details.
Usage: /usr/bin/ksysguardd [-d] [-i] [-p port]

dpkg also shows a dependency of ksysguardd on libsensors.

Package: ksysguardd
Source: kde-workspace
Version: 4:4.11.12-0ubuntu1.1
Depends: libc6 (>=3D 2.15), libsensors4 (>=3D 1:3.0.0)

Maybe there are different versions and/or build options ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
