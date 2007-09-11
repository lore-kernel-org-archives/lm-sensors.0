From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 11 Sep 2007 16:43:49 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070911164348.GD30825@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7117140338720151571=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164440.GL32667@tree.beaverton.ibm.com> <20070829111052.503a73a5@hyperion.delvare> <20070829145002.GQ32667@tree.beaverton.ibm.com> <20070830115743.4dd8b2d5@hyperion.delvare>
In-Reply-To: <20070830115743.4dd8b2d5@hyperion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org


--===============7117140338720151571==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 30, 2007 at 11:57:43AM +0200, Jean Delvare wrote:
> OK, that's a bit different then, but I'm still not sure that there is
> much value in exporting these values in sysfs, in particular if there
> is no way to reset them.

It turns out there _is_ a way to reset them; the next iteration of the
driver will have it.

> I am also not happy with the names you proposed: power1_max_input and
> power1_min_input are somewhat confusing IMHO, I'd suggest
> power1_input_highest and power1_input_lowest to make them clearly
> different from the min and max limits we have for other sensor types.
> If we have them at all, of course.

Agreed and changed.

--D

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG5sXEa6vRYYgWQuURAqy4AJwNw7mv4nUYd2pGi+u6L1dc5l9uwgCgs6ij
nFhUr8RHhsPwSHunxbJKWks=
=Ee3w
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--


--===============7117140338720151571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7117140338720151571==--
