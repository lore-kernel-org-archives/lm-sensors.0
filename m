From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 15 Nov 2009 15:54:21 +0000
Subject: Re: [lm-sensors] [PATCH v2 07/10] LIS3LV02D: Remove calibaration
Message-Id: <4B00242D.1050704@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-3-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-4-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-5-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-6-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-7-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-8-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-8-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: daniel@caiaq.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 10-11-09 13:41, Samu Onkalo schreef:
> Chip is calibrated by the manufacturer. There is no need to calibarate
> it at driver level. If the chip is used as a joystick, calibaration can
> be done using joystick device calibration mechanism.
>=20
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
> ---
>  drivers/hwmon/lis3lv02d.c |   32 +++-----------------------------
>  drivers/hwmon/lis3lv02d.h |    3 ---
>  2 files changed, 3 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> index 0335b36..5b39257 100644
> --- a/drivers/hwmon/lis3lv02d.c
> +++ b/drivers/hwmon/lis3lv02d.c
> @@ -344,19 +344,12 @@ static void lis3lv02d_joystick_poll(struct input_po=
lled_dev *pidev)
>  	int x, y, z;
> =20
>  	lis3lv02d_get_xyz(&lis3_dev, &x, &y, &z);
> -	input_report_abs(pidev->input, ABS_X, x - lis3_dev.xcalib);
> -	input_report_abs(pidev->input, ABS_Y, y - lis3_dev.ycalib);
> -	input_report_abs(pidev->input, ABS_Z, z - lis3_dev.zcalib);
> +	input_report_abs(pidev->input, ABS_X, x);
> +	input_report_abs(pidev->input, ABS_Y, y);
> +	input_report_abs(pidev->input, ABS_Z, z);
>  	input_sync(pidev->input);
>  }
> =20
> -
> -static inline void lis3lv02d_calibrate_joystick(void)
> -{
> -	lis3lv02d_get_xyz(&lis3_dev,
> -		&lis3_dev.xcalib, &lis3_dev.ycalib, &lis3_dev.zcalib);
> -}
> -
>  int lis3lv02d_joystick_enable(void)
>  {
>  	struct input_dev *input_dev;
> @@ -373,8 +366,6 @@ int lis3lv02d_joystick_enable(void)
>  	lis3_dev.idev->poll_interval =3D MDPS_POLL_INTERVAL;
>  	input_dev =3D lis3_dev.idev->input;
> =20
> -	lis3lv02d_calibrate_joystick();
> -
>  	input_dev->name       =3D "ST LIS3LV02DL Accelerometer";
>  	input_dev->phys       =3D DRIVER_NAME "/input0";
>  	input_dev->id.bustype =3D BUS_HOST;
> @@ -430,20 +421,6 @@ static ssize_t lis3lv02d_position_show(struct device=
 *dev,
>  	return sprintf(buf, "(%d,%d,%d)\n", x, y, z);
>  }
> =20
> -static ssize_t lis3lv02d_calibrate_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	return sprintf(buf, "(%d,%d,%d)\n", lis3_dev.xcalib, lis3_dev.ycalib, l=
is3_dev.zcalib);
> -}
> -
> -static ssize_t lis3lv02d_calibrate_store(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf, size_t count)
> -{
> -	lis3lv02d_calibrate_joystick();
> -	return count;
> -}
> -
>  static ssize_t lis3lv02d_rate_show(struct device *dev,
>  			struct device_attribute *attr, char *buf)
>  {
> @@ -452,14 +429,11 @@ static ssize_t lis3lv02d_rate_show(struct device *d=
ev,
> =20
>  static DEVICE_ATTR(selftest, S_IRUGO, lis3lv02d_selftest_show, NULL);
>  static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
> -static DEVICE_ATTR(calibrate, S_IRUGO|S_IWUSR, lis3lv02d_calibrate_show,
> -	lis3lv02d_calibrate_store);
>  static DEVICE_ATTR(rate, S_IRUGO, lis3lv02d_rate_show, NULL);
> =20
>  static struct attribute *lis3lv02d_attributes[] =3D {
>  	&dev_attr_selftest.attr,
>  	&dev_attr_position.attr,
> -	&dev_attr_calibrate.attr,
>  	&dev_attr_rate.attr,
>  	NULL
>  };
> diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
> index 655875e..a692116 100644
> --- a/drivers/hwmon/lis3lv02d.h
> +++ b/drivers/hwmon/lis3lv02d.h
> @@ -216,9 +216,6 @@ struct lis3lv02d {
>  	struct input_polled_dev	*idev;     /* input device */
>  	struct platform_device	*pdev;     /* platform device */
>  	atomic_t		count;     /* interrupt count after last read */
> -	int			xcalib;    /* calibrated null value for x */
> -	int			ycalib;    /* calibrated null value for y */
> -	int			zcalib;    /* calibrated null value for z */
>  	struct axis_conversion	ac;        /* hw -> logical axis */
> =20
>  	u32			irq;       /* IRQ number */


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
