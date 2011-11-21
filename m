From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Date: Mon, 21 Nov 2011 13:31:23 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Fix checkpatch errors
Message-Id: <CAM=Q2ctHFmaJJrAxfu3+u2e-Ug7+umOOa6=d3DYVq0ghFi3hJA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, Nov 21, 2011 at 4:12 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> =A0drivers/hwmon/lm63.c | =A0 74 +++++++++++++++++++++++++++++++++++-----=
---------
> =A01 files changed, 53 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
> index 508cb29..e02d7f0 100644
> --- a/drivers/hwmon/lm63.c
> +++ b/drivers/hwmon/lm63.c
> @@ -204,7 +204,12 @@ static ssize_t set_fan(struct device *dev, struct de=
vice_attribute *dummy,
> =A0{
> =A0 =A0 =A0 =A0struct i2c_client *client =3D to_i2c_client(dev);
> =A0 =A0 =A0 =A0struct lm63_data *data =3D i2c_get_clientdata(client);
> - =A0 =A0 =A0 unsigned long val =3D simple_strtoul(buf, NULL, 10);
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D kstrtoul(buf, 10, &val);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>
> =A0 =A0 =A0 =A0mutex_lock(&data->update_lock);
> =A0 =A0 =A0 =A0data->fan[1] =3D FAN_TO_REG(val);
> @@ -231,11 +236,15 @@ static ssize_t set_pwm1(struct device *dev, struct =
device_attribute *dummy,
> =A0 =A0 =A0 =A0struct i2c_client *client =3D to_i2c_client(dev);
> =A0 =A0 =A0 =A0struct lm63_data *data =3D i2c_get_clientdata(client);
> =A0 =A0 =A0 =A0unsigned long val;
> -
> + =A0 =A0 =A0 int err;
> +
> =A0 =A0 =A0 =A0if (!(data->config_fan & 0x20)) /* register is read-only */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EPERM;
>
> - =A0 =A0 =A0 val =3D simple_strtoul(buf, NULL, 10);
> + =A0 =A0 =A0 err =3D kstrtoul(buf, 10, &val);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
Since the valid range is upto 255 do we still need string to long ?


> =A0 =A0 =A0 =A0mutex_lock(&data->update_lock);
> =A0 =A0 =A0 =A0data->pwm1_value =3D val <=3D 0 ? 0 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val >=3D 255 ? 2 * da=
ta->pwm1_freq :
> @@ -245,8 +254,8 @@ static ssize_t set_pwm1(struct device *dev, struct de=
vice_attribute *dummy,
> =A0 =A0 =A0 =A0return count;
> =A0}
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
