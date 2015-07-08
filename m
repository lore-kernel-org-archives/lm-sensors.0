From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Jul 2015 02:34:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f71882fg): Add support for f81768d
Message-Id: <559C8C24.7000609@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436318213-30778-1-git-send-email-george.joseph@fairview5.com>
In-Reply-To: <1436318213-30778-1-git-send-email-george.joseph@fairview5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On 07/07/2015 06:16 PM, George Joseph wrote:
> Add f81768d (id 0x1210) currently found on Jetway motherboards.
> It has 11 voltages but otherwise needed no special handling
> in this driver.
>
> Signed-off-by: George Joseph <george.joseph@fairview5.com>
> ---
>   drivers/hwmon/f71882fg.c | 44 ++++++++++++++++++++++++++++----------------
>   1 file changed, 28 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index e4ff21f..4c9ec5c 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -59,6 +59,7 @@
>   #define SIO_F71889E_ID		0x0909	/* Chipset ID */
>   #define SIO_F71889A_ID		0x1005	/* Chipset ID */
>   #define SIO_F8000_ID		0x0581	/* Chipset ID */
> +#define SIO_F81768D_ID		0x1210	/* Chipset ID */
>   #define SIO_F81865_ID		0x0704	/* Chipset ID */
>   #define SIO_F81866_ID		0x1010	/* Chipset ID */
>
> @@ -107,7 +108,7 @@
>
>   #define	F71882FG_REG_START		0x01
>
> -#define F71882FG_MAX_INS		10
> +#define F71882FG_MAX_INS		11
>
>   #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
>
> @@ -116,7 +117,7 @@ module_param(force_id, ushort, 0);
>   MODULE_PARM_DESC(force_id, "Override the detected device ID");
>
>   enum chips { f71808e, f71808a, f71858fg, f71862fg, f71868a, f71869, f71869a,
> -	f71882fg, f71889fg, f71889ed, f71889a, f8000, f81865f, f81866a};
> +	f71882fg, f71889fg, f71889ed, f71889a, f8000, f81768d, f81865f, f81866a};

line longer than 80 characters. No need to resend, I fixed it up.

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
