From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Jan 2016 22:45:42 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] lm90: register with thermal zones
Message-Id: <20160122224542.GA26117@rob-hp-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1453404877-17897-1-git-send-email-stephan@kochen.nl>
 <1453404877-17897-4-git-send-email-stephan@kochen.nl>
In-Reply-To: <1453404877-17897-4-git-send-email-stephan-j6uo2F6POYhmR6Xm/wNWPw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?St=E9phan?= Kochen <stephan-j6uo2F6POYhmR6Xm/wNWPw@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Jan 21, 2016 at 08:34:37PM +0100, St=E9phan Kochen wrote:
> Any lm90-driven node in the device tree can now be referenced in thermal
> zones. One thermal zone device is registered for each sensor present.
>=20
> Signed-off-by: St=E9phan Kochen <stephan@kochen.nl>
> ---
>  Documentation/devicetree/bindings/hwmon/lm90.txt |  8 ++++
>  drivers/hwmon/lm90.c                             | 54 ++++++++++++++++++=
++++++
>  2 files changed, 62 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/lm90.txt b/Documenta=
tion/devicetree/bindings/hwmon/lm90.txt
> index 045e94b..da9aae7 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm90.txt
> +++ b/Documentation/devicetree/bindings/hwmon/lm90.txt
> @@ -28,6 +28,13 @@ Required node properties:
> =20
>  - vcc-supply: vcc regulator for the supply voltage.
> =20
> +- #thermal-sensor-cells: Should be 1. See ../../thermal/thermal.txt for a
> +                         description of this property. Use the following
> +                         values to refer to a specific sensor:
> +                         0: chip internal sensor
> +                         1: external sensor
> +                         2: second external sensor, if present

From my read of an LM90 datasheet, there is only an onchip sensor and a=20
single external one.

Rob

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
