From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 21 Feb 2014 05:21:55 +0000
Subject: Re: [lm-sensors] [PATCH] sensors.conf.default: Add default voltage settings for nct6791
Message-Id: <5306E273.2080104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140220212423.0bd23f8f@endymion.delvare>
In-Reply-To: <20140220212423.0bd23f8f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 02/20/2014 12:24 PM, Jean Delvare wrote:
> Guenter, do I get it right that the NCT6791 has the same voltage input
> constraints as the NCT6775 and NCT6776?
>
Hi Jean,

Yes, this is correct.

> Are there other Nuvoton chips that should be added to the list?
>
NCT6779.

Note that NCT6791 and NCT6779 have 15 voltage monitoring registers.

Guenter

> Index: etc/sensors.conf.default
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- etc/sensors.conf.default	(r=E9vision 6222)
> +++ etc/sensors.conf.default	(copie de travail)
> @@ -308,7 +308,7 @@
>   #    set in8_max  3.0 * 1.10
>
>
> -chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
> +chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*" "n=
ct6791-*"
>
>       label in0 "Vcore"
>       label in2 "AVCC"
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
