From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 15 Nov 2009 15:49:33 +0000
Subject: Re: [lm-sensors] [PATCH v2 02/10] LIS3LV02D: Correct memory leak in
Message-Id: <4B00230D.3090808@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-3-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-3-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: daniel@caiaq.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 10-11-09 13:41, Samu Onkalo schreef:
> polled input device itself was not free'd.
>=20
> Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
> ---
>  drivers/hwmon/lis3lv02d.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> index 7f43a3b..dbd0b05 100644
> --- a/drivers/hwmon/lis3lv02d.c
> +++ b/drivers/hwmon/lis3lv02d.c
> @@ -333,6 +333,7 @@ void lis3lv02d_joystick_disable(void)
>  	if (lis3_dev.irq)
>  		misc_deregister(&lis3lv02d_misc_device);
>  	input_unregister_polled_device(lis3_dev.idev);
> +	input_free_polled_device(lis3_dev.idev);
>  	lis3_dev.idev =3D NULL;
>  }
>  EXPORT_SYMBOL_GPL(lis3lv02d_joystick_disable);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
