From: Simon Guinot <simon@sequanux.org>
Date: Fri, 22 Oct 2010 08:27:12 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] [ARM] Kirkwood: add fan support for
Message-Id: <20101022082712.GU29120@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0191344927883593262=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287330612-11256-2-git-send-email-simon@sequanux.org>
	<1287712396.9690.378.camel@groeck-laptop>
	<alpine.LFD.2.00.1010212202400.2764@xanadu.home>
In-Reply-To: <alpine.LFD.2.00.1010212202400.2764@xanadu.home>
To: linux-arm-kernel@lists.infradead.org


--===============0191344927883593262==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2F7AbV2suvT8PGoH"
Content-Disposition: inline


--2F7AbV2suvT8PGoH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu, Oct 21, 2010 at 10:08:01PM -0400, Nicolas Pitre wrote:
> On Thu, 21 Oct 2010, Guenter Roeck wrote:
>=20
> > On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > > From: Simon Guinot <sguinot@lacie.com>
> > >=20
> > > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> >=20
> > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> >=20
> > I assume this will get pushed through the ARM tree, right ?
>=20
> Might be simpler if this is routed along the same path as the core code=
=20
> it relies upon to avoid dependency ordering issues.  There is nothing=20
> particularly ARM specific here anyway.

There is some changes, related to the netspace_v2-setup.c file, stagged
in your Orion tree. At some point, a merge will be needed.

Simon

--2F7AbV2suvT8PGoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkzBSuAACgkQgtp0PDeOcDpSHACdHYBU3ADjT9pLonohz7ohVY7q
K9cAnRSb0MIQ8HNcMTaT/tVQUTo00I1r
=WJrw
-----END PGP SIGNATURE-----

--2F7AbV2suvT8PGoH--


--===============0191344927883593262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0191344927883593262==--
