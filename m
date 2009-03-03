From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Mar 2009 07:47:46 +0000
Subject: Re: [lm-sensors] [PATCH] lm90: Support the MAX6648/6692 chips
Message-Id: <20090303084746.14462e04@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090302210106.GD6550@plum>
	<20090302150426.b22100c1.akpm@linux-foundation.org>
In-Reply-To: <20090302150426.b22100c1.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: djwong@us.ibm.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Andrew,

On Mon, 2 Mar 2009 15:04:26 -0800, Andrew Morton wrote:
> On Mon, 2 Mar 2009 13:01:06 -0800
> "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> 
> > @@ -776,7 +776,12 @@ static int lm90_detect(struct i2c_client *new_client, int kind,
> >  			 && (reg_config1 & 0x3f) = 0x00
> >  			 && reg_convrate <= 0x07) {
> >  				kind = max6646;
> > -			}
> > +			} else
> > +			/* The MAX6648/6692 chips have a working man/chip id
> > +			 * and the same register set as the 6657.
> > +			 */
> > +			if (chip_id = 0x59 && address = 0x4C)
> > +				kind = max6657;
> >  		}
> 
> gack, the indenting and layout there is totally busted.

This specific layout is consistently used through the whole function,
and checkpatch.pl doesn't complain about it. While unconventional, it
has its advantages, in particular it avoids extra indentation that
would make some lines too long. At any rate it doesn't make sense to
change this last chunk without changing all the rest if this layout is
deemed unacceptable.

> --- a/drivers/hwmon/lm90.c~lm90-support-the-max6648-6692-chips-fix
> +++ a/drivers/hwmon/lm90.c
> @@ -776,12 +776,14 @@ static int lm90_detect(struct i2c_client
>  			 && (reg_config1 & 0x3f) = 0x00
>  			 && reg_convrate <= 0x07) {
>  				kind = max6646;
> -			} else
> -			/* The MAX6648/6692 chips have a working man/chip id
> -			 * and the same register set as the 6657.
> -			 */
> -			if (chip_id = 0x59 && address = 0x4C)
> +			} else if (chip_id = 0x59 && address = 0x4C) {
> +				/*
> +				 * The MAX6648/6692 chips have a working
> +				 * man/chip id and the same register set as the
> +				 * 6657.
> +				 */
>  				kind = max6657;
> +			}
>  		}
>  
>  		if (kind <= 0) { /* identification failed */

I thus nack this change of yours.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
