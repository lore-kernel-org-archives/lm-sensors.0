From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Date: Thu, 01 Apr 2010 12:54:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: sht15: Fix sht15_calc_temp
Message-Id: <1732720040.861270126460533.JavaMail.root@mail.savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20100401140152.3141b989@hyperion.delvare>
References: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
In-Reply-To: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>

----- "Jean Delvare" <khali@linux-fr.org> wrote :
> May I suggest the more simple fix below?
> 
> ---
>  drivers/hwmon/sht15.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.34-rc3.orig/drivers/hwmon/sht15.c	2010-04-01
> 13:41:15.000000000 +0200
> +++ linux-2.6.34-rc3/drivers/hwmon/sht15.c	2010-04-01
> 13:41:55.000000000 +0200
> @@ -305,10 +305,10 @@ static inline int sht15_calc_temp(struct
>  	int d1 = 0;
>  	int i;
>  
> -	for (i = 1; i < ARRAY_SIZE(temppoints); i++)
> +	for (i = ARRAY_SIZE(temppoints) - 1; i > 0 ;i--)
>  		/* Find pointer to interpolate */
>  		if (data->supply_uV > temppoints[i - 1].vdd) {
> -			d1 = (data->supply_uV/1000 - temppoints[i - 1].vdd)
> +			d1 = (data->supply_uV - temppoints[i - 1].vdd)
>  				* (temppoints[i].d1 - temppoints[i - 1].d1)
>  				/ (temppoints[i].vdd - temppoints[i - 1].vdd)
>  				+ temppoints[i - 1].d1;
> 
> It leads to the same numbers as with Jerome's patch, with the
> advantages that 1* it is a much smaller change, more suitable for
> applying to stable kernels and 2* it avoids the magic constant number
> 10000.
> 
> The "/1000" seems to be a relict of former times when
> temppoints[*].vdd
> was probably expressed in millivolt instead of microvolt. And the
> inverted loop iteration is obviously a bug.
> 
> Note that in both cases, something should be done about values which
> are outside of the temppoints array. I don't know how likely these
> are,
> but they are seriously mishandled. For supply_uV values below
> temppoints[0].vdd, d1 defaults to 0, so no adjustment is done at all.
> temppoints[0].d1 would seem to be a much better default, if we don't
> want to do any interpolation in that case. For supply_uV values above
> temppoints[4].vdd, we do interpolate, which seems reasonable.
> 
> Opinions?
> 
> -- 
> Jean Delvare

That's fine, it does a good job for me, in the expected voltage range.

Jerome Oufella

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
