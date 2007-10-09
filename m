From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Tue, 09 Oct 2007 19:16:22 +0000
Subject: Re: [lm-sensors] [ANNOUNCE] superiotool -- Detect Super I/Os,
Message-Id: <20071009191622.GK13822@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1850686284827442952=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20071008013540.GB12533@greenwood>
In-Reply-To: <20071008013540.GB12533@greenwood>
To: lm-sensors@vger.kernel.org


--===============1850686284827442952==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/HO4hzKTNbM1mOX"
Content-Disposition: inline


--j/HO4hzKTNbM1mOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2007 at 08:22:54PM +0200, Jean Delvare wrote:
> > It dumps the per-LDN register contents, not sure if that's the same as
> > the I/O space you're referring to? If no, then it's not supported, corr=
ect.
>=20
> No, that's not the same I/O space. What I'm talking about is the I/O
> space those address is typically stored in registers 0x60 and 0x61 for
> a given logical device.

Ah, ok. That's not printed by superiotool. Maybe we'll add that later
(but I don't think we need it for LinuxBIOS purposes, so we probably won't).


> > This is likely a _very_ chip-specific feature, so we need one extra
> > function with tons of custom printf's per chip. I'm not too sure if
> > this is really _that_ useful to warrant such an amount of work, but
> > we'll see...
>=20
> I don't know if it's worth the effort, but if not, then you should
> probably not print these values at all. They're available in the other
> dump format anyway.

Yes, if at all, the human-readable output should only print readable text.


> > > I've also hit a strange bug with -v (no kidding), I'll send a patch
> > > when I'm done fixing it.
> >=20
> > Yeah, known issue (if we're talking about the same one). See the thread
> > starting here http://linuxbios.org/pipermail/linuxbios/2007-October/025=
461.html
> > for a discussion and possible solutions. We haven't yet found the best
> > way to do it, but will have to choose one soonish.
>=20
> No, I didn't go that far. My concern was simply that strncpy is
> misused. strncpy doesn't null-terminate the string it copies, so you
> end up passing an invalid string to printf.

Ah, yes, that's likely the reason for random junk the the end of the
version number some people have noticed.


> I have a simple fix using atoi instead of the ugly strncpy/strlen mix
> you have:
>=20
>  superiotool.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> --- superiotool.orig/superiotool.c	2007-10-09 19:48:15.000000000 +0200
> +++ superiotool/superiotool.c	2007-10-09 19:53:43.000000000 +0200
> @@ -170,12 +170,7 @@ void probing_for(const char *vendor, con
> =20
>  static void print_version(void)
>  {
> -	char tmp[80];
> -
> -	strncpy((char *)&tmp,
> -		(const char *)&SUPERIOTOOL_VERSION[6],
> -		strlen(SUPERIOTOOL_VERSION) - 8);
> -	printf("superiotool r%s\n", (char *)&tmp);
> +	printf("superiotool r%d\n", atoi(&SUPERIOTOOL_VERSION[6]));

Yeah, that was my first thought, but IIRC atoi() is deprecated in favor
of strotol(), or at least it doesn't detect any errors (according to the
manpage), which strtol() does. Btw, atoi() has to ignore random non-digit
junk at the end of the string, is it guaranteed to do that in all
implementations (different libc's or platforms, e.g. *BSD, Solaris, etc)?

Also, _if_ the svn revision number gets too big, atoi()/strtol() will
"truncate" it (yes, this is more a theoretical issue, won't happen
anytime soon).


> I don't like your patch at all, BTW. At this point of complexity you
> have to admit that you're doing something wrong and give up ;) Why

Nah, never give up :)


> don't you use arbitrary version numbers as every other projects do?

We don't do tarball releases, so arbitrary 0.x version numbers aren't
that useful, and...


> This is much more valuable than SVN revision numbers, and much easier
> to maintain than what you're trying to do.

=2E..we want svn revisions as version number in order to be able to
exactly match a bug to a certain svn revision (and also to match dump
outputs to svn revisions).

Svn revision numbers are (if the solution works correctly) completely
maintenance-free, you don't have to change a single line of code, and
the number will be increased automatically upon every commit. A lot
easier than "manual" version number updates (which you'll forget often).

FWIW, it looks like this proposal is the best so far, so we'll probably
use it: http://linuxbios.org/pipermail/linuxbios/2007-October/025551.html
It gathers the svn version at build time (thus makes 'svnversion' a
build requirement, but we can live with that). Other than that it does
all we want, I think.


Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--j/HO4hzKTNbM1mOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHC9OGXdVoV3jWIbQRAoh7AJ4w2diVziIiMy14L4ZNqGmSk/FL0wCeKJLm
tvXOyLV91wszFBB0kAvqCkk=
=Rt8a
-----END PGP SIGNATURE-----

--j/HO4hzKTNbM1mOX--


--===============1850686284827442952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1850686284827442952==--
