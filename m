From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 10 Jun 2011 19:31:21 +0000
Subject: Re: [lm-sensors] [GIT] kbuild fixes for 3.0
Message-Id: <20110610213121.7aa12662@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110609214241.GA4849@sepie.suse.cz>
	<BANLkTim84t=yeqykZydEjHrVYGnO4xc5ew@mail.gmail.com>
	<BANLkTi=qaA_AMvq_78eon3Lr86wT2R497g@mail.gmail.com>
	<BANLkTinbXpFp43+EebWbWvs1Uu5wWvhxQQ@mail.gmail.com>
	<BANLkTinKMmYG7=KBHr2LfOYzcgbtszwy5g@mail.gmail.com>
	<BANLkTinQ2mL1eNPzMHjDjXnLyv58annZmA@mail.gmail.com>
	<BANLkTi=wQaUSagZjptGnvUHNpJeMm0C6yw@mail.gmail.com>
	<BANLkTinA2S55fn5nNb1WOo=T0dKX3cBzfQ@mail.gmail.com>
In-Reply-To: <BANLkTinA2S55fn5nNb1WOo=T0dKX3cBzfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: lm-sensors@lm-sensors.org, Michal Marek <mmarek@suse.cz>, pefoley2@verizon.net, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org

Salut Arnaud,

On Fri, 10 Jun 2011 12:30:59 -0400, Arnaud Lacombe wrote:
> On Fri, Jun 10, 2011 at 1:16 AM, Arnaud Lacombe <lacombar@gmail.com> wrot=
e:
> > I totally agree! But, it is a technical challenge to give a 2 digit
> > version number to an application expecting a 3 digit version number
> > without much control over its environment.
> >
> > Beside that, no matter what, you are about to break
> > `/usr/sbin/sensors-detect' (from my Fedora 14), which rely on a 3
> > digits version number:
> >
> > # [0] -> VERSION
> > # [1] -> PATCHLEVEL
> > # [2] -> SUBLEVEL
> > # [3] -> EXTRAVERSION
> > #
> > use vars qw(@kernel_version $kernel_arch);
> >
> > sub initialize_kernel_version
> > {
> > =A0 =A0 =A0 =A0`uname -r` =3D~ /(\d+)\.(\d+)\.(\d+)(.*)/;
> > =A0 =A0 =A0 =A0@kernel_version =3D ($1, $2, $3, $4);
> > =A0 =A0 =A0 =A0chomp($kernel_arch =3D `uname -m`);
> >
> > =A0 =A0 =A0 =A0# We only support kernels >=3D 2.6.5
> > =A0 =A0 =A0 =A0if (!kernel_version_at_least(2, 6, 5)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "Kernel version is unsupported (to=
o old, >> > 2.6.5 needed)\n";
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit -1;
> > =A0 =A0 =A0 =A0}
> > }
> >
> `sensors-detect's kernel version detection regexp is unable to parse 2
> digits kernel version number and dies with:
>=20
> [From Fedora 14's /usr/sbin/sensors-detect]
>=20
> Use of uninitialized value $kernel_version[0] in numeric gt (>) at
> ./sensors-detect line 2442.
> Use of uninitialized value $kernel_version[0] in numeric eq (=3D) at
> ./sensors-detect line 2442.
> Kernel version is unsupported (too old, >=3D 2.6.5 needed)
>=20
> I just checked the SVN repository, the issue still seems to be
> present. I am not sure if other lm-sensors part are affected. This
> will becomes an issue with the upcoming 3.x kernel serie.

Does the following patch help?

Index: prog/detect/sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/sensors-detect	(r=E9vision 5979)
+++ prog/detect/sensors-detect	(copie de travail)
@@ -2462,8 +2462,8 @@
=20
 sub initialize_kernel_version
 {
-	`uname -r` =3D~ /(\d+)\.(\d+)\.(\d+)(.*)/;
-	@kernel_version =3D ($1, $2, $3, $4);
+	`uname -r` =3D~ /(\d+)\.(\d+)(?:\.(\d+))?(.*)/;
+	@kernel_version =3D ($1, $2, $3 || 0, $4);
 	chomp($kernel_arch =3D `uname -m`);
=20
 	# We only support kernels >=3D 2.6.5

I don't expect any other breakage in lm-sensors, but I certainly do in
other packages. For example the function above exists in script
i2c-stub-from-dump in package i2c-tools too.

Honestly, this whole 2-digit kernel version seems like a major and
better avoided pain. The first stable series kernel for 3.0 will be
3.0.1, so it will have 3 digits again. Which means that in practice,
most distributions and users will still be running kernels with 3-digit
versions. Breaking dozens of scripts for what will end up being a mere
corner case seems silly to me. We all have better things to do than to
fix random user-space scripts, don't we?

I fail to see how numbering the next kernel "3.0" will make it any
cooler than numbering it "3.0.0". Especially when nobody will run it
for longer than 2 weeks.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
