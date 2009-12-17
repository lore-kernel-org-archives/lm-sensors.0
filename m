From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Dec 2009 15:10:09 +0000
Subject: Re: [lm-sensors] [PATCH] adt7462: Fix pin 28 monitoring
Message-Id: <20091217161009.3a3a106f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <994.13667.qm@web53501.mail.re2.yahoo.com>
In-Reply-To: <994.13667.qm@web53501.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: roger blofeld <blofeldus@yahoo.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Hi Roger,

On Fri, 11 Dec 2009 18:54:54 -0800 (PST), roger blofeld wrote:
> The ADT7462_PIN28_VOLT value is a 4-bit field, so the corresponding shift must be 4.
> 
> Signed-off-by: Roger Blofeld <blofeldus@yahoo.com>
> ---
> My mailer will whitespace damage the inline copy of the patch.
> The attached version should be OK.
> 
> diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
> index 1852f27..262c133 100644
> --- a/drivers/hwmon/adt7462.c
> +++ b/drivers/hwmon/adt7462.c
> @@ -97,7 +97,7 @@ I2C_CLIENT_INSMOD_1(adt7462);
>  #define        ADT7462_PIN24_SHIFT        6
>  #define        ADT7462_PIN26_VOLT_INPUT    0x08
>  #define        ADT7462_PIN25_VOLT_INPUT    0x20
> -#define        ADT7462_PIN28_SHIFT        6    /* cfg3 */
> +#define        ADT7462_PIN28_SHIFT        4    /* cfg3 */
>  #define        ADT7462_PIN28_VOLT        0x5
>  
>  #define ADT7462_REG_ALARM1            0xB8

Correct. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
