From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 17 Jul 2013 23:36:32 +0000
Subject: Re: [lm-sensors] [patch] hwmon: using wrong ARRAY_SIZE() limit
Message-Id: <20130717233632.GD2120@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130717084317.GA4851@elgon.mountain>
In-Reply-To: <20130717084317.GA4851@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Wed, Jul 17, 2013 at 03:26:14PM +0300, Dan Carpenter wrote:
> We cleaned up this code to use ARRAY_SIZE() instead of just the number
> 4.  The problem is that data->reg_temp[] has 5 elements and we actually
> wanted ARRAY_SIZE(data->temp) which has 4 elements.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
Hi Dan,

good catch, except that the array size of data->temp[] should be 5, not 4.
So the real culprit is commit 7cbbd6a (Add support for critical low/high
temperature limits on NCT6106) which increased the size of reg_temp but not the
size of temp.

Do you want to send me a patch fixing that, or should I take care of it ?

Thanks,
Guenter

> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index f0941d7..52b6a92 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -1451,7 +1451,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
>  		for (i = 0; i < NUM_TEMP; i++) {
>  			if (!(data->have_temp & (1 << i)))
>  				continue;
> -			for (j = 0; j < ARRAY_SIZE(data->reg_temp); j++) {
> +			for (j = 0; j < ARRAY_SIZE(data->temp); j++) {
>  				if (data->reg_temp[j][i])
>  					data->temp[j][i]
>  					  = nct6775_read_temp(data,
> @@ -3974,7 +3974,7 @@ static int nct6775_resume(struct device *dev)
>  		if (!(data->have_temp & (1 << i)))
>  			continue;
>  
> -		for (j = 1; j < ARRAY_SIZE(data->reg_temp); j++)
> +		for (j = 1; j < ARRAY_SIZE(data->temp); j++)
>  			if (data->reg_temp[j][i])
>  				nct6775_write_temp(data, data->reg_temp[j][i],
>  						   data->temp[j][i]);
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
