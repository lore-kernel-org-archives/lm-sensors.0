From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Mar 2009 19:38:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/f75375s.c: remove unnecessary
Message-Id: <20090311203831.24429ddb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903111711.n2BHBbPs024221@pogo.cesa.opbu.xerox.com>
In-Reply-To: <200903111711.n2BHBbPs024221@pogo.cesa.opbu.xerox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Mar 2009 10:11:37 -0700, Andrew Klossner wrote:
> f75375_probe calls i2c_get_clientdata to initialize the data pointer,
> but there isn't yet any client data to get, and the value is never
> used before the variable is assigned a new value seven lines later.

Correct, good catch.

> The call doesn't hurt anything and wastes only a couple of cycles.
> The reason to fix it is because this module serves as an example to
> hackers writing new hwmon drivers, and this part of the example is
> confusing.

Out of curiosity, why would this driver be used as an example rather
than any of other?

> Signed-off-by: Andrew Klossner <andrew@cesa.opbu.xerox.com>
> ---
>  drivers/hwmon/f75375s.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
> index 1692de3..18a1ba8 100644
> --- a/drivers/hwmon/f75375s.c
> +++ b/drivers/hwmon/f75375s.c
> @@ -617,7 +617,7 @@ static void f75375_init(struct i2c_client *client, struct f75375_data *data,
>  static int f75375_probe(struct i2c_client *client,
>  		const struct i2c_device_id *id)
>  {
> -	struct f75375_data *data = i2c_get_clientdata(client);
> +	struct f75375_data *data;
>  	struct f75375s_platform_data *f75375s_pdata = client->dev.platform_data;
>  	int err;
>  

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
