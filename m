From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 18:58:24 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for MAX6642
Message-Id: <20110406185824.GA26734@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D9CB118.80103@appeartv.com>
In-Reply-To: <4D9CB118.80103@appeartv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Per,

On Wed, Apr 06, 2011 at 02:29:44PM -0400, Per Dal=E9n wrote:
> First a big thanks to Guenter Roeck for helping me (allot) to cleanup
> this driver
>=20
> v3 -> v4:
>  * Removed "data->valid =3D 0;" (missed that in v3 ;)
>  * only read the limits once
>  * changed the temp_input and temp_high as suggested by Guenter, also
> changed the functions/macros related to that change

> MAX6642 is a SMBus-Compatible Remote/Local Temperature Sensor with Overte=
mperature Alarm from Maxim.
> =20
> Signed-off-by: Per Dalen <per.dalen@appeartv.com>
>=20
Sorry, one more detail I just noticed. More of a question.

[ ... ]
> +
> +static struct max6642_data *max6642_update_device(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct max6642_data *data =3D i2c_get_clientdata(client);
> +	u16 val, tmp;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, data->last_updated + HZ * 8) || !data->valid) {

Are you sure you only want to update readings every 8 seconds ?

Also, after spending all this time on this driver (and after falling into
the same trap last night with another driver ;), it looks like this is real=
ly
just another variant of the lm90, and adding support for max6642 to the lm90
driver might be quite trivial. Have you considered this ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
