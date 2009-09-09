From: Dok Sander <doksander@yahoo.com>
Date: Wed, 09 Sep 2009 18:47:49 +0000
Subject: Re: [lm-sensors] cross-compiling for mips fails
Message-Id: <514792.17440.qm@web59303.mail.re1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <801433.83353.qm@web59310.mail.re1.yahoo.com>
In-Reply-To: <801433.83353.qm@web59310.mail.re1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I heard that mips doesn't have I/O ports so is this more of a problem with =
lm-sensors' cross-compiling compatibility(It shouldn't be looking for io.h =
at all)? lm-sensors doesn't provide configure and there aren't arent anythi=
ng related to cross-compiling. I know that Debian supports lm-sensors for m=
ips so it's possible to compile somehow. Hints/Patches, anyone?

--- On Mon, 9/7/09, Dok Sander <doksander@yahoo.com> wrote:

> From: Dok Sander <doksander@yahoo.com>
> Subject: cross-compiling for mips fails
> To: lm-sensors@lm-sensors.org
> Date: Monday, September 7, 2009, 6:42 PM
> Hi,
>=20
> I'm trying to cross-compile lm-sensors for mips.
> I'm using eglibc 2.10.1 as the main C library. I get the
> following error:
>=20
> make: *** No rule to make
> target `sys/io.h', needed by
> `prog/dump/superio.rd'.=A0 Stop.
>=20
> And checking the headers, sys/io.h does not exist. So this
> could be problem of eglibc instead. Has anyone else
> encountered this problem?
>=20
> =A0 Thanks
>=20
>=20
>=20
>      =20


     =20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
