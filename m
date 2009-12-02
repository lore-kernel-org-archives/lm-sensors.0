From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Wed, 02 Dec 2009 17:40:59 +0000
Subject: Re: [lm-sensors] [PATCH v4 5/5] LIS3: Update documentation to match
Message-Id: <20091202094059.9cec6e27.randy.dunlap@oracle.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1259656422-7697-1-git-send-email-samu.p.onkalo@nokia.com>
	<1259656422-7697-2-git-send-email-samu.p.onkalo@nokia.com>
	<1259656422-7697-3-git-send-email-samu.p.onkalo@nokia.com>
	<1259656422-7697-4-git-send-email-samu.p.onkalo@nokia.com>
	<1259656422-7697-5-git-send-email-samu.p.onkalo@nokia.com>
	<1259656422-7697-6-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1259656422-7697-6-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: eric.piel@tremplin-utc.net, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue,  1 Dec 2009 10:33:42 +0200 Samu Onkalo wrote:

> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
> Acked-by: =C9ric Piel <eric.piel@tremplin-utc.net>
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

                                  guaranteed

Otherwise looks good.  Thanks.

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


---
~Randy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
