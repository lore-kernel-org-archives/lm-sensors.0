From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2012 11:49:59 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Update my e-mail address
Message-Id: <20120625134959.154e319c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340566367-10778-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340566367-10778-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 24 Jun 2012 12:32:47 -0700, Guenter Roeck wrote:
> My old e-mail address won't be valid for much longer. Time to update it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/jc42.c        |    2 +-
>  drivers/hwmon/lineage-pem.c |    2 +-
>  drivers/hwmon/ltc4261.c     |    2 +-
>  drivers/hwmon/max16065.c    |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
> index a9bfd67..e72ba5d 100644
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> @@ -590,6 +590,6 @@ abort:
>  
>  module_i2c_driver(jc42_driver);
>  
> -MODULE_AUTHOR("Guenter Roeck <guenter.roeck@ericsson.com>");
> +MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
>  MODULE_DESCRIPTION("JC42 driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
> index d264937..bd75d24 100644
> --- a/drivers/hwmon/lineage-pem.c
> +++ b/drivers/hwmon/lineage-pem.c
> @@ -567,6 +567,6 @@ static struct i2c_driver pem_driver = {
>  
>  module_i2c_driver(pem_driver);
>  
> -MODULE_AUTHOR("Guenter Roeck <guenter.roeck@ericsson.com>");
> +MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
>  MODULE_DESCRIPTION("Lineage CPL PEM hardware monitoring driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
> index 069b7d3..77476a5 100644
> --- a/drivers/hwmon/ltc4261.c
> +++ b/drivers/hwmon/ltc4261.c
> @@ -292,6 +292,6 @@ static struct i2c_driver ltc4261_driver = {
>  
>  module_i2c_driver(ltc4261_driver);
>  
> -MODULE_AUTHOR("Guenter Roeck <guenter.roeck@ericsson.com>");
> +MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
>  MODULE_DESCRIPTION("LTC4261 driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
> index 822261b..019427d 100644
> --- a/drivers/hwmon/max16065.c
> +++ b/drivers/hwmon/max16065.c
> @@ -692,6 +692,6 @@ static struct i2c_driver max16065_driver = {
>  
>  module_i2c_driver(max16065_driver);
>  
> -MODULE_AUTHOR("Guenter Roeck <guenter.roeck@ericsson.com>");
> +MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
>  MODULE_DESCRIPTION("MAX16065 driver");
>  MODULE_LICENSE("GPL");

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
