From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 22 Oct 2008 12:47:39 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] libsensors: Add support for current
Message-Id: <48FF20EB.7050104@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022135759.6ed045c0@hyperion.delvare>
In-Reply-To: <20081022135759.6ed045c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Add support for current sensors.
> ---
> The code for function print_chip_curr() is duplicated directly from
> print_chip_in() with IN subfeature names replaced by their CURR
> counterparts and V changed to A.
> 
> Applies on top of the previous patch. I'd appreciate review and testing
> of this patch. Vincent, this should show you the current values you
> were missing so far.
> 
>  doc/libsensors-API.txt |    9 ++++++
>  lib/sensors.h          |    9 ++++++
>  lib/sysfs.c            |   16 ++++++++++-
>  prog/sensors/chips.c   |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 102 insertions(+), 1 deletion(-)
> 

I've reviewed this and it looks good.

Regards,

Hans

> --- lm-sensors-3.orig/lib/sensors.h	2008-10-22 12:03:36.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2008-10-22 12:06:50.000000000 +0200
> @@ -134,6 +134,7 @@ typedef enum sensors_feature_type {
>  	SENSORS_FEATURE_TEMP		= 0x02,
>  	SENSORS_FEATURE_POWER		= 0x03,
>  	SENSORS_FEATURE_ENERGY		= 0x04,
> +	SENSORS_FEATURE_CURR		= 0x05,
>  	SENSORS_FEATURE_VID		= 0x10,
>  	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
>  	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
> @@ -182,6 +183,14 @@ typedef enum sensors_subfeature_type {
>  
>  	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
>  
> +	SENSORS_SUBFEATURE_CURR_INPUT = SENSORS_FEATURE_CURR << 8,
> +	SENSORS_SUBFEATURE_CURR_MIN,
> +	SENSORS_SUBFEATURE_CURR_MAX,
> +	SENSORS_SUBFEATURE_CURR_ALARM = (SENSORS_FEATURE_CURR << 8) | 0x80,
> +	SENSORS_SUBFEATURE_CURR_MIN_ALARM,
> +	SENSORS_SUBFEATURE_CURR_MAX_ALARM,
> +	SENSORS_SUBFEATURE_CURR_BEEP,
> +
>  	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
>  
>  	SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_BEEP_ENABLE << 8,
> --- lm-sensors-3.orig/lib/sysfs.c	2008-10-22 12:03:36.000000000 +0200
> +++ lm-sensors-3/lib/sysfs.c	2008-10-22 12:06:50.000000000 +0200
> @@ -138,7 +138,7 @@ char sensors_sysfs_mount[NAME_MAX];
>  
>  #define MAX_SENSORS_PER_TYPE	20
>  #define MAX_SUBFEATURES		8
> -#define MAX_SENSOR_TYPES	5
> +#define MAX_SENSOR_TYPES	6
>  /* Room for all 5 types (in, fan, temp, power, energy) with all their
>     subfeatures + VID + misc features */
>  #define ALL_POSSIBLE_SUBFEATURES \
> @@ -153,6 +153,7 @@ int get_type_scaling(sensors_subfeature_
>  	switch (type & 0xFF80) {
>  	case SENSORS_SUBFEATURE_IN_INPUT:
>  	case SENSORS_SUBFEATURE_TEMP_INPUT:
> +	case SENSORS_SUBFEATURE_CURR_INPUT:
>  		return 1000;
>  	case SENSORS_SUBFEATURE_FAN_INPUT:
>  		return 1;
> @@ -184,6 +185,7 @@ char *get_feature_name(sensors_feature_t
>  	case SENSORS_FEATURE_TEMP:
>  	case SENSORS_FEATURE_POWER:
>  	case SENSORS_FEATURE_ENERGY:
> +	case SENSORS_FEATURE_CURR:
>  		underscore = strchr(sfname, '_');
>  		name = strndup(sfname, underscore - sfname);
>  		break;
> @@ -259,6 +261,16 @@ static const struct subfeature_type_matc
>  	{ NULL, 0 }
>  };
>  
> +static const struct subfeature_type_match curr_matches[] = {
> +	{ "input", SENSORS_SUBFEATURE_CURR_INPUT },
> +	{ "min", SENSORS_SUBFEATURE_CURR_MIN },
> +	{ "max", SENSORS_SUBFEATURE_CURR_MAX },
> +	{ "alarm", SENSORS_SUBFEATURE_CURR_ALARM },
> +	{ "min_alarm", SENSORS_SUBFEATURE_CURR_MIN_ALARM },
> +	{ "max_alarm", SENSORS_SUBFEATURE_CURR_MAX_ALARM },
> +	{ NULL, 0 }
> +};
> +
>  static const struct subfeature_type_match cpu_matches[] = {
>  	{ "vid", SENSORS_SUBFEATURE_VID },
>  	{ NULL, 0 }
> @@ -270,6 +282,7 @@ static struct feature_type_match matches
>  	{ "fan%d%c", fan_matches },
>  	{ "cpu%d%c", cpu_matches },
>  	{ "power%d%c", power_matches },
> +	{ "curr%d%c", curr_matches },
>  	{ "energy%d%c", energy_matches },
>  };
>  
> @@ -360,6 +373,7 @@ static int sensors_read_dynamic_chip(sen
>  		case SENSORS_SUBFEATURE_TEMP_INPUT:
>  		case SENSORS_SUBFEATURE_POWER_AVERAGE:
>  		case SENSORS_SUBFEATURE_ENERGY_INPUT:
> +		case SENSORS_SUBFEATURE_CURR_INPUT:
>  			nr--;
>  			break;
>  		}
> --- lm-sensors-3.orig/prog/sensors/chips.c	2008-10-22 12:04:38.000000000 +0200
> +++ lm-sensors-3/prog/sensors/chips.c	2008-10-22 12:06:50.000000000 +0200
> @@ -578,6 +578,72 @@ static void print_chip_beep_enable(const
>  	free(label);
>  }
>  
> +static void print_chip_curr(const sensors_chip_name *name,
> +			    const sensors_feature *feature,
> +			    int label_size)
> +{
> +	const sensors_subfeature *sf, *sfmin, *sfmax;
> +	double alarm_max, alarm_min;
> +	char *label;
> +
> +	if (!(label = sensors_get_label(name, feature))) {
> +		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> +			feature->name);
> +		return;
> +	}
> +	print_label(label, label_size);
> +	free(label);
> +
> +	sf = sensors_get_subfeature(name, feature,
> +				    SENSORS_SUBFEATURE_CURR_INPUT);
> +	if (sf)
> +		printf("%+6.2f A", get_value(name, sf));
> +	else
> +		printf("     N/A");
> +
> +	sfmin = sensors_get_subfeature(name, feature,
> +				       SENSORS_SUBFEATURE_CURR_MIN);
> +	sfmax = sensors_get_subfeature(name, feature,
> +				       SENSORS_SUBFEATURE_CURR_MAX);
> +	if (sfmin && sfmax)
> +		printf("  (min = %+6.2f A, max = %+6.2f A)",
> +		       get_value(name, sfmin),
> +		       get_value(name, sfmax));
> +	else if (sfmin)
> +		printf("  (min = %+6.2f A)",
> +		       get_value(name, sfmin));
> +	else if (sfmax)
> +		printf("  (max = %+6.2f A)",
> +		       get_value(name, sfmax));
> +
> +	sf = sensors_get_subfeature(name, feature,
> +				    SENSORS_SUBFEATURE_CURR_ALARM);
> +	sfmin = sensors_get_subfeature(name, feature,
> +				       SENSORS_SUBFEATURE_CURR_MIN_ALARM);
> +	sfmax = sensors_get_subfeature(name, feature,
> +				       SENSORS_SUBFEATURE_CURR_MAX_ALARM);
> +	if (sfmin || sfmax) {
> +		alarm_max = sfmax ? get_value(name, sfmax) : 0;
> +		alarm_min = sfmin ? get_value(name, sfmin) : 0;
> +
> +		if (alarm_min || alarm_max) {
> +			printf(" ALARM (");
> +
> +			if (alarm_min)
> +				printf("MIN");
> +			if (alarm_max)
> +				printf("%sMAX", (alarm_min) ? ", " : "");
> +
> +			printf(")");
> +		}
> +	} else if (sf) {
> +		printf("   %s",
> +		       get_value(name, sf) ? "ALARM" : "");
> +	}
> +
> +	printf("\n");
> +}
> +
>  void print_chip(const sensors_chip_name *name)
>  {
>  	const sensors_feature *feature;
> @@ -609,6 +675,9 @@ void print_chip(const sensors_chip_name
>  		case SENSORS_FEATURE_ENERGY:
>  			print_chip_energy(name, feature, label_size);
>  			break;
> +		case SENSORS_FEATURE_CURR:
> +			print_chip_curr(name, feature, label_size);
> +			break;
>  		default:
>  			continue;
>  		}
> --- lm-sensors-3.orig/doc/libsensors-API.txt	2008-10-22 12:06:42.000000000 +0200
> +++ lm-sensors-3/doc/libsensors-API.txt	2008-10-22 12:07:02.000000000 +0200
> @@ -11,6 +11,15 @@ given new feature.
>    enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_INPUT
>    enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST
>    enum sensors_subfeature_type SENSORS_SUBFEATURE_POWER_INPUT_LOWEST
> +* Added support for current sensors
> +  enum sensors_feature_type SENSORS_FEATURE_CURR
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_INPUT
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_MIN
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_MAX
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_ALARM
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_MIN_ALARM
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_MAX_ALARM
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_BEEP
>  
>  0x401	lm-sensors 3.0.2 to 3.0.3
>  * Added bus type "virtual":
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
