From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 22:01:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: sht15: fix integer overflow in
Message-Id: <20110315230105.6a03387c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300225632-24746-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300225632-24746-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 15 Mar 2011 17:47:12 -0400, Vivien Didelot wrote:
> An integer overflow occurs in the calculation of RHlinear when the
> relative humidity is greater than around 30%. The consequence is a subtle
> (but noticeable) error in the resulting humidity measurement.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/hwmon/sht15.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index a610e78..2c586fc 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -333,11 +333,11 @@ static inline int sht15_calc_humid(struct sht15_data *data)
>  
>  	const int c1 = -4;
>  	const int c2 = 40500; /* x 10 ^ -6 */
> -	const int c3 = -2800; /* x10 ^ -9 */
> +	const int c3 = -28; /* x 10 ^ -7 */
>  
>  	RHlinear = c1*1000
>  		+ c2 * data->val_humid/1000
> -		+ (data->val_humid * data->val_humid * c3)/1000000;
> +		+ (data->val_humid * data->val_humid * c3) / 10000;
>  	return (temp - 25000) * (10000 + 80 * data->val_humid)
>  		/ 1000000 + RHlinear;
>  }

That's right. Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
