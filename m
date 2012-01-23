From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Jan 2012 17:36:23 +0000
Subject: Re: [lm-sensors] [PATCH 41/82] hwmon: (lm90) Fix multi-line comments
Message-Id: <20120123183623.3bc53b65@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-42-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-42-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 19 Jan 2012 15:55:35 -0800, Guenter Roeck wrote:
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm90.c |   64 +++++++++++++++++++++++++++++--------------------
>  1 files changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index d2dd5f9..dc11937 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -307,23 +307,27 @@ struct lm90_data {
>  	u8 reg_local_ext;	/* local extension register offset */
>  
>  	/* registers values */
> -	s8 temp8[8];	/* 0: local low limit
> -			   1: local high limit
> -			   2: local critical limit
> -			   3: remote critical limit
> -			   4: local emergency limit (max6659 and max6695/96)
> -			   5: remote emergency limit (max6659 and max6695/96)
> -			   6: remote 2 critical limit (max6695/96 only)
> -			   7: remote 2 emergency limit (max6695/96 only) */
> -	s16 temp11[8];	/* 0: remote input
> -			   1: remote low limit
> -			   2: remote high limit
> -			   3: remote offset (except max6646, max6657/58/59,
> -					     and max6695/96)
> -			   4: local input
> -			   5: remote 2 input (max6695/96 only)
> -			   6: remote 2 low limit (max6695/96 only)
> -			   7: remote 2 high limit (ma6695/96 only) */
> +	s8 temp8[8];	/*
> +			 * 0: local low limit
> +			 * 1: local high limit

I tend to find it less readable this way, because of the shift between
the declaration and the explanation. I'm wondering if checkpatch would
complain if we cheat a bit in this case and do:

	s8 temp8[8];	/* 0: local low limit
			 * 1: local high limit

etc. Would you consider it acceptable?

> +			 * 2: local critical limit
> +			 * 3: remote critical limit
> +			 * 4: local emergency limit (max6659 and max6695/96)
> +			 * 5: remote emergency limit (max6659 and max6695/96)
> +			 * 6: remote 2 critical limit (max6695/96 only)
> +			 * 7: remote 2 emergency limit (max6695/96 only)
> +			 */
> +	s16 temp11[8];	/*
> +			 * 0: remote input
> +			 * 1: remote low limit
> +			 * 2: remote high limit
> +			 * 3: remote offset (except max6646, max6657/58/59,
> +			 * and max6695/96)

Original was better aligned.

> +			 * 4: local input
> +			 * 5: remote 2 input (max6695/96 only)
> +			 * 6: remote 2 low limit (max6695/96 only)
> +			 * 7: remote 2 high limit (ma6695/96 only)

There's an "x" missing here, was already the case originally but let's
fix it.

> +			 */
>  	u8 temp_hyst;
>  	u16 alarms; /* bitvector (upper 8 bits for max6695/96) */
>  };

Rest OK.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
