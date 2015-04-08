From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Apr 2015 15:20:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (ibmpowernv) add support for the new device tree
Message-Id: <20150408152029.GA11030@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427883306-32528-3-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1427883306-32528-3-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On Wed, Apr 01, 2015 at 12:15:04PM +0200, C=E9dric Le Goater wrote:
> The new OPAL device tree for sensors has a different layout and uses new
> property names, for the type and for the handler used to capture the
> sensor data.
>=20
> This patch modifies the ibmpowernv driver to support such a tree in a
> way preserving compatibility with older OPAL firmwares.
>=20
> This is achieved by changing the error path of the routine parsing
> an OPAL node name. The node is simply considered being from the new
> device tree layout and fallback values are used.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@fr.ibm.com>

Hi Cedric,

I was about to apply the series, but then I found the following problem.

> ---
>  drivers/hwmon/ibmpowernv.c |   47 +++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>=20
[ ... ]
> =20
> @@ -189,11 +204,16 @@ static u32 get_sensor_hwmon_index(struct sensor_dat=
a *sdata,
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < count; i++)
> -		if (sdata_table[i].opal_index =3D=3D sdata->opal_index &&
> -		    sdata_table[i].type =3D=3D sdata->type)
> -			return sdata_table[i].hwmon_index;
> +	/*
> +	 * We don't use the OPAL index on newer device trees
> +	 */
> +	if (sdata->opal_index !=3D -1) {

opal_index is u32, so this won't work (or at least the result is
unpredictable).

Also, in patch 4/4 (v4), get_logical_cpu() takes unsigned int as parameter,
but get_hard_smp_processor_id() returns an int, causing gcc to complain
if the code is built with W=3D1.

Please fix and resubmit the entire series.

When you do that, please also ensure that continuation lines
are aligned (in patch 3/4).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
