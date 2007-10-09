From: Uwe Hermann <uwe@hermann-uwe.de>
Date: Tue, 09 Oct 2007 17:54:24 +0000
Subject: Re: [lm-sensors] [ANNOUNCE] superiotool -- Detect Super I/Os,
Message-Id: <20071009175424.GI13822@greenwood>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4527139445718633008=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20071008013540.GB12533@greenwood>
In-Reply-To: <20071008013540.GB12533@greenwood>
To: lm-sensors@vger.kernel.org


--===============4527139445718633008==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 09, 2007 at 07:14:29PM +0200, Jean Delvare wrote:
> >      LDN 0x0a (ACPI)
> >      idx 30 70 e0 e1 e2 e3 e4 e5 e6 e7 e8 f2 f3 f4 f6 f7=20
> >      val 01 00 00 00 ff 00 40 02 0c 10 09 7d 00 00 00 00=20
> >      def 00 00 01 00 ff 08 00 RR 00 00 RR 7c 00 00 00 00=20
> >      LDN 0x0b (Hardware monitor)
> >      idx 30 60 61 70 f0 f1=20
> >      val 01 02 90 00 c1 3f=20
> >      def 00 00 00 00 c1 00
> >=20
> >   All numbers are in hex. idx is the register number, val is the current
> >   content of the register, def is the default value as per datasheet.
> >=20
> >   I assume the dump feature might help with lm-sensors development, as
> >   you can easily dump the hardware monitor register contents (or have
> >   users send dumps) and compare values from different boards/chips etc.
>=20
> We tell users to use isadump for that. As isadump is part of the
> lm-sensors package, we can be reasonably certain that it is available
> to the users. And more often than not, we need the dump of the
> LDN-specific I/O space, which superio doesn't support as far as I can see.

It dumps the per-LDN register contents, not sure if that's the same as
the I/O space you're referring to? If no, then it's not supported, correct.


> Two things I've noticed while trying superiotool:
>=20
> * The human-readable dump of my F71805FG chip includes:
> 27=3D20
> 29=3D00
> 2a=3Dff
> 2b=3Dff
> That's not exactly human-readable by my definition ;)

Yeah, that was the initial format in the very early days, the plain
register dump feature came later and we redeclared the old format
to be the "human-readable" format for now (but it really needs lots of
improvements, and isn't available for all chips anyway).

This is likely a _very_ chip-specific feature, so we need one extra
function with tons of custom printf's per chip. I'm not too sure if
this is really _that_ useful to warrant such an amount of work, but
we'll see...


> * When dumping a Winbond W83627THF chip, sometimes the default value is
> replaced with NA, MM or RR. While I can imagine what NA stands for, I
> am curious what MM and RR mean. This should be explained in the manual
> page IMHO.

Yes, the documentation needs improvements.

NA =3D None available (refers to the default register value from the datash=
eet)
RR =3D Reserved (register is marked as "Reserved" in the datasheet)
MM =3D Misc.

The NA vs. MM usage is not consistent at the moment. MM is meant for
default values which cannot be expressed as a simple hex number
(stuff like "Bit 3 is 1 if SYSCF is pulled-up, bit 7 is 0 except
on full moons, the remaining bits are 1").

Ideally, we'll implement a sort of "footnotes" for MM entries where
the specifics are explained (in the superiotool output), but that's not
possible, yet. It's also debatable whether it's useful to do that work
if you can just look into the respective datasheet for MM values.


> I've also hit a strange bug with -v (no kidding), I'll send a patch
> when I'm done fixing it.

Yeah, known issue (if we're talking about the same one). See the thread
starting here http://linuxbios.org/pipermail/linuxbios/2007-October/025461.=
html
for a discussion and possible solutions. We haven't yet found the best
way to do it, but will have to choose one soonish.


Uwe.
--=20
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHC8BQXdVoV3jWIbQRAlMXAKCNYxZUuh7hbknw5wNS0ZPiYDNNCgCdGorw
6wHBEiD5HKxhwlexiQi/+Xk=
=XXkz
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--


--===============4527139445718633008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4527139445718633008==--
