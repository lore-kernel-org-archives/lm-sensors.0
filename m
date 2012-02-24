From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 24 Feb 2012 15:45:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max34440) Fix resetting temperature history
Message-Id: <20120224164537.25648b24@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1330095000-9846-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1330095000-9846-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 24 Feb 2012 06:50:00 -0800, Guenter Roeck wrote:
> Temperature history is reset by writing 0x8000 into the peak temperature
> register, not 0xffff.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/pmbus/max34440.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
> index beaf5a8..9b97a5b 100644
> --- a/drivers/hwmon/pmbus/max34440.c
> +++ b/drivers/hwmon/pmbus/max34440.c
> @@ -82,7 +82,7 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
>  	case PMBUS_VIRT_RESET_TEMP_HISTORY:
>  		ret = pmbus_write_word_data(client, page,
>  					    MAX34440_MFR_TEMPERATURE_PEAK,
> -					    0xffff);
> +					    0x8000);
>  		break;
>  	default:
>  		ret = -ENODATA;

Good catch.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
