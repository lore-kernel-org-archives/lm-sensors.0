From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Sep 2013 07:37:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (hwmon-vid) Add __maybe_unused attribute to dummy variable
Message-Id: <20130910093758.0e7c1822@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378724001-9199-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1378724001-9199-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon,  9 Sep 2013 03:53:21 -0700, Guenter Roeck wrote:
> This gets rid of this warning:
> 
> drivers/hwmon/hwmon-vid.c: In function 'get_via_model_d_vrm':
> drivers/hwmon/hwmon-vid.c:249:27: warning: variable 'dummy' set but not used
> [-Wunused-but-set-variable]

FWIW I no longer see this warning with gcc 4.7.2, but I remember seeing
it before.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/hwmon-vid.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
> index 89cfd64..ef91b8a 100644
> --- a/drivers/hwmon/hwmon-vid.c
> +++ b/drivers/hwmon/hwmon-vid.c
> @@ -246,7 +246,7 @@ static struct vrm_model vrm_models[] = {
>   */
>  static u8 get_via_model_d_vrm(void)
>  {
> -	unsigned int vid, brand, dummy;
> +	unsigned int vid, brand, __maybe_unused dummy;
>  	static const char *brands[4] = {
>  		"C7-M", "C7", "Eden", "C7-D"
>  	};

Very nice, I didn't know about this attribute.

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
