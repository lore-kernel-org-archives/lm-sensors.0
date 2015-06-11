From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 11 Jun 2015 08:11:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/1 linux-next] hwmon: (w83627ehf) use swap() in w82627ehf_swap_tempreg()
Message-Id: <20150611101151.6ca81769@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1433953981-24515-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1433953981-24515-1-git-send-email-fabf@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

On Wed, 10 Jun 2015 18:33:01 +0200, Fabian Frederick wrote:
> Use kernel.h macro definition.
> 
> Thanks to Julia Lawall for Coccinelle scripting support.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/hwmon/w83627ehf.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index b10353b..697007a 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -1937,27 +1937,11 @@ static inline void w83627ehf_init_device(struct w83627ehf_data *data,
>  static void w82627ehf_swap_tempreg(struct w83627ehf_data *data,
>  				   int r1, int r2)
>  {
> -	u16 tmp;
> -
> -	tmp = data->temp_src[r1];
> -	data->temp_src[r1] = data->temp_src[r2];
> -	data->temp_src[r2] = tmp;
> -
> -	tmp = data->reg_temp[r1];
> -	data->reg_temp[r1] = data->reg_temp[r2];
> -	data->reg_temp[r2] = tmp;
> -
> -	tmp = data->reg_temp_over[r1];
> -	data->reg_temp_over[r1] = data->reg_temp_over[r2];
> -	data->reg_temp_over[r2] = tmp;
> -
> -	tmp = data->reg_temp_hyst[r1];
> -	data->reg_temp_hyst[r1] = data->reg_temp_hyst[r2];
> -	data->reg_temp_hyst[r2] = tmp;
> -
> -	tmp = data->reg_temp_config[r1];
> -	data->reg_temp_config[r1] = data->reg_temp_config[r2];
> -	data->reg_temp_config[r2] = tmp;
> +	swap(data->temp_src[r1], data->temp_src[r2]);
> +	swap(data->reg_temp[r1], data->reg_temp[r2]);
> +	swap(data->reg_temp_over[r1], data->reg_temp_over[r2]);
> +	swap(data->reg_temp_hyst[r1], data->reg_temp_hyst[r2]);
> +	swap(data->reg_temp_config[r1], data->reg_temp_config[r2]);
>  }
>  
>  static void

Looks good. Applied, thanks.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
