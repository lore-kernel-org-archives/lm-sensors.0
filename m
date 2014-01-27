From: Mark Brown <broonie@kernel.org>
Date: Mon, 27 Jan 2014 22:36:43 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <20140127223643.GA5010@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0596731652896817745=="
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net>
 <20140126211357.6fa68909@endymion.delvare>
 <52E573B6.9040903@roeck-us.net>
 <20140126214936.7736f530@endymion.delvare>
 <52E58330.90602@roeck-us.net>
 <52E58656.7000903@roeck-us.net>
 <20140126235103.GP11727@sirena.org.uk>
 <52E6951C.60609@wwwdotorg.org>
 <20140127185031.GA28910@roeck-us.net>
In-Reply-To: <20140127185031.GA28910@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Jean Delvare <khali@linux-fr.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>, linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>


--===============0596731652896817745==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 10:50:31AM -0800, Guenter Roeck wrote:

> Turns out that won't help either after Mark's patches to ACPI and
> to the regulator core are applied. Right now I don't have a solution
> that would work for all systems.

Could you be more explicit in your logic here please?  Given that those
patches should only affect non-DT platforms (modulo the fact that it's
compile time only which I guess you see is an issue) and that your bodge
consists of ignoring all errors for non-DT platforms I honestly can't
think what impact they would have on the bodge so I'm now even more
confused.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5t94AAoJELSic+t+oim9+VcP/is9GRFTYQeFhml4WZ1oeiK1
3Vui+lE/0khIgd+x+iXpVfblcgSV0MkTifJFOO452rpYJn2Y012nxjP+Vqp1msaT
9Rq9nb6yp8IQcXMAGeaK/5pcUKtfhyYMhefzjK39YGpqzsnrbphu7pAuzTlmDz80
veBLFPoADWLTlu8FvDboFfxt6NkBVn6FQXT5TEydZEf/Nylrq7oetNa3Un4vFOkn
IZ9i6CI9lU256gTN0+evgo+JMkuxR7/E5bytMTjjUnaW3fHPLOe4OydFE0/+jSyA
0YGUIQMgv5EqL/a74wdKSY1zycXC8oI66oVuEEt+aw6Su/nrFGbvtJEvmJM/FjOl
yvuOPmpTVH1myuKWzLIzsd54Ae1zTr0K6wOuIssmbiVv4ryXYWrxDfeKbWWrCQE5
lKZ7AFoUcmZDSCzvndTfhF3e6raEbrw6Fydf9bCLM5RxtJyyML/QcAkJisvmsWEW
KZpigkv1FRNsiuJlYBd98onL+/pkbzolzxe/8Ww8Xmm42S8b0DWqJlT3bGhd5VMv
JZwpXIM2qPIjDwwSO35n0Fk5ttb4T8j+VgPbJklZVGgGcXkSQmoZWgUyBcGBc2pN
3i8jtb/Awfjny0lzedbys3BDPXCgNwxZeKhE6cGtzGd1Bb45GsD/nXDUqCYOi8V6
jVPTzDuSADinWFmDwcmB
=yF+L
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


--===============0596731652896817745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0596731652896817745==--
