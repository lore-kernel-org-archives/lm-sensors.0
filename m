From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 29 Aug 2007 14:50:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070829145002.GQ32667@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2471501315649404140=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164440.GL32667@tree.beaverton.ibm.com> <20070829111052.503a73a5@hyperion.delvare>
In-Reply-To: <20070829111052.503a73a5@hyperion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============2471501315649404140==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hSZb4FHl1C2xfsUy"
Content-Disposition: inline


--hSZb4FHl1C2xfsUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 29, 2007 at 11:10:52AM +0200, Jean Delvare wrote:

> I'm not sure if we want these "historical" files. We don't have them for
> the other input types, and I believe that it's not the driver's job to
> compute and export these values. If anyone cares about the history of

In the case of ibmpex, it is the _hardware_ that computes the historical
data; the driver merely exports what it sees.

--D

--hSZb4FHl1C2xfsUy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG1Yeaa6vRYYgWQuURAlgvAJ9g3FNI5fg2l0uCLKoNeRgJzemDAwCbBukX
KluMposcq7GvI4eRGe5g2Cg=
=RfZf
-----END PGP SIGNATURE-----

--hSZb4FHl1C2xfsUy--


--===============2471501315649404140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2471501315649404140==--
