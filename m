From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 06 Mar 2014 02:28:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pmbus/ltc2978) Add new chip ID for LTC2974
Message-Id: <CAEZKy8Lh+b-vBKtU2Np1JHcK=yz5Sq-vzA23fT0PHBTT1ahYFw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1394054411-18935-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1394054411-18935-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 5, 2014 at 1:20 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> LTC2974 datasheet revision C lists the chip ID for LTC2974 as 0x0213.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/pmbus/ltc2978.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index de3c152..7647c11 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -54,6 +54,7 @@ enum chips { ltc2974, ltc2977, ltc2978, ltc3880, ltc3883
> };
>  #define LTC3883_MFR_IIN_PEAK           0xe1
>
>  #define LTC2974_ID                     0x0212
> +#define LTC2974_ID_REV2                        0x0213
>

Hello Guenter,

only a nit-pik; since the other devices in this file have REVx appended,
should this device too?

thanks,

*** Rob.

 #define LTC2977_ID                     0x0130
>  #define LTC2978_ID_REV1                        0x0121
>  #define LTC2978_ID_REV2                        0x0122
> @@ -394,7 +395,7 @@ static int ltc2978_probe(struct i2c_client *client,
>         if (chip_id < 0)
>                 return chip_id;
>
> -       if (chip_id = LTC2974_ID) {
> +       if (chip_id = LTC2974_ID || chip_id = LTC2974_ID_REV2) {
>                 data->id = ltc2974;
>         } else if (chip_id = LTC2977_ID) {
>                 data->id = ltc2977;
> --
> 1.7.9.7
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
