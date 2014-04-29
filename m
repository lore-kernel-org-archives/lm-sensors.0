From: Mark Brown <broonie@kernel.org>
Date: Tue, 29 Apr 2014 22:21:31 +0000
Subject: Re: [lm-sensors] [PATCH 02/10] mfd: vexpress: Convert custom func API to regmap
Message-Id: <20140429222131.GO15125@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7382258600121488253=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1398707877-22596-3-git-send-email-pawel.moll@arm.com>
To: Pawel Moll <pawel.moll@arm.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, Liam Girdwood <lgirdwood@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Mike Turquette <mturquette@linaro.org>


--===============7382258600121488253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Content-Disposition: inline


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 06:57:49PM +0100, Pawel Moll wrote:

> Components of the Versatile Express platform (configuration
> microcontrollers on motherboard and daughterboards in particular)
> talk to each other over a custom configuration bus. They
> provide miscellaneous functions (from clock generator control
> to energy sensors) which are represented as platform devices

Acked-by: Mark Brown <broonie@linaro.org>

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYCXkAAoJELSic+t+oim9meEQAJISu52vfboXBUHxI1ipL4jT
tjCvzAx1VLcVlUgWjuxwdIMYhszOQwjvp8j5/KFJ3LmZ4G7b99PlZAhMUeaDkD0G
IY15zj/yPelhUuMhLMwFCJrO4AXM3FltAhpxDf+RKsWPEpMzJ3rT4aR0/Fl/dXQ3
QsNGSKUi3RknT+fXoYb0Kr2GDJxIgi9fty/aIsNG7nZA4OqB3tex9w/8uPf1rN6G
g21ryh7YAp6o3r2146S9kiY0dYxByLRJ1pDHJYoRcOzh9YZwNIQFsQACCXhVzoP7
WiA4h8e76AW327/Fe78X7AEHQ+jfdP9wcWC7OYfRySukwzsO8QpFX6gsrYU0p2Vj
fpPDLiTtd6V0bSm2G8pMxrcAZq3YJKd4mN0lO4zaKitrdAvUD4AxbASt6ODFzMxp
ejQk+mZdBO5/gl9uE6B8aK+RqDQ6hPICVWo7O4UMMkBITfLxG5XX8XUmKBoTS4sC
SZ9cnxBJlwbCgavRpylR9qx0GLxzC6spfp8hmerJRvc84T1VBM3Ef61uvmC5naBV
eTFs6lr1FD/uih11n29WCwDNmaF4N2Mw6R3ezuC7oW/DaadIk44p1yE0opr/3o5f
w+IgUgz7bOfLFvKUefiA6LefigY3llgHG4zBXxCBgkraaFIFIn5mertQH5qeWvF2
m9LFUk74mADNNTKUsNq1
=kkiV
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--


--===============7382258600121488253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7382258600121488253==--
