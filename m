From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Date: Mon, 29 Mar 2010 16:23:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: sht15: Fix sht15_calc_temp
Message-Id: <919663887.2141269879836780.JavaMail.root@mail.savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
In-Reply-To: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

My conclusion is that the measurements are biased everytime.

I wrote a small test suite testing measurements at the manufacturer-supplied reference points.
As you can see the bias is substantial.

Jonathan, any objection ?



==> Test #1
  Supply: 2500000uV, raw reading: 7000, 
  original calc_temp: 31599mC;
  patched calc_temp: 30600mC
  hand-made calc gives: 30600

==> Test #2
  Supply: 3000000uV, raw reading: 6800, 
  original calc_temp: 29598mC;
  patched calc_temp: 28400mC
  hand-made calc gives: 28400

==> Test #3
  Supply: 3500000uV, raw reading: 6400, 
  original calc_temp: 25598mC;
  patched calc_temp: 24300mC
  hand-made calc gives: 24300

==> Test #4
  Supply: 4000000uV, raw reading: 6000, 
  original calc_temp: 21598mC;
  patched calc_temp: 20200mC
  hand-made calc gives: 20200

==> Test #5
  Supply: 5000000uV, raw reading: 5400, 
  original calc_temp: 15598mC;
  patched calc_temp: 13900mC
  hand-made calc gives: 13900

Jerome

> I discovered two issues.
> First the previous sht15_calc_temp() loop did not iterate through the
> temppoints array since the (data->supply_uV > temppoints[i - 1].vdd)
> test is always true in this direction.
> 
> Also the two-points linear interpolation function was returning
> biased
> values which I adressed using a different form of interpolation.
> 
> Signed-off-by: Jerome Oufella <jerome.oufella at
> savoirfairelinux.com>
> ---
> 
>  drivers/hwmon/sht15.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
> index 864a371..a6ad93b 100644
> --- a/drivers/hwmon/sht15.c
> +++ b/drivers/hwmon/sht15.c
> @@ -303,15 +303,15 @@ error_ret:
>  static inline int sht15_calc_temp(struct sht15_data *data)
>  {
>  	int d1 = 0;
> -	int i;
> +	int i, t;
>  
> -	for (i = 1; i < ARRAY_SIZE(temppoints); i++)
> +	for (i = ARRAY_SIZE(temppoints) - 1; i > 0; i--)
>  		/* Find pointer to interpolate */
> -		if (data->supply_uV > temppoints[i - 1].vdd) {
> -			d1 = (data->supply_uV/1000 - temppoints[i - 1].vdd)
> -				* (temppoints[i].d1 - temppoints[i - 1].d1)
> -				/ (temppoints[i].vdd - temppoints[i - 1].vdd)
> -				+ temppoints[i - 1].d1;
> +		if (data->supply_uV >= temppoints[i - 1].vdd) {
> +			t = (data->supply_uV - temppoints[i-1].vdd) / 
> +				((temppoints[i].vdd - temppoints[i-1].vdd) / 10000);
> +
> +			d1 = (temppoints[i].d1 * t + (10000 - t) * temppoints[i-1].d1) /
> 10000;
>  			break;
>  		}
>  
> -- 
> 1.6.3.3

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
