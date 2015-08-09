From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 09 Aug 2015 07:09:29 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] i2c: move client binding docs to proper place
Message-Id: <20150809070929.GA1526@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7016089682405031848=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439058636-3082-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============7016089682405031848==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 08:30:32PM +0200, Wolfram Sang wrote:
> The I2C binding directory is for master controllers, muxes and alike. Not=
 for
> client drivers. Move those who slipped in to their proper places.
>=20
> I'd like to take these patches via my tree, so it is promptly cleaned up =
in one
> go. So, I am mainly asking for acks here.

Thanks for the acks. Applied this series to for-next, thanks!


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxvypAAoJEBQN5MwUoCm2CqgQAIALBBU8Kate9KLAkdZFrU8p
z9HnslYW6cCKozgIPuVy40lXub77kDLgHetT8VRHF1qWGE/hG0bfCQIr42ghkAG6
ALYbscdFLtZB4f51Uo5ctCoyuA6ywLyXLAhVyzEK1uzvdnSFkdj6TSjxslmdDx6l
zNfgxG7gPIPrA/gjxEkA046ILCtVffLUIUMyhskgjZm+9ZKoRCV8yB4Ker/BPTU0
NwhJfV+FelO5GPBmsCXcDJY7SO0nODANVl4BE2n2d3Vxom469mjl0NBBUEYK1tvR
fmDsheQep1lyHjiH92QpZ7dxBQ384/jsq0jxFateru62OWp9uq6WCpC1YjjkY3pa
vCtRT5rHPTroP2nLKaiNQKPE46WUgxQ1q89v94wKQ5AQVXwoN8Iu17wLdxOaI80w
MPTWGueUuDVRNhZ4crPMvmair/H+Q7h7qaeGWh4wk5Kj4YZm5lwShKMniIm54VAH
qGnQiyS0AYgEU38xG5W0ALqXRbMGfmTJPbIyP0OmJ9ROgzFhvSMcc+qocLnN3g+2
thLNNrBEdWUTwkQqLhgyTGK++9BMXuUCOmH/YnBXJg9/t8KWTJUByK5XtB9GE0J3
zbmykPrAxpIg88y4jeFv7czU0j8xfz67s2ZZ0T8DfNwEs0SrieNaZ1ndxbYCRTGF
6J7cvkPPNjP0HQWJoDv5
=b3X/
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


--===============7016089682405031848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7016089682405031848==--
