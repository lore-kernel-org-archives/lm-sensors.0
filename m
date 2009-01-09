From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Jan 2009 13:34:39 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (k8temp) fix temperature
Message-Id: <20090109143439.1256da8a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215231213.GC7013@alberich.amd.com>
In-Reply-To: <20081215231213.GC7013@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Tue, 16 Dec 2008 00:12:13 +0100, Andreas Herrmann wrote:
> Current Temperature for K8 RevG desktop CPUs is a "normalized value"
> which can be below ambient temperature.
>=20
> As a consequence lots of RevG systems report temperatures like:
>=20
>  sensors
>  k8temp-pci-00c3
>  Adapter: PCI adapter
>  Core0 Temp:
>               +17C
>  Core0 Temp:
>                +3C
>  Core1 Temp:
>               +21C
>  Core1 Temp:
>                +5C
>=20
> being quite below ambient temperature.
> There are even reports of negative temperature values.
>=20
> This patch corrects the temperature reporting of k8temp for
> RevG desktop CPUs.

Thanks for working on this, that was very needed.

> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/k8temp.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
> index ff12281..b138f79 100644
> --- a/drivers/hwmon/k8temp.c
> +++ b/drivers/hwmon/k8temp.c
> @@ -49,6 +49,7 @@ struct k8temp_data {
>  	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
>  	u32 temp[2][2];		/* core, place */
>  	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
> +	u32 temp_offset;
>  };
> =20
>  static struct k8temp_data *k8temp_update_device(struct device *dev)
> @@ -116,13 +117,15 @@ static ssize_t show_temp(struct device *dev,
>  	    to_sensor_dev_attr_2(devattr);
>  	int core =3D attr->nr;
>  	int place =3D attr->index;
> +	int temp;
>  	struct k8temp_data *data =3D k8temp_update_device(dev);
> =20
>  	if (data->swap_core_select)
>  		core =3D core ? 0 : 1;
> =20
> -	return sprintf(buf, "%d\n",
> -		       TEMP_FROM_REG(data->temp[core][place]));
> +	temp =3D TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
> +
> +	return sprintf(buf, "%d\n", temp);
>  }
> =20
>  /* core, place */
> @@ -176,6 +179,16 @@ static int __devinit k8temp_probe(struct pci_dev *pd=
ev,
>  				 "wrong - check erratum #141\n");
>  		}
> =20
> +		if (((model >=3D 0x68) && (model !=3D 0xc1)) &&
> +		    !(model =3D 0x68) && !(model =3D 0x6c) &&
> +		    !(model =3D 0x7c))

This test is pretty confusing, with these extra parentheses and the mix
of (a !=3D b) and !(a =3D b). What about the following instead? As far as
I can see, it leads to the same results, but is much more readable:

		if (model >=3D 0x69 &&
		    !(model =3D 0xc1 || model =3D 0x6c || model =3D 0x7c))


> +			/*
> +			 * RevG desktop CPUs (i.e. no socket S1G1 parts)
> +			 * need additional offset, otherwise reported
> +			 * temperature is below ambient temperature
> +			 */
> +			data->temp_offset =3D 21000;

If you apply the same offset to all sensors, you'll still obtain
something odd:

 k8temp-pci-00c3
 Adapter: PCI adapter
 Core0 Temp:
              +38=B0C
 Core0 Temp:
              +24=B0C
 Core1 Temp:
              +42=B0C
 Core1 Temp:
              +26=B0C

That's not terribly realistic, is it? Unless both sensors for a given
core are very far apart - but I suspect each core is pretty small,
isn't it?

> +
>  		break;
>  	}
> =20


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
