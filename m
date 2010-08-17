From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Aug 2010 16:52:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon,
Message-Id: <20100817185218.14b918de@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100622084557.GA4524@loge.amd.com>
In-Reply-To: <20100622084557.GA4524@loge.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 16 Aug 2010 11:21:38 +0200, Andreas Herrmann wrote:
> From: Andreas Herrmann <andreas.herrmann3@amd.com>
>=20
> The family check in k8temp is not required because the driver is
> already bound to a northbridge device only used with K8 CPUs.

This check was added by... you:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=BB9a35f293a3c8b5d57253cdfe2f29fa2627e1b9

But yes, I agree it's not needed. And actually, the driver wasn't even
failing to bind if a different CPU model was found.

> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/k8temp.c |   49 +++++++++++++++++++++---------------------=
-----
>  1 files changed, 22 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index bcb1a35..2210b21 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -182,36 +182,31 @@ static int __devinit k8temp_probe(struct pci_dev *p=
dev,
>  	model =3D boot_cpu_data.x86_model;
>  	stepping =3D boot_cpu_data.x86_mask;
> =20
> -	switch (boot_cpu_data.x86) {
> -	case 0xf:
> -		/* feature available since SH-C0, exclude older revisions */
> -		if (((model =3D 4) && (stepping =3D 0)) ||
> -		    ((model =3D 5) && (stepping <=3D 1))) {
> -			err =3D -ENODEV;
> -			goto exit_free;
> -		}
> +	/* feature available since SH-C0, exclude older revisions */
> +	if (((model =3D 4) && (stepping =3D 0)) ||
> +	    ((model =3D 5) && (stepping <=3D 1))) {
> +		err =3D -ENODEV;
> +		goto exit_free;
> +	}
> +
> +	/*
> +	 * AMD NPT family 0fh, i.e. RevF and RevG:
> +	 * meaning of SEL_CORE bit is inverted
> +	 */
> +	if (model >=3D 0x40) {
> +		data->swap_core_select =3D 1;
> +		dev_warn(&pdev->dev, "Temperature readouts might be "
> +			 "wrong - check erratum #141\n");
> +	}
> =20
> +	if (is_rev_g_desktop(model))
>  		/*
> -		 * AMD NPT family 0fh, i.e. RevF and RevG:
> -		 * meaning of SEL_CORE bit is inverted
> +		 * RevG desktop CPUs (i.e. no socket S1G1 or
> +		 * ASB1 parts) need additional offset,
> +		 * otherwise reported temperature is below
> +		 * ambient temperature
>  		 */
> -		if (model >=3D 0x40) {
> -			data->swap_core_select =3D 1;
> -			dev_warn(&pdev->dev, "Temperature readouts might be "
> -				 "wrong - check erratum #141\n");
> -		}
> -
> -		if (is_rev_g_desktop(model))
> -			/*
> -			 * RevG desktop CPUs (i.e. no socket S1G1 or
> -			 * ASB1 parts) need additional offset,
> -			 * otherwise reported temperature is below
> -			 * ambient temperature
> -			 */
> -			data->temp_offset =3D 21000;
> -
> -		break;
> -	}
> +		data->temp_offset =3D 21000;
> =20
>  	pci_read_config_byte(pdev, REG_TEMP, &scfg);
>  	scfg &=3D ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */

Applied, thanks (modulo the missing curly braces, which I've added back
myself.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
