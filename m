From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 Oct 2013 16:21:42 +0000
Subject: Re: [lm-sensors] [PATCH v4 3/3] hwmon: (lm90) use enums for the indexes of temp8 and temp11
Message-Id: <20131030172142.49234b28@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375856306-14415-1-git-send-email-wni@nvidia.com>
	<1375856306-14415-4-git-send-email-wni@nvidia.com>
In-Reply-To: <1375856306-14415-4-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Wed, 7 Aug 2013 14:18:26 +0800, Wei Ni wrote:
> Using enums for the indexes and nrs of temp8 and temp11.
> This make the code much more readable.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  drivers/hwmon/lm90.c |  154 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 90 insertions(+), 64 deletions(-)
> (...)

Looks much better except for one minor detail:

> +/*
> + * TEMP11 register index
> + */
> +enum lm90_temp11_reg_index {
> +	REMOTE_TEMP = 0,
> +	REMOTE_LOW,
> +	REMOTE_HIGH,
> +	REMOTE_OFFSET,	/* except max6646, max6657/58/59,
> +			 *  and max6695/96
> +			 */

This comment fits on a single line now.

> +	LOCAL_TEMP,
> +	REMOTE2_TEMP,	/* max6695/96 only */
> +	REMOTE2_LOW,	/* max6695/96 only */
> +	REMOTE2_HIGH,	/* max6695/96 only */
> +	TEMP11_REG_NUM
> +};

Other than that, it's OK, and I think I'll apply it after all.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
