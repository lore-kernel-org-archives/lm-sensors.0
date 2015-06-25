From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Jun 2015 00:00:06 +0000
Subject: Re: [lm-sensors] [PATCH] fix nct7802_temp_is_visible
Message-Id: <558B4486.9070802@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435186051-10196-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435186051-10196-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Constantine Shulyupin <const@MakeLinux.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Constantine,

On 06/24/2015 03:47 PM, Constantine Shulyupin wrote:
> From: const <const@makelinux.com>
>
> Fixed registers are invisible only when registers' mode is 0
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> ---
>   drivers/hwmon/nct7802.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index ec56782..65e40c2 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -541,13 +541,11 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
>   	if (err < 0)
>   		return 0;
>
> -	if (index < 9 &&
> -	    (reg & 03) != 0x01 && (reg & 0x03) != 0x02)		/* RD1 */
> +	if (index < 9 && !(reg & 0x03))			/* RD1 */
>   		return 0;
> -	if (index >= 9 && index < 18 &&
> -	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
> +	if (index >= 9 && index < 18 && !(reg & 0x0c))	/* RD2 */
>   		return 0;
> -	if (index >= 18 && index < 27 && (reg & 0x30) != 0x10)	/* RD3 */
> +	if (index >= 18 && index < 27 && !(reg & 0x30))	/* RD3 */

11b sets a sensor to voltage sense mode, not temperature mode.
This is what the inX attributes are for. We can not just display a
random temperature value if a sensor is configured to measure a voltage.

According to my datasheet, 01b (0x10 shifted) is reserved for RD3.
So there is a bug, but it is

	if (index >= 18 && index < 27 && (reg & 0x30) != 0x10)	/* RD3 */
which should be
	if (index >= 18 && index < 27 && (reg & 0x30) != 0x20)	/* RD3 */

Can you send an updated patch ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
