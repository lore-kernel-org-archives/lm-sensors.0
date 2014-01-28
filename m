From: Mark Brown <broonie@kernel.org>
Date: Tue, 28 Jan 2014 10:24:51 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <20140128102451.GF11841@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0392107089660002645=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20140126214936.7736f530@endymion.delvare>
 <52E58330.90602@roeck-us.net>
 <52E58656.7000903@roeck-us.net>
 <20140126235103.GP11727@sirena.org.uk>
 <52E6951C.60609@wwwdotorg.org>
 <20140127185031.GA28910@roeck-us.net>
 <20140127230447.7e8be3a4@endymion.delvare>
 <20140127234135.GA18059@roeck-us.net>
 <20140127235815.GA8513@sirena.org.uk>
 <52E71708.7010607@roeck-us.net>
In-Reply-To: <52E71708.7010607@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>


--===============0392107089660002645==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KKZr+d1tCZIVt60"
Content-Disposition: inline


--+KKZr+d1tCZIVt60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 06:33:44PM -0800, Guenter Roeck wrote:

> I confirmed that your two patches ("regulator: core: Correct default
> return value for full constraints" and "ACPI: Flag use of ACPI and ACPI
> idioms for power supplies to regulator API") together fix the problem
> with the lm90 driver, at least for ACPI based systems.

Great, thanks!

--+KKZr+d1tCZIVt60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS54VwAAoJELSic+t+oim9kJQP/087RVhgPHFHw7dJC3dGkV9l
u1iQvFW7G1LG8P19BpcC6l2jJ7KzF3fJOqBJSlaVWmvq4j1tI9Tjmt2UtB9tb+wZ
3ChuwUQy0Qm5SwVwFPzK8TUxuU/AFoas6uyez/KpvOG2LgJPSI+HwquWqAj2EjKg
Vem5JGSVnX4sp4tGwiIsvIIzFKQa05c2+iRGzks34B+scvMHUGhqf2cU3lSh8ax2
gIDJWE1iOq6zEFyW+VfQt/IFotg6YaNQzpb42LODx/fbCUb7IH5OqXqMlmnsiw0V
oT5ihIZvSNKUGqVuTTmYwdkrOdUCJxbZ8uKaXvfA3mtJDHWqzR3lyd4ygf54GKbc
47K+mIR7oBaWHHRpLaJvgTeTytezbpkzxBnHLdvpBMXH9FBQxP18/VR+RPDoAgFZ
n76SgcBkNl6qddeKAHFV+k2upuajDSTQ0KhN3q27ln/2SS9MAcISEINfX4aLHpyg
9tlluszIgvE1aYDm868rBhggm6x0oBqNtCWkx4dQGpbjVmlefDQ+FUkjaQH3nGFg
iUO+sq3PPc+/o2fMP5socIBeaFN1p0hrbLggdp40Lp6csBXyMBuIKlLUEcfp1bJp
mR5vkZ92gX6uY9x3XlmqtWJNWsqKE7eG/BXUNHicNbe3Y2vizVUnwmjmSLpFxC1S
QU01v/zmkP/qgo2l2Bd3
=e8QD
-----END PGP SIGNATURE-----

--+KKZr+d1tCZIVt60--


--===============0392107089660002645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0392107089660002645==--
