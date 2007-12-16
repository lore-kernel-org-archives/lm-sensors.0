From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 16 Dec 2007 11:34:59 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add TEMP_TARGET support
Message-Id: <20071216123459.049e0fde@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4751C613.8040502@assembler.cz>
In-Reply-To: <4751C613.8040502@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sat, 01 Dec 2007 21:37:39 +0100, Rudolf Marek wrote:
> Attached patch enables driver to export the target temperature. This temp=
erature
> is calibrated into each CPU, and serves as some indicator to cooling plat=
form.
> All fans should spin at full speed if the temperature is reached.
>=20
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
>=20
> I managed to get answer from Intel at:
>=20
> http://softwarecommunity.intel.com/isn/Community/en-US/forums/permalink/3=
0228436/30230975/ShowThread.aspx#30230975
>=20
> Can someone test if it works please? The lines in the patch are longer th=
an 80
> chars, imho it is allowed now?

Only if folding the line in question would hinder code readability.
This doesn't seem to be the case here so I think you should fold (most
of) the lines.

> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +36.0=B0C  (high =3D +65.0=B0C, crit =3D +85.0=B0C)
>=20
> I have in plan to add Penryn CPUs to driver once I know the details.

I can only test on my T2600 which does not have the feature. So all I
can say is that there is no regression there.

> Index: linux-2.6.23.9/drivers/hwmon/coretemp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.23.9.orig/drivers/hwmon/coretemp=
.c	2007-12-01 12:28:08.000000000 +0100
> +++ linux-2.6.23.9/drivers/hwmon/coretemp.c	2007-12-01 21:29:10.000000000=
 +0100
> @@ -38,7 +38,7 @@
> =20
>  #define DRVNAME	"coretemp"
> =20
> -typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_LABEL, SHOW_NAME } SHOW;
> +typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAM=
E } SHOW;
> =20
>  /*
>   * Functions declaration
> @@ -55,6 +55,7 @@
>  	unsigned long last_updated;	/* in jiffies */
>  	int temp;
>  	int tjmax;
> +	int ttarget;
>  	u8 alarm;
>  };
> =20
> @@ -95,9 +96,10 @@
> =20
>  	if (attr->index =3D SHOW_TEMP)
>  		err =3D data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
> -	else
> +	else if (attr->index =3D SHOW_TJMAX)
>  		err =3D sprintf(buf, "%d\n", data->tjmax);
> -
> +	else
> +		err =3D sprintf(buf, "%d\n", data->ttarget);
>  	return err;
>  }
> =20
> @@ -105,6 +107,8 @@
>  			  SHOW_TEMP);
>  static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
>  			  SHOW_TJMAX);
> +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
> +			  SHOW_TTARGET);
>  static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
>  static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LA=
BEL);
>  static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
> @@ -223,10 +227,27 @@
>  			 "temperature might be wrong!\n");
>  	}
> =20
> +	data->ttarget =3D data->tjmax;

This initialization isn't needed. data->ttarget is only read if the
temp1_max is created, and in this case you overwrite the value below.

> +
> +	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
> +	   on older CPUs but not here */

I can't really make sense of the second part of this comment, please
clarify.

> +	if (c->x86_model > 0xe) {
> +		err =3D rdmsr_safe_on_cpu(data->id, 0x1a2, &eax, &edx);
> +		if (err) {
> +			dev_warn(&pdev->dev, "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
> +		} else {
> +			data->ttarget =3D data->tjmax - (((eax >> 8) & 0xff) * 1000);
> +			err =3D device_create_file(&pdev->dev,
> +							&sensor_dev_attr_temp1_max.dev_attr);
> +			if (err)
> +				goto exit_free;
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, data);

You have a race condition here, the driver data should be set before
creating any sysfs file, otherwise dev_get_drvdata() might be called
before it is set.

> =20
>  	if ((err =3D sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
> -		goto exit_free;
> +		goto exit_dev;
> =20
>  	data->class_dev =3D hwmon_device_register(&pdev->dev);
>  	if (IS_ERR(data->class_dev)) {
> @@ -240,6 +261,8 @@
> =20
>  exit_class:
>  	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> +exit_dev:
> +	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
>  exit_free:
>  	kfree(data);
>  exit:
> @@ -252,6 +275,7 @@
> =20
>  	hwmon_device_unregister(data->class_dev);
>  	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
> +	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(data);
>  	return 0;
> Index: linux-2.6.23.9/Documentation/hwmon/coretemp
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- linux-2.6.23.9.orig/Documentation/hwmon/co=
retemp	2007-12-01 21:25:17.000000000 +0100
> +++ linux-2.6.23.9/Documentation/hwmon/coretemp	2007-12-01 21:28:35.00000=
0000 +0100
> @@ -25,7 +25,8 @@
>  the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
> =20
>  temp1_input	 - Core temperature (in millidegrees Celsius).
> -temp1_crit	 - Maximum junction temperature  (in millidegrees Celsius).
> +temp1_max	 - All cooling devices should be turned on (on Core2).
> +temp1_crit	 - Maximum junction temperature (in millidegrees Celsius).
>  temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
>  		   Correct CPU operation is no longer guaranteed.
>  temp1_label	 - Contains string "Core X", where X is processor

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
