From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 04 Dec 2014 20:16:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <CAEZKy8L0G=QbH=zuBQmJ1=etgn8x0WnO2sUXPB1QRDbVYRt49w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guenter,

does it also make sense to include a check for the conf != 0 here (it
should be set to 0 for POR from the datasheet)? Other than this
quesiton/comment, the code looks fine to me.

thanks,

*** Rob.



On Thu, Dec 4, 2014 at 10:04 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> A chip returning 0x00 in all registers is erroneously detected
> as LM75. Check hysteresis and temperature limit registers and
> abort if both are 0 to reduce the likelyhood for this to happen.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm75.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index f58439b..6753fd9 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -415,6 +415,12 @@ static int lm75_detect(struct i2c_client *new_client,
>                  || i2c_smbus_read_byte_data(new_client, 7) != os)
>                         return -ENODEV;
>         }
> +       /*
> +        * It is very unlikely that this is a LM75 if both
> +        * hysteresis and temperature limit registers are 0.
> +        */
> +       if (hyst = 0 && os = 0)
> +               return -ENODEV;
>
>         /* Addresses cycling */
>         for (i = 8; i <= 248; i += 40) {
> --
> 1.9.1
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
