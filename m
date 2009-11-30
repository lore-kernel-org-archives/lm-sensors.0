From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Mon, 30 Nov 2009 15:18:42 +0000
Subject: Re: [lm-sensors] [PATCH v3 5/5] LIS3: Update documentation to match
Message-Id: <4B13E252.7040800@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258622842-23129-1-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-2-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-3-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-4-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-5-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-6-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1258622842-23129-6-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 19-11-09 10:27, Samu Onkalo schreef:
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> ---
>  Documentation/hwmon/lis3lv02d |   31 ++++++++++++++++++++++++-------
>  1 files changed, 24 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/hwmon/lis3lv02d b/Documentation/hwmon/lis3lv02d
> index 21f0902..cd354e3 100644
> --- a/Documentation/hwmon/lis3lv02d
> +++ b/Documentation/hwmon/lis3lv02d
> @@ -20,18 +20,35 @@ sporting the feature officially called "HP Mobile Dat=
a Protection System 3D" or
>  models (full list can be found in drivers/hwmon/hp_accel.c) will have th=
eir
>  axis automatically oriented on standard way (eg: you can directly play
>  neverball). The accelerometer data is readable via
> -/sys/devices/platform/lis3lv02d.
> +/sys/devices/platform/lis3lv02d. Reported values are scaled
> +to mg values (1/1000th of earth gravity).
> =20
>  Sysfs attributes under /sys/devices/platform/lis3lv02d/:
>  position - 3D position that the accelerometer reports. Format: "(x,y,z)"
> -calibrate - read: values (x, y, z) that are used as the base for input
> -		  class device operation.
> -            write: forces the base to be recalibrated with the current
> -		   position.
> -rate - reports the sampling rate of the accelerometer device in HZ
> +rate - read reports the sampling rate of the accelerometer device in HZ.
> +	write changes sampling rate of the accelerometer device.
> +	Only values which are supported by HW are accepted.
> +selftest - performs selftest for the chip as specified by chip manufactu=
rer.
> =20
>  This driver also provides an absolute input class device, allowing
> -the laptop to act as a pinball machine-esque joystick.
> +the laptop to act as a pinball machine-esque joystick. Joystick device c=
an be
> +calibrated. Joystick device can be in two different modes.
> +By default output values are scaled between -32768 .. 32767. In joystick=
 raw
> +mode, joystick and sysfs position entry have the same scale. There can be
> +small difference due to input system fuzziness feature.
> +Events are also available as input event device.
> +
> +Selftest is meant only for hardware diagnostic purposes. It is not meant=
 to be
> +used during normal operations. Position data is not corrupted during sel=
ftest
> +but interrupt behaviour is not quaranteed to work reliably. In test mode=
, the
> +sensing element is internally moved little bit. Selftest measures differ=
ence
> +between normal mode and test mode. Chip specifications tell the acceptan=
ce
> +limit for each type of the chip. Limits are provided via platform data
> +to allow adjustment of the limits without a change to the actual driver.
> +Seltest returns either "OK x y z" or "FAIL x y z" where x, y and z are
> +measured difference between modes. Axes are not remapped in selftest mod=
e.
> +Measurement values are provided to help HW diagnostic applications to ma=
ke
> +final decision.
> =20
>  On HP laptops, if the led infrastructure is activated, support for a led
>  indicating disk protection will be provided as /sys/class/leds/hp::hddpr=
otect.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
