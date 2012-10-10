From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2012 13:44:56 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (coretemp) Drop dependency on PCI for TjMax detection on Atom CP
Message-Id: <20121010154456.00e2e6b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1349816943-17697-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue,  9 Oct 2012 14:08:59 -0700, Guenter Roeck wrote:
> So far, we use the NM10 Express Chipset PCI chip ID to detect TjMax for
> Atom CPUs with model 0x1c. As it turns out, we can use the CPU stepping
> (x86_mask) for the same purpose; stepping is 10 for all model 0x1c CPUs
> with TjMax of 100 degrees C. This was verified by checking the output of
> /proc/cpuinfo for the respective CPUs (D4xx, D5xx, N4xx, N5xx).
>=20
> Other CPUs currently covered by the same code (Exx, Z6xx, Z2460) are not
> supported by the NM10 Express Chipset. Most of those CPUs have TjMax of 90
> degrees C, except for E6xxT models which have a TjMax of 110 degrees C.
> E6xxT CPUs can however not be detected by software.
>=20
> Calculate TjMax for Atom CPUs as follows:
>=20
> ID	Stepping	TjMax		Models
> 0x1c	10		100		D4xx, N4xx, D5xx, N5xx
> 0x1c	not 10		90		Z5xx, N2xx, 230, 330, others

Documentation/hwmon/coretemp says 125=B0C for Atom 230 and 330. N5xx
aren't listed in this document BTW.

> 0x26	-		90		Atom Tunnel Creek (Exx),
> 					Lincroft (Z6xx)
> 0x27	-		90		Atom Medfield (Z2460)
> 0x36	-		100000		Atom Cedar Trail (N2xxx, D2xxx)

You mean 100.

>=20
> and drop the module dependency on PCI.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Stepping information for model 0x1c CPUs was found in FreeBSD,
> Open Hardware Monitor, and HWSensors.
>=20
>  drivers/hwmon/Kconfig    |    2 +-
>  drivers/hwmon/coretemp.c |   37 +++++++++++++++----------------------
>  2 files changed, 16 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index c74e73b..0a4c790 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -465,7 +465,7 @@ config SENSORS_HIH6130
> =20
>  config SENSORS_CORETEMP
>  	tristate "Intel Core/Core2/Atom temperature sensor"
> -	depends on X86 && PCI
> +	depends on X86
>  	help
>  	  If you say yes here you get support for the temperature
>  	  sensor inside your CPU. Most of the family 6 CPUs
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 984a3f1..1937cd4 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -34,7 +34,6 @@
>  #include <linux/list.h>
>  #include <linux/platform_device.h>
>  #include <linux/cpu.h>
> -#include <linux/pci.h>
>  #include <linux/smp.h>
>  #include <linux/moduleparam.h>
>  #include <asm/msr.h>
> @@ -219,7 +218,6 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x86 =
*c, u32 id,
>  	int usemsr_ee =3D 1;
>  	int err;
>  	u32 eax, edx;
> -	struct pci_dev *host_bridge;
>  	int i;
> =20
>  	/* explicit tjmax table entries override heuristics */
> @@ -228,31 +226,26 @@ static int __cpuinit adjust_tjmax(struct cpuinfo_x8=
6 *c, u32 id,
>  			return tjmax_table[i].tjmax;
>  	}
> =20
> -	/* Early chips have no MSR for TjMax */
> -
> -	if (c->x86_model =3D=3D 0xf && c->x86_mask < 4)
> -		usemsr_ee =3D 0;
> -
>  	/* Atom CPUs */
> =20
> -	if (c->x86_model =3D=3D 0x1c || c->x86_model =3D=3D 0x26
> -	    || c->x86_model =3D=3D 0x27) {
> -		usemsr_ee =3D 0;
> -
> -		host_bridge =3D pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
> +	if (c->x86_model =3D=3D 0x1c) {
> +		/*
> +		 * TjMax for stepping 10 CPUs (N4xx, N5xx, D4xx, D5xx)
> +		 * is 100 degrees C, for all others it is 90 degrees C.
> +		 */
> +		if (c->x86_mask =3D=3D 10)
> +			return 100000;
> +		return 90000;
> +	} else if (c->x86_model =3D=3D 0x26 || c->x86_model =3D=3D 0x27) {
> +		return 90000;
> +	} else if (c->x86_model =3D=3D 0x36) {
> +		return 100000;
> +	}
> =20
> -		if (host_bridge && host_bridge->vendor =3D=3D PCI_VENDOR_ID_INTEL
> -		    && (host_bridge->device =3D=3D 0xa000	/* NM10 based nettop */
> -		    || host_bridge->device =3D=3D 0xa010))	/* NM10 based netbook */
> -			tjmax =3D 100000;
> -		else
> -			tjmax =3D 90000;
> +	/* Early chips have no MSR for TjMax */
> =20
> -		pci_dev_put(host_bridge);
> -	} else if (c->x86_model =3D=3D 0x36) {
> +	if (c->x86_model =3D=3D 0xf && c->x86_mask < 4)
>  		usemsr_ee =3D 0;
> -		tjmax =3D 100000;
> -	}
> =20
>  	if (c->x86_model > 0xe && usemsr_ee) {
>  		u8 platform_id;

I like it.

Acked-by: Jean Delvare <khali@linux-fr.org>

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
