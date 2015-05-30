From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 May 2015 18:17:28 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (atxp1) Drop auto-detection
Message-Id: <5569FEB8.4090101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432931265-21499-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432931265-21499-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/29/2015 01:27 PM, Guenter Roeck wrote:
> Auto-detection for this chip is highly unreliable, and one of its
> I2C addresses can also be used by EEPROMs, increasing the risk for
> false positives even more. Drop auto-detection entirely to remove
> the risk.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Add text describing the supported I2C addresses, and that the driver
>      must be instantiated explicitly.
>      Validate supported vrm values in probe function.
>
[ ... ]

> -
>   static int atxp1_probe(struct i2c_client *client,
>   		       const struct i2c_device_id *id)
>   {
> @@ -309,6 +269,11 @@ static int atxp1_probe(struct i2c_client *client,
>
>   	/* Get VRM */
>   	data->vrm = vid_which_vrm();
> +	if (data->vrm != 90 && data->vrm != 91) {
> +		 dev_err(&adapter->dev, "atxp1: Not supporting VRM %d.%d\n",
> +			 data->vrm / 10, data->vrm % 10);

s/&adapter->//

Compile testing is always a good idea.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
