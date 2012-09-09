From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 09 Sep 2012 21:30:25 +0000
Subject: Re: [lm-sensors] [PATCH v4] linux/kernel.h: Fix DIV_ROUND_CLOSEST to support negative dividends
Message-Id: <20120909213025.GA2183@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346425339-17138-1-git-send-email-linux@roeck-us.net>
 <CAMuHMdWT2xKzOY9t05mYTMjmk=-V_XQQ8mZc69eQyrDN99hMuw@mail.gmail.com>
 <20120909161759.GA7998@roeck-us.net>
 <CAMuHMdUirbD8MjyZJfuHv6ht0iK5u2WJ3m0WanXsFQFWgcoPJw@mail.gmail.com>
In-Reply-To: <CAMuHMdUirbD8MjyZJfuHv6ht0iK5u2WJ3m0WanXsFQFWgcoPJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Sun, Sep 09, 2012 at 10:38:41PM +0200, Geert Uytterhoeven wrote:
> Hi G=FCnter,
>=20
> On Sun, Sep 9, 2012 at 6:17 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sun, Sep 09, 2012 at 04:57:34PM +0200, Geert Uytterhoeven wrote:
> >> On Fri, Aug 31, 2012 at 5:02 PM, Guenter Roeck <linux@roeck-us.net> wr=
ote:
> >> > DIV_ROUND_CLOSEST returns a bad result for negative dividends:
> >> >         DIV_ROUND_CLOSEST(-2, 2) =3D 0
> >> >
> >> > Most of the time this does not matter. However, in the hardware moni=
toring
> >> > subsystem, DIV_ROUND_CLOSEST is sometimes used on integers which can=
 be
> >> > negative (such as temperatures).
> >>
> >> This seems to cause 3 new warnings in my m68k builds of v3.6-rc5:
> >>
> >> drivers/hwmon/mcp3021.c:76: warning: comparison is always true due to
> >> limited range of data type
> >> drivers/ide/ide-cd.c:1158: warning: comparison is always true due to
> >> limited range of data type
> >> drivers/ide/ide-cd.c:1159: warning: comparison is always true due to
> >> limited range of data type
> >>
> >> $ m68k-linux-gnu-gcc -v
> >> Using built-in specs.
> >> Target: m68k-linux-gnu
> >> Configured with: ../src/configure -v --enable-languages=3Dc,c++
> >> --prefix=3D/usr --enable-shared --with-system-zlib --libexecdir=3D/usr=
/lib
> >> --without-included-gettext --enable-threads=3Dposix --enable-nls
> >> --with-gxx-include-dir=3D/usr/m68k-linux-gnu/include/c++/4.1.2
> >> --program-suffix=3D-4.1 --enable-__cxa_atexit --enable-clocale=3Dgnu
> >> --enable-libstdcxx-debug --disable-libssp --disable-werror
> >> --enable-checking=3Drelease --program-prefix=3Dm68k-linux-gnu-
> >> --includedir=3D/usr/m68k-linux-gnu/include --build=3Dx86_64-linux-gnu
> >> --host=3Dx86_64-linux-gnu --target=3Dm68k-linux-gnu
> >> Thread model: posix
> >> gcc version 4.1.2 20061115 (prerelease) (Ubuntu 4.1.1-21)
> >>
> > The "always true" condition is on purpose to cause the compiler to opti=
mize the
> > expression away. I don't see the warnings myself, on none of the target=
s I am
> > building (x86, ppc, arm, mips), but then I am using much more recent co=
mpiler
> > versions. Odd is that you only see the warnings on "u16" and not elsewh=
ere.
> >
> > I don't immediately see the warnings with a more recent m68k compiler (=
4.6.3),
> > nor with any other target (x86, ppc, arm, mips) in my nightly builds.
>=20
> I also don't see it in any of the linux-next builds of v3.6-rc5. So
> probably it's just
> a gcc 4.1.2 issue...
>=20
> > Can you send me your configuration ?
>=20
> The ide-cd one shows up in any config that enables ide-cd, incl. defconfi=
g and
> allmodconfig.
> The mcp3021 one I only see in allmodconfig.
>=20
I tried both and did not see the problem. I agree, it does look like a comp=
iler
version problem.


> > Also, do you know where I can find the Ubuntu/Debian package for your c=
ompiler
> > version, by any chance ?
>=20
> It's not from an official binary package. I built the cross-compiler
> from the then
> current gcc 4.1.1-21 sources in Ubuntu.
>=20
Ok.=20

Just in case you are interested, I installed the m68k cross-compiler from
	deb http://www.freewrt.org/~tg/debs68k/ cross main

For my other targets, I use Yocto builds.

I think I'll let this go as false positive for now, unless there are proble=
ms
with more recent compilers.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
