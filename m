From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Tue, 19 Jun 2012 17:37:10 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: (applesmc) Do not return random value in error case
Message-Id: <20120619173710.GA2174@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340120803-23543-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340120803-23543-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 19, 2012 at 08:46:41AM -0700, Guenter Roeck wrote:
> If a bad parameter is passed to applesmc_read_motion_sensor(), an uninitialized
> and thus arbitrary value is returned. Fix by returning immediately if a bad
> parameter is detected.
> 
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/applesmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index f082e48..cc8dd57 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -450,7 +450,7 @@ static int applesmc_read_motion_sensor(int index, s16 *value)
>  		ret = applesmc_read_key(MOTION_SENSOR_Z_KEY, buffer, 2);
>  		break;
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
>  
>  	*value = ((s16)buffer[0] << 8) | buffer[1];
> -- 
> 1.7.9.7
> 

Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
