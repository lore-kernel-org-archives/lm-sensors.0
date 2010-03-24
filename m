From: Giel van Schijndel <me@mortis.eu>
Date: Wed, 24 Mar 2010 09:36:51 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] [RFC] hwmon: f71882fg: Add watchdog
Message-Id: <20100324093651.GG6368@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8264047705240098210=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100323141718.GA23172@salidar.me.mortis.eu>
 <1269385936-3440-1-git-send-email-me@mortis.eu>
 <1269385936-3440-2-git-send-email-me@mortis.eu>
 <1269385936-3440-3-git-send-email-me@mortis.eu>
 <1269385936-3440-4-git-send-email-me@mortis.eu>
 <4BA9CF57.4030504@redhat.com>
In-Reply-To: <4BA9CF57.4030504@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============8264047705240098210==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2010 at 09:37:43AM +0100, Hans de Goede wrote:
> Nack:
> As the watchdog has its own SIO logical device number, it should
> have a separate driver, not have support glued to the hwmon driver.

Thus, if I understand correctly, you would suggest for me to implement a
new driver in drivers/watchdog/ to implement this driver?

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkup3TMACgkQZBYm/87l50LN5wCbBtIb6TJFDU1srAhh338S3j5r
K8YAn10/R03753u4fiFgRkUcLECobecW
=rP7e
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--


--===============8264047705240098210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8264047705240098210==--
