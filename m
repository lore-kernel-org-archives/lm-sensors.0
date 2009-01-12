From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Jan 2009 12:14:36 +0000
Subject: Re: [lm-sensors] Patch: libsensors: add support for ACPI bus
Message-Id: <20090112131436.39cfb417@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <495D3AFC.5040809@redhat.com>
In-Reply-To: <495D3AFC.5040809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

Sorry for the late answer.

On Thu, 01 Jan 2009 22:51:56 +0100, Hans de Goede wrote:
> The way the new atk0110 driver work it ends up being connected to an "ACP=
I"=20
> bus, this patch adds support for this to lm_sensors-3.0.3
>=20
> With this patch the sensors output on an Asus board looks like this:
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:          +1.45 V  (min =3D  +1.45 V, max =3D  +1.75 V)
>   +3.3 Voltage:          +3.38 V  (min =3D  +3.00 V, max =3D  +3.60 V)
>   +5.0 Voltage:          +5.16 V  (min =3D  +4.50 V, max =3D  +5.50 V)
> +12.0 Voltage:         +12.24 V  (min =3D +11.20 V, max =3D +13.20 V)
> CPU FAN Speed:         1516 RPM  (min =3D    0 RPM)
> CHASSIS FAN Speed:        0 RPM  (min =3D    0 RPM)
> POWER FAN Speed:          0 RPM  (min =3D    0 RPM)
> CHASSIS4 FAN FAN Speed:   0 RPM  (min =3D    0 RPM)
> CHASSIS2 FAN FAN Speed:   0 RPM  (min =3D    0 RPM)
> CHASSIS3 FAN FAN Speed:   0 RPM  (min =3D    0 RPM)
> CPU Temperature:        +43.0=B0C  (high =3D +90.0=B0C, crit =3D +125.0=
=B0C)
> MB Temperature:         +44.0=B0C  (high =3D +45.0=B0C, crit =3D +90.0=B0=
C)
>=20
>=20
> Jean, can you please review this patch, if its ok I can apply it myself.

I have no objection, the patch looks just fine to me, just go ahead and
apply it. Please don't forget to apply the libsensors-API document.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
