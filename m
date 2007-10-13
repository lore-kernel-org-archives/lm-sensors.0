From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Sat, 13 Oct 2007 00:29:17 +0000
Subject: Re: [lm-sensors] [PATCH v4] IBM power meter driver
Message-Id: <20071013002917.GO16752@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2615682043824029962=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com> <20070828015029.GA10107@khazad-dum.debian.net> <20070828131942.18449886@hyperion.delvare> <20070828164905.GM32667@tree.beaverton.ibm.com> <20070828232504.GP32667@tree.beaverton.ibm.com> <20070911132335.GJ31992@jupiter.solarsys.private> <20070914193346.GM30825@tree.beaverton.ibm.com> <20071009120044.GP3835@jupiter.solarsys.private>
In-Reply-To: <20071009120044.GP3835@jupiter.solarsys.private>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, haveblue@us.ibm.com


--===============2615682043824029962==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Content-Disposition: inline


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 09, 2007 at 08:00:44AM -0400, Mark M. Hoffman wrote:

> Sorry it took me so long to get back to this.  I've applied this to my hwmon
> testing branch, but I would still like to get a review from an IPMI expert.

I'm working on finding somebody to do that.

> OBTW: please try to send patches which apply cleanly to some tree to which I
> have access.  E.g.  from the Makefile - preceding and trailing context are not
> present in any git tree that I know.

Oops, sorry about that.

The i5k_amb driver referenced in the Makefile diff is the same one that
I posted to lm-sensors a few weeks ago, though there hasn't been much
discussion after it was pointed out that someone had already written a
driver to achieve the same purpose.  Unfortunately, nothing's happened
to either driver; any thoughts?  I'm thinking that we ought to get one
of them into shape for upstream, though I don't particularly care which
one it is...

--D

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHEBFda6vRYYgWQuURAjPXAKCTgW3HhKqRSYcacX46VeqlhnX4qQCfb43d
co8Oq8BASFJBcVCOyQvoeEs=
=3o+h
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--


--===============2615682043824029962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2615682043824029962==--
