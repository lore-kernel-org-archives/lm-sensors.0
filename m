From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 26 Mar 2011 07:56:25 +0000
Subject: Re: [lm-sensors] [PATCH] Add all new Fintek chips to default config
Message-Id: <4D8D9C29.2000908@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110325161923.4fd7e1b1@endymion.delvare>
In-Reply-To: <20110325161923.4fd7e1b1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

On 03/25/2011 04:19 PM, Jean Delvare wrote:
> Hans, given that the f71882fg driver delegates the scaling of internal
> voltages to user-space, I think we need the following config entries
> for the new Fintek chips to have good-looking outputs by default?
>

Agreed, ACK. And thanks for taking care of this.

Regards,

Hans


> Index: etc/sensors.conf.default
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- etc/sensors.conf.default	(r=E9vision 5945)
> +++ etc/sensors.conf.default	(copie de travail)
> @@ -433,7 +433,8 @@
>       set in6_max  3.0 * 1.10
>
>
> -chip "f71882fg-*"
> +chip "f71808e-*" "f71862fg-*" "f71869-*" "f71882fg-*" \
> +     "f71889fg-*" "f71889ed-*" "f71889a-*"
>
>       label in0 "+3.3V"
>       label in7 "3VSB"
> @@ -444,7 +445,7 @@
>       compute in8  @*2, @/2
>
>
> -chip "f8000-*"
> +chip "f71858fg-*" "f8000-*"
>
>       label in0 "+3.3V"
>       label in1 "3VSB"
> @@ -455,6 +456,17 @@
>       compute in2  @*2, @/2
>
>
> +chip "f81865f-*"
> +
> +    label in0 "+3.3V"
> +    label in5 "3VSB"
> +    label in6 "Vbat"
> +
> +    compute in0  @*2, @/2
> +    compute in5  @*2, @/2
> +    compute in6  @*2, @/2
> +
> +
>   chip "adt7473-*" "adt7475-*"
>
>       label in2 "+3.3V"
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
