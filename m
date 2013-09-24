From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 24 Sep 2013 21:33:19 +0000
Subject: Re: [lm-sensors] [PATCHv6 02/16] drivers: thermal: introduce device tree parser
Message-Id: <5242051F.70609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7453002955338718391=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1379537849-28425-1-git-send-email-eduardo.valentin@ti.com> <1379540136-28378-1-git-send-email-eduardo.valentin@ti.com> <20130923104003.GA16069@e106331-lin.cambridge.arm.com>
In-Reply-To: <20130923104003.GA16069@e106331-lin.cambridge.arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "wni@nvidia.com" <wni@nvidia.com>, "joe@perches.com" <joe@perches.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

--===============7453002955338718391==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9VuNC348GOpQBO6G88XXmFPgOq4Q8R8lS"

--9VuNC348GOpQBO6G88XXmFPgOq4Q8R8lS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23-09-2013 06:40, Mark Rutland wrote:
>=20
> It would be nice to have a name for the cells after a phandle which
> describe the cooling device's configuration. You've called them
> parameters here, but it probably makes sense to call them a
> cooling-specifier (following clock-specifier and interrupt-specifier).

Maybe it was not very clear, and I am working on improving this, but
what I am proposing is simply to have:
 cooling-device =3D <&cdev min max>

where min and max are one cell unsigned values referring to minimum
cooling level and maximum cooling level, for this reference. Note that
'cdev' may have 10 levels, but in this reference we may use only from 6
to 10:
 cooling-device =3D <&cdev 6 10>;

I don't see a need to have a cooling-names for this case. And for now, I
also don't see why we would use other specifiers. But we can leave it
open for future extensions.

It does make sense to have thermal-sensor-names (using thermal-sensor as
per your suggestion). Because it makes clear where the sensor is in the
case of using several sensors in one zone. Just like in the example I
already gave:
> +cpu-thermal: cpu-thermal {
> +	polling-delay-passive =3D <250>; /* milliseconds */
> +	polling-delay =3D <1000>; /* milliseconds */
> +
> +		/* sensor       ID */
> +     thermal-sensors =3D <&bandgap0	0>,
> +		  	  <&adc		0>;
> +	thermal-sensors-names =3D "cpu", "pcb north";
> +
> +		/* hotspot =3D 100 * bandgap - 120 * adc + 484 */
> +	coefficients =3D 		<100	-120	484>;
> +
> +        trips {
> +		...
> +        };
> +
> +	cooling-attachments {
> +		...
> +	};
> +};



--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--9VuNC348GOpQBO6G88XXmFPgOq4Q8R8lS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJCBSsACgkQCXcVR3XQvP1s2gD6Ak+M7jZvhrKL6WWAYGh9j+XT
JWpfJDtukecQzRmJ3JsA/2Gni/BCC7ay0GgvMwk1o7FqN8cFxJ6//g02cMMqppab
=7JL8
-----END PGP SIGNATURE-----

--9VuNC348GOpQBO6G88XXmFPgOq4Q8R8lS--


--===============7453002955338718391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7453002955338718391==--
