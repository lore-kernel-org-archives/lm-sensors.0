From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Jun 2015 15:49:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon:f71882fg add f81866/f71868 SuperIO support
Message-Id: <558EC5FE.5080007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435217418-26249-1-git-send-email-hpeter+linux_kernel@gmail.com> <1435217418-26249-2-git-send-email-hpeter+linux_kernel@gmail.com>
In-Reply-To: <1435217418-26249-2-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Hung <hpeter@gmail.com>, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

Hi Peter,

On 06/25/2015 12:30 AM, Peter Hung wrote:
> Add New Fintek SuperIO F81866(0x1010) & F71868(0x1106)
> with H/W Monitor functions.
>
> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>
> ---
>   drivers/hwmon/f71882fg.c | 50 ++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
> index 2e5c6f4..10bc8b3 100644
> --- a/drivers/hwmon/f71882fg.c
> +++ b/drivers/hwmon/f71882fg.c
> @@ -59,6 +59,8 @@
>   #define SIO_F71889A_ID		0x1005	/* Chipset ID */
>   #define SIO_F8000_ID		0x0581	/* Chipset ID */
>   #define SIO_F81865_ID		0x0704	/* Chipset ID */
> +#define SIO_F81866_ID		0x1010	/* Chipset ID */
> +#define SIO_F71868_ID		0x1106	/* Chipset ID */
>
>   #define REGION_LENGTH		8
>   #define ADDR_REG_OFFSET		5
> @@ -101,7 +103,7 @@
>
>   #define	F71882FG_REG_START		0x01
>
> -#define F71882FG_MAX_INS		9
> +#define F71882FG_MAX_INS		10
>
>   #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
>
> @@ -110,7 +112,7 @@ module_param(force_id, ushort, 0);
>   MODULE_PARM_DESC(force_id, "Override the detected device ID");
>
>   enum chips { f71808e, f71808a, f71858fg, f71862fg, f71869, f71869a, f71882fg,
> -	     f71889fg, f71889ed, f71889a, f8000, f81865f };
> +	     f71889fg, f71889ed, f71889a, f8000, f81865f, f81866a, f71868a };
>

Unless there is a special reason to not do so, please keep the chip IDs
in numeric order.

>   static const char *const f71882fg_names[] = {
>   	"f71808e",
> @@ -125,21 +127,25 @@ static const char *const f71882fg_names[] = {
>   	"f71889a",
>   	"f8000",
>   	"f81865f",
> +	"f81866a",
> +	"f71868a",

Same here and everywhere else.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
