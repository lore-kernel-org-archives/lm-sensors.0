From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 Apr 2009 17:01:01 +0000
Subject: Re: [lm-sensors] [PATCH] asus_atk0110: fix compiler warning
Message-Id: <20090430190101.7a46f082@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090429192255.GA8623@dreamland.darkstar.lan>
In-Reply-To: <20090429192255.GA8623@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Luca,

On Wed, 29 Apr 2009 21:22:55 +0200, Luca Tettamanti wrote:
> atk_sensor_type is only used when DEBUG is defined.
> 
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> 
> ---
> Jean can you pick this up?
> 
>  drivers/hwmon/asus_atk0110.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
> index 0897ede..bff0103 100644
> --- a/drivers/hwmon/asus_atk0110.c
> +++ b/drivers/hwmon/asus_atk0110.c
> @@ -348,6 +348,7 @@ static int validate_hwmon_pack(struct atk_data *data, union acpi_object *obj)
>  	return 0;
>  }
>  
> +#ifdef DEBUG
>  static char const *atk_sensor_type(union acpi_object *flags)
>  {
>  	u64 type = flags->integer.value & ATK_TYPE_MASK;
> @@ -370,6 +371,7 @@ static char const *atk_sensor_type(union acpi_object *flags)
>  
>  	return what;
>  }
> +#endif
>  
>  static void atk_print_sensor(struct atk_data *data, union acpi_object *obj)
>  {

Thanks for the fix, I've just applied it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
