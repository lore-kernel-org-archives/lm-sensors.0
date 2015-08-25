From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 25 Aug 2015 14:57:56 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <20150825145756.GA4066@schokonusskuchen.bad>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3232555000457902757=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20150825052513.GI1654@sirena.org.uk>
In-Reply-To: <20150825052513.GI1654@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>, linux@roeck-us.net


--===============3232555000457902757==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 06:25:13AM +0100, Mark Brown wrote:
> On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
> > Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
> > slaves") broke the lm-sensors which relies on I2C hwmon slave devices u=
nder
> > /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
> > devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sy=
sfs
> > code in lm-sensors does not find them anymore:
>=20
> Acked-by: Mark Brown <broonie@kernel.org>

Don't you think there will be regressions given that the new naming
scheme was around for 18 months?


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJV3IJ0AAoJEBQN5MwUoCm2w+sQAIwXpDGWvO2iC4Jel73lxhhN
NRtBAQTeIXfZxhI5Hk6TKnlftuVCNz3wWlxmtyQnhz6hnJFFzmQ5eZ1ONPJXPSF3
C/ZDa9SjuD2MPoEWmGrRpvNNS65zOictqLpy2X8U93RwKemtkxFFV0IjqN3XN6Ko
S7QaCCyq1ZDPztV2wMpM7txOfsxRZd+UuU6BDczskBGsaelOk1TDZ+4Epv/P4Zkr
eBpLVVeEapTGjvdaGwxTlmi6N0MsZ1GFkRb8U1GCs+Q90LyzEWtnaJsiRvxewWTT
+EfRHwQYg9CSuKaG9rjMpxH6IU+JzlRc1aqx1YMFS8wNAJRLJnrcWNjvGIlRF4Wf
3bZL7up+81pH4zbbhxgzat5TokTA/C4ZEBKv64vk3FbNEIdwm129pILb5o8d7fsH
Wl5qcdFCIlawYF2Xj70E/J2qqdetCeGEw7Mgxdw3nelcKqa04Q2PZ8cPYRoeBmpX
eqrzSAVZDw4E+4JfgHuAoH8FWIHw/fxPzp44WhG4hkGX1YStagoxLWFNlGPRnzgs
96rz+igZerxE1qc+7e2/FS3TFOQmrIE6bhds//QhVVgc+2DfRhLYp7D6/SLc2Sx+
gzs3R8lDVbCN+A8PjlctmRKMc5cIHuIQmsKeDMmZdG4myBOeESwzzDVp5dY+rnDB
sAUkNEN39tMdj6CmSOUM
=RThC
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--


--===============3232555000457902757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3232555000457902757==--
