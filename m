From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 20:07:25 +0000
Subject: Re: [lm-sensors] [PATCH 3/6] hwmon: (lm80) Convert temperature display function macros into function
Message-Id: <535428FD.7010103@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397615334-30317-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397615334-30317-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/15/2014 07:28 PM, Guenter Roeck wrote:
> Convert temperature display function macros into functions to reduce
> code size and improve code readability.
>
> Code size reduction is about 2k on x86_64.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/lm80.c |  134 ++++++++++++++++++++++----------------------------
>   1 file changed, 59 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
> index fe980d6..a9749fd 100644
> --- a/drivers/hwmon/lm80.c
> +++ b/drivers/hwmon/lm80.c
> @@ -92,6 +92,23 @@ static inline unsigned char FAN_TO_REG(unsigned rpm, unsigned div)
>
>   #define DIV_FROM_REG(val)		(1 << (val))
>
> +enum temp_index {
> +	t_input = 0,
> +	t_hot_max,
> +	t_hot_hyst,
> +	t_os_max,
> +	t_os_hyst,
> +	t_num_temp
> +};
> +
> +static u8 temp_regs[] = {

Note that I've made this array a const.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
