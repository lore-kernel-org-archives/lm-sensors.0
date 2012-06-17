From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 11:50:07 +0000
Subject: Re: [lm-sensors] [PATCH 76/95] hwmon: (tmp102) Convert to use devm_ functions
Message-Id: <20120617135007.593b0d8c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-77-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-77-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 08:23:57 -0700, Guenter Roeck wrote:
> Convert to use devm_ functions to reduce code size and simplify the code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp102.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
> index 0d466b9..b6cda09 100644
> --- a/drivers/hwmon/tmp102.c
> +++ b/drivers/hwmon/tmp102.c
> @@ -159,9 +159,9 @@ static int __devinit tmp102_probe(struct i2c_client *client,
>  		return -ENODEV;
>  	}
>  
> -	tmp102 = kzalloc(sizeof(*tmp102), GFP_KERNEL);
> +	tmp102 = devm_kzalloc(&client->dev, sizeof(*tmp102), GFP_KERNEL);
>  	if (!tmp102) {
> -		dev_dbg(&client->dev, "kzalloc failed\n");
> +		dev_dbg(&client->dev, "devm_kzalloc failed\n");

I'd think it's not worth updating these messages, devm_kzalloc is just
one flavor of kzalloc.

(These messages are useless anyway, as explained in a previous review.)

In any case:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
