From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 16:34:09 +0000
Subject: Re: [lm-sensors] [PATCH v3 resend] sensors: Add support for
Message-Id: <20110316173409.05b44bd3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316151522.GB28824@ericsson.com>
In-Reply-To: <20110316151522.GB28824@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 16 Mar 2011 08:15:22 -0700, Guenter Roeck wrote:
> [ copied mailing list this time ]
> 
> This patch adds support for additional sensor attributes to the sensors command.
> 
> v3:
> - Print detailed alarms (if supported) even if the "alarm" flag exists as well.
>   [ With this change, the nexists field in struct sensor_subfeature_list is unused.
>     Question is if we should keep it, or remove it and add it back in if needed
>     at a later time. ]

I would remove it. We might as well never need it later.

> - Always use alarms_printed flag to determine if alarms need to be printed.
> - Document that *num_limits and *num_alarms must be initialized by the caller.
> - Don't create a core dump if subfeature arrays are too small.
> - Use %s in error message to save some binary space.
> - Use ARRAY_SIZE where appropriate.
> - Add missing spaces before "sensor = <type>" output.
> - Add missing SENSORS_SUBFEATURE_POWER_AVERAGE.
> - Replace power_max with power_common_sensors and call get_sensor_limit_data()
>   with it as argument to add common power sensors to list of limits.
> - Replace "limit" with "subfeature" in comments.
> - Commit "If an attribute value is 0, display the value with its base unit,
>   not with the minumum supported unit" separately.
> 
> v2:
> - Changed several variable and function names to better match functionality
> - Removed unnecessary conditionals
> - Modified output to better match original code alignments
> - Always print alarms if set, even if there are no limit registers
> - Added range check to get_sensor_limit_data() to avoid buffer overruns.
>   If an overrun occurs, display an error message and try to write a core dump.
> - Added comment explaining when alarms are queued, and why alarm values are
>   not queued.
> - Avoid use of strcpy() and strcat(). Instead, use patch from Jean's
>   review to attach temperature units to limit values.
> - Print highest/lowest as well as max/crit power attributes if provided.
> - Replace MIN/MAX temperature alarms with LOW/HIGH
> - If an attribute value is 0, display the value with its base unit,
>   not with the minumum supported unit
> - Replace "emergency" with "emerg" for emergency high temperature attributes.
> 
> --

Only minor comments left, and then you can commit:

> 
> Index: prog/sensors/chips.c
> =================================> --- prog/sensors/chips.c	(revision 5942)
> +++ prog/sensors/chips.c	(working copy)
> @@ -27,6 +27,7 @@
>  
>  #include "main.h"
>  #include "chips.h"
> +#include "lib/general.h"

This is tempting, but I'm afraid I can't let you do that. This header
file is not part of the public libsensors API, so applications can't
use it. As a matter of fact, it was decided to duplicate the definition
of ARRAY_SIZE() in sensord, rather than to include "lib/general.h". We
have to do the same for sensors.

>  #include "lib/sensors.h"
>  #include "lib/error.h"
>  
> @@ -126,38 +127,162 @@ static int get_label_size(const sensors_chip_name
>  	return max_size + 2;
>  }
>  
> -static void print_temp_limits(double limit1, double limit2,
> -			      const char *name1, const char *name2, int alarm)
> +static void print_alarms(struct sensor_subfeature_data *alarms, int alarm_count,
> +			 int leading_spaces)
>  {
> -	if (fahrenheit) {
> -		limit1 = deg_ctof(limit1);
> -		limit2 = deg_ctof(limit2);
> -        }
> +	int i, printed;
>  
> -	if (name2) {
> -		printf("(%-4s = %+5.1f%s, %-4s = %+5.1f%s)  ",
> -		       name1, limit1, degstr,
> -		       name2, limit2, degstr);
> -	} else if (name1) {
> -		printf("(%-4s = %+5.1f%s)                  ",
> -		       name1, limit1, degstr);
> -	} else {
> -		printf("                                  ");
> +	printf("%*s", leading_spaces + 7, "ALARM");
> +	if (alarm_count > 1 || alarms[0].name) {
> +		printf(" (");
> +		for (i = printed = 0; i < alarm_count; i++) {
> +			if (alarms[i].name) {
> +				if (printed)
> +					printf(", ");
> +				printf("%s", alarms[i].name);
> +				printed = 1;
> +			}
> +		}
> +		printf(")");
>  	}
> +}
>  
> -	if (alarm)
> -		printf("ALARM  ");
> +static void print_limits(struct sensor_subfeature_data *limits,
> +			 int limit_count,
> +			 struct sensor_subfeature_data *alarms,
> +			 int alarm_count, int label_size,
> +			 const char *fmt)
> +{
> +	int i;
> +	int alarms_printed = 0;
> +
> +	for (i = 0; i < limit_count; i++) {
> +		if (!(i & 1)) {
> +			if (i)
> +				printf("\n%*s", label_size + 10, "");
> +			printf("(");
> +		} else {
> +			printf(", ");
> +		}
> +		printf(fmt, limits[i].name, limits[i].value,
> +			     limits[i].unit);
> +		if ((i & 1) || i = limit_count - 1) {
> +			printf(")");
> +			if (alarm_count && !alarms_printed) {
> +				print_alarms(alarms, alarm_count,
> +					     (i & 1) ? 0 : 16);
> +				alarms_printed = 1;
> +			}
> +		}
> +	}
> +	if (alarm_count && !alarms_printed)
> +		print_alarms(alarms, alarm_count, 32);
>  }
>  
> +/*
> + * Get sensor limit information.
> + * *num_limits and *num_alarms must be initialized by the caller.
> + */
> +static void get_sensor_limit_data(const sensors_chip_name *name,
> +				  const sensors_feature *feature,
> +				  const struct sensor_subfeature_list *sfl,
> +				  struct sensor_subfeature_data *limits,
> +				  int max_limits,
> +				  int *num_limits,
> +				  struct sensor_subfeature_data *alarms,
> +				  int max_alarms,
> +				  int *num_alarms)
> +{
> +	const sensors_subfeature *sf;
> +
> +	for (; sfl->subfeature >= 0; sfl++) {
> +		sf = sensors_get_subfeature(name, feature, sfl->subfeature);
> +		if (sf) {
> +			if (sfl->alarm) {
> +				/*
> +				 * Only queue alarm subfeatures if the alarm
> +				 * is active, and don't store the alarm value
> +				 * (it is implied to be active if queued).
> +				 */
> +				if (get_value(name, sf)) {
> +					if (*num_alarms >= max_alarms) {
> +						fprintf(stderr,
> +							"Not enough %s buffers (%d)\n",
> +							"alarm", max_alarms);
> +					} else {
> +						alarms[*num_alarms].name = sfl->name;
> +						(*num_alarms)++;
> +					}
> +				}
> +			} else {
> +				/*
> +				 * Always queue limit subfeatures with their value.
> +				 */
> +				if (*num_limits >= max_limits) {
> +					fprintf(stderr,
> +						"Not enough %s buffers (%d)\n",
> +						"limit", max_limits);
> +				} else {
> +					limits[*num_limits].value = get_value(name, sf);
> +					limits[*num_limits].name = sfl->name;
> +					(*num_limits)++;
> +				}
> +			}
> +			if (sfl->exists) {
> +				get_sensor_limit_data(name, feature, sfl->exists,
> +						      limits, max_limits, num_limits,
> +						      alarms, max_alarms, num_alarms);
> +			}
> +		} else if (sfl->nexists)
> +			get_sensor_limit_data(name, feature, sfl->nexists,
> +					      limits, max_limits, num_limits,
> +					      alarms, max_alarms, num_alarms);
> +	}
> +}
> +
> +static const struct sensor_subfeature_list temp_max_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, NULL, 0, "hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_crit_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, NULL, 0, "crit hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_emergency_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST, NULL, NULL, 0,
> +	    "emerg hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_ALARM, NULL, NULL, 1, NULL },
> +	{ SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_TEMP_MIN_ALARM, NULL, NULL, 1, "LOW" },
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_ALARM, NULL, NULL, 1, "HIGH" },
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM, NULL, NULL, 1, "EMERGENCY" },
> +	{ SENSORS_SUBFEATURE_TEMP_MIN, NULL, NULL, 0, "low" },
> +	{ SENSORS_SUBFEATURE_TEMP_MAX, temp_max_sensors, NULL, 0, "high" },
> +	{ SENSORS_SUBFEATURE_TEMP_LCRIT, NULL, NULL, 0, "crit low" },
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, NULL, 0, "crit" },
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, NULL, 0,
> +	    "emerg" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
>  static void print_chip_temp(const sensors_chip_name *name,
>  			    const sensors_feature *feature,
>  			    int label_size)
>  {
> -	const sensors_subfeature *sf, *sfmin, *sfmax, *sfcrit, *sfhyst;
> -	double val, limit1, limit2;
> -	const char *s1, *s2;
> -	int alarm, crit_displayed = 0;
> +	struct sensor_subfeature_data sensors[8];
> +	struct sensor_subfeature_data alarms[5];
> +	int sensor_count, alarm_count;
> +	const sensors_subfeature *sf;
> +	double val;
>  	char *label;
> +	int i;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -168,80 +293,6 @@ static void print_chip_temp(const sensors_chip_nam
>  	free(label);
>  
>  	sf = sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_TEMP_ALARM);
> -	alarm = sf && get_value(name, sf);
> -
> -	sfmin = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_TEMP_MIN);
> -	sfmax = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_TEMP_MAX);
> -	sfcrit = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT);
> -	if (sfmax) {
> -		sf = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_MAX_ALARM);
> -		if (sf && get_value(name, sf))
> -			alarm |= 1;
> -
> -     		if (sfmin) {
> -			limit1 = get_value(name, sfmin);
> -			s1 = "low";
> -			limit2 = get_value(name, sfmax);
> -			s2 = "high";
> -
> -			sf = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_MIN_ALARM);
> -			if (sf && get_value(name, sf))
> -				alarm |= 1;
> -		} else {
> -			limit1 = get_value(name, sfmax);
> -			s1 = "high";
> -
> -			sfhyst = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_MAX_HYST);
> -			if (sfhyst) {
> -				limit2 = get_value(name, sfhyst);
> -				s2 = "hyst";
> -			} else if (sfcrit) {
> -				limit2 = get_value(name, sfcrit);
> -				s2 = "crit";
> -
> -				sf = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -				if (sf && get_value(name, sf))
> -					alarm |= 1;
> -				crit_displayed = 1;
> -			} else {
> -				limit2 = 0;
> -				s2 = NULL;
> -			}
> -		}
> -	} else if (sfcrit) {
> -		limit1 = get_value(name, sfcrit);
> -		s1 = "crit";
> -
> -		sfhyst = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
> -		if (sfhyst) {
> -			limit2 = get_value(name, sfhyst);
> -			s2 = "hyst";
> -		} else {
> -			limit2 = 0;
> -			s2 = NULL;
> -		}
> -
> -		sf = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -		if (sf && get_value(name, sf))
> -			alarm |= 1;
> -		crit_displayed = 1;
> -	} else {
> -		limit1 = limit2 = 0;
> -		s1 = s2 = NULL;
> -	}
> -
> -
> -	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_TEMP_FAULT);
>  	if (sf && get_value(name, sf)) {
>  		printf("   FAULT  ");
> @@ -256,30 +307,21 @@ static void print_chip_temp(const sensors_chip_nam
>  		} else
>  			printf("     N/A  ");
>  	}
> -	print_temp_limits(limit1, limit2, s1, s2, alarm);
>  
> -	if (!crit_displayed && sfcrit) {
> -		limit1 = get_value(name, sfcrit);
> -		s1 = "crit";
> +	sensor_count = alarm_count = 0;
> +	get_sensor_limit_data(name, feature, temp_sensors,
> +			      sensors, ARRAY_SIZE(sensors), &sensor_count,
> +			      alarms, ARRAY_SIZE(alarms), &alarm_count);
>  
> -		sfhyst = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
> -		if (sfhyst) {
> -			limit2 = get_value(name, sfhyst);
> -			s2 = "hyst";
> -		} else {
> -			limit2 = 0;
> -			s2 = NULL;
> -		}
> +	for (i = 0; i < sensor_count; i++) {
> +		if (fahrenheit)
> +			sensors[i].value = deg_ctof(sensors[i].value);
> +		sensors[i].unit = degstr;
> +	}
>  
> -		sf = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -		alarm = sf && get_value(name, sf);
> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     "%-4s = %+5.1f%s");
>  
> -		printf("\n%*s", label_size + 10, "");
> -		print_temp_limits(limit1, limit2, s1, s2, alarm);
> -	}
> -
>  	/* print out temperature sensor info */
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_TEMP_TYPE);
> @@ -291,7 +333,7 @@ static void print_chip_temp(const sensors_chip_nam
>  		if (sens > 1000)
>  			sens = 4;
>  
> -		printf("sensor = %s", sens = 0 ? "disabled" :
> +		printf("  sensor = %s", sens = 0 ? "disabled" :
>  		       sens = 1 ? "diode" :
>  		       sens = 2 ? "transistor" :
>  		       sens = 3 ? "thermal diode" :
> @@ -302,13 +344,29 @@ static void print_chip_temp(const sensors_chip_nam
>  	printf("\n");
>  }
>  
> +static const struct sensor_subfeature_list voltage_sensors[] = {
> +	{ SENSORS_SUBFEATURE_IN_ALARM, NULL, NULL, 1, NULL },
> +	{ SENSORS_SUBFEATURE_IN_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_IN_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_IN_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_IN_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ SENSORS_SUBFEATURE_IN_LCRIT, NULL, NULL, 0, "crit min" },
> +	{ SENSORS_SUBFEATURE_IN_MIN, NULL, NULL, 0, "min" },
> +	{ SENSORS_SUBFEATURE_IN_MAX, NULL, NULL, 0, "max" },
> +	{ SENSORS_SUBFEATURE_IN_CRIT, NULL, NULL, 0, "crit max" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
>  static void print_chip_in(const sensors_chip_name *name,
>  			  const sensors_feature *feature,
>  			  int label_size)
>  {
> -	const sensors_subfeature *sf, *sfmin, *sfmax;
> -	double val, alarm_max, alarm_min;
> +	const sensors_subfeature *sf;
>  	char *label;
> +	struct sensor_subfeature_data sensors[4];
> +	struct sensor_subfeature_data alarms[4];
> +	int sensor_count, alarm_count;
> +	double val;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -321,50 +379,18 @@ static void print_chip_in(const sensors_chip_name
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_IN_INPUT);
>  	if (sf && get_input_value(name, sf, &val) = 0)
> -		printf("%+6.2f V", val);
> +		printf("%+6.2f V  ", val);
>  	else
> -		printf("     N/A");
> +		printf("     N/A  ");
>  
> -	sfmin = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MIN);
> -	sfmax = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MAX);
> -	if (sfmin && sfmax)
> -		printf("  (min = %+6.2f V, max = %+6.2f V)",
> -		       get_value(name, sfmin),
> -		       get_value(name, sfmax));
> -	else if (sfmin)
> -		printf("  (min = %+6.2f V)",
> -		       get_value(name, sfmin));
> -	else if (sfmax)
> -		printf("  (max = %+6.2f V)",
> -		       get_value(name, sfmax));
> +	sensor_count = alarm_count = 0;
> +	get_sensor_limit_data(name, feature, voltage_sensors,
> +			      sensors, ARRAY_SIZE(sensors), &sensor_count,
> +			      alarms, ARRAY_SIZE(alarms), &alarm_count);
>  
> -	sf = sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_IN_ALARM);
> -	sfmin = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MIN_ALARM);
> -	sfmax = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MAX_ALARM);
> -	if (sfmin || sfmax) {
> -		alarm_max = sfmax ? get_value(name, sfmax) : 0;
> -		alarm_min = sfmin ? get_value(name, sfmin) : 0;
> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     "%s = %+6.2f V");
>  
> -		if (alarm_min || alarm_max) {
> -			printf(" ALARM (");
> -
> -			if (alarm_min)
> -				printf("MIN");
> -			if (alarm_max)
> -				printf("%sMAX", (alarm_min) ? ", " : "");
> -
> -			printf(")");
> -		}
> -	} else if (sf) {
> -		printf("   %s",
> -		       get_value(name, sf) ? "ALARM" : "");
> -	}
> -
>  	printf("\n");
>  }
>  
> @@ -455,15 +481,43 @@ static void scale_value(double *value, const char
>  	*prefixstr = scale->unit;
>  }
>  
> +static const struct sensor_subfeature_list power_common_sensors[] = {
> +	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, NULL, 1, NULL },
> +	{ SENSORS_SUBFEATURE_POWER_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_POWER_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ SENSORS_SUBFEATURE_POWER_CAP_ALARM, NULL, NULL, 1, "CAP" },
> +	{ SENSORS_SUBFEATURE_POWER_MAX, NULL, NULL, 0, "max" },
> +	{ SENSORS_SUBFEATURE_POWER_CRIT, NULL, NULL, 0, "crit" },
> +	{ SENSORS_SUBFEATURE_POWER_CAP, NULL, NULL, 0, "cap" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list power_inst_sensors[] = {
> +	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, NULL, 0, "lowest" },
> +	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, NULL, 0, "highest" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list power_avg_sensors[] = {
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, NULL, 0, "lowest" },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, NULL, 0, "highest" },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, NULL, 0,
> +		"interval" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
>  static void print_chip_power(const sensors_chip_name *name,
>  			     const sensors_feature *feature,
>  			     int label_size)
>  {
>  	double val;
> -	int need_space = 0;
> -	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
> +	const sensors_subfeature *sf;
> +	struct sensor_subfeature_data sensors[6];
> +	struct sensor_subfeature_data alarms[3];
> +	int sensor_count, alarm_count;
>  	char *label;
>  	const char *unit;
> +	int i;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -473,60 +527,38 @@ static void print_chip_power(const sensors_chip_na
>  	print_label(label, label_size);
>  	free(label);
>  
> +	sensor_count = alarm_count = 0;
> +
>  	/* Power sensors come in 2 flavors: instantaneous and averaged.
>  	   To keep things simple, we assume that each sensor only implements
>  	   one flavor. */
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_POWER_INPUT);
> -	if (sf) {
> -		sfmin = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
> -		sfmax = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
> -		sfint = NULL;
> -	} else {
> +	get_sensor_limit_data(name, feature, 

Evil trailing white space ;)

> +			      sf ? power_inst_sensors : power_avg_sensors,
> +			      sensors, ARRAY_SIZE(sensors), &sensor_count,
> +			      alarms, ARRAY_SIZE(alarms), &alarm_count);
> +	/* Add sensors common to both flavors. */
> +	get_sensor_limit_data(name, feature, 

Here too.

> +			      power_common_sensors,
> +			      sensors, ARRAY_SIZE(sensors), &sensor_count,
> +			      alarms, ARRAY_SIZE(alarms), &alarm_count);
> +	if (!sf)
>  		sf = sensors_get_subfeature(name, feature,
>  					    SENSORS_SUBFEATURE_POWER_AVERAGE);
> -		sfmin = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> -		sfmax = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> -		sfint = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
> -	}
>  
>  	if (sf && get_input_value(name, sf, &val) = 0) {
>  		scale_value(&val, &unit);
> -		printf("%6.2f %sW", val, unit);
> +		printf("%6.2f %sW  ", val, unit);
>  	} else
> -		printf("     N/A");
> +		printf("     N/A  ");
>  
> -	if (sfmin || sfmax || sfint) {
> -		printf("  (");
> +	for (i = 0; i < sensor_count; i++)
> +		scale_value(&sensors[i].value, &sensors[i].unit);
>  
> -		if (sfmin) {
> -			val = get_value(name, sfmin);
> -			scale_value(&val, &unit);
> -			printf("min = %6.2f %sW", val, unit);
> -			need_space = 1;
> -		}
> +	print_limits(sensors, sensor_count, alarms, alarm_count,
> +		     label_size, "%s = %6.2f %sW");
>  
> -		if (sfmax) {
> -			val = get_value(name, sfmax);
> -			scale_value(&val, &unit);
> -			printf("%smax = %6.2f %sW", (need_space ? ", " : ""),
> -			       val, unit);
> -			need_space = 1;
> -		}
> -
> -		if (sfint) {
> -			printf("%sinterval = %6.2f s", (need_space ? ", " : ""),
> -			       get_value(name, sfint));
> -			need_space = 1;
> -		}
> -		printf(")");
> -	}
> -
>  	printf("\n");
>  }
>  
> @@ -600,13 +632,29 @@ static void print_chip_beep_enable(const sensors_c
>  	free(label);
>  }
>  
> +static const struct sensor_subfeature_list current_sensors[] = {
> +	{ SENSORS_SUBFEATURE_CURR_ALARM, NULL, NULL, 1, NULL },
> +	{ SENSORS_SUBFEATURE_CURR_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_CURR_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_CURR_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_CURR_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ SENSORS_SUBFEATURE_CURR_LCRIT, NULL, NULL, 0, "crit min" },
> +	{ SENSORS_SUBFEATURE_CURR_MIN, NULL, NULL, 0, "min" },
> +	{ SENSORS_SUBFEATURE_CURR_MAX, NULL, NULL, 0, "max" },
> +	{ SENSORS_SUBFEATURE_CURR_CRIT, NULL, NULL, 0, "crit max" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
>  static void print_chip_curr(const sensors_chip_name *name,
>  			    const sensors_feature *feature,
>  			    int label_size)
>  {
> -	const sensors_subfeature *sf, *sfmin, *sfmax;
> -	double alarm_max, alarm_min, val;
> +	const sensors_subfeature *sf;
> +	double val;
>  	char *label;
> +	struct sensor_subfeature_data sensors[4];
> +	struct sensor_subfeature_data alarms[4];
> +	int sensor_count, alarm_count;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -619,50 +667,18 @@ static void print_chip_curr(const sensors_chip_nam
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_CURR_INPUT);
>  	if (sf && get_input_value(name, sf, &val) = 0)
> -		printf("%+6.2f A", val);
> +		printf("%+6.2f A  ", val);
>  	else
> -		printf("     N/A");
> +		printf("     N/A  ");
>  
> -	sfmin = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MIN);
> -	sfmax = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MAX);
> -	if (sfmin && sfmax)
> -		printf("  (min = %+6.2f A, max = %+6.2f A)",
> -		       get_value(name, sfmin),
> -		       get_value(name, sfmax));
> -	else if (sfmin)
> -		printf("  (min = %+6.2f A)",
> -		       get_value(name, sfmin));
> -	else if (sfmax)
> -		printf("  (max = %+6.2f A)",
> -		       get_value(name, sfmax));
> +	sensor_count = alarm_count = 0;
> +	get_sensor_limit_data(name, feature, current_sensors,
> +			      sensors, ARRAY_SIZE(sensors), &sensor_count,
> +			      alarms, ARRAY_SIZE(alarms), &alarm_count);
>  
> -	sf = sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_CURR_ALARM);
> -	sfmin = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MIN_ALARM);
> -	sfmax = sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MAX_ALARM);
> -	if (sfmin || sfmax) {
> -		alarm_max = sfmax ? get_value(name, sfmax) : 0;
> -		alarm_min = sfmin ? get_value(name, sfmin) : 0;
> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     "%s = %+6.2f A");
>  
> -		if (alarm_min || alarm_max) {
> -			printf(" ALARM (");
> -
> -			if (alarm_min)
> -				printf("MIN");
> -			if (alarm_max)
> -				printf("%sMAX", (alarm_min) ? ", " : "");
> -
> -			printf(")");
> -		}
> -	} else if (sf) {
> -		printf("   %s",
> -		       get_value(name, sf) ? "ALARM" : "");
> -	}
> -
>  	printf("\n");
>  }
>  
> Index: prog/sensors/chips.h
> =================================> --- prog/sensors/chips.h	(revision 5941)
> +++ prog/sensors/chips.h	(working copy)
> @@ -24,6 +24,32 @@
>  
>  #include "lib/sensors.h"
>  
> +/*
> + * Retrieved subfeatures
> + */
> +struct sensor_subfeature_data {
> +	double value;		/* Subfeature value. Not used for alarms. */
> +	const char *name;	/* Subfeature name */
> +	const char *unit;	/* Unit to be displayed for this subfeature.
> +				   This field is optional. */
> +};
> +
> +/*
> + * Subfeature data structure. Used to create a table of implemented subfeatures
> + * for a given feature.
> + */
> +struct sensor_subfeature_list {
> +	int subfeature;
> +	const struct sensor_subfeature_list *exists;
> +				/* Complementary subfeatures to be displayed
> +				   if subfeature exists */
> +	const struct sensor_subfeature_list *nexists;
> +				/* Alternative subfeatures to be displayed
> +				   if subfeature does not exist */
> +	int alarm;		/* true if this is an alarm */
> +	const char *name;	/* subfeature name to be printed */
> +};
> +
>  void print_chip_raw(const sensors_chip_name *name);
>  void print_chip(const sensors_chip_name *name);
>  


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
