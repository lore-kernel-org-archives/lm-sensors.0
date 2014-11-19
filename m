From: Eduardo Valentin <edubezval@gmail.com>
Date: Wed, 19 Nov 2014 12:03:22 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <20141119120320.GA10180@developer>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3025729432996991808=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1416321575-18348-1-git-send-email-edubezval@gmail.com>
 <1416321575-18348-2-git-send-email-edubezval@gmail.com>
 <20141119092139.1965e44e@amdc2363>
In-Reply-To: <20141119092139.1965e44e@amdc2363>
To: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


--===============3025729432996991808==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hey Lukasz,

On Wed, Nov 19, 2014 at 09:21:39AM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20

<big cut>=20

> >  }
>=20
> On which branch should I apply this patch?
>=20

This is based in my -linus branch. That means I will send this for the
next major window, not rc. The branch -fixes of thermal-soc include
patches for rc windows.

> I've tried to apply this patch on top of newest linux-soc-thermal/next:
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.=
git
> branch: next
> SHA1:4027494124fd88e5d51127eebba315de5d8d57c8
>=20
> Unfortunately, it conflicts with:
> "thermal: fix multiple disbalanced device node counters"
> c2aad93c Vladimir Zapolskiy

The -next branch is intended to contain patches for linux-next testing.
I include the content of -linus and -fixes together to be tested in
linux-next.

However, as this patch has not been merged yet into -linus, I haven't
rebuilt my -next branch.

>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbIb8AAoJEMLUO4d9pOJWkwgIAJVX3QS2UiIRUV9KeE20LzYW
cMcbbGVEbqn6Vib/XW9zarPN5djBUTmXU+qTUM6Z4794uRME53/rXtUaCwbocKtZ
fTjHnVMDHWQ//LDdXkwSgrfhbG8iYklo8MD4T6Er3Joec3BMv1JCo/GcM9n1d2Nr
1dm6CiKWIbLKAim+3kZhCQmEFLXIWB5lH9ZAPTCLfn9jXN156UHPUc5tKij01S9D
hIzhFFJ2mx7oQpiW3Ecj2Pq7zxHsvGTibi5RlWA3RcBTqYA3rAi50DTF0HWXvtCq
ydWgShJxpTGd/oKjyvyEd+6u9PstW8mxFpQ4zG3zcNFlLWMy7HwO85hVBlTfGXc=
=qst+
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--


--===============3025729432996991808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3025729432996991808==--
