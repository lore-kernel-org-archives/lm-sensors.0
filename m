From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 24 May 2014 14:55:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (nct6683) Fix probe unwind paths to properly unregister platform dev
Message-Id: <5380B2FE.8090702@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1400898016.10421.1.camel@phoenix>
In-Reply-To: <1400898016.10421.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/23/2014 07:20 PM, Axel Lin wrote:
> Call platform_device_unregister() rather than platform_device_put() to
> unregister successfully registered platform devices.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/hwmon/nct6683.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index 540c81c..1fd6098 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -1389,13 +1389,15 @@ static int __init sensors_nct6683_init(void)
>   		pdev[i] = platform_device_alloc(DRVNAME, address);
>   		if (!pdev[i]) {
>   			err = -ENOMEM;
> -			goto exit_device_put;
> +			goto exit_device_unregister;
>   		}
>
>   		err = platform_device_add_data(pdev[i], &sio_data,
>   					       sizeof(struct nct6683_sio_data));
> -		if (err)
> -			goto exit_device_put;
> +		if (err) {
> +			platform_device_put(pdev[i]);
> +			goto exit_device_unregister;
> +		}
>
>   		memset(&res, 0, sizeof(res));
>   		res.name = DRVNAME;
> @@ -1411,13 +1413,17 @@ static int __init sensors_nct6683_init(void)
>   		}
>
>   		err = platform_device_add_resources(pdev[i], &res, 1);
> -		if (err)
> -			goto exit_device_put;
> +		if (err) {
> +			platform_device_put(pdev[i]);
> +			goto exit_device_unregister;
> +		}
>
>   		/* platform_device_add calls probe() */
>   		err = platform_device_add(pdev[i]);
> -		if (err)
> -			goto exit_device_put;
> +		if (err) {
> +			platform_device_put(pdev[i]);
> +			goto exit_device_unregister;
> +		}
>   	}
>   	if (!found) {
>   		err = -ENODEV;
> @@ -1426,10 +1432,10 @@ static int __init sensors_nct6683_init(void)
>
>   	return 0;
>
> -exit_device_put:
> -	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
> +exit_device_unregister:
> +	while (--i >= 0) {

Hi Axel,

Good catch. Note that nct6775 has the same problem, if you want to tackle
the problem there as well.

I think something like

exit_device_put:
	platform_device_put(pdev[i]);
exit_device_unregister:
	while (--i >= 0)
		platform_device_unregister(pdev[i]);

would be better though since it saves all the individual calls to
platform_device_put(). Also, the if statement in the cleanup loop
is no longer necessary.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
