From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 22 Aug 2007 12:03:03 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] libsensors4: Change the prototype of
Message-Id: <46CC25F7.9060904@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070821212633.2dc3e622@hyperion.delvare>
In-Reply-To: <20070821212633.2dc3e622@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Change the prototype of sensors_get_label(). Errors can be reported
> with a NULL pointer.
> 

Looks good to me,

Regards,

Hans

> ---
>  lib/access.c                 |   22 +++++++++++-----------
>  lib/libsensors.3             |   11 ++++++-----
>  lib/sensors.h                |    7 +++----
>  prog/sensord/rrd.c           |    2 +-
>  prog/sensord/sense.c         |   12 ++----------
>  prog/sensord/sensord.h       |    1 -
>  prog/sensors/chips.c         |    4 ++--
>  prog/sensors/chips_generic.c |    8 ++++----
>  8 files changed, 29 insertions(+), 38 deletions(-)
> 
> --- lm-sensors-3.orig/lib/access.c	2007-08-19 17:07:31.000000000 +0200
> +++ lm-sensors-3/lib/access.c	2007-08-19 18:51:37.000000000 +0200
> @@ -139,27 +139,27 @@ int sensors_chip_name_has_wildcards(cons
>  }
>  
>  /* Look up the label which belongs to this chip. Note that chip should not
> -   contain wildcard values! *result is newly allocated (free it yourself).
> -   This function will return 0 on success, and <0 on failure.
> +   contain wildcard values! The returned string is newly allocated (free it
> +   yourself). On failure, NULL is returned.
>     If no label exists for this feature, its name is returned itself. */
> -int sensors_get_label(const sensors_chip_name *name, int feature, char **result)
> +char *sensors_get_label(const sensors_chip_name *name, int feature)
>  {
> +	char *label;
>  	const sensors_chip *chip;
>  	const sensors_chip_feature *featureptr;
>  	char buf[128], path[PATH_MAX];
>  	FILE *f;
>  	int i;
>  
> -	*result = NULL;
>  	if (sensors_chip_name_has_wildcards(name))
> -		return -SENSORS_ERR_WILDCARDS;
> +		return NULL;
>  	if (!(featureptr = sensors_lookup_feature_nr(name, feature)))
> -		return -SENSORS_ERR_NO_ENTRY;
> +		return NULL;
>  
>  	for (chip = NULL; (chip = sensors_for_all_config_chips(name, chip));)
>  		for (i = 0; i < chip->labels_count; i++)
>  			if (!strcasecmp(featureptr->data.name,chip->labels[i].name)){
> -				*result = strdup(chip->labels[i].value);
> +				label = strdup(chip->labels[i].value);
>  				goto sensors_get_label_exit;
>  			}
>  
> @@ -173,19 +173,19 @@ int sensors_get_label(const sensors_chip
>  		if (i > 0) {
>  			/* i - 1 to strip the '\n' at the end */
>  			buf[i - 1] = 0;
> -			*result = strdup(buf);
> +			label = strdup(buf);
>  			goto sensors_get_label_exit;
>  		}
>  	}
>  
>  	/* No label, return the feature name instead */
> -	*result = strdup(featureptr->data.name);
> +	label = strdup(featureptr->data.name);
>  	
>  sensors_get_label_exit:
> -	if (*result = NULL)
> +	if (!label)
>  		sensors_fatal_error("sensors_get_label",
>  				    "Allocating label text");
> -	return 0;
> +	return label;
>  }
>  
>  /* Looks up whether a feature should be ignored. Returns
> --- lm-sensors-3.orig/lib/libsensors.3	2007-08-19 17:53:30.000000000 +0200
> +++ lm-sensors-3/lib/libsensors.3	2007-08-19 18:53:12.000000000 +0200
> @@ -38,8 +38,7 @@ libsensors \- publicly accessible functi
>  .B int sensors_match_chip(const sensors_chip_name *chip1,
>                         \fBconst sensors_chip_name *chip2);\fP
>  .B const char *sensors_get_adapter_name(int bus_nr);
> -.B int sensors_get_label(const sensors_chip_name *name, int feature,
> -                      \fBchar **result);\fP
> +.B char *sensors_get_label(const sensors_chip_name *name, int feature);\fP
>  .B int sensors_get_feature(const sensors_chip_name *name, int feature,
>                          \fBdouble *result);\fP
>  .B int sensors_set_feature(const sensors_chip_name *name, int feature,
> @@ -78,10 +77,12 @@ Compare two chips name descriptions, to 
>  This function returns the adapter name of a bus number, as used within the
>  sensors_chip_name structure. If it could not be found, it returns NULL.
>  
> -\fBint sensors_get_label(const sensors_chip_name *name, int feature,
> -                      char **result);\fP
> +\fBchar *sensors_get_label(const sensors_chip_name *name, int feature);\fP
>  .br
> -Look up the label which belongs to this chip. Note that chip should not contain wildcard values! *result is newly allocated (free it yourself). This function will return 0 on success, and <0 on failure.
> +Look up the label which belongs to this chip. Note that chip should not
> +contain wildcard values! The returned string is newly allocated (free it
> +yourself). On failure, NULL is returned.
> +If no label exists for this feature, its name is returned itself.
>  
>  \fBint sensors_get_feature(const sensors_chip_name *name,
>                          int feature, double *result);\fP
> --- lm-sensors-3.orig/lib/sensors.h	2007-08-19 17:43:50.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2007-08-19 18:53:51.000000000 +0200
> @@ -88,11 +88,10 @@ int sensors_match_chip(const sensors_chi
>  const char *sensors_get_adapter_name(const sensors_bus_id *bus);
>  
>  /* Look up the label which belongs to this chip. Note that chip should not
> -   contain wildcard values! *result is newly allocated (free it yourself).
> -   This function will return 0 on success, and <0 on failure.
> +   contain wildcard values! The returned string is newly allocated (free it
> +   yourself). On failure, NULL is returned.
>     If no label exists for this feature, its name is returned itself. */
> -int sensors_get_label(const sensors_chip_name *name, int feature,
> -		      char **result);
> +char *sensors_get_label(const sensors_chip_name *name, int feature);
>  
>  /* Read the value of a feature of a certain chip. Note that chip should not
>     contain wildcard values! This function will return 0 on success, and <0
> --- lm-sensors-3.orig/prog/sensord/rrd.c	2007-08-13 22:18:25.000000000 +0200
> +++ lm-sensors-3/prog/sensord/rrd.c	2007-08-19 19:04:18.000000000 +0200
> @@ -163,7 +163,7 @@ applyToFeatures
>              } else if (getRawLabel (chip, labelNumber, &rawLabel)) {
>                sensorLog (LOG_ERR, "Error getting raw sensor label: %s/#%d", chip->prefix, labelNumber);
>                ret = -1;
> -            } else if (getLabel (chip, labelNumber, &label)) {
> +            } else if (!(label = sensors_get_label (chip, labelNumber))) {
>                sensorLog (LOG_ERR, "Error getting sensor label: %s/#%d", chip->prefix, labelNumber);
>                ret = -1;
>              } else if (valid) {
> --- lm-sensors-3.orig/prog/sensord/sense.c	2007-08-16 11:59:39.000000000 +0200
> +++ lm-sensors-3/prog/sensord/sense.c	2007-08-19 19:04:45.000000000 +0200
> @@ -46,14 +46,6 @@ getValid
>  }
>  
>  int
> -getLabel
> -(const sensors_chip_name *name, int feature, char **label) {
> -  int err;
> -  err = sensors_get_label (name, feature, label);
> -  return err;
> -}
> -
> -int
>  getRawLabel
>  (const sensors_chip_name *name, int feature, const char **label) {
>    const sensors_feature_data *rawFeature;
> @@ -109,7 +101,7 @@ readUnknownChip
>      if (getValid (chip, sensor->number, &valid)) {
>        sensorLog (LOG_ERR, "Error getting sensor validity: %s/%s", chip->prefix, sensor->name);
>        ret = 20;
> -    } else if (getLabel (chip, sensor->number, &label)) {
> +    } else if (!(label = sensors_get_label (chip, sensor->number))) {
>        sensorLog (LOG_ERR, "Error getting sensor label: %s/%s", chip->prefix, sensor->name);
>        ret = 21;
>      } else if (!valid) {
> @@ -169,7 +161,7 @@ doKnownChip
>      } else if (getValid (chip, labelNumber, &valid)) {
>        sensorLog (LOG_ERR, "Error getting sensor validity: %s/#%d", chip->prefix, labelNumber);
>        ret = 22;
> -    } else if (getLabel (chip, labelNumber, &label)) {
> +    } else if (!(label = sensors_get_label (chip, labelNumber))) {
>        sensorLog (LOG_ERR, "Error getting sensor label: %s/#%d", chip->prefix, labelNumber);
>        ret = 22;
>      } else if (valid) {
> --- lm-sensors-3.orig/prog/sensord/sensord.h	2007-08-13 22:18:25.000000000 +0200
> +++ lm-sensors-3/prog/sensord/sensord.h	2007-08-19 19:04:02.000000000 +0200
> @@ -59,7 +59,6 @@ extern int unloadLib (void);
>  /* from sense.c */
>  
>  extern int getValid (const sensors_chip_name *name, int feature, int *valid);
> -extern int getLabel (const sensors_chip_name *name, int feature, char **label);
>  extern int getRawLabel (const sensors_chip_name *name, int feature, const char **label);
>  
>  extern int readChips (void);
> --- lm-sensors-3.orig/prog/sensors/chips.c	2007-08-18 09:17:20.000000000 +0200
> +++ lm-sensors-3/prog/sensors/chips.c	2007-08-19 19:06:16.000000000 +0200
> @@ -91,7 +91,7 @@ void print_vid_info(const sensors_chip_n
>    char *label;
>    double vid;
>  
> -  if (!sensors_get_label(name, f_vid, &label)
> +  if ((label = sensors_get_label(name, f_vid))
>        && !sensors_get_feature(name, f_vid, &vid)) {
>      print_label(label, label_size);
>      printf("%+6.3f V\n", vid);
> @@ -108,7 +108,7 @@ void print_unknown_chip(const sensors_ch
>   
>    a = 0;
>    while((data=sensors_get_all_features(name, &a))) {
> -    if (sensors_get_label(name, data->number, &label)) {
> +    if (!(label = sensors_get_label(name, data->number))) {
>        printf("ERROR: Can't get feature `%s' data!\n",data->name);
>        continue;
>      }
> --- lm-sensors-3.orig/prog/sensors/chips_generic.c	2007-08-18 09:17:20.000000000 +0200
> +++ lm-sensors-3/prog/sensors/chips_generic.c	2007-08-19 18:57:43.000000000 +0200
> @@ -69,7 +69,7 @@ static int sensors_get_label_size(const 
>  
>    i = 0;
>    while((iter = sensors_get_all_features(name, &i))) {
> -    if (!sensors_get_label(name, iter->number, &label) &&
> +    if ((label = sensors_get_label(name, iter->number)) &&
>          strlen(label) > max_size)
>        max_size = strlen(label);
>      free(label);
> @@ -98,7 +98,7 @@ static void print_generic_chip_temp(cons
>    short has_features[SENSORS_FEATURE_TEMP_SENS - SENSORS_FEATURE_TEMP] = {0, };
>    double feature_vals[SENSORS_FEATURE_TEMP_SENS - SENSORS_FEATURE_TEMP] = {0.0, };
>    
> -  if (sensors_get_label(name, feature->number, &label)) {
> +  if (!(label = sensors_get_label(name, feature->number))) {
>      printf("ERROR: Can't get temperature label!\n");
>      return;
>    }
> @@ -211,7 +211,7 @@ static void print_generic_chip_in(const 
>    double val, alarm_max, alarm_min;
>    char *label;
>    
> -  if (sensors_get_label(name, feature->number, &label)) {
> +  if (!(label = sensors_get_label(name, feature->number))) {
>      printf("ERROR: Can't get in label!\n");
>      return;
>    }
> @@ -273,7 +273,7 @@ static void print_generic_chip_fan(const
>    double feature_vals[SENSORS_FEATURE_FAN_DIV - SENSORS_FEATURE_FAN] = {0.0, };
>    double val;
>    
> -  if (sensors_get_label(name, feature->number, &label)) {
> +  if (!(label = sensors_get_label(name, feature->number))) {
>      printf("ERROR: Can't get fan label!\n");
>      return;
>    }
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
