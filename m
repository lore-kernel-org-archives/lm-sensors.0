From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Mon, 07 May 2012 11:10:00 +0000
Subject: Re: [lm-sensors] [PATCH, v3] hwmon: coretemp: use list instead of fixed size array for temp
Message-Id: <20120507110959.GA7339@otc-wbsnb-06>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6784094509511844847=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1336386848-31041-1-git-send-email-kirill.shutemov@linux.intel.com>
 <4D68720C2E767A4AA6A8796D42C8EB591184C1@BGSMSX102.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591184C1@BGSMSX102.gar.corp.intel.com>
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--===============6784094509511844847==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2012 at 10:59:48AM +0000, R, Durgadoss wrote:
> Hi,
>=20
>=20
> > -----Original Message-----
> > From: Kirill A. Shutemov [mailto:kirill.shutemov@linux.intel.com]
> > Sent: Monday, May 07, 2012 4:04 PM
> > To: Yu, Fenghua; Guenter Roeck; R, Durgadoss
> > Cc: Andi Kleen; Jean Delvare; lm-sensors@lm-sensors.org; linux-
> > kernel@vger.kernel.org; Kirill A. Shutemov
> > Subject: [PATCH, v3] hwmon: coretemp: use list instead of fixed size ar=
ray for
> > temp data
> >=20
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> >=20
> > Let's rework code to allow arbitrary number of cores on a CPU, not
> > limited by hardcoded array size.
> >=20
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  v3:
> >    - drop redundant refcounting and checks;
> >  v2:
> >    - fix NULL pointer dereference. Thanks to R, Durgadoss;
> >    - use mutex instead of spinlock for list locking.
> > ---
> >  drivers/hwmon/coretemp.c |  120 ++++++++++++++++++++++++++++-----------
> > ------
> >  1 files changed, 75 insertions(+), 45 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > index b9d5123..fa082d5 100644
> > --- a/drivers/hwmon/coretemp.c
> > +++ b/drivers/hwmon/coretemp.c
> > @@ -36,6 +36,8 @@
> >  #include <linux/cpu.h>
> >  #include <linux/pci.h>
> >  #include <linux/smp.h>
> > +#include <linux/list.h>
> > +#include <linux/kref.h>
>=20
> I think we don't need to include kref.h now :-)

Right. :(
Guenter, should I resend the patch or you can fix this on apply?

>=20
> BTW, at some places, looks like we are using 'tdata' obtained from get_te=
mp_data,
> without checking for NULL values. Other than that, looks Ok for me.

Do you mean sysfs show methods? It should never be NULL there. If it's
NULL, we have bug (race?) somewhere.

> Acked-by: Durgadoss R <durgadoss.r@intel.com>

Thanks.

--=20
 Kirill A. Shutemov

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPp62HAAoJEAd+omnVudOMI+oP/0TiZ/j0N7TeF3reo3J/XL9P
1X5zcxy3TAw+qufVYgegfVv+KbfRk1j5I/AR3F0w5ZN2Eapa84UpeaPvUWiy+gJ3
5xqGSFQ/TVomYS4L0qyOzoG4rrNBhuiS2qdugGFE27VOG1U+AfE1apR7qsRwjJVw
KSAYons6HL6tfgo24IreOUt7C/xoZu/LqGMbnPTlZ0GNVzPKqrne7OM/dNOfjatw
BpwUQpndQYI4pWqgCARP5bYEATzyOoOiMJW62gyaIO4wk/YHUYmyOc7OSv6r1jXi
hMSfYyUYDA2mf5d0yvf+4uVns/eq/UkRlut1dN9rySWp7AB8hW6c+M3KQpUtYMHV
JQTOl+XBsTK8BIYXSW1xlRhe9PtG9RiyoCLom7BjUw4R66I5f5VIlM85EJzTueKJ
uOFPZ2ZZWDUP6D5hiMqftxVqclNRdHLwymCs+S/VdSdWroeIB0zALebCAcD0t1WT
vlgY/N0C1uNIk4rVkgKCHP0s4RbI/ghrCEFGLrC9XivNwsd/8IQAifVYUWQj/8wp
iwkvDx+soKLEVpwpEvKTWRpOocA1cFUTKGVI3wp/wo3cpOrOIU6JWPyxAnupBWP8
AN784ftHbmzZNSu4gThmT7CM/iCBt155CHWUOheViTmut7XXA9ntgPfydlRm/Kga
bZ5k6hk7Pkuqjo5iUFVZ
=re3c
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


--===============6784094509511844847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6784094509511844847==--
