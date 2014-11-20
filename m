From: Eduardo Valentin <edubezval@gmail.com>
Date: Thu, 20 Nov 2014 13:52:32 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] thermal: of: improve of-thermal sensor registration API
Message-Id: <20141120135155.GB24778@developer>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5454670088193997135=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1416321575-18348-1-git-send-email-edubezval@gmail.com>
 <1416321575-18348-2-git-send-email-edubezval@gmail.com>
 <CAAVeFu+aUdpV_hj50TAZDO_5JgRmPH2RtJuP7Qozx4RNEzO-6A@mail.gmail.com>
In-Reply-To: <CAAVeFu+aUdpV_hj50TAZDO_5JgRmPH2RtJuP7Qozx4RNEzO-6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>


--===============5454670088193997135==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alexander,

On Wed, Nov 19, 2014 at 05:06:24PM +0900, Alexandre Courbot wrote:
> On Tue, Nov 18, 2014 at 11:39 PM, Eduardo Valentin <edubezval@gmail.com> =
wrote:
> > Different drivers request API extensions in of-thermal. For this reason,
> > additional callbacks are required to fit the new drivers needs.
> >
> > The current API implementation expects the registering sensor driver
> > to provide a get_temp and get_trend callbacks as function parameters.
> > As the amount of callbacks is growing, this patch changes the existing
> > implementation to use a .ops field to hold all the of thermal callbacks
> > to sensor drivers.
> >
> > This patch also changes the existing of-thermal users to fit the new
> > API design. No functional change is introduced in this patch.
>=20
> A good idea even if no ops were to be added!
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks for reviewing.

Eduardo Valentin

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbfIeAAoJEMLUO4d9pOJWV48H/0hSblonH5J96HEdJgx5O5y9
NBKK0ulyOQMn5xGoD6cvowht+oF3ViTFDpq0/Uvjg2I5QMMyB8JOGNUPlIS58Eq4
OlMz4VGEh77l6HFosEeeXDiOslb+sLZi79LBfaCp4vkPuifRnT6WUAc+QYSXUjuc
5QyL8aXypQr98Vu6YOlnpLNSC0KjkFJcdTviXY7kO3r78MNm1Htt3VGCoW/X5FR9
jXDZWX/P0bq4Kvu5+j+ADPuZjSkAmEUc6Jm5RPQo0nXtVDHGfLojNYHc2kVIlVH8
bXYJXik+Wt5KpAWivF3lTvj6NIMhis5oWJHhZARLz/uL30UjX2Im+wVD1jSAtcc=
=Kf2R
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--


--===============5454670088193997135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5454670088193997135==--
