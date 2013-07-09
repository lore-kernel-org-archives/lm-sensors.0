From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 09 Jul 2013 06:15:15 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm90) add support to handle irq
Message-Id: <20130709061514.GB17499@mithrandir>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2942155981179491748=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1372924670-16355-1-git-send-email-wni@nvidia.com>
 <1372924670-16355-3-git-send-email-wni@nvidia.com>
In-Reply-To: <1372924670-16355-3-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--===============2942155981179491748==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 03:57:49PM +0800, Wei Ni wrote:
> Add support to handle irq. When the temperature touch

Nit: This first sentence can be dropped. It merely repeats the subject.
And another nit: "irq" -> "IRQ"

> the limit value, the driver can handle the interrupt.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 2cb7f8e..fce9dfa 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -89,6 +89,7 @@
>  #include <linux/err.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/interrupt.h>
> =20
>  /*
>   * Addresses to scan
> @@ -1423,6 +1424,18 @@ static void lm90_init_client(struct i2c_client *cl=
ient)
>  		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);
>  }
> =20
> +static void lm90_alert(struct i2c_client *client, unsigned int flag);

Any reason why the implementation of lm90_alert() can't be moved here.
Granted, it'll make the diff larger but at least it'll allow us to get
rid of the forward declaration.

> +static irqreturn_t lm90_irq_thread(int irq, void *dev_id)
> +{
> +	struct lm90_data *data =3D dev_id;
> +	struct i2c_client *client =3D to_i2c_client(data->hwmon_dev->parent);
> +
> +	lm90_alert(client, 0);
> +
> +	return IRQ_HANDLED;
> +}

Isn't this potentially dangerous, since if the IRQ was shared, IRQ
processing will always stop after this handler. Shouldn't you check
whether the device actually triggered an interrupt (by reading the
interrupt status register)?

> +
>  static int lm90_probe(struct i2c_client *client,
>  		      const struct i2c_device_id *id)
>  {
> @@ -1499,6 +1512,18 @@ static int lm90_probe(struct i2c_client *client,
>  		goto exit_remove_files;
>  	}
> =20
> +	if (client->irq >=3D 0) {
> +		dev_dbg(dev, "lm90 irq: %d\n", client->irq);

Nit: "irq" -> "IRQ"

Thierry

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR26pyAAoJEN0jrNd/PrOhAs0QAKtJ+crf4masyOYYczW7cFWO
tqEE6aaXzEg/1LBXfdEVIo2BKCEMYhgOJB909FwheCyV3ruPDrZKNod+AFmbRMsK
y6DEpB3lal5o6SCpNz41mNQwv1UGvf05ntrnWXFEfhuEJhXAX44A1bvzVutKv1eO
Lusn3eU9q0Rb5d2fVUEjN6s5P2zM7CHU2h5Hr256KTxHN58DUSrevaEmSDnarnEZ
G3c5TFHVp2j7zibalNxtuDNyIVKRiRzn6ZZT7RKil6CkhdUk0SG9nn0AdCZe6Wxk
HukhnhLqiYWb3GL/HveOS9wGnGzJxvX2OO9S6yUNpqND1hYD5bGxfRqSLLJ5Hnmi
iu0YGF+yMcpNYGcl1oSctCTyN9aytOcNaxd9J+ik2GyE2RvrQHR0uTW8rJrePXKy
vrg/br26FiDOD/2eCLaGHen1vXCOjXKxiXim3zyrid5IZFFkXuuGUwuFslcqBK0T
fpMKR3EAZ9HW2CTAy4M3jqABvynIm18iRYFN97zxIcm7qEOktgxL8EpI95qOT4YE
aTBBqFE4gKESrqFfkyenYu9K+G+GTpeGwGuRp6gLasYZ3v8XJtRueFtL9oSG+zLp
4Zvq1oDp96XPJbrxOile1fRw55U8MQpfGzppNNmukljafdBgdTNDpHx+LbdrFoa3
W83Wxz/IUZhffPUD1G8C
=vQz9
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--


--===============2942155981179491748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2942155981179491748==--
