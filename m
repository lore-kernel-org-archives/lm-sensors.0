From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 23:49:49 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Temperatures should be signed
Message-Id: <20070716234949.GH2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6069970281184425000=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070716230724.GG2619@tree.beaverton.ibm.com>
In-Reply-To: <20070716230724.GG2619@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============6069970281184425000==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline


--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 17, 2007 at 01:22:45AM +0200, Vadim Zeitlin wrote:

>  Normally I'd just say that the corresponding sensors are not connected but
> these values do change slightly (+/-1 degree) from time to time so I'm not
> sure if this is indeed the case or they are connected but should be
> interpreted differently somehow.

Maybe the pins for those temperature inputs aren't connected and are
floating around? <shrug> Idle speculation on my part, however.

If you have a copy of i2cdump, take a look at registers 0x21, 0x24 and
0x25 a few seconds after reading the sensors via sysfs; if the values that
i2cdump shows you match what you're seeing, then there's nothing the driver
can do.  If, however, temp2,5,6 go normal after a few seconds of
waiting, then we need to increase the wait time during the temperature
sensor read a bit.

--D

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGnAQda6vRYYgWQuURAoXhAJ9+s3GXvAqsW1UNdK3PzrjlzpUBLQCeL+rY
Oe7I4XpwAuS7MPRcv8d9JMg=
=VoVE
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--


--===============6069970281184425000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6069970281184425000==--
