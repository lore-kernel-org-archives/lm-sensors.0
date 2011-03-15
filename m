From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Mar 2011 10:27:34 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <20110315112734.3f75b5bf@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/jMg/NXw3WPX.1BRglQAif+h"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
To: lm-sensors@vger.kernel.org

--MP_/jMg/NXw3WPX.1BRglQAif+h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guenter,

Sorry for the late answer.

On Wed, 9 Feb 2011 19:07:57 -0800, Guenter Roeck wrote:
> This patch adds support for additional sensor attributes to the sensors command.
> It is essentially a re-submit of a patch submitted earlier, plus support
> for additional sensor attributes which have been added to the sysfs ABI
> since the original patch was submitted.
> 
> This patch rewrites significant paths of chips.c to make it easier to add
> additional attributes. A thorough review would therefore be helpful.
> 
> --
> 
> Resubmitting this one as well. Question is how to proceed with it 
> if no one has time for a thorough review. Maybe commit and clean up
> with subsequent patches if needed ?

What would certainly have helped would be to split the patch into at
least two pieces, one adding the generic mechanism and converting the
already supported limits to use is, and another one adding support for
the new limits. It would have made reviewing slightly easier, and would
also have demonstrated your point that the new mechanism makes adding
new attributes and limits easier.

Regarding the change itself, it is generally welcome, as the specific
code had become difficult to maintain, and would have become totally
horrible after adding support for the new limits. I wasn't especially
proud of it in the first place, so I'm happy to see it go.

I've tested the new code with valgrind and no problems were reported in
my case (chips covered: radeon, coretemp, w83795adg, emc6d102 and
adm1032.)

I've also compared the output of "sensors" before and after the patch.
Except for a decreasing amount trailing white space, which is
definitely not an issue, I noticed two differences.

The first difference is "hyst" being changed to "crit hyst" for
critical temperature limit hysteresis. The original code enforced every
temperature limit label to 4 characters to keep all lines nicely
aligned, and your change breaks this effort. As the hysteresis value
was always printed right after the limit it related to, on the same
line, the "crit" in front of "hyst" was redundant. With the new code,
there might be a new line in between, which isn't so nice. This should
be addressed in an incremental patch IMHO (I can take care.)

The second difference is the amount of space before the ALARM flags for
voltage and temperature inputs. There used to be only two spaces,
saving screen space and being in line with the temperature sensor type
information. Now there are 4 spaces for voltages and temperatures, but
still only 2 for fans. I presume this change wasn't made on purpose, so
I'd like to see it reverted, with ALARM flags being preceded with 2
spaces for all sensor types. Should be very easy to address, see below.

Now, to the code itself:

> 
> Index: prog/sensors/chips.c
> ===================================================================
> --- prog/sensors/chips.c	(revision 5917)
> +++ prog/sensors/chips.c	(working copy)
> @@ -126,38 +126,124 @@
>  	return max_size + 2;
>  }
>  
> -static void print_temp_limits(double limit1, double limit2,
> -			      const char *name1, const char *name2, int alarm)
> +static void print_limits(struct sensor_limit_data *sensors,
> +			 int sensor_count,
> +			 struct sensor_limit_data *alarms,
> +			 int alarm_count, int label_size,
> +			 const char *fmt)

sensors and sensor_count are really misnomers here. These are limits
and limit_count.

>  {
> -	if (fahrenheit) {
> -		limit1 = deg_ctof(limit1);
> -		limit2 = deg_ctof(limit2);
> -        }
> +	int i, j;
> +	int first = 1;
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
> +	for (i = 0; i < sensor_count; i++) {
> +		if (!(i & 1)) {
> +			if (i)
> +				printf("\n%*s", label_size + 10, "");
> +			printf("(");
> +		} else if (i)

I don't get this conditional... it's always true, isn't it?

> +			printf(", ");
> +		printf(fmt, sensors[i].name, sensors[i].value, sensors[i].unit);
> +		if ((i & 1) || i == sensor_count - 1) {
> +			printf(")  ");

The original code would insert many spaces here if only one limit was
printed on this line, to align all potential ALARM flags regardless of
each sensor having an odd or even limit count.

> +			if (first && alarm_count) {

With your current implementation, testing "first" is equivalent to
testing "i < 2", so you don't really need "first".

> +				printf("  ALARM");

You want "ALARM", not "  ALARM", otherwise this is too many spaces. Or
alternatively change the ")  " above to just ")".

> +				if (alarm_count > 1 || alarms[0].name) {

The second test is sufficient. As a matter of fact, you print
alarms[0].name unconditionally in the loop below.

> +					printf("(");

You want " (" here.

> +					for (j = 0; j < alarm_count; j++) {
> +						printf("%s", alarms[j].name);
> +						if (j < alarm_count - 1)
> +							printf(", ");
> +					}
> +					printf(")");
> +				}
> +				first = 0;
> +			}
> +		}
>  	}
> +}

You'll have to decide whether this function ends with printing a ")", or
")  ". Right now, it does the former if there are alarms printed, and
the latter if not. The calling code can't deal with this, obviously. It
seems to me that ending on ")" would make more sense, to give the
caller maximum flexibility.

Also, this function only prints the alarms if at least one limit was
found. While it indeed makes little sense to have alarm flags without
corresponding limits, well... there is weird hardware out there, so I'm
not sure we can ignore this case.

>  
> -	if (alarm)
> -		printf("ALARM  ");
> +static void get_sensor_limit_data(const sensors_chip_name *name,
> +				  const sensors_feature *feature,
> +				  const struct sensor_limits *ts,
> +				  struct sensor_limit_data *ts_data,
> +				  int *ts_sensors,
> +				  struct sensor_limit_data *ts_alarm_data,
> +				  int *ts_alarms)

The names of the last 4 parameters are really confusing... even worse
than for print_limits()! Please use the same naming convention for both
functions. And in the calling functions, too. And I'm not even sure
what "ts" stands for... "temperature sensor", as a legacy of a time
where this function was only used to print temperature limits?

> +{
> +	const sensors_subfeature *sf;
> +
> +	for (; ts->subfeature >= 0; ts++) {
> +		sf = sensors_get_subfeature(name, feature, ts->subfeature);
> +		if (sf) {
> +			if (ts->alarm && get_value(name, sf)) {
> +				ts_alarm_data[*ts_alarms].name = ts->name;
> +				(*ts_alarms)++;
> +			} else if (!ts->alarm) {

This test is partly redundant. If you split the get_value() test above,
you can skip the !ts->alarm test. BTW the test on get_value()
definitely deserves a comment. You only queue alarm subfeatures if
the alarm is active, and you don't store their value, while limit
subfeatures are always queued, with their value. The function should be
documented as such.

> +				ts_data[*ts_sensors].value
> +				  = get_value(name, sf);
> +				ts_data[*ts_sensors].name = ts->name;
> +				(*ts_sensors)++;
> +			}
> +			if (ts->exists) {
> +				get_sensor_limit_data(name, feature, ts->exists,
> +						      ts_data, ts_sensors,
> +						      ts_alarm_data, ts_alarms);
> +			}
> +		} else if (!sf && ts->nexists)

The test for !sf is redundant here, it will always succeed.

> +			get_sensor_limit_data(name, feature, ts->nexists,
> +					      ts_data, ts_sensors,
> +					      ts_alarm_data, ts_alarms);
> +	}
>  }

There is something I don't like about this function: you assume that
the provided ts, ts_sensors and ts_alarms are such that all the
subfeatures from ts (including exists and nexists recursions) will fit
in ts_sensors and ts_alarms are. If this assumption fails, you'll
overrun the arrays and corrupt the stack, which is pretty bad. The
recursive relations between the various ts arrays make it easy to get
wrong, methinks.

Unfortunately I see no way to check the sizes for correctness at build
time, which means we'll have to do it at run time. This could be done
with the current prototype by having the caller pass the array sizes as
the initial values of ts_sensors and ts_alarms. The code would only
have to be adjusted a little. Or maybe you have a better idea?

>  
> +static const struct sensor_limits temp_alarms[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_TEMP_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_ALARM, NULL, NULL, 1, "EMERGENCY" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits temp_max_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_MAX_HYST, NULL, NULL, 0, "hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits temp_crit_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT_HYST, NULL, NULL, 0, "crit hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits temp_emergency_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST, NULL, NULL, 0,
> +	    "emergency hyst" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits temp_sensors[] = {
> +	{ SENSORS_SUBFEATURE_TEMP_ALARM, NULL, temp_alarms, 1, NULL },
> +	{ SENSORS_SUBFEATURE_TEMP_MIN, NULL, NULL, 0, "low" },
> +	{ SENSORS_SUBFEATURE_TEMP_MAX, temp_max_sensors, NULL, 0, "high" },
> +	{ SENSORS_SUBFEATURE_TEMP_LCRIT, NULL, NULL, 0, "crit low" },
> +	{ SENSORS_SUBFEATURE_TEMP_CRIT, temp_crit_sensors, NULL, 0, "crit" },
> +	{ SENSORS_SUBFEATURE_TEMP_EMERGENCY, temp_emergency_sensors, NULL, 0,
> +	    "emergency" },
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
> +	struct sensor_limit_data sensors[8];
> +	struct sensor_limit_data alarms[5];
> +	int sensor_count, alarm_count;
> +	const sensors_subfeature *sf;
> +	double val;
>  	char *label;
> +	int i;
> +	char fmt[32];
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -168,80 +254,6 @@
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
> @@ -256,30 +268,21 @@
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
> +			      sensors, &sensor_count,
> +			      alarms, &alarm_count);
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
> +	if (fahrenheit)
> +		for (i = 0; i < sensor_count; i++)
> +			sensors[i].value = deg_ctof(sensors[i].value);
>  
> -		sf = sensors_get_subfeature(name, feature,
> -					SENSORS_SUBFEATURE_TEMP_CRIT_ALARM);
> -		alarm = sf && get_value(name, sf);
> +	strcpy(fmt, "%-4s = %+5.1f");
> +	strcat(fmt, degstr);

I strongly discourage the use of strcpy and strcat, especially on stack
buffers, for both safety and performance reasons. I would have
suggested the use of snprintf instead, but...

You implemented a very nice mechanism to attach units to limit values,
which you use for power limits, I fail to see why you don't just use it
here as well? It would make the code more elegant IMHO (see attached
patch.)

> +	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
> +		     fmt);
>  
> -		printf("\n%*s", label_size + 10, "");
> -		print_temp_limits(limit1, limit2, s1, s2, alarm);
> -	}
> -
>  	/* print out temperature sensor info */
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_TEMP_TYPE);
> @@ -302,13 +305,33 @@
>  	printf("\n");
>  }
>  
> +static const struct sensor_limits voltage_alarms[] = {
> +	{ SENSORS_SUBFEATURE_IN_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_IN_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_IN_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_IN_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits voltage_sensors[] = {
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
> +	struct sensor_limit_data sensors[4];
> +	struct sensor_limit_data alarms[4];
> +	int sensor_count, alarm_count;
> +	double val;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -321,50 +344,18 @@
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_IN_INPUT);
>  	if (sf && get_input_value(name, sf, &val) == 0)
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
> +			      sensors, &sensor_count,
> +			      alarms, &alarm_count);
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
> @@ -450,15 +441,53 @@
>  	*prefixstr = scale->unit;
>  }
>  
> +static const struct sensor_limits power_alarms[] = {
> +	{ SENSORS_SUBFEATURE_POWER_CAP_ALARM, NULL, NULL, 1, "CAP" },
> +	{ SENSORS_SUBFEATURE_POWER_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_POWER_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits power_inst_highest[] = {
> +	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, NULL, 0, "max" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits power_inst_max[] = {
> +	{ SENSORS_SUBFEATURE_POWER_MAX, NULL, NULL, 0, "max" },
> +	{ SENSORS_SUBFEATURE_POWER_CRIT, NULL, NULL, 0, "crit" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits power_inst_sensors[] = {
> +	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, power_alarms, 1, NULL },
> +	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, power_inst_highest,
> +	    power_inst_max, 0, "min" },

This deserves a comment at least... if it is correct at all. Why would
INPUT_HIGHEST require INPUT_LOWEST? I can imagine a chip providing one
without the other (this would even make a lot of sense if you ask me).
I also don't get why MAX and CRIT would be mutually exclusive with
INPUT_LOWEST and INPUT_HIGHEST. Please explain or fix.

> +	{ SENSORS_SUBFEATURE_POWER_CAP, NULL, NULL, 0, "cap" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits power_avg_sensors[] = {
> +	{ SENSORS_SUBFEATURE_POWER_ALARM, NULL, NULL, 1, NULL },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, NULL, 0, "min" },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, NULL, 0, "max" },
> +	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, NULL, 0,
> +	    "interval" },
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
> +	struct sensor_limit_data sensors[4];
> +	struct sensor_limit_data alarms[3];
> +	int sensor_count, alarm_count;
>  	char *label;
>  	const char *unit;
> +	int i;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -468,60 +497,36 @@
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
>  	if (sf) {
> -		sfmin = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST);
> -		sfmax = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_INPUT_LOWEST);
> -		sfint = NULL;
> +		get_sensor_limit_data(name, feature, power_inst_sensors,
> +				      sensors, &sensor_count, alarms,
> +				      &alarm_count);
>  	} else {
> -		sf = sensors_get_subfeature(name, feature,
> -					    SENSORS_SUBFEATURE_POWER_AVERAGE);
> -		sfmin = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> -		sfmax = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> -		sfint = sensors_get_subfeature(name, feature,
> -					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
> +		get_sensor_limit_data(name, feature, power_avg_sensors,
> +				      sensors, &sensor_count, alarms,
> +				      &alarm_count);
>  	}
>  
>  	if (sf && get_input_value(name, sf, &val) == 0) {
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
> +	if (sensor_count)

This test isn't needed, print_limits() will deal with the !sensor_count
case just fine (and as a matter of fact you don't have this test in any
other function.)

> +		print_limits(sensors, sensor_count, alarms, alarm_count,
> +			     label_size, "%s = %6.2f %sW");
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
> @@ -595,13 +600,33 @@
>  	free(label);
>  }
>  
> +static const struct sensor_limits current_alarms[] = {
> +	{ SENSORS_SUBFEATURE_CURR_LCRIT_ALARM, NULL, NULL, 1, "LCRIT" },
> +	{ SENSORS_SUBFEATURE_CURR_MIN_ALARM, NULL, NULL, 1, "MIN" },
> +	{ SENSORS_SUBFEATURE_CURR_MAX_ALARM, NULL, NULL, 1, "MAX" },
> +	{ SENSORS_SUBFEATURE_CURR_CRIT_ALARM, NULL, NULL, 1, "CRIT" },
> +	{ -1, NULL, NULL, 0, NULL }
> +};
> +
> +static const struct sensor_limits current_sensors[] = {
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
> +	struct sensor_limit_data sensors[4];
> +	struct sensor_limit_data alarms[4];
> +	int sensor_count, alarm_count;
>  
>  	if (!(label = sensors_get_label(name, feature))) {
>  		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
> @@ -614,50 +639,18 @@
>  	sf = sensors_get_subfeature(name, feature,
>  				    SENSORS_SUBFEATURE_CURR_INPUT);
>  	if (sf && get_input_value(name, sf, &val) == 0)
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
> +			      sensors, &sensor_count,
> +			      alarms, &alarm_count);
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
> ===================================================================
> --- prog/sensors/chips.h	(revision 5917)
> +++ prog/sensors/chips.h	(working copy)
> @@ -24,6 +24,29 @@
>  
>  #include "lib/sensors.h"
>  
> +/*
> + * Retrieved limits
> + */
> +struct sensor_limit_data {
> +	double value;
> +	const char *name;
> +	const char *unit;

Please add a comment on what unit can be used for and the fact that it
is optional.

> +};
> +
> +/*
> + * Limit data structure. Used to create a table of supported limits for a given
> + * feature.
> + */
> +struct sensor_limits {
> +	int subfeature;				/* Limit we are looking for */
> +	const struct sensor_limits *exists;	/* Secondary limits if limit
> +						   exists */
> +	const struct sensor_limits *nexists;	/* Secondary limits if limit
> +						   does not exist */

"Secondary" is a generic term. In the first case, you are talking about
a complement of information. In the second case, you a talking about
alternatives. I think the terms "Complementary" and "Alternative" would
be more descriptive than "Secondary.

> +	int alarm;				/* true if this is an alarm */
> +	const char *name;			/* limit name to be printed */
> +};

Your use of the word "limit" in the above structures is somewhat
misleading, as they are suitable for both limits and alarms, and could
presumably be extended to other subfeatures as well in the future (in
particular I start thinking that temperature sensor types would fit in
there nicely.) I think you should use the word "subfeature" instead.

> +
>  void print_chip_raw(const sensors_chip_name *name);
>  void print_chip(const sensors_chip_name *name);
>  

I really like the spirit of the patch. Once fixed, it'll be awesome.

Do you have any more patch pending for lm-sensors? I'd like to flush
the queue and then schedule the release of lm-sensors 3.3.0.

Thanks,
-- 
Jean Delvare

--MP_/jMg/NXw3WPX.1BRglQAif+h
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=use-unit-for-temperature-limits.patch

Use the unit field of struct sensor_limit_data to handle temperature
units (degree Celsius vs. degree Fahrenheit).
---
 prog/sensors/chips.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- lm-sensors.orig/prog/sensors/chips.c	2011-03-15 10:51:40.000000000 +0100
+++ lm-sensors/prog/sensors/chips.c	2011-03-15 10:52:20.000000000 +0100
@@ -243,7 +243,6 @@ static void print_chip_temp(const sensor
 	double val;
 	char *label;
 	int i;
-	char fmt[32];
 
 	if (!(label = sensors_get_label(name, feature))) {
 		fprintf(stderr, "ERROR: Can't get label of feature %s!\n",
@@ -274,14 +273,14 @@ static void print_chip_temp(const sensor
 			      sensors, &sensor_count,
 			      alarms, &alarm_count);
 
-	if (fahrenheit)
-		for (i = 0; i < sensor_count; i++)
+	for (i = 0; i < sensor_count; i++) {
+		if (fahrenheit)
 			sensors[i].value = deg_ctof(sensors[i].value);
+		sensors[i].unit = degstr;
+	}
 
-	strcpy(fmt, "%-4s = %+5.1f");
-	strcat(fmt, degstr);
 	print_limits(sensors, sensor_count, alarms, alarm_count, label_size,
-		     fmt);
+		     "%-4s = %+5.1f%s");
 
 	/* print out temperature sensor info */
 	sf = sensors_get_subfeature(name, feature,

--MP_/jMg/NXw3WPX.1BRglQAif+h
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/jMg/NXw3WPX.1BRglQAif+h--
