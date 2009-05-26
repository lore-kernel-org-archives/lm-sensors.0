From: Hector Oron <hector.oron@gmail.com>
Date: Tue, 26 May 2009 15:08:22 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <dd0a3d700905260808p1a264254td05eff3624206f23@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

2009/5/26 Ben Dooks <ben@simtec.co.uk>:
> + =A0 =A0 =A0 /* Register with the core ADC driver. */
> +
> + =A0 =A0 =A0 hwmon->client =3D s3c_adc_register(dev, NULL, s3c_hwmon_adc=
done, 0);

I have been trying out this code and when compiling I get a warning,

  CC [M]  drivers/hwmon/s3c-adc.o
drivers/hwmon/s3c-adc.c: In function 's3c_hwmon_probe':
drivers/hwmon/s3c-adc.c:275: warning: passing argument 3 of
's3c_adc_register' from
er type

s3c_hwmon_adcdone is a callback function and register function is
expecting something like "void (*conv)(unsigned d0, unsigned d1)"

I quite do not understand it very well to propose a patch.

Cheers

--=20
 H=E9ctor Or=F3n

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
