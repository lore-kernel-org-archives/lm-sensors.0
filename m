From: Mark Brown <broonie@kernel.org>
Date: Mon, 16 Sep 2013 10:23:37 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/3] Documentation: dt: hwmon: add OF document for LM90
Message-Id: <20130916102337.GZ29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0495937361067375681=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1378985061-28547-1-git-send-email-wni@nvidia.com>
 <1378985061-28547-4-git-send-email-wni@nvidia.com>
 <5231D709.5080308@wwwdotorg.org>
 <523688FB.2010701@nvidia.com>
In-Reply-To: <523688FB.2010701-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--===============0495937361067375681==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+EtoZOcuEljFWerI"
Content-Disposition: inline


--+EtoZOcuEljFWerI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2013 at 12:28:43PM +0800, Wei Ni wrote:
> On 09/12/2013 11:00 PM, Stephen Warren wrote:

> >> +- vcc-supply: vcc regulator for the supply voltage.
> >> +              If this is not set, assuming vcc is always powered.

> > I thought that was going to be a "Required Property".

> There may have many platforms without regulator, they always power on
> this device, so how can they set this "vcc-supply "property if we set it
> as "Required Property".
> Set to dummy-regulator? but it seems the regulator framework can't
> handle it yet.

To repeat once more: these platforms will physically have a regulator,
the device won't function without power and unfortunately the device
tree bindings only have optional and required properties.

--+EtoZOcuEljFWerI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSNtwmAAoJELSic+t+oim9XukQAInDuT/CuiodQAxLwPHctc1o
1PDVDOD2tw2Y5raXf2BoiiFfIvOuQPjq85S2+rib0cO6CAGr9kNOn5TgYw+R3Cwx
+0wRkzs50kUjDrQGS1iMeFH3uRCiFRfajmyMaftUIQ8SPR5pmZHGnPc9CF0n19G0
C6QwNP/FpWbxRNaqTtiaFAPeSPYQjblCEknicV/R0o2kZoSqv6pWPBDqjfgX4t58
QPwAXd1yCscAnHXThz8OgUCxHCY+qeXtlU5WnqNp0TTCNsi1WOXXVn5bafJsDKPl
pwKxDFfvNDFZZnMGa2pOZANzWlJ4lsYP/74ghk52pTI86zjSpEBW5WUZ4yyoTdNR
/jN+i08Ml6gR4lqdFUimvX/UjEjoU6ndbkZ6pCXps9S/qfLCbU3k2o3BpwjeZ9D/
a93vVhPxDXIdnAHJNkgSlBJAr4HZ6fGH0l7Azzh5to6CCLmTSDsbulXXYOkEY8MM
EDqMg8osQXHCOcE1hVt73rXGp3FDWRJ5oBbY8sHomIw7TGJe0bBbXRtKlWJrOO6d
Q6SUCXJuxcOSr23EBKJy0i6SkzSvzWFd0n2tYzhDnOrtgoezY6JwjAgodYfPKaZ3
+m62n01rsy8u4M9WrcDHyE4KDgGXd75AvUx3AexY8sctunSfjAsl7uxdK0WgbtNh
t+LVAd8OQdxQ4HTgZqTl
=aUd3
-----END PGP SIGNATURE-----

--+EtoZOcuEljFWerI--


--===============0495937361067375681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0495937361067375681==--
