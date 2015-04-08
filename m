From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Apr 2015 15:21:58 +0000
Subject: Re: [lm-sensors] [v4] hwmon: (ibmpowernv) pretty print labels
Message-Id: <20150408152158.GA15824@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1428500527-7833-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1428500527-7833-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org

On Wed, Apr 08, 2015 at 03:42:07PM +0200, C=E9dric Le Goater wrote:
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
> ---
>=20
>  Changes since v3:
>=20
>  - removed error message in case of an unknown physical cpu number
>=20
>  Changes since v2:
>=20
>  - fix bogus logical cpu retrieval=20
>  - use 'threads_per_core' to print out cpu range
>=20
>  Changes since v1:
>=20
>  - check cpu validity before printing out the attribute label.=20
>    if invalid, use a "phy" prefix to distinguish a linux cpu=20
>    number from a physical cpu number.=20
>=20
>  drivers/hwmon/ibmpowernv.c |   41 ++++++++++++++++++++++++++++++++++++++=
+++
>  1 file changed, 41 insertions(+)
>=20
> Index: linux.git/drivers/hwmon/ibmpowernv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
> +++ linux.git/drivers/hwmon/ibmpowernv.c
> @@ -30,6 +30,7 @@
>  #include <linux/platform_device.h>
>  #include <asm/opal.h>
>  #include <linux/err.h>
> +#include <asm/cputhreads.h>
> =20
>  #define MAX_ATTR_LEN	32
>  #define MAX_LABEL_LEN	64
> @@ -110,12 +111,52 @@ static ssize_t show_label(struct device
>  	return sprintf(buf, "%s\n", sdata->label);
>  }
> =20
> +static int __init get_logical_cpu(unsigned int hwcpu)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		if (get_hard_smp_processor_id(cpu) =3D=3D hwcpu)

drivers/hwmon/ibmpowernv.c: In function 'get_logical_cpu':
drivers/hwmon/ibmpowernv.c:119:38: warning: comparison between signed and
unsigned integer expressions [-Wsign-compare]
   if (get_hard_smp_processor_id(cpu) =3D=3D hwcpu)
                                         ^

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
