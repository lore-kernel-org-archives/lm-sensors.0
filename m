From: Forest Bond <forest@alittletooquiet.net>
Date: Fri, 05 Sep 2008 18:45:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <20080905184519.GB9884@storm.local.network>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7564074397051261706=="
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============7564074397051261706==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 10, 2008 at 08:08:16AM +0200, Wilken Gottwalt wrote:
> Am Montag 07 Juli 2008 19:29:00 schrieb Juerg Haefliger:
> > > Am Montag 07 Juli 2008 08:11:02 schrieb Juerg Haefliger:
> > >> >> Wilken, what motherboard is this? Are there any BIOS settings
> > >> >> (thermal management) that you can play around with? Try different
> > >> >> thermal management settings and rerun cpuid and check if the ther=
mal
> > >> >> monitors show up as 'true'.
> > >> >> I have a cpuid dump from Sergio (C7 on a LN10000 board) and the o=
nly
> > >> >> difference between his dump and yours is that his shows 'true' for
> > >> >> both thermal monitors. Maybe your BIOS disables these features on
> > >> >> your CPU.
> > >> >
> > >> > It's the Artigo-Box from Via with a PX10000 board
> > >> > (http://www.via.com.tw/en/products/embedded/artigo/).
> > >> > No, there are no bios settings dealing with thermal or power
> > >> > management. There is nothing I can play with. The bios is very
> > >> > rudimentary.

[...]

> > I'll try to get some answers from VIA but I'm out of ideas. Looks like
> > your CPU doesn't have those thermal sensors.
>=20
> This is weird, it's a plain C7.

Anybody get anywhere with this?  I'm trying to get some useful data out of =
the
Pico-ITX boards as well.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIwX4/RO4fQQdv5AwRAn8IAJ9bGf9fi1uQk/CWK2qr4kLD3L8ALQCcDbuE
51/ky2TP+dD28iQOxm6Dd5c=
=X839
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--


--===============7564074397051261706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7564074397051261706==--
