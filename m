From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Aug 2013 11:09:31 +0000
Subject: Re: [lm-sensors] Proposal: I2C device power (Was: hwmon: (lm90) Add power control)
Message-Id: <20130809110931.GX6427@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1785327774912620337=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <1376027820.695103970@f416.i.mail.ru>
 <20130809102757.GT6427@sirena.org.uk>
 <1376045411.585130456@f141.i.mail.ru>
In-Reply-To: <1376045411.585130456-gOtJ1i61JehsdVUOrk1QfQ@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>


--===============1785327774912620337==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zN/UJhV2gvyhY9D2"
Content-Disposition: inline


--zN/UJhV2gvyhY9D2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2013 at 02:50:11PM +0400, Alexander Shiyan wrote:

> > This would need to be an array of supplies, relatively few devices need
> > only a single power supply.  This is also not something that should be
> > handled in I2C, power is not something that's uniquely needed by devices
> > on an I2C bus.

> Additional regulators can be handled in the driver, or "parent"-scheme can
> be used. Is not it?

Given how common it is to have multiple supplies it seems sensible to
just handle that in the core - it's common to have a digital supply and
an analogue supply for example.  The regulator framework already has
APIs for working with multiple regulators in a single call so it's not
going to be much more effort on the framework side.

--zN/UJhV2gvyhY9D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSBM3oAAoJELSic+t+oim9lWwP/36VFWFam8wJQbJ17f69Zqdz
5gFP0wmDN4Wy7uWw73CRYZHq9BkzOYf/I2wl8D88WRAUJIbvnarcbTkg0ykHyedk
q1HJUEU3tYfOX7y5FUY2VYb32Ax5sUEp/8tNjrDwEC0QX0Xuw8gGgHcnGLkFI4fv
BCplAVxCRgddnRrpeEpEQ5UDMm4ds1NIfs7M25pXT789D0Cv7hfoVi9vya8SybSm
Vsj1QNFpw3dsUrjzdrwfv7m/GaqvsWDFk4bZ+Mm7TopG5E1KUmrdMSsKATvJYnUv
lRkEpwab/WSkyuwM75xA2AlklA8rNFyeehtQBO05A+tLclf/aAhryknHwRibrrmi
IP9HE6slrn+ZNcBwK3L9sdIj4D9dJKU7PMTFbcsNzjr1h1kKBjUY1fesYLO+lCfk
XBOfdy2t9n+RREkFdrb0bw2SrL385ucWDmaCkxMjHE/NMnhNE6qxK9VrnHpxhZE9
Y309BFCcrIGjQ7K8LbZCslM49cmUlHO6TDfgAOFPsMwNnUcjdHFd4K8B+xNRA3G9
QkmRuxM3Oxv/KwR65/jyTsw0tq2pnoiqLiJy3P+qvb5ibCwTTUO1LcuWbV3sdxI4
pqvPNzz+tO0w4aj6vyyUe0P5W7VolvtsFY+ggRDroPioTnqOwq+9BnJuknlb+98/
UmYyb+CSZq94i0NqDHoG
=EjiJ
-----END PGP SIGNATURE-----

--zN/UJhV2gvyhY9D2--


--===============1785327774912620337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1785327774912620337==--
