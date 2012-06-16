From: George Joseph <george.joseph@fairview5.com>
Date: Sat, 16 Jun 2012 19:54:53 +0000
Subject: Re: [lm-sensors] [PATCH 23/95] hwmon: (asc7621) Convert to use devm_ functions
Message-Id: <CAHKv19CdKPAGtKpw_Y=xVYw+cu4cXjTYKdCwJP0_UrGSL2zR=Q@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-24-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-24-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jun 15, 2012 at 9:23 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Convert to use devm_ functions to reduce code size and simplify the code.
>
> Cc: George Joseph <george.joseph@fairview5.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: George Joseph <george.joseph@fairview5.com>

Thanks Guenter!

> ---
> =A0drivers/hwmon/asc7621.c | =A0 =A05 ++---
> =A01 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/asc7621.c b/drivers/hwmon/asc7621.c
> index 7caa242..b867aab7 100644
> --- a/drivers/hwmon/asc7621.c
> +++ b/drivers/hwmon/asc7621.c
> @@ -1109,7 +1109,8 @@ asc7621_probe(struct i2c_client *client, const
> struct i2c_device_id *id)
> =A0 =A0 =A0 =A0if (!i2c_check_functionality(client->adapter,
> I2C_FUNC_SMBUS_BYTE_DATA))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EIO;
>
> - =A0 =A0 =A0 data =3D kzalloc(sizeof(struct asc7621_data), GFP_KERNEL);
> + =A0 =A0 =A0 data =3D devm_kzalloc(&client->dev, sizeof(struct asc7621_d=
ata),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> =A0 =A0 =A0 =A0if (data =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> @@ -1143,7 +1144,6 @@ exit_remove:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(asc=
7621_params[i].sda.dev_attr));
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 kfree(data);
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> @@ -1192,7 +1192,6 @@ static int asc7621_remove(struct i2c_client *client)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &(asc=
7621_params[i].sda.dev_attr));
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 kfree(data);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.9.7
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
