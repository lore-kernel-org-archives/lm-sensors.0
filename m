From: Mark Brown <broonie@sirena.org.uk>
Date: Mon, 27 Jan 2014 15:08:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Fix driver to work on standard PCs with CONFIG_REGULATOR enab
Message-Id: <20140127150837.GZ11727@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6435705042188690123=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1390777731-10277-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390777731-10277-1-git-send-email-linux@roeck-us.net>
To: lm-sensors@vger.kernel.org


--===============6435705042188690123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JqdxN8yMrvvaufxH"
Content-Disposition: inline


--JqdxN8yMrvvaufxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 06:39:39AM -0800, Guenter Roeck wrote:

> Going back to the original problem, lm90 no longer works in any non-DT
> system which has CONFIG_REGULATORS enabled, such as any Ubuntu distribution.

*sigh*  To repeat yet again this is not associated with DT in the way
that you seem to believe it is.

> I agree that it would have been better if the regulator subsystem would deal
> with the issue, but that seems unlikely to happen. If anything, it will get
> worse with the assumption that regulators are fully declared in any ACPI
> based system (such a system for sure won't know about an USB-I2C adapter
> with an LM90 connected to it). So what do you want to do ?

I don't think you understand what _has_full_constraints() does, the way
that you're still going on about DT seems to suggest that this is the
case.  A USB-I2C adaptor will work in exactly the same way as anything
on the motherboard in an ACPI system unless it explicitly ensures that
it registers any software controllable supplies which also works fine.

--JqdxN8yMrvvaufxH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5nZyAAoJELSic+t+oim9muEP/3d62MuxHLv6cdbO89VXsZyj
rogIh+aKQIRFu68UM3zFJxaNQf6FsGijNdr+PIdDAB/AligClULL/MktrSCs8aBg
UrN5fI8nHfLuIoWQq/A8EibozvhhJzcS4jvhvIixCj83ftX0gNP1+I3UmZ7Wns9g
Xdk68XDMWzdumpu178A7ZYbYJ7N8NigOcRStOrQTKFPo/P7BQ/4zMSl9hQdI8T2E
YO2lj4TQ3/6huYy/6m5fN2Ek3Rvu0QQ0YwvHa5JDUWLW5vChIwMfiBhZp36nIZvI
bJgOapKc6uOpkbRHIH6r4MgvK077euS2rlnX0NRlc/tpWtvDnImxJiGbEox/YYoV
OJ3Zxz9rC/0CqrSYf2WlmYT0pG/P07NZOyXyH10RiIzxCDSX7lbT+SpG5zTAAYpt
yE0RIYcdPy631WP+HCWLAPOA1ViCad0wyAe6hDZg3WRpC8zKqkZgZCmCnmdQYNz7
IqUldTnQJsNh9PNVlz5CdsSblI3fMLMwdEtQaG/JcuLEBScP9jW8VzrIWUh2Xevp
tCGApwYOx5LKHoichGGN70bDcxllBWnKz8QDv64uroKxj5NiBeR6DSGdFNh4KaBq
h/zu6Vj4l24ydjnCauMbmmBh0eaCZtBdxCZGnRDhttT4Cg0V6lWHdA80ep14T6Xp
TutnhPNeVcNX+2vpKR/y
=uFwl
-----END PGP SIGNATURE-----

--JqdxN8yMrvvaufxH--


--===============6435705042188690123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6435705042188690123==--
