From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Mar 2009 15:27:16 +0000
Subject: Re: [lm-sensors] [PATCH] lm90: Support the MAX6648/6692 chips
Message-Id: <20090304162716.131baff0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090302210106.GD6550@plum>
	<20090302150426.b22100c1.akpm@linux-foundation.org>
	<20090303084746.14462e04@hyperion.delvare>
	<20090303000412.3c38c266.akpm@linux-foundation.org>
In-Reply-To: <20090303000412.3c38c266.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: djwong@us.ibm.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 3 Mar 2009 00:04:12 -0800, Andrew Morton wrote:
> On Tue, 3 Mar 2009 08:47:46 +0100 Jean Delvare <khali@linux-fr.org> wrote:
> 
> > Hi Andrew,
> > 
> > On Mon, 2 Mar 2009 15:04:26 -0800, Andrew Morton wrote:
> > > On Mon, 2 Mar 2009 13:01:06 -0800
> > > "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> > > 
> > > > @@ -776,7 +776,12 @@ static int lm90_detect(struct i2c_client *new_client, int kind,
> > > >  			 && (reg_config1 & 0x3f) = 0x00
> > > >  			 && reg_convrate <= 0x07) {
> > > >  				kind = max6646;
> > > > -			}
> > > > +			} else
> > > > +			/* The MAX6648/6692 chips have a working man/chip id
> > > > +			 * and the same register set as the 6657.
> > > > +			 */
> > > > +			if (chip_id = 0x59 && address = 0x4C)
> > > > +				kind = max6657;
> > > >  		}
> > > 
> > > gack, the indenting and layout there is totally busted.
> > 
> > This specific layout is consistently used through the whole function,
> > and checkpatch.pl doesn't complain about it. While unconventional, it
> > has its advantages, in particular it avoids extra indentation that
> > would make some lines too long. At any rate it doesn't make sense to
> > change this last chunk without changing all the rest if this layout is
> > deemed unacceptable.
> 
> lol, be serious.
> 
> > > --- a/drivers/hwmon/lm90.c~lm90-support-the-max6648-6692-chips-fix
> > > +++ a/drivers/hwmon/lm90.c
> > > @@ -776,12 +776,14 @@ static int lm90_detect(struct i2c_client
> > >  			 && (reg_config1 & 0x3f) = 0x00
> > >  			 && reg_convrate <= 0x07) {
> > >  				kind = max6646;
> > > -			} else
> > > -			/* The MAX6648/6692 chips have a working man/chip id
> > > -			 * and the same register set as the 6657.
> > > -			 */
> > > -			if (chip_id = 0x59 && address = 0x4C)
> > > +			} else if (chip_id = 0x59 && address = 0x4C) {
> > > +				/*
> > > +				 * The MAX6648/6692 chips have a working
> > > +				 * man/chip id and the same register set as the
> > > +				 * 6657.
> > > +				 */
> > >  				kind = max6657;
> > > +			}
> > >  		}
> > >  
> > >  		if (kind <= 0) { /* identification failed */
> > 
> > I thus nack this change of yours.
> 
> Something like this...
> 
> diff -puN drivers/hwmon/lm90.c~drivers-hwmon-lm90c-fix-coding-style drivers/hwmon/lm90.c
> --- a/drivers/hwmon/lm90.c~drivers-hwmon-lm90c-fix-coding-style
> +++ a/drivers/hwmon/lm90.c
> @@ -694,22 +694,22 @@ static int lm90_detect(struct i2c_client
>  						LM90_REG_R_CONVRATE)) < 0)
>  			return -ENODEV;
>  		
> -		if ((address = 0x4C || address = 0x4D)
> -		 && man_id = 0x01) { /* National Semiconductor */
> +		if ((address = 0x4C || address = 0x4D) && man_id = 0x01) {
> +			/* National Semiconductor */
>  			int reg_config2;
>  
>  			if ((reg_config2 = i2c_smbus_read_byte_data(new_client,
>  						LM90_REG_R_CONFIG2)) < 0)
>  				return -ENODEV;
>  
> -			if ((reg_config1 & 0x2A) = 0x00
> -			 && (reg_config2 & 0xF8) = 0x00
> -			 && reg_convrate <= 0x09) {
> -				if (address = 0x4C
> -				 && (chip_id & 0xF0) = 0x20) { /* LM90 */
> +			if ((reg_config1 & 0x2A) = 0x00 &&
> +			    (reg_config2 & 0xF8) = 0x00 &&
> +			    reg_convrate <= 0x09) {
> +				if (address = 0x4C &&
> +				    (chip_id & 0xF0) = 0x20) { /* LM90 */
>  					kind = lm90;
> -				} else
> -				if ((chip_id & 0xF0) = 0x30) { /* LM89/LM99 */
> +				} else if ((chip_id & 0xF0) = 0x30) {
> +					/* LM89/LM99 */
>  					kind = lm99;
>  					dev_info(&adapter->dev,
>  						 "Assuming LM99 chip at "
> @@ -720,27 +720,24 @@ static int lm90_detect(struct i2c_client
>  						 "loading the lm90 driver\n",
>  						 i2c_adapter_id(adapter),
>  						 address);
> -				} else
> -				if (address = 0x4C
> -				 && (chip_id & 0xF0) = 0x10) { /* LM86 */
> +				} else if (address = 0x4C &&
> +					(chip_id & 0xF0) = 0x10) { /* LM86 */
>  					kind = lm86;
>  				}
>  			}
> -		} else
> -		if ((address = 0x4C || address = 0x4D)
> -		 && man_id = 0x41) { /* Analog Devices */
> -			if ((chip_id & 0xF0) = 0x40 /* ADM1032 */
> -			 && (reg_config1 & 0x3F) = 0x00
> -			 && reg_convrate <= 0x0A) {
> +		} else if ((address = 0x4C || address = 0x4D) &&
> +				man_id = 0x41) {
> +			/* Analog Devices */
> +			if ((chip_id & 0xF0) = 0x40  && /* ADM1032 */
> +			    (reg_config1 & 0x3F) = 0x00 &&
> +			    reg_convrate <= 0x0A) {
>  				kind = adm1032;
> -			} else
> -			if (chip_id = 0x51 /* ADT7461 */
> -			 && (reg_config1 & 0x1B) = 0x00
> -			 && reg_convrate <= 0x0A) {
> +			} else if (chip_id = 0x51 && /* ADT7461 */
> +				 (reg_config1 & 0x1B) = 0x00 &&
> +				 reg_convrate <= 0x0A) {
>  				kind = adt7461;
>  			}
> -		} else
> -		if (man_id = 0x4D) { /* Maxim */
> +		} else if (man_id = 0x4D) { /* Maxim */
>  			/*
>  			 * The MAX6657, MAX6658 and MAX6659 do NOT have a
>  			 * chip_id register. Reading from that address will
> @@ -750,31 +747,32 @@ static int lm90_detect(struct i2c_client
>  			 * will be those of the previous read, so in our case
>  			 * those of the man_id register.
>  			 */
> -			if (chip_id = man_id
> -			 && (address = 0x4C || address = 0x4D)
> -			 && (reg_config1 & 0x1F) = (man_id & 0x0F)
> -			 && reg_convrate <= 0x09) {
> +			if (chip_id = man_id &&
> +			    (address = 0x4C || address = 0x4D) &&
> +			    (reg_config1 & 0x1F) = (man_id & 0x0F) &&
> +			    reg_convrate <= 0x09) {
>  			 	kind = max6657;
> -			} else
> -			/* The chip_id register of the MAX6680 and MAX6681
> -			 * holds the revision of the chip.
> -			 * the lowest bit of the config1 register is unused
> -			 * and should return zero when read, so should the
> -			 * second to last bit of config1 (software reset)
> -			 */
> -			if (chip_id = 0x01
> -			 && (reg_config1 & 0x03) = 0x00
> -			 && reg_convrate <= 0x07) {
> +			} else if (chip_id = 0x01 &&
> +					(reg_config1 & 0x03) = 0x00 &&
> +				 	reg_convrate <= 0x07) {
> +				/*
> +				 * The chip_id register of the MAX6680 and
> +				 * MAX6681 holds the revision of the chip.
> +				 * the lowest bit of the config1 register is
> +				 * unused and should return zero when read, so
> +				 * should the second to last bit of config1
> +				 * (software reset)
> +				 */
>  			 	kind = max6680;
> -			} else
> -			/* The chip_id register of the MAX6646/6647/6649
> -			 * holds the revision of the chip.
> -			 * The lowest 6 bits of the config1 register are
> -			 * unused and should return zero when read.
> -			 */
> -			if (chip_id = 0x59
> -			 && (reg_config1 & 0x3f) = 0x00
> -			 && reg_convrate <= 0x07) {
> +			} else if (chip_id = 0x59 &&
> +					(reg_config1 & 0x3f) = 0x00 &&
> +					 reg_convrate <= 0x07) {
> +				/*
> +				 * The chip_id register of the MAX6646/6647/6649
> +				 * holds the revision of the chip.
> +				 * The lowest 6 bits of the config1 register are
> +				 * unused and should return zero when read.
> +				 */
>  				kind = max6646;
>  			} else if (chip_id = 0x59 && address = 0x4C) {
>  				/*

Yes, something like this. But you know, the lm90 driver has a dedicated
maintainer, so you don't need to take care about this driver personally.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
