From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Jan 2012 22:29:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] lm90.c: fix checkpatch error
Message-Id: <1325716145.2649.32.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325716040-22310-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325716040-22310-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-01-04 at 17:27 -0500, Frans Meulenbroeks wrote:
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
>  drivers/hwmon/lm90.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 615bc4f..36dcbc9 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -388,9 +388,14 @@ static int lm90_read16(struct i2c_client *client, u8 regh, u8 regl, u16 *value)
>  	 * we have to read the low byte again, and now we believe we have a
>  	 * correct reading.
>  	 */
> -	if ((err = lm90_read_reg(client, regh, &oldh))
> -	 || (err = lm90_read_reg(client, regl, &l))
> -	 || (err = lm90_read_reg(client, regh, &newh)))
> +	err = lm90_read_reg(client, regh, &oldh);
> +	if (err)
> +		return err;
> +	err = lm90_read_reg(client, regl, &l);
> +	if (err)
> +		return err;
> +	err = lm90_read_reg(client, regh, &newh);
> +	if (err)
>  		return err;
>  	if (oldh != newh) {
>  		err = lm90_read_reg(client, regl, &l);

Ah, we left those in for readability.

Guenter




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
