From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 22 Oct 2008 12:47:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] libsensors: Add support for
Message-Id: <48FF20E0.90301@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Add support for instantaneous power sensors.
> ---
> I'd appreciate review and testing of this patch. Darrick, please test
> that this doesn't break support of your IBM chips.
> 
>  doc/libsensors-API.txt |    6 ++++++
>  lib/sensors.h          |    6 ++++--
>  lib/sysfs.c            |    3 +++
>  prog/sensors/chips.c   |   28 +++++++++++++++++++++-------
>  4 files changed, 34 insertions(+), 9 deletions(-)
> 

I've reviewed this and it looks good.

Regards,

Hans

> --- lm-sensors-3.orig/lib/sensors.h	2008-10-22 11:50:39.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2008-10-22 12:03:36.000000000 +0200
> @@ -31,7 +31,7 @@
>     when the API + ABI breaks), the third digit is incremented to track small
>     API additions like new flags / enum values. The second digit is for tracking
>     larger additions like new methods. */
> -#define SENSORS_API_VERSION		0x401
> +#define SENSORS_API_VERSION		0x402
>  
>  #define SENSORS_CHIP_NAME_PREFIX_ANY	NULL
>  #define SENSORS_CHIP_NAME_ADDR_ANY	(-1)
> @@ -175,7 +175,9 @@ typedef enum sensors_subfeature_type {
>  	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
>  	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
>  	SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST,
> -
> +	SENSORS_SUBFEATURE_POWER_INPUT,
> +	SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST,
> +	SENSORS_SUBFEATURE_POWER_INPUT_LOWEST,
>  	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,
>  
>  	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
> --- lm-sensors-3.orig/lib/sysfs.c	2008-10-22 11:50:39.000000000 +0200
> +++ lm-sensors-3/lib/sysfs.c	2008-10-22 12:03:36.000000000 +0200
> @@ -247,6 +247,9 @@ static const struct subfeature_type_matc
>  	{ "average", SENSORS_SUBFEATURE_POWER_AVERAGE },
>  	{ "average_highest", SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST },
>  	{ "average_lowest", SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST },
> +	{ "input", SENSORS_SUBFEATURE_POWER_INPUT },
> +	{ "input_highest", SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST },
> +	{ "input_lowest", SENSORS_SUBFEATURE_POWER_INPUT_LOWEST },
>  	{ "average_interval", SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL },
>  	{ NULL, 0 }
>  };
> --- lm-sensors-3.orig/prog/sensors/chips.c	2008-10-22 11:50:38.000000000 +0200
> +++ lm-sensors-3/prog/sensors/chips.c	2008-10-22 12:04:38.000000000 +0200
> @@ -449,8 +449,28 @@ static void print_chip_power(const senso
>  	print_label(label, label_size);
>  	free(label);
>  
> +	/* Power sensors come in 2 flavors: instantaneous and averaged.
> +	   To keep things simple, we assume that each sensor only implements
> +	   one flavor. */
>  	sf = sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_POWER_AVERAGE);
> +				    SENSORS_SUBFEATURE_POWER_INPUT);
> +	if (sf) {
> +		sfmin = sensors_get_subfeature(name, feature,
> +					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
> +		sfmax = sensors_get_subfeature(name, feature,
> +					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
> +		sfint = NULL;
> +	} else {
> +		sf = sensors_get_subfeature(name, feature,
> +					    SENSORS_SUBFEATURE_POWER_AVERAGE);
> +		sfmin = sensors_get_subfeature(name, feature,
> +					       SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> +		sfmax = sensors_get_subfeature(name, feature,
> +					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> +		sfint = sensors_get_subfeature(name, feature,
> +					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
> +	}
> +
>  	if (sf) {
>  		val = get_value(name, sf);
>  		scale_value(&val, &unit);
> @@ -458,12 +478,6 @@ static void print_chip_power(const senso
>  	} else
>  		printf("     N/A");
>  
> -	sfmin = sensors_get_subfeature(name, feature,
> -				      SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> -	sfmax = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> -	sfint = sensors_get_subfeature(name, feature,
> -				     SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
>  	if (sfmin || sfmax || sfint) {
>  		printf("  (");
>  
> --- lm-sensors-3.orig/doc/libsensors-API.txt	2008-10-22 12:03:35.000000000 +0200
> +++ lm-sensors-3/doc/libsensors-API.txt	2008-10-22 12:06:42.000000000 +0200
> @@ -6,6 +6,12 @@ over time. This document summarizes thes
>  authors can quickly figure out how to test for the availability of a
>  given new feature.
>  
> +0x402	lm-sensors SVN
> +* Added support for instantaneous power sensors
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_INPUT
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_INPUT_LOWEST
> +
>  0x401	lm-sensors 3.0.2 to 3.0.3
>  * Added bus type "virtual":
>    #define SENSORS_BUS_TYPE_VIRTUAL
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
