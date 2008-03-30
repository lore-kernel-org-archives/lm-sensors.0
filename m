From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 30 Mar 2008 18:24:46 +0000
Subject: Re: [lm-sensors] [PATCH] Rough draft of power/energy sensor support
Message-Id: <20080330202446.755a30b8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080313013724.GH5529@tree.beaverton.ibm.com>
In-Reply-To: <20080313013724.GH5529@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Fri, 28 Mar 2008 14:01:08 -0700, Darrick J. Wong wrote:
> [Resend due to IBM mail server problems; apparently it can take a week
> to deliver the "can't send for past week" message???]

FWIW, your post was properly received by the list on March 13th:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-March/022710.html

> Here is a patch to lm-sensors3 SVN to add support for power and energy
> sensors that are reported via sysfs.  The energyX_input name follows
> the changes that I proposed making to
> Documentation/hwmon/sysfs-interface.txt a month ago.  I was able to get
> the sensors command to report the new power/energy sensors that are in
> the ibmpex driver with this patch, though I've not done anything more
> than basic read testing.
> 
> Questions?  Comments?  I suspect MAX_SENSOR_TYPES should be moved to
> lib/sensors.h, though whoever encoded the '6' into sysfs.c would know
> for sure.

No, we don't want to expose MAX_SENSOR_TYPES as part of the API, nor
MAX_SENSORS_PER_TYPE or MAX_SUBFEATURES for that matter. These are
values libsensors only needs to build a temporary sparse array in order
to sort all the subfeatures properly. This is really an implementation
detail applications shouldn't care about. These values are likely to be
incremented in the future, and we really don't want applications to
need a rebuild when this happens. Applications should not assume any
limitation in what libsensors can pass to them.

>          As an aside, I can break this patch into smaller chunks if
> that is desirable, though the combined patch itself is small.

You could split the prog/sensors part, that's easy and that way we can
merge the libsensors part quickly even if there are more discussions
about the prog/sensors part.

> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> Index: lib/sensors.h
> =================================> --- lib/sensors.h	(revision 5140)
> +++ lib/sensors.h	(working copy)
> @@ -130,6 +130,8 @@
>  	SENSORS_FEATURE_IN		= 0x00,
>  	SENSORS_FEATURE_FAN		= 0x01,
>  	SENSORS_FEATURE_TEMP		= 0x02,
> +	SENSORS_FEATURE_POWER		= 0x03,
> +	SENSORS_FEATURE_ENERGY		= 0x04,
>  	SENSORS_FEATURE_VID		= 0x10,
>  	SENSORS_FEATURE_BEEP_ENABLE	= 0x18,
>  	SENSORS_FEATURE_UNKNOWN		= INT_MAX,
> @@ -168,6 +170,13 @@
>  	SENSORS_SUBFEATURE_TEMP_OFFSET,
>  	SENSORS_SUBFEATURE_TEMP_BEEP,
>  
> +	SENSORS_SUBFEATURE_POWER_AVERAGE = SENSORS_FEATURE_POWER << 8,
> +	SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST,
> +	SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST,
> +	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL,

power[1-*]_average_interval is not expressed in Watts, so it should be:

	SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL = (SENSORS_FEATURE_POWER << 8) | 0x80,

Otherwise "compute" statements meant for the power value itself would
also apply to the interval, which doesn't make sense.

What about the power[1-*]_input, power[1-*]_input_highest and
power[1-*]_input_lowest files which are already described in
Documentation/hwmon/sysfs-interface? It seems odd to add support for
the average values without also adding support for the instantaneous
values.

> +
> +	SENSORS_SUBFEATURE_ENERGY_INPUT = SENSORS_FEATURE_ENERGY << 8,
> +
>  	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
>  
>  	SENSORS_SUBFEATURE_BEEP_ENABLE = SENSORS_FEATURE_BEEP_ENABLE << 8,
> Index: lib/sysfs.c
> =================================> --- lib/sysfs.c	(revision 5140)
> +++ lib/sysfs.c	(working copy)
> @@ -137,11 +137,13 @@
>  
>  #define MAX_SENSORS_PER_TYPE	20
>  #define MAX_SUBFEATURES		8
> +#define MAX_SENSOR_TYPES	5
>  /* Room for all 3 types (in, fan, temp) with all their subfeatures + VID
>     + misc features */

This comment should be updated to mention the two new types.

>  #define ALL_POSSIBLE_SUBFEATURES \
> -				(MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 \
> -				 + MAX_SENSORS_PER_TYPE + 1)
> +				(MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * \
> +				 MAX_SENSOR_TYPES * 2 + \
> +				 MAX_SENSORS_PER_TYPE + 1)
>  
>  static
>  int get_type_scaling(sensors_subfeature_type type)
> @@ -152,6 +154,10 @@
>  		return 1000;
>  	case SENSORS_SUBFEATURE_FAN_INPUT:
>  		return 1;
> +	case SENSORS_SUBFEATURE_POWER_AVERAGE:
> +		return 1000000;
> +	case SENSORS_SUBFEATURE_ENERGY_INPUT:
> +		return 1000000;
>  	}
>  
>  	switch (type) {

You'll have to add another case to handle
SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL once it is treated as an
"unscaled" subfeature.

> @@ -172,6 +178,8 @@
>  	case SENSORS_FEATURE_IN:
>  	case SENSORS_FEATURE_FAN:
>  	case SENSORS_FEATURE_TEMP:
> +	case SENSORS_FEATURE_POWER:
> +	case SENSORS_FEATURE_ENERGY:
>  		underscore = strchr(sfname, '_');
>  		name = strndup(sfname, underscore - sfname);
>  		break;
> @@ -231,6 +239,19 @@
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
> @@ -241,6 +262,8 @@
>  	{ "in%d%c", in_matches },
>  	{ "fan%d%c", fan_matches },
>  	{ "cpu%d%c", cpu_matches },
> +	{ "power%d%c", power_matches },
> +	{ "energy%d%c", energy_matches },
>  };
>  
>  /* Return the subfeature type and channel number based on the subfeature
> @@ -326,10 +349,12 @@
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
> @@ -346,11 +371,12 @@
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
> @@ -388,7 +414,8 @@
>  		if (!all_subfeatures[i].name)
>  			continue;
>  
> -		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 ||
> +		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
> +		    MAX_SENSOR_TYPES * 2 ||
>  		    i / (MAX_SUBFEATURES * 2) != prev_slot) {
>  			fnum++;
>  			prev_slot = i / (MAX_SUBFEATURES * 2);
> @@ -409,7 +436,8 @@
>  			continue;
>  
>  		/* New main feature? */
> -		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES * 6 ||
> +		if (i >= MAX_SENSORS_PER_TYPE * MAX_SUBFEATURES *
> +		    MAX_SENSOR_TYPES * 2 ||
>  		    i / (MAX_SUBFEATURES * 2) != prev_slot) {
>  			ftype = all_subfeatures[i].type >> 8;
>  			fnum++;

The rest looks all OK to me.

> Index: prog/sensors/chips.c
> =================================> --- prog/sensors/chips.c	(revision 5140)
> +++ prog/sensors/chips.c	(working copy)
> @@ -43,7 +43,7 @@
>  				"%s!\n", feature->name);
>  			continue;
>  		}
> -		printf("%s:\n", label);
> +		printf("%s\n", label);
>  		free(label);
>  
>  		b = 0;

This can be discussed separately, but doesn't belong to this patch.

> @@ -400,6 +400,71 @@
>  	printf("\n");
>  }
>  
> +static void print_chip_power(const sensors_chip_name *name,
> +			     const sensors_feature *feature,
> +			     int label_size)
> +{
> +	const sensors_subfeature *sf, *sfmin, *sfmax;
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
> +				    SENSORS_SUBFEATURE_POWER_AVERAGE);
> +	if (sf)
> +		printf("%4.0f W", get_value(name, sf));

This would print the value with a resolution of 1 Watt, while your
interface proposal suggested to use the microWatt as a unit. This
doesn't seem very consistent. Wouldn't "%6.2f W" make more sense?

> +	else
> +		printf("     N/A");
> +
> +	sfmin = sensors_get_subfeature(name, feature,
> +				      SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> +	sfmax = sensors_get_subfeature(name, feature,
> +				       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> +	if (sfmin && sfmax)
> +		printf("  (min = %4.0f W, max = %1.0f W)",

I can't see the rationale for using %4.0f for the min and %1.0f for the
max. Can you please explain?

> +		       get_value(name, sfmin),
> +		       get_value(name, sfmax));
> +	else if (sfmin)
> +		printf("  (min = %4.0f W)",
> +		       get_value(name, sfmin));
> +	else if (sfmax)
> +		printf("  (max = %1.0f W)",
> +		       get_value(name, sfmax));
> +
> +	printf("\n");
> +}
> +
> +static void print_chip_energy(const sensors_chip_name *name,
> +			      const sensors_feature *feature,
> +			      int label_size)
> +{
> +	const sensors_subfeature *sf;
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
> +				    SENSORS_SUBFEATURE_ENERGY_INPUT);
> +	if (sf)
> +		printf("%4.0f J", get_value(name, sf));

This would print the value with a resolution of 1 Joule, while your
interface proposal suggested to use the microJoule as a unit. This
doesn't seem very consistent.

> +	else
> +		printf("     N/A");
> +
> +	printf("\n");
> +}
> +

Note that if you expect a wide range of possible power or energy values
across devices, we could adjust the unit depending on the value, for
example mW if the value is less than 1 Watt, and W otherwise. This was
never needed for other measurement types so far, so we didn't implement
it, but that can be added if needed.

>  static void print_chip_vid(const sensors_chip_name *name,
>  			   const sensors_feature *feature,
>  			   int label_size)
> @@ -467,6 +532,12 @@
>  		case SENSORS_FEATURE_BEEP_ENABLE:
>  			print_chip_beep_enable(name, feature, label_size);
>  			break;
> +		case SENSORS_FEATURE_POWER:
> +			print_chip_power(name, feature, label_size);
> +			break;
> +		case SENSORS_FEATURE_ENERGY:
> +			print_chip_energy(name, feature, label_size);
> +			break;
>  		default:
>  			continue;
>  		}

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
