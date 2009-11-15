From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 15 Nov 2009 15:49:08 +0000
Subject: Re: [lm-sensors] [PATCH v2 01/10] LIS3LV02D: Send sync event
Message-Id: <4B0022F4.3040401@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: daniel@caiaq.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 10-11-09 13:41, Samu Onkalo schreef:
> Send input_sync after each measurement round. This helps userspace to
> detect which reported values belongs to the same measurement.
>=20
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

> ---
>  drivers/hwmon/lis3lv02d.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> index cf5afb9..7f43a3b 100644
> --- a/drivers/hwmon/lis3lv02d.c
> +++ b/drivers/hwmon/lis3lv02d.c
> @@ -276,6 +276,7 @@ static void lis3lv02d_joystick_poll(struct input_poll=
ed_dev *pidev)
>  	input_report_abs(pidev->input, ABS_X, x - lis3_dev.xcalib);
>  	input_report_abs(pidev->input, ABS_Y, y - lis3_dev.ycalib);
>  	input_report_abs(pidev->input, ABS_Z, z - lis3_dev.zcalib);
> +	input_sync(pidev->input);
>  }
> =20
> =20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
