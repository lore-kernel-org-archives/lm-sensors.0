From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Jun 2009 11:48:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: Add documentation for tmp421
Message-Id: <20090616134858.0e417fe4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090615074339.GC4667@ubuntu>
In-Reply-To: <20090615074339.GC4667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 15 Jun 2009 09:43:39 +0200, Andre Prendel wrote:
> This patch adds documentation for driver tmp421.
>=20
> Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
> ---
>  tmp421 |   36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> Index: linux-2.6/Documentation/hwmon/tmp421
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null	1970-01-01 00:00:00.000000000 +0=
000
> +++ linux-2.6/Documentation/hwmon/tmp421	2009-06-11 21:50:46.000000000 +0=
200
> @@ -0,0 +1,36 @@
> +Kernel driver tmp421
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +  * Texas Instruments TMP421
> +    Prefix: 'tmp421'
> +    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
> +  * Texas Instruments TMP422
> +    Prefix: 'tmp422'
> +    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
> +  * Texas Instruments TMP423
> +    Prefix: 'tmp423'
> +    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
> +    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
> +
> +Authors:
> +	Andre Prendel <andre.prendel@gmx.de>
> +
> +Description
> +-----------
> +
> +This driver implements support for Texas Instruments TMP421, TMP422
> +and TMP423 temperature sensor chips. These chips implements one local

Spelling: implement.

> +and up to one (TMP421), up to two (TMP422) or up to three (TMP423)
> +remote sensors. Temperature is measured in degrees Celsius. The chips
> +are wired over I2C/SMBus and specified over a temperature range of
> +-40=B0C to +125=B0C. Resolution for both the local and remote channels is
> +0.0625=B0C.

The degree symbol is not ASCII, I'd suggest spelling it "degree C" to
avoid charset headaches.

> +
> +The chips supports only temperature measurement and exports these

Spelling: support. Also, the drivers exports the values to sysfs, not
the chips.

> +values via following sysfs-interface:
> +
> +temp[1-4]_input
> +temp[2-4]_fault

Maybe you could add a section explaining that not all possible
addresses are probed by default, why and how to work around it if
needed.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
