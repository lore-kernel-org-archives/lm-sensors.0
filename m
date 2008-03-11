From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Mar 2008 12:39:00 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: Define min value for loadavg in
Message-Id: <20080311133900.14e71d4e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080302213559.GA18471@volta.aurel32.net>
In-Reply-To: <20080302213559.GA18471@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Aurelien,

On Sun, 2 Mar 2008 22:35:59 +0100, Aurelien Jarno wrote:
> The patch below changes sensord so that it sets the minimum value of
> the loadavg field to 0 in the rrd file, as this value can't be=20
> negative.
>=20
> Index: prog/sensord/sensord.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- prog/sensord/sensord.h	(r=E9vision 5132)
> +++ prog/sensord/sensord.h	(copie de travail)
> @@ -79,6 +79,7 @@
>    DataType_voltage =3D 0,
>    DataType_rpm,
>    DataType_temperature,
> +  DataType_loadavg,
>    DataType_other =3D -1
>  } DataType;
> =20
> Index: prog/sensord/rrd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- prog/sensord/rrd.c	(r=E9vision 5132)
> +++ prog/sensord/rrd.c	(copie de travail)
> @@ -202,6 +202,10 @@
>          min =3D "0";
>          max =3D "250";
>          break;
> +      case DataType_loadavg:
> +        min =3D "0";
> +        max =3D "U";
> +        break;
>        default:
>          min =3D max =3D "U";
>          break;
> @@ -217,8 +221,11 @@
>    int ret =3D 0;
>    struct ds data =3D { 0, argv};
>    ret =3D applyToFeatures (rrdGetSensors_DS, &data);
> -  if (!ret && doLoad)
> -    ret =3D rrdGetSensors_DS (&data, LOADAVG, LOAD_AVERAGE, NULL);
> +  if (!ret && doLoad) {
> +    FeatureDescriptor feature;
> +    feature.type =3D DataType_loadavg;
> +    ret =3D rrdGetSensors_DS (&data, LOADAVG, LOAD_AVERAGE, &feature);
> +  }
>    return ret ? -1 : data.num;
>  }
> =20

What does this change in practice? What's the benefit?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
