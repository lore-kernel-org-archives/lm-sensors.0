From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Mar 2012 16:51:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (jc42) Add support for AT30TS00, TS3000GB2, TSE2002GB2, and MCP9804
Message-Id: <20120307175131.6914735e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331137039-16108-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed,  7 Mar 2012 08:17:19 -0800, Guenter Roeck wrote:
> Also update IDT datasheet locations.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/jc42 |   18 +++++++++++++-----
>  drivers/hwmon/Kconfig    |    6 +++---
>  drivers/hwmon/jc42.c     |   18 ++++++++++++++++++
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
> index e713375..fd70d23 100644
> --- a/Documentation/hwmon/jc42
> +++ b/Documentation/hwmon/jc42
> @@ -7,21 +7,29 @@ Supported chips:
>      Addresses scanned: I2C 0x18 - 0x1f
>      Datasheets:
>  	http://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
> +  * Atmel AT30TS00
> +    Prefix: 'at30ts00'
> +    Addresses scanned: I2C 0x18 - 0x1f
> +    Datasheets:
> +	http://www.atmel.com/Images/doc8585.pdf
>    * IDT TSE2002B3, TS3000B3
> -    Prefix: 'tse2002b3', 'ts3000b3'
> +    Prefix: 'tse2002b3', 'tse2002gb2', 'ts3000b3', 'ts300gb2'

You mean ts3000gb2 not ts300gb2. But do we really want to have 4
different prefixes for only 2 device IDs anyway?

I'm not even sure why we defined that many different prefixes in the
first place when we treat them all the same, and autodetection doesn't
even bother setting the prefix right. All these chips are
register-compatible by definition, so I really wouldn't mind dropping
all these different prefixes (which I don't think anyone is using
today) and going with "jc42" for everyone.

Other than this, patch looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
