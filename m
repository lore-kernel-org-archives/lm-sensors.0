From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 17 Nov 2014 08:21:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (nct6775) Add support for NCT6792D
Message-Id: <20141117092144.0571fbfc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372180172-3159-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372180172-3159-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sun, 16 Nov 2014 10:15:13 -0800, Guenter Roeck wrote:
> NCT6792D is similar to NCT6791D. Only beep control and temperature
> monitoring registers are different.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/nct6775.c | 47 +++++++++++++++++++++++++++++++++++++----------

Please also update Documentation/hwmon/nct6775 and
drivers/hwmon/Kconfig.

>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index 504cbdd..ffe7427 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -38,6 +38,7 @@
>   * nct6776f     9      5       3       6+3    0xc330 0xc1    0x5ca3
>   * nct6779d    15      5       5       2+6    0xc560 0xc1    0x5ca3
>   * nct6791d    15      6       6       2+6    0xc800 0xc1    0x5ca3
> + * nct6792d    15      6       6       2+6    0xc911 0xc1    0x5ca3

Given that all other chips have the device ID mask listed, maybe you
should do the same for the NCT6792D for consistency and list it as
0xc910?

Everything else looks good.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Can you please also update wiki/Devices accordingly? I updated
sensors-detect already.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
