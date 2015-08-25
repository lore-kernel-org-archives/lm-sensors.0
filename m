From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 25 Aug 2015 16:22:14 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <20150825162214.GA8229@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4486137623691539183=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150825052513.GI1654@sirena.org.uk>
 <20150825145756.GA4066@schokonusskuchen.bad>
 <55DC8746.1060809@roeck-us.net>
 <20150825161850.GA8118@katana>
In-Reply-To: <20150825161850.GA8118@katana>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>


--===============4486137623691539183==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > So I am not surprised that this only shows up now.
>=20
> I am, to be honest. It shows running lm-sensors with ACPI on a kernel
> newer than 18 months. Not a rare scenario, so I thought.

And thanks to Mark's recent post I understand now that this is only
relevant for ACPI5 enumerated devices. I lost that detail.


--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3JY1AAoJEBQN5MwUoCm2FA8P/1wYI9bMsAAg7tP0WiWwQeEt
aKFTzwbmN4vlgvz3RatXZiActfOf+x2mFSbzULoWyw/NcgquwqP+TDdoEq24OM68
SB9ITK5dmp5/BgFZTDJHmBUntWy85obQaLe5ZZTwnpJ3lMUeyP41q2WGpFNH84V7
u06KJqYKw611sWTiYPPL4PuhYZTXLpTeQl1yVyrcGvbJUEqQrMTZQG6523bSNE3J
Yx76L7opbrZe5ftay2mTNMH8/f1yfrdjYzuYHL2kgYvEPw4dWcaPCwiMgbA7eYq7
BZLBBAPOc75QAXKWA0aLWKF+h0jL1GD121fY2wEGVgxsVmuDwLgW7RLmO5wRpd20
rJCC5NlVuU2eFPznBVnQ42dou7W30G0aFnM7YPckr4XNMP1PiW/qEwf7b2mNlvv8
pd4fYtRKJVLbHpHCC6bt7e6Af8Y235ymKPn1mrwE2Fm9iCdVldMQImGeFDuERXaN
IQwMbaFLtZ4r92Cfknxc87WH7WYaf/oj9Qeq7uFJiHcOEYlA8nB7Z847kFAXTT1s
UIW1VweOwF8J2/woqcV/UwmoRc/dsU/AoeeK21Iz3mx7nCvyiIQNgUHPbSmwh4d5
BX2H3WPPeECp/JOdw59JEsoON2RU+zAAxidbvABxkAM7sYJwE5y0TimIz4xl7WJx
y4+l4E84bcV0EhK+oNjC
=LDB6
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--


--===============4486137623691539183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4486137623691539183==--
