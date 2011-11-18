From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Nov 2011 09:35:01 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: adm1031: fixed spacing
Message-Id: <20111118103501.3c14d106@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321605413-13614-1-git-send-email-zac.3.14159@gmail.com>
In-Reply-To: <1321605413-13614-1-git-send-email-zac.3.14159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zac Storer <zac.3.14159@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, 18 Nov 2011 01:36:53 -0700, Zac Storer wrote:
> Fixed spacing coding style issues.
> 
> Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
> ---
>  drivers/hwmon/adm1031.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index 0683e6b..694392b 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -1058,7 +1058,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
>  			data->alarm &= 0xc0ff;
>  		}
>  
> -		for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
> +		for (chan = 0; chan < (data->chip_type = adm1030 ? 1 : 2); chan++) {
>  			data->fan_div[chan] >  			    adm1031_read_value(client, ADM1031_REG_FAN_DIV(chan));
>  			data->fan_min[chan] 
Err, you apparently did not understand my request. Please send _one_
patch fixing all the adm1031 coding style issues at once.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
