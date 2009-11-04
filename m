From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Nov 2009 09:10:19 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/8] sensord: Refactoring of
Message-Id: <20091104101019.21def8b5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Tue, 3 Nov 2009 21:03:05 +0100, Andre Prendel wrote:
> This patch cleans up function applyToFeature().
> 
> Function applyToFeature() is nearly unreadable. There are some deep
> levels of indentation and cascades of loops makes code flow difficult to
> read.
> 
> I split up this function into three smaller one. This reduces
> indentation levels and makes code flow clearer.
> 
> Changes in v2:
> 
> * Rename generate_features() to _appyToFeatures().
> * Get rid of needless variable num.
> * Change prototype of function pointer FeatureFN. None of the
>   functions returns with an error, so we needn't a return value.
> 
> Changes in v3:
> 
> * Drop change in rrdGetSensors()
> * Move signature change of FeatureFN to a separate patch (5/8).
> 
> Note: The issue (in v1) with the overwritten return value will be
> fixed by the next patch.
> ---
>  prog/sensord/rrd.c |  104 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 62 insertions(+), 42 deletions(-)
> 
> Index: sensors/prog/sensord/rrd.c
> =================================> --- sensors.orig/prog/sensord/rrd.c	2009-11-03 20:02:45.000000000 +0100
> +++ sensors/prog/sensord/rrd.c	2009-11-03 20:03:14.000000000 +0100
> @@ -137,52 +137,72 @@
>  	}
>  }
>  
> -static int applyToFeatures(FeatureFN fn, void *data)
> +static int _applyToFeatures(FeatureFN fn, void *data,
> +			    const sensors_chip_name *chip,
> +			    const ChipDescriptor *desc)
>  {
> -	const sensors_chip_name *chip;
> -	int i, j, ret = 0, num = 0;
> +	int i, ret;
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
> +		rrdCheckLabel(rawLabel, i);
> +		ret = fn(data, rrdLabels[i], label, feature);

You don't do anything with "ret" in this function, and the following
patch removes it, so you might as well not introduce it in the first
place.

> +		free(label);
> +	}
> +	return 0;
> +}
> +
> +static ChipDescriptor *lookup_known_chips(const sensors_chip_name *chip)
> +{
> +	int i;
> +
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
> +

Usual coding style would suggest no blank line here...

> +			desc = lookup_known_chips(chip);
> +			if (!desc)
> +				continue;

... but possibly one there.

> +			ret = _applyToFeatures(fn, data, chip, desc);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return 0;
>  }
>  
>  struct ds {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
