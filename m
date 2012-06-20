From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jun 2012 14:40:55 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (ntc_thermistor) Ensure that data->name string is terminated
Message-Id: <20120620164055.4dc30ed0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340120803-23543-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340120803-23543-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Jun 2012 08:46:40 -0700, Guenter Roeck wrote:
> Fix Coverity warning: Calling strncpy with a maximum size argument of 20 bytes
> on destination array "data->name" of size 20 bytes might leave the destination
> string unterminated.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/ntc_thermistor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
> index 6da9696..e46a5b2 100644
> --- a/drivers/hwmon/ntc_thermistor.c
> +++ b/drivers/hwmon/ntc_thermistor.c
> @@ -351,7 +351,7 @@ static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
>  
>  	data->dev = &pdev->dev;
>  	data->pdata = pdata;
> -	strncpy(data->name, pdev->id_entry->name, PLATFORM_NAME_SIZE);
> +	strncpy(data->name, pdev->id_entry->name, sizeof(data->name) - 1);
>  
>  	switch (pdev->id_entry->driver_data) {
>  	case TYPE_NCPXXWB473:

Please use strlcpy instead, it's meant exactly for this. strncpy is
evil and should be discarded IMHO.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
