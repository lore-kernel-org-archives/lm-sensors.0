From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Apr 2008 14:20:54 +0000
Subject: Re: [lm-sensors] [PATCH 4/4]: sensors: Automatically scale
Message-Id: <20080402162054.47ff47a0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080331235441.GH7191@tree.beaverton.ibm.com>
In-Reply-To: <20080331235441.GH7191@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Mon, 31 Mar 2008 16:54:41 -0700, Darrick J. Wong wrote:
> Automatically scale energy and power values when printing them in cooked
> mode.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

First of all, this patch adds the following warnings:

prog/sensors/chips.c: In function "print_chip_power":
prog/sensors/chips.c:454: warning: passing argument 3 of "scale_value" from incompatible pointer type
prog/sensors/chips.c:470: warning: passing argument 3 of "scale_value" from incompatible pointer type
prog/sensors/chips.c:477: warning: passing argument 3 of "scale_value" from incompatible pointer type
prog/sensors/chips.c: In function "print_chip_energy":
prog/sensors/chips.c:523: warning: passing argument 3 of "scale_value" from incompatible pointer type

Please fix.

> 
> Index: lm-sensors-3.0.0/lib/sysfs.c
> =================================> --- lm-sensors-3.0.0.orig/lib/sysfs.c	2008-03-31 16:35:30.000000000 -0700
> +++ lm-sensors-3.0.0/lib/sysfs.c	2008-03-31 16:35:46.000000000 -0700
> @@ -155,10 +155,6 @@
>  		return 1000;
>  	case SENSORS_SUBFEATURE_FAN_INPUT:
>  		return 1;
> -	case SENSORS_SUBFEATURE_POWER_AVERAGE:
> -		return 1000000;
> -	case SENSORS_SUBFEATURE_ENERGY_INPUT:
> -		return 1000000;
>  	case SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL:
>  		return 1000;
>  	}

This revert was certainly not meant to be.

> Index: lm-sensors-3.0.0/prog/sensors/chips.c
> =================================> --- lm-sensors-3.0.0.orig/prog/sensors/chips.c	2008-03-31 16:35:38.000000000 -0700
> +++ lm-sensors-3.0.0/prog/sensors/chips.c	2008-03-31 16:35:46.000000000 -0700
> @@ -401,10 +401,40 @@
>  	printf("\n");
>  }
>  
> +struct scale_table {
> +	float upper_bound;

We use double everywhere, please stick to that to avoid converting back
and forth.

> +	const char *units;

I suggest "unit" instead - there's just one at a time.

> +};
> +
> +static void scale_value(struct scale_table *scales, float *value,
> +			const char **unitstr)
> +{
> +	float divisor = 1;
> +
> +	while (scales->upper_bound != 0 && *value > scales->upper_bound) {
> +		divisor = scales->upper_bound;
> +		scales++;
> +	}
> +
> +	*value /= divisor;
> +
> +	*unitstr = scales->units;
> +}
> +
> +struct scale_table power_scales[] = {

Should be static const.

> +	{1e3,  "uW"},
> +	{1e6,  "mW"},
> +	{1e9,   "W"},
> +	{1e12, "KW"},

Kilo is lowercase k.

> +	{1e15, "MW"},
> +	{0,    "GW"},
> +};

I'm a bit surprised, I expected 1e-6 for uW, 1e-3 for mW, 0 for W, etc?
Does your code actually output correct values? Or course you would then
have to adjust your algorithm as you would no longer be able to use 0
as a terminator - but that's easy to work around.

> +
>  static void print_chip_power(const sensors_chip_name *name,
>  			     const sensors_feature *feature,
>  			     int label_size)
>  {
> +	float val;
>  	int need_space = 0;
>  	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
>  	char *label;
> @@ -419,9 +449,11 @@
>  
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_POWER_AVERAGE);
> -	if (sf)
> -		printf("%6.2f W", get_value(name, sf));
> -	else
> +	if (sf) {
> +		val = get_value(name, sf);
> +		scale_value(power_scales, &val, &label);
> +		printf("%6.2f %s", val, label);

This reuse of label is a bit confusing. I'd prefer that you define a
new variable for that.

> +	} else
>  		printf("     N/A");
>  
>  	sfmin = sensors_get_subfeature(name, feature,
> @@ -434,13 +466,17 @@
>  		printf("  (");
>  
>  		if (sfmin) {
> -			printf("min = %6.2f W", get_value(name, sfmin));
> +			val = get_value(name, sfmin);
> +			scale_value(power_scales, &val, &label);
> +			printf("min = %6.2f %s", val, label);
>  			need_space = 1;
>  		}
>  
>  		if (sfmax) {
> -			printf("%smax = %6.2f W", (need_space ? ", " : ""),
> -			       get_value(name, sfmax));
> +			val = get_value(name, sfmax);
> +			scale_value(power_scales, &val, &label);
> +			printf("%smax = %6.2f %s", (need_space ? ", " : ""),
> +			       val, label);
>  			need_space = 1;
>  		}
>  
> @@ -455,10 +491,20 @@
>  	printf("\n");
>  }
>  
> +struct scale_table energy_scales[] = {
> +	{1e3,  "uJ"},
> +	{1e6,  "mJ"},
> +	{1e9,   "J"},
> +	{1e12, "KJ"},
> +	{1e15, "MJ"},
> +	{0,    "GJ"},
> +};

This table is really the same as power_scales with just W becoming J. I
think it would be better to have a single table for all units, and to
add the unit symbol on the fly. That way we won't need to add another
table if we ever want to automatically scale values expressed in
another unit.

> +
>  static void print_chip_energy(const sensors_chip_name *name,
>  			      const sensors_feature *feature,
>  			      int label_size)
>  {
> +	float val;
>  	const sensors_subfeature *sf;
>  	char *label;
>  
> @@ -472,9 +518,11 @@
>  
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_ENERGY_INPUT);
> -	if (sf)
> -		printf("%6.2f J", get_value(name, sf));
> -	else
> +	if (sf) {
> +		val = get_value(name, sf);
> +		scale_value(energy_scales, &val, &label);
> +		printf("%6.2f %s", val, label);
> +	} else
>  		printf("     N/A");
>  
>  	printf("\n");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
