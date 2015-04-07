From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Apr 2015 16:44:39 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Message-Id: <20150407164439.GA4514@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>

On Tue, Apr 07, 2015 at 04:45:56PM +0200, C=E9dric Le Goater wrote:
> The new OPAL device tree adds a few properties which can be used to add
> extra information on the sensor label.
>=20
> In the case of a cpu core sensor, the firmware exposes the physical=20
> identifier of the core in the "ibm,pir" property. The driver=20
> translates this identifier in a linux cpu number and prints out a=20
> range corresponding to the hardware threads of the core (as they
> share the same sensor).
>=20
> The numbering gives a hint on the localization of the core in the=20
> system (which socket, which chip).=20
>=20
> Signed-off-by: C=E9dric Le Goater <clg@fr.ibm.com>

Hi Cedric,

Please do not send follow-up patches as reply, but as separate e-mail.

Further comments below.

> ---
>=20
>  Changes since v1:
>=20
>  - check cpu validity before printing out the attribute label.=20
>    if invalid, use a "phy" prefix to distinguish a linux cpu=20
>    number from a physical cpu number.=20
>=20
>  drivers/hwmon/ibmpowernv.c |   34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>=20
> Index: linux.git/drivers/hwmon/ibmpowernv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
> +++ linux.git/drivers/hwmon/ibmpowernv.c
> @@ -113,9 +113,43 @@ static ssize_t show_label(struct device
>  static void __init make_sensor_label(struct device_node *np,
>  		    struct sensor_data *sdata, const char *label)
>  {
> +	u32 id;
>  	size_t n;
> =20
>  	n =3D snprintf(sdata->label, sizeof(sdata->label), "%s", label);
> +
> +	/*
> +	 * Core temp pretty print
> +	 */
> +	if (!of_property_read_u32(np, "ibm,pir", &id)) {
> +		int i =3D -1;
> +
> +		for_each_possible_cpu(i)
> +			if (paca[i].hw_cpu_id =3D=3D id)

I think you should consider using get_hard_smp_processor_id() and avoid
direct access to the paca array.

> +				break;
> +
> +		if (i !=3D -1)

I don't think that works. i is initialized by for_each_possible_cpu(),
either to -1 or 0 depending on the state of CONFIG_SMP. So pre-initializing
it won't make a difference. Its last value is NR_CPUS (SMP) or 1 (non-SMP).

You would need a second variable (which you could pre-initialize)
to determine if the code found a matching ID or not.

> +			/*
> +			 * The digital thermal sensors are associated
> +			 * with a core. Let's print out the range of
> +			 * cpu ids corresponding to the hardware
> +			 * threads of the core.
> +			 */
> +			n +=3D snprintf(sdata->label + n,
> +				      sizeof(sdata->label) - n,
> +				      " %d-%d", i, i+7);

I would really like to see how this looks like in practice.

The id in the devicetree entry is the physical CPU. The resulting index
is the logical CPU number. So let's assume that the logical CPU number
for the first physical CPU is 0. Output would be "0-7". If the second
physical CPU matches logical CPU 1, output would be "1-8".=20
How does that make any sense ?

Also, how do you know that the range of CPU IDs is always 8 ?

Can you provide some resulting outputs ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
