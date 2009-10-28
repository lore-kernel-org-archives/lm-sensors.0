From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Oct 2009 16:42:45 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/6] sensord: Refactoring of
Message-Id: <20091028174245.55f6cedb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Oct 2009 21:57:27 +0100, Andre Prendel wrote:
> This patch cleans up function applyToFeature().
> 
> Function applyToFeature() is nearly unreadable. There are some deep
> levels of indentation and cascades of loops makes code flow difficult to
> read.
> 
> I split up this function into three smaller one. This reduces
> indentation levels and makes code flow clearer.
> 
> Note:
> This is just the first step. I'm not happy with the mechanism. IMHO
> this generic way (function pointer) is not the best one. Hiding the
> compiler warnings (void (label)) in rrdGetSensors_DS() and
> rrdCGI_DEF() confirms my opinion.
> 
> I think a more conrete way is a better approach. So this should be
> just the starting point for further optimizations.
> 
> Changes v2:
> 
> * Rename generate_features() to _appyToFeatures().
> * Get rid of needless variable num.
> * Change prototype of function pointer FeatureFN. None of the
>   functions returns with an error, so we needn't a return value.

This would have been a nice little separate patch ;)

Some problems with this patch, see below:

> 
> ---
> 
>  prog/sensord/rrd.c |  124 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 70 insertions(+), 54 deletions(-)
> Index: sensors/prog/sensord/rrd.c
> =================================> --- sensors.orig/prog/sensord/rrd.c	2009-10-26 21:08:33.000000000 +0100
> +++ sensors/prog/sensord/rrd.c	2009-10-26 21:14:18.000000000 +0100
> @@ -68,7 +68,7 @@
>  #define LOADAVG "loadavg"
>  #define LOAD_AVERAGE "Load Average"
>  
> -typedef int (*FeatureFN) (void *data, const char *rawLabel, const char *label,
> +typedef void (*FeatureFN) (void *data, const char *rawLabel, const char *label,
>  			  const FeatureDescriptor *feature);
>  
>  static char rrdNextChar(char c)
> @@ -137,52 +137,72 @@
>  	}
>  }
>  
> -static int applyToFeatures(FeatureFN fn, void *data)
> +static int _applyToFeatures(FeatureFN fn, void *data,
> +			     const sensors_chip_name *chip,
> +			     const ChipDescriptor *desc)
> +{
> +	int i;
> +	const FeatureDescriptor *features = desc->features;
> +	const FeatureDescriptor *feature;
> +	const char *rawLabel;
> +	char *label;
> +
> +	for (i = 0; i < MAX_RRD_SENSORS && features[i].format; ++i) {
> +		feature = features + i;
> +		rawLabel = feature->feature->name;
> +
> +		label = sensors_get_label(chip, feature->feature);
> +		if (!label) {
> +			sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
> +				  chip->prefix, rawLabel);
> +			return -1;
> +		}
> +
> +		rrdCheckLabel(rawLabel, i);
> +		fn(data, rrdLabels[i], label, feature);
> +		free(label);
> +	}
> +	return 0;
> +}
> +
> +static ChipDescriptor *lookup_known_chips(const sensors_chip_name *chip)
>  {
> -	const sensors_chip_name *chip;
> -	int i, j, ret = 0, num = 0;
> +	int i;
>  
> -	for (j = 0; (ret = 0) && (j < sensord_args.numChipNames); ++ j) {
> -		i = 0;
> -		while ((ret = 0) && ((chip = sensors_get_detected_chips(&sensord_args.chipNames[j], &i)) != NULL)) {
> -			int index0, chipindex = -1;
> -
> -			/* Trick: we compare addresses here. We know it works
> -			 * because both pointers were returned by
> -			 * sensors_get_detected_chips(), so they refer to
> -			 * libsensors internal structures, which do not move.
> -			 */
> -			for (index0 = 0; knownChips[index0].features; ++index0)
> -				if (knownChips[index0].name = chip) {
> -					chipindex = index0;
> -					break;
> -				}
> -			if (chipindex >= 0) {
> -				const ChipDescriptor *descriptor = &knownChips[chipindex];
> -				const FeatureDescriptor *features = descriptor->features;
> -
> -				for (index0 = 0; (ret = 0) && (num < MAX_RRD_SENSORS) && features[index0].format; ++index0) {
> -					const FeatureDescriptor *feature = features + index0;
> -					const char *rawLabel = feature->feature->name;
> -					char *label = NULL;
> -
> -					if (!(label = sensors_get_label(chip, feature->feature))) {
> -						sensorLog(LOG_ERR, "Error getting sensor label: %s/%s", chip->prefix, rawLabel);
> -						ret = -1;
> -					} else  {
> -						rrdCheckLabel(rawLabel, num);
> -						ret = fn(data,
> -							 rrdLabels[num],
> -							 label, feature);
> -						++ num;
> -					}
> -					if (label)
> -						free(label);
> -				}
> -			}
> +	/* Trick: we compare addresses here. We know it works
> +	 * because both pointers were returned by
> +	 * sensors_get_detected_chips(), so they refer to
> +	 * libsensors internal structures, which do not move.
> +	 */
> +	for (i = 0; knownChips[i].features; i++) {
> +		if (knownChips[i].name = chip) {
> +			return &knownChips[i];
>  		}
>  	}
> -	return ret;
> +	return NULL;
> +}
> +
> +static int applyToFeatures(FeatureFN fn, void *data)
> +{
> +	int i, i_detected, ret;
> +	const sensors_chip_name *chip, *chip_arg;
> +	ChipDescriptor *desc;
> +
> +	for (i = 0; i < sensord_args.numChipNames; i++) {
> +		chip_arg = &sensord_args.chipNames[i];
> +		i_detected = 0;
> +		while ((chip = sensors_get_detected_chips(chip_arg,
> +							  &i_detected))) {
> +			desc = lookup_known_chips(chip);
> +			if (!desc)
> +				continue;
> +
> +			ret = _applyToFeatures(fn, data, chip, desc);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return 0;
>  }
>  
>  struct ds {
> @@ -190,7 +210,7 @@
>  	const char **argv;
>  };
>  
> -static int rrdGetSensors_DS(void *_data, const char *rawLabel,
> +static void rrdGetSensors_DS(void *_data, const char *rawLabel,
>  			    const char *label,
>  			    const FeatureDescriptor *feature)
>  {
> @@ -227,7 +247,6 @@
>  		sprintf(ptr, "DS:%s:GAUGE:%d:%s:%s", rawLabel, 5 *
>  			sensord_args.rrdTime, min, max);
>  	}
> -	return 0;
>  }
>  
>  static int rrdGetSensors(const char **argv)
> @@ -236,8 +255,8 @@
>  	struct ds data = { 0, argv};
>  	ret = applyToFeatures(rrdGetSensors_DS, &data);
>  	if (!ret && sensord_args.doLoad)
> -		ret = rrdGetSensors_DS(&data, LOADAVG, LOAD_AVERAGE, NULL);
> -	return ret ? -1 : data.num;
> +		rrdGetSensors_DS(&data, LOADAVG, LOAD_AVERAGE, NULL);
> +	return data.num;

This change doesn't seem to be required, nor desired. ret can still
hold an error value returned by applyToFeatures() and we want to
propagate it up to the caller.

>  }
>  
>  int rrdInit(void)
> @@ -303,7 +322,7 @@
>  	int loadAvg;
>  };
>  
> -static int rrdCGI_DEF(void *_data, const char *rawLabel, const char *label,
> +static void rrdCGI_DEF(void *_data, const char *rawLabel, const char *label,
>  		      const FeatureDescriptor *feature)
>  {
>  	struct gr *data = _data;
> @@ -311,7 +330,6 @@
>  	if (!feature || (feature->rrd && (feature->type = data->type)))
>  		printf("\n\tDEF:%s=%s:%s:AVERAGE", rawLabel,
>  		       sensord_args.rrdFile, rawLabel);
> -	return 0;
>  }
>  
>  /*
> @@ -339,14 +357,13 @@
>  	return color;
>  }
>  
> -static int rrdCGI_LINE(void *_data, const char *rawLabel, const char *label,
> +static void rrdCGI_LINE(void *_data, const char *rawLabel, const char *label,
>  		       const FeatureDescriptor *feature)
>  {
>  	struct gr *data = _data;
>  	if (!feature || (feature->rrd && (feature->type = data->type)))
>  		printf("\n\tLINE2:%s#%.6x:\"%s\"", rawLabel,
>  		       rrdCGI_color(label), label);
> -	return 0;
>  }
>  
>  static struct gr graphs[] = {
> @@ -468,11 +485,10 @@
>  		if (!ret)
>  			ret = applyToFeatures(rrdCGI_DEF, graph);
>  		if (!ret && sensord_args.doLoad && graph->loadAvg)
> -			ret = rrdCGI_DEF(graph, LOADAVG, LOAD_AVERAGE, NULL);
> -		if (!ret)
> +			rrdCGI_DEF(graph, LOADAVG, LOAD_AVERAGE, NULL);
>  			ret = applyToFeatures(rrdCGI_LINE, graph);

Messed up big time :p

>  		if (!ret && sensord_args.doLoad && graph->loadAvg)
> -			ret = rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
> +			rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
>  		printf (">\n</p>\n");
>  	}
>  	printf("<p>\n<small><b>sensord</b> by "


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
