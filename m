From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Sep 2013 12:11:57 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <20130910121157.GJ29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3105039541783057448=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130909135022.GZ29403@sirena.org.uk>
 <20130909155043.GA18975@roeck-us.net>
 <20130909160237.GR29403@sirena.org.uk>
 <20130909161735.GC18975@roeck-us.net>
 <20130909203910.GV29403@sirena.org.uk>
 <522E9A85.9050803@nvidia.com>
 <522EA51C.90706@roeck-us.net>
 <522EB0AF.9030708@nvidia.com>
 <20130910101359.GX29403@sirena.org.uk>
 <522F02A4.7060702@nvidia.com>
In-Reply-To: <522F02A4.7060702-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--===============3105039541783057448==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wvmAFhn+Ugdou746"
Content-Disposition: inline


--wvmAFhn+Ugdou746
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 10, 2013 at 07:29:40PM +0800, Wei Ni wrote:

> On my platform, it use palmas-regulator.c, ldo6 for this lm90 power
> rail. I checked this driver, it will handle ramp_delay except LDOx.
> Since I'm not familiar with this palmas device and driver, so do you
> mean I can set regulator-ramp-delay property in the DT for ldo6, but I
> really don't know what value should I set :(

Laxman just submitted a patch adding the ramp delay information which I
applied.  It seems like this is just a hack for your board and can
therefore be removed?

--wvmAFhn+Ugdou746
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLwyKAAoJELSic+t+oim9EJ0QAJABKUsNKO5ZsmnJsLVUSgQA
gwqfjeFiV2Zt/1GQmIpqmYeEBnkHVdXzDkSrP26dlvKymzDEmxs3Fak2qZ1UeI3/
WpHpK/1kOgnVPlyL514Tx5PJAmM9mmHh3/Ry1HEeMsq6fVpydTj0UrS5z3xnVe1A
kPryp2w7zNaPnVIanyQleWhDZ99Dzqo4E9ZbF0tsogIXVGRbsQXR8P7WgXITCCh1
yW5fvFFypiXXMFoV/Ur9jORR7cawnvubiQDjgpSCE/PVEK9hEAUFN4/n+FJD4ej7
yiDrBWvb8XNtSeAyTHYhBRXMgISeNcWyrViNkpli2NjDz0c1TOvXEK1LmWhX3c9M
P6NgYaqv3TqoWwNQfBouuAMeXVSjlhgSA6rPLsFGWr9Dz29t1jdD0cm5FIJrXl7k
SeK1TCL19U1HnAzbuO8eegKDjdQWxYecFULX10G46rqa5lVRwq9V6TkYaPdytHsI
IxkuuE60ILJD95GlPTHGdh8rhv2LrKefcSCapVfpyNIpVU7uI87yTHSS50xT4Lc6
w6HHA9HOZEIWsit6pUeh0cB9ydY5SZG7Y2AGP0GaloKOqdAuulsyO6KByEglz9m2
MkHjxOBPHJ9tlaWFMC/heLBGAaNfyBoNwm4ct1kLACTq1EXIa0Kd0lNG9msxYyia
+wEJ6nOxHvPPcAaso47k
=RC+n
-----END PGP SIGNATURE-----

--wvmAFhn+Ugdou746--


--===============3105039541783057448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3105039541783057448==--
