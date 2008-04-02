From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Apr 2008 12:27:09 +0000
Subject: Re: [lm-sensors] [PATCH 2/4 v2] libsensors: Support energy and
Message-Id: <20080402142709.49a0f304@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Mon, 31 Mar 2008 16:51:57 -0700, Darrick J. Wong wrote:
> Add power and sensor meters to libsensors.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 

Better but not yet perfect:

> Index: lm-sensors-3.0.0/lib/sensors.h
> =================================> --- lm-sensors-3.0.0.orig/lib/sensors.h	2008-03-31 16:07:49.000000000 -0700
> +++ lm-sensors-3.0.0/lib/sensors.h	2008-03-31 16:08:52.000000000 -0700
> @@ -131,6 +131,8 @@
>  	SENSORS_FEATURE_IN		= 0x00,
>  	SENSORS_FEATURE_FAN		= 0x01,
>  	SENSORS_FEATURE_TEMP		= 0x02,
> +	SENSORS_FEATURE_POWER		= 0x03,
> +	SENSORS_FEATURE_ENERGY		= 0x04,
>  	SENSORS_FEATURE_VID		= 0x10,
>  	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
>  	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
> @@ -169,6 +171,14 @@
>  	SENSORS_SUBFEATURE_TEMP_OFFSET,
>  	SENSORS_SUBFEATURE_TEMP_BEEP,
>  
> +	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
> +	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
> +	SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST,
> +
> +	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
> +
> +	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
> +
>  	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
>  
>  	SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_BEEP_ENABLE << 8,
> Index: lm-sensors-3.0.0/lib/sysfs.c
> =================================> --- lm-sensors-3.0.0.orig/lib/sysfs.c	2008-03-31 16:08:14.000000000 -0700
> +++ lm-sensors-3.0.0/lib/sysfs.c	2008-03-31 16:08:52.000000000 -0700
> @@ -138,11 +138,13 @@
>  
>  #define MAX_SENSORS_PER_TYPE	20
>  #define MAX_SUBFEATURES		8
> -/* Room for all 3 types (in, fan, temp) with all their subfeatures + VID
> -   + misc features */
> +#define MAX_SENSOR_TYPES	5
> +/* Room for all 5 types (in, fan, temp, power, energy) with all their
> +   subfeatures + VID misc features */

Missing "+" between "VID" and "misc features".

>  #define ALL_POSSIBLE_SUBFEATURES \
> -				(MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 \
> -				 + MAX_SENSORS_PER_TYPE + 1)
> +				(MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * \
> +				 MAX_SENSOR_TYPES * 2 + \
> +				 MAX_SENSORS_PER_TYPE + 1)
>  
>  static
>  int get_type_scaling(sensors_subfeature_type type)
> @@ -153,6 +155,12 @@
>  		return 1000;
>  	case SENSORS_SUBFEATURE_FAN_INPUT:
>  		return 1;
> +	case SENSORS_SUBFEATURE_POWER_AVERAGE:
> +		return 1000000;
> +	case SENSORS_SUBFEATURE_ENERGY_INPUT:
> +		return 1000000;

Note that you could use a fall-through construct for these, as they
need the same scaling factor.

> +	case SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL:
> +		return 1000;

This happens to work because SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL
is the only second-class subfeature of SENSORS_FEATURE_POWER. This
would break in the future if we add a second second-class subfeature
which needs a different scaling factor.

The right way to do it is to handle
SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL in the second switch block,
right below. Again I have to admit that this isn't properly documented.

>  	}
>  
>  	switch (type) {
> @@ -173,6 +181,8 @@
>  	case SENSORS_FEATURE_IN:
>  	case SENSORS_FEATURE_FAN:
>  	case SENSORS_FEATURE_TEMP:
> +	case SENSORS_FEATURE_POWER:
> +	case SENSORS_FEATURE_ENERGY:
>  		underscore = strchr(sfname, '_');
>  		name = strndup(sfname, underscore - sfname);
>  		break;
> @@ -232,6 +242,19 @@
>  	{ NULL, 0 }
>  };
>  
> +static const struct subfeature_type_match power_matches[] = {
> +	{ "average", SENSORS_SUBFEATURE_POWER_AVERAGE },
> +	{ "average_highest", SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST },
> +	{ "average_lowest", SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST },
> +	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
> +	{ NULL, 0 }
> +};
> +
> +static const struct subfeature_type_match energy_matches[] = {
> +	{ "input", SENSORS_SUBFEATURE_ENERGY_INPUT },
> +	{ NULL, 0 }
> +};
> +
>  static const struct subfeature_type_match cpu_matches[] = {
>  	{ "vid", SENSORS_SUBFEATURE_VID },
>  	{ NULL, 0 }
> @@ -242,6 +265,8 @@
>  	{ "in%d%c", in_matches },
>  	{ "fan%d%c", fan_matches },
>  	{ "cpu%d%c", cpu_matches },
> +	{ "power%d%c", power_matches },
> +	{ "energy%d%c", energy_matches },
>  };
>  
>  /* Return the subfeature type and channel number based on the subfeature
> @@ -327,10 +352,12 @@
>  
>  		/* Adjust the channel number */
>  		switch (sftype & 0xFF00) {
> -			case SENSORS_SUBFEATURE_FAN_INPUT:
> -			case SENSORS_SUBFEATURE_TEMP_INPUT:
> -				nr--;
> -				break;
> +		case SENSORS_SUBFEATURE_FAN_INPUT:
> +		case SENSORS_SUBFEATURE_TEMP_INPUT:
> +		case SENSORS_SUBFEATURE_POWER_AVERAGE:
> +		case SENSORS_SUBFEATURE_ENERGY_INPUT:
> +			nr--;
> +			break;
>  		}
>  
>  		if (nr < 0 || nr >= MAX_SENSORS_PER_TYPE) {
> @@ -347,11 +374,12 @@
>  		   sorted table */
>  		switch (sftype) {
>  		case SENSORS_SUBFEATURE_VID:
> -			i = nr + MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6;
> +			i = nr + MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
> +			    MAX_SENSOR_TYPES * 2;
>  			break;
>  		case SENSORS_SUBFEATURE_BEEP_ENABLE:
> -			i = MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 +
> -			    MAX_SENSORS_PER_TYPE;
> +			i = MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
> +			    MAX_SENSOR_TYPES * 2 + MAX_SENSORS_PER_TYPE;
>  			break;
>  		default:
>  			i = (sftype >> 8) * MAX_SENSORS_PER_TYPE *
> @@ -389,7 +417,8 @@
>  		if (!all_subfeatures[i].name)
>  			continue;
>  
> -		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 ||
> +		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
> +		    MAX_SENSOR_TYPES * 2 ||
>  		    i / (MAX_SUBFEATURES * 2) != prev_slot) {
>  			fnum++;
>  			prev_slot = i / (MAX_SUBFEATURES * 2);
> @@ -410,7 +439,8 @@
>  			continue;
>  
>  		/* New main feature? */
> -		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 ||
> +		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
> +		    MAX_SENSOR_TYPES * 2 ||
>  		    i / (MAX_SUBFEATURES * 2) != prev_slot) {
>  			ftype = all_subfeatures[i].type >> 8;
>  			fnum++;

The rest looks OK, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
