From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 10:50:17 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors: Add support for additional
Message-Id: <20110316115017.0b798c29@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/Zxo/wRH1i3c+7gd98vMb08Z"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316042006.GA25075@ericsson.com>
In-Reply-To: <20110316042006.GA25075@ericsson.com>
To: lm-sensors@vger.kernel.org

--MP_/Zxo/wRH1i3c+7gd98vMb08Z
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Guenter,

On Tue, 15 Mar 2011 21:20:06 -0700, Guenter Roeck wrote:
> This patch adds support for additional sensor attributes to the sensors c=
ommand.
>=20
> v2: Incorporated feedback from code review as follows.
>=20
> - Changed several variable and function names to better match functionali=
ty.
> - Removed unnecessary conditionals.
> - Modified output to better match original alignment.
> - Always print alarms if set, even if there are no limit registers
> - Added range check to get_sensor_limit_data() to avoid buffer overruns.
>   If an overrun occurs, display an error message and try to write a core =
dump.
> - Added comment explaining when alarms are queued, and why alarm values a=
re
>   not queued.
> - Avoid use of strcpy() and strcat(). Instead, use patch from Jean's
>   review to attach temperature units to limit values.
> - Print highest/lowest as well as max/crit power attributes if provided.
> - Replace MIN/MAX temperature alarms with LOW/HIGH.
> - If an attribute value is 0, display the value with its base unit,
>   not with the minumum supported unit.
> - Replace "emergency" with "emerg" for emergency high temperature attribu=
tes.
>=20
> An example sensors output from a system with lots of sensors is attached
> for reference.

Please use "svn diff -x-p" for non-trivial SVN-generated patches. This
adds the function name before each change (like diff -p), making the
changes easier to review.

One bug introduced by this new version of the patch: now that limit
printing no longer ends with two spaces, the temperature sensor type
printing lacks proper spacing:

TR1 Temp:     +74.0=B0C  (high =3D +85.0=B0C, hyst =3D +82.0=B0C)
                       (crit =3D +90.0=B0C, crit hyst =3D +87.0=B0C)sensor =
=3D thermistor
TR2 Temp:     +96.0=B0C  (high =3D +85.0=B0C, hyst =3D +82.0=B0C)  ALARM
                       (crit =3D +90.0=B0C, crit hyst =3D +87.0=B0C)sensor =
=3D thermistor
CPU1 Temp:    +37.0=B0C  (high =3D +85.0=B0C, hyst =3D +80.0=B0C)
                       (crit =3D +84.0=B0C, crit hyst =3D +79.0=B0C)sensor =
=3D Intel PECI

Fix is attached.

Now to the code review:

>=20
> --
>=20
> Index: prog/sensors/chips.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- prog/sensors/chips.c	(revision 5939)
> +++ prog/sensors/chips.c	(working copy)
> @@ -24,6 +24,8 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <math.h>
> +#include <sys/types.h>
> +#include <signal.h>
> =20
>  #include "main.h"
>  #include "chips.h"
> @@ -126,38 +128,159 @@
>  	return max_size + 2;
>  }
> =20
> -static void print_temp_limits(double limit1, double limit2,
> -			      const char *name1, const char *name2, int alarm)
> +static void print_alarms(struct sensor_subfeature_data *alarms, int alar=
m_count,
> +			 int leading_spaces)
>  {
> -	if (fahrenheit) {
> -		limit1 =3D deg_ctof(limit1);
> -		limit2 =3D deg_ctof(limit2);
> -        }
> +	int i;
> =20
> -	if (name2) {
> -		printf("(%-4s =3D %+5.1f%s, %-4s =3D %+5.1f%s)  ",
> -		       name1, limit1, degstr,
> -		       name2, limit2, degstr);
> -	} else if (name1) {
> -		printf("(%-4s =3D %+5.1f%s)                  ",
> -		       name1, limit1, degstr);
> -	} else {
> -		printf("                                  ");
> +	printf("%*s", leading_spaces + 7, "ALARM");
> +	if (alarms[0].name) {
> +		printf(" (");
> +		for (i =3D 0; i < alarm_count; i++) {
> +			printf("%s", alarms[i].name);
> +			if (i < alarm_count - 1)
> +				printf(", ");
> +		}
> +		printf(")");
>  	}
> +}
> =20
> -	if (alarm)
> -		printf("ALARM  ");
> +static void print_limits(struct sensor_subfeature_data *limits,
> +			 int limit_count,
> +			 struct sensor_subfeature_data *alarms,
> +			 int alarm_count, int label_size,
> +			 const char *fmt)
> +{
> +	int i;
> +	int alarms_printed =3D 0;
> +
> +	for (i =3D 0; i < limit_count; i++) {
> +		if (!(i & 1)) {
> +			if (i)
> +				printf("\n%*s", label_size + 10, "");
> +			printf("(");
> +		} else {
> +			printf(", ");
> +		}
> +		printf(fmt, limits[i].name, limits[i].value,
> +			     limits[i].unit);
> +		if ((i & 1) || i =3D=3D limit_count - 1) {
> +			printf(")");
> +			if (i < 2 && alarm_count) {

Now that you introduced variable alarms_printed, you could instead test
for (alarm_count && !alarms_printed). This is certainly more readable,
and consistent with the test at the end of the function.

> +				print_alarms(alarms, alarm_count,
> +					     (i & 1) ?  0 : 16);

coding style: double space between "?" and "0".

> +				alarms_printed =3D 1;
> +			}
> +		}
> +	}
> +	if (alarm_count && !alarms_printed)
> +		print_alarms(alarms, alarm_count, 32);
>  }
> =20

Please document that *num_limits and *num_alarms must be initialized by
the caller.

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
> +	for (; sfl->subfeature >=3D 0; sfl++) {
> +		sf =3D sensors_get_subfeature(name, feature, sfl->subfeature);
> +		if (sf) {
> +			if (sfl->alarm) {
> +				/*
> +				 * Only queue alarm subfeatures if the alarm
> +				 * is active, and don't store the alarm value
> +				 * (it is implied to be active if queued).
> +				 */
> +				if (get_value(name, sf)) {
> +					if (*num_alarms >=3D max_alarms) {
> +						fprintf(stderr,
> +							"Not enough alarm buffers (%d)\n",
> +							max_alarms);
> +						kill(0, SIGABRT);
> +					}

This is way too aggressive. Being out of buffers is not the end of the
world. I'm sure the users won't be happy to be unable to use "sensors"
at all just because of this. Just skip the alarms which do not fit.

> +					alarms[*num_alarms].name =3D sfl->name;
> +					(*num_alarms)++;
> +				}
> +			} else {
> +				/*
> +				 * Always queue limit subfeatures with their value.
> +				 */
> +				if (*num_limits >=3D max_limits) {
> +					fprintf(stderr,
> +						"Not enough limit buffers (%d)\n",
> +						max_limits);
> +					kill(0, SIGABRT);
> +				}

Same here. Also, you have almost similar error strings, so you can use
%s for the differing word to let the compiler reuse the string. This
should save a few bytes in the sensors binary (patch attached.)

> +				limits[*num_limits].value =3D get_value(name, sf);
> +				limits[*num_limits].name =3D sfl->name;
> +				(*num_limits)++;
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
> +static const struct sensor_subfeature_list temp_alarms[] =3D {
> +	{ SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_TEMP_MIN_ALARM, NULL, NULL, 1, "LOW" },
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_ALARM, NULL, NULL, 1, "HIGH" },
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM, NULL, NULL, 1, "EMERGENCY" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_max_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, NULL, 0, "hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_crit_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, NULL, 0, "crit hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_emergency_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST, NULL, NULL, 0,
> +	    "emerg hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list temp_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_TEMP_ALARM, NULL, temp_alarms, 1, NULL },
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
> -	int alarm, crit_displayed =3D 0;
> +	struct sensor_subfeature_data sensors[8];
> +	struct sensor_subfeature_data alarms[5];
> +	int sensor_count, alarm_count;
> +	const sensors_subfeature *sf;
> +	double val;
>  	char *label;
> +	int i;
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -168,80 +291,6 @@
>  	free(label);
> =20
>  	sf =3D sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_TEMP_ALARM);
> -	alarm =3D sf && get_value(name, sf);
> -
> -	sfmin =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_TEMP_MIN);
> -	sfmax =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_TEMP_MAX);
> -	sfcrit =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT);
> -	if (sfmax) {
> -		sf =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_MAX_ALARM);
> -		if (sf && get_value(name, sf))
> -			alarm |=3D 1;
> -
> -     		if (sfmin) {
> -			limit1 =3D get_value(name, sfmin);
> -			s1 =3D "low";
> -			limit2 =3D get_value(name, sfmax);
> -			s2 =3D "high";
> -
> -			sf =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_MIN_ALARM);
> -			if (sf && get_value(name, sf))
> -				alarm |=3D 1;
> -		} else {
> -			limit1 =3D get_value(name, sfmax);
> -			s1 =3D "high";
> -
> -			sfhyst =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_MAX_HYST);
> -			if (sfhyst) {
> -				limit2 =3D get_value(name, sfhyst);
> -				s2 =3D "hyst";
> -			} else if (sfcrit) {
> -				limit2 =3D get_value(name, sfcrit);
> -				s2 =3D "crit";
> -
> -				sf =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -				if (sf && get_value(name, sf))
> -					alarm |=3D 1;
> -				crit_displayed =3D 1;
> -			} else {
> -				limit2 =3D 0;
> -				s2 =3D NULL;
> -			}
> -		}
> -	} else if (sfcrit) {
> -		limit1 =3D get_value(name, sfcrit);
> -		s1 =3D "crit";
> -
> -		sfhyst =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
> -		if (sfhyst) {
> -			limit2 =3D get_value(name, sfhyst);
> -			s2 =3D "hyst";
> -		} else {
> -			limit2 =3D 0;
> -			s2 =3D NULL;
> -		}
> -
> -		sf =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -		if (sf && get_value(name, sf))
> -			alarm |=3D 1;
> -		crit_displayed =3D 1;
> -	} else {
> -		limit1 =3D limit2 =3D 0;
> -		s1 =3D s2 =3D NULL;
> -	}
> -
> -
> -	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_TEMP_FAULT);
>  	if (sf && get_value(name, sf)) {
>  		printf("   FAULT  ");
> @@ -256,30 +305,21 @@
>  		} else
>  			printf("     N/A  ");
>  	}
> -	print_temp_limits(limit1, limit2, s1, s2, alarm);
> =20
> -	if (!crit_displayed && sfcrit) {
> -		limit1 =3D get_value(name, sfcrit);
> -		s1 =3D "crit";
> +	sensor_count =3D alarm_count =3D 0;
> +	get_sensor_limit_data(name, feature, temp_sensors,
> +			      sensors, 8, &sensor_count,
> +			      alarms, 5, &alarm_count);

The repeated constants are likely to accidentally diverge over time.
Better user ARRAY_SIZE (steal it from prog/sensord/sensord.h or
lib/general.h.)

> =20
> -		sfhyst =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_HYST);
> -		if (sfhyst) {
> -			limit2 =3D get_value(name, sfhyst);
> -			s2 =3D "hyst";
> -		} else {
> -			limit2 =3D 0;
> -			s2 =3D NULL;
> -		}
> +	for (i =3D 0; i < sensor_count; i++) {
> +		if (fahrenheit)
> +			sensors[i].value =3D deg_ctof(sensors[i].value);
> +		sensors[i].unit =3D degstr;
> +	}
> =20
> -		sf =3D sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -		alarm =3D sf && get_value(name, sf);
> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     "%-4s =3D %+5.1f%s");
> =20
> -		printf("\n%*s", label_size + 10, "");
> -		print_temp_limits(limit1, limit2, s1, s2, alarm);
> -	}
> -
>  	/* print out temperature sensor info */
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_TEMP_TYPE);
> @@ -302,13 +342,33 @@
>  	printf("\n");
>  }
> =20
> +static const struct sensor_subfeature_list voltage_alarms[] =3D {
> +	{ SENSORS_SUBFEATURE_IN_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_IN_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_IN_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_IN_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list voltage_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_IN_ALARM, NULL, voltage_alarms, 1, NULL },
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
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -321,50 +381,18 @@
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_IN_INPUT);
>  	if (sf && get_input_value(name, sf, &val) =3D=3D 0)
> -		printf("%+6.2f V", val);
> +		printf("%+6.2f V  ", val);
>  	else
> -		printf("     N/A");
> +		printf("     N/A  ");
> =20
> -	sfmin =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MIN);
> -	sfmax =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MAX);
> -	if (sfmin && sfmax)
> -		printf("  (min =3D %+6.2f V, max =3D %+6.2f V)",
> -		       get_value(name, sfmin),
> -		       get_value(name, sfmax));
> -	else if (sfmin)
> -		printf("  (min =3D %+6.2f V)",
> -		       get_value(name, sfmin));
> -	else if (sfmax)
> -		printf("  (max =3D %+6.2f V)",
> -		       get_value(name, sfmax));
> +	sensor_count =3D alarm_count =3D 0;
> +	get_sensor_limit_data(name, feature, voltage_sensors,
> +			      sensors, 4, &sensor_count,
> +			      alarms, 4, &alarm_count);
> =20
> -	sf =3D sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_IN_ALARM);
> -	sfmin =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MIN_ALARM);
> -	sfmax =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_IN_MAX_ALARM);
> -	if (sfmin || sfmax) {
> -		alarm_max =3D sfmax ? get_value(name, sfmax) : 0;
> -		alarm_min =3D sfmin ? get_value(name, sfmin) : 0;
> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     "%s =3D %+6.2f V");
> =20
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
> =20
> @@ -441,6 +469,11 @@
>  	};
>  	struct scale_table *scale =3D prefix_scales;
> =20
> +	if (abs_value =3D=3D 0) {
> +		*prefixstr =3D "";
> +		return;
> +	}
> +
>  	while (scale->upper_bound && abs_value > scale->upper_bound) {
>  		divisor =3D scale->upper_bound;
>  		scale++;

Unrelated change -> separate patch. Which you can apply right away,
BTW, as it is obviously correct.

> @@ -450,15 +483,49 @@
>  	*prefixstr =3D scale->unit;
>  }
> =20
> +static const struct sensor_subfeature_list power_alarms[] =3D {
> +	{ SENSORS_SUBFEATURE_POWER_CAP_ALARM, NULL, NULL, 1, "CAP" },
> +	{ SENSORS_SUBFEATURE_POWER_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_POWER_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list power_max[] =3D {
> +	{ SENSORS_SUBFEATURE_POWER_MAX, NULL, NULL, 0, "max" },
> +	{ SENSORS_SUBFEATURE_POWER_CRIT, NULL, NULL, 0, "crit" },
> +	{ SENSORS_SUBFEATURE_POWER_CAP, NULL, NULL, 0, "cap" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list power_inst_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, power_alarms, 1, NULL },
> +	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, NULL, 0, "lowest" },
> +	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, power_max, power_max, 0,
> +		"highest" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list power_avg_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, NULL, 1, NULL },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, NULL, 0, "lowest" },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, NULL, 0, "highest" },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, power_max, power_max, 0,
> +		"interval" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};

Hmm. Unconditionally linking the lists by setting exists and nexists to
the same value is certainly clever, but... it's a little confusing, and
you are lucky it works at all: you couldn't use this trick if the last
item of the main list happened to have a legitimate need for exists or
nexists.

I'd rather rename power_max to power_common_sensors, and have a
separate call to get_sensor_limit_data() for it. It should work just as
fine and is less tricky.

BTW, it seems incorrect to include power_max for both instantaneous and
averaging power sensors, but power_alarms only for instantaneous power
sensors, given that these alarms correspond to these limits.

> +
>  static void print_chip_power(const sensors_chip_name *name,
>  			     const sensors_feature *feature,
>  			     int label_size)
>  {
>  	double val;
> -	int need_space =3D 0;
> -	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
> +	const sensors_subfeature *sf;
> +	struct sensor_subfeature_data sensors[6];
> +	struct sensor_subfeature_data alarms[3];
> +	int sensor_count, alarm_count;
>  	char *label;
>  	const char *unit;
> +	int i;
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -468,60 +535,30 @@
>  	print_label(label, label_size);
>  	free(label);
> =20
> +	sensor_count =3D alarm_count =3D 0;
> +
>  	/* Power sensors come in 2 flavors: instantaneous and averaged.
>  	   To keep things simple, we assume that each sensor only implements
>  	   one flavor. */
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_POWER_INPUT);
> -	if (sf) {
> -		sfmin =3D sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
> -		sfmax =3D sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
> -		sfint =3D NULL;
> -	} else {
> -		sf =3D sensors_get_subfeature(name, feature,
> -					    SENSORS_SUBFEATURE_POWER_AVERAGE);

This feature is no longer read in your code, which means that you broke
support for averaging power sensors. It was already the case with the
previous version of this patch, but somehow I managed to not notice.

> -		sfmin =3D sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> -		sfmax =3D sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> -		sfint =3D sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
> -	}
> +	get_sensor_limit_data(name, feature,=20
> +			      sf ? power_inst_sensors : power_avg_sensors,
> +			      sensors, 6, &sensor_count,
> +			      alarms, 3, &alarm_count);
> =20
>  	if (sf && get_input_value(name, sf, &val) =3D=3D 0) {
>  		scale_value(&val, &unit);
> -		printf("%6.2f %sW", val, unit);
> +		printf("%6.2f %sW  ", val, unit);
>  	} else
> -		printf("     N/A");
> +		printf("     N/A  ");
> =20
> -	if (sfmin || sfmax || sfint) {
> -		printf("  (");
> +	for (i =3D 0; i < sensor_count; i++)
> +		scale_value(&sensors[i].value, &sensors[i].unit);
> =20
> -		if (sfmin) {
> -			val =3D get_value(name, sfmin);
> -			scale_value(&val, &unit);
> -			printf("min =3D %6.2f %sW", val, unit);
> -			need_space =3D 1;
> -		}
> +	print_limits(sensors, sensor_count, alarms, alarm_count,
> +		     label_size, "%s =3D %6.2f %sW");
> =20
> -		if (sfmax) {
> -			val =3D get_value(name, sfmax);
> -			scale_value(&val, &unit);
> -			printf("%smax =3D %6.2f %sW", (need_space ? ", " : ""),
> -			       val, unit);
> -			need_space =3D 1;
> -		}
> -
> -		if (sfint) {
> -			printf("%sinterval =3D %6.2f s", (need_space ? ", " : ""),
> -			       get_value(name, sfint));
> -			need_space =3D 1;
> -		}
> -		printf(")");
> -	}
> -
>  	printf("\n");
>  }
> =20
> @@ -595,13 +632,33 @@
>  	free(label);
>  }
> =20
> +static const struct sensor_subfeature_list current_alarms[] =3D {
> +	{ SENSORS_SUBFEATURE_CURR_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_CURR_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_CURR_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_CURR_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_subfeature_list current_sensors[] =3D {
> +	{ SENSORS_SUBFEATURE_CURR_ALARM, NULL, current_alarms, 1, NULL },
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
> =20
>  	if (!(label =3D sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -614,50 +671,18 @@
>  	sf =3D sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_CURR_INPUT);
>  	if (sf && get_input_value(name, sf, &val) =3D=3D 0)
> -		printf("%+6.2f A", val);
> +		printf("%+6.2f A  ", val);
>  	else
> -		printf("     N/A");
> +		printf("     N/A  ");
> =20
> -	sfmin =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MIN);
> -	sfmax =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MAX);
> -	if (sfmin && sfmax)
> -		printf("  (min =3D %+6.2f A, max =3D %+6.2f A)",
> -		       get_value(name, sfmin),
> -		       get_value(name, sfmax));
> -	else if (sfmin)
> -		printf("  (min =3D %+6.2f A)",
> -		       get_value(name, sfmin));
> -	else if (sfmax)
> -		printf("  (max =3D %+6.2f A)",
> -		       get_value(name, sfmax));
> +	sensor_count =3D alarm_count =3D 0;
> +	get_sensor_limit_data(name, feature, current_sensors,
> +			      sensors, 4, &sensor_count,
> +			      alarms, 4, &alarm_count);
> =20
> -	sf =3D sensors_get_subfeature(name, feature,
> -				    SENSORS_SUBFEATURE_CURR_ALARM);
> -	sfmin =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MIN_ALARM);
> -	sfmax =3D sensors_get_subfeature(name, feature,
> -				       SENSORS_SUBFEATURE_CURR_MAX_ALARM);
> -	if (sfmin || sfmax) {
> -		alarm_max =3D sfmax ? get_value(name, sfmax) : 0;
> -		alarm_min =3D sfmin ? get_value(name, sfmin) : 0;
> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     "%s =3D %+6.2f A");
> =20
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
> =20
> Index: prog/sensors/chips.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- prog/sensors/chips.h	(revision 5939)
> +++ prog/sensors/chips.h	(working copy)
> @@ -24,6 +24,32 @@
> =20
>  #include "lib/sensors.h"
> =20
> +/*
> + * Retrieved limits

Subfeatures, not just limits.

> + */
> +struct sensor_subfeature_data {
> +	double value;		/* Subfeature value. Not used for alarms. */
> +	const char *name;	/* Subfeature name */
> +	const char *unit;	/* Unit to be displayed for this subfeature.
> +				   This field is optional. */
> +};
> +
> +/*
> + * Subfeature data structure. Used to create a table of supported subfea=
tures
> + * for a given feature.

"supported" is not necessarily very clear. I believe that "implemented"
would describe the purpose more accurately.

> + */
> +struct sensor_subfeature_list {
> +	int subfeature;		/* Limit we are looking for */

Subfeature, not just limit. This field doesn't necessarily need a
comment anyway.

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
> =20

Thanks,
--=20
Jean Delvare

--MP_/Zxo/wRH1i3c+7gd98vMb08Z
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=fix-temp-sensor-type-spacing.patch

Restore missing spaces before temperature sensor type.
---
 prog/sensors/chips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lm-sensors.orig/prog/sensors/chips.c	2011-03-16 09:27:46.000000000 +0100
+++ lm-sensors/prog/sensors/chips.c	2011-03-16 11:22:37.000000000 +0100
@@ -331,7 +331,7 @@ static void print_chip_temp(const sensor
 		if (sens > 1000)
 			sens = 4;
 
-		printf("sensor = %s", sens == 0 ? "disabled" :
+		printf("  sensor = %s", sens == 0 ? "disabled" :
 		       sens == 1 ? "diode" :
 		       sens == 2 ? "transistor" :
 		       sens == 3 ? "thermal diode" :

--MP_/Zxo/wRH1i3c+7gd98vMb08Z
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=reuse-error-message-string.patch

Reuse error message string for a slightly smaller text section in the
sensors binary.
---
 prog/sensors/chips.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- lm-sensors.orig/prog/sensors/chips.c	2011-03-16 11:22:37.000000000 +0100
+++ lm-sensors/prog/sensors/chips.c	2011-03-16 11:43:07.000000000 +0100
@@ -201,8 +201,8 @@ static void get_sensor_limit_data(const
 				if (get_value(name, sf)) {
 					if (*num_alarms >= max_alarms) {
 						fprintf(stderr,
-							"Not enough alarm buffers (%d)\n",
-							max_alarms);
+							"Not enough %s buffers (%d)\n",
+							"alarm", max_alarms);
 						kill(0, SIGABRT);
 					}
 					alarms[*num_alarms].name = sfl->name;
@@ -214,8 +214,8 @@ static void get_sensor_limit_data(const
 				 */
 				if (*num_limits >= max_limits) {
 					fprintf(stderr,
-						"Not enough limit buffers (%d)\n",
-						max_limits);
+						"Not enough %s buffers (%d)\n",
+						"limit", max_limits);
 					kill(0, SIGABRT);
 				}
 				limits[*num_limits].value = get_value(name, sf);

--MP_/Zxo/wRH1i3c+7gd98vMb08Z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/Zxo/wRH1i3c+7gd98vMb08Z--
