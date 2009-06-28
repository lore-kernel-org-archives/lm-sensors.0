From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Jun 2009 09:29:51 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] sensord: Refactoring of
Message-Id: <20090628112951.79d6a483@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Mon, 15 Jun 2009 09:49:32 +0200, Andre Prendel wrote:
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

This alone is hardly a good reason. It is very frequent, when using
function pointers, that you have to hide warnings about unused
parameters. That doesn't make function pointers bad per se.

I am not claiming that the use of function pointers was a good idea
though... I'll judge when I see your patch removing them ;)

> I think a more conrete way is a better approach. So this should be
> just the starting point for further optimizations.
> ---
> 
>  rrd.c |  107 ++++++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 65 insertions(+), 42 deletions(-)
> 
> Index: sensors/prog/sensord/rrd.c
> =================================> --- sensors.orig/prog/sensord/rrd.c	2009-06-14 14:57:03.000000000 +0200
> +++ sensors/prog/sensord/rrd.c	2009-06-14 15:30:16.000000000 +0200
> @@ -137,54 +137,77 @@
>  	}
>  }
>  
> -static int applyToFeatures(FeatureFN fn, void *data)
> +static int generate_features(FeatureFN fn, void *data,

This is a strange function name... You don't generate anything there,
do you?

> +			     const sensors_chip_name *chip,
> +			     const ChipDescriptor *desc)
>  {
> -	const sensors_chip_name *chip;
> -	int i, j, ret = 0, num = 0;
> -
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
> +	int i, ret = 0, num = 0;
> +	const FeatureDescriptor *features = desc->features;
> +	const FeatureDescriptor *feature;
> +	const char *rawLabel;
> +	char *label;
> +
> +	for (i = 0; num < MAX_RRD_SENSORS && features[i].format; ++i) {

As far as I can see, "i" and "num" have the same value throughout the
loop, so you might as well get rid of one of them.

> +		feature = features + i;
> +		rawLabel = feature->feature->name;
> +
> +		label = sensors_get_label(chip, feature->feature);
> +		if (!label) {
> +			sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
> +				  chip->prefix, rawLabel);
> +			ret = -1;
> +			break;
> +		} else  {
> +			rrdCheckLabel(rawLabel, num);
> +			ret = fn(data, rrdLabels[num], label, feature);

The value of "ret" will be overwritten at the next iteration. So the
function merely returns the value returned by the last iteration and
discards the value returned by all earlier iterations. This doesn't
make much sense to me.

> +			++num;
>  		}

If you want to save one more level of indentation: the "else" is
optional.

> +		free(label);
>  	}
>  	return ret;
>  }
>  
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
> +		}
> +	}
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
> +			desc = lookup_known_chips(chip);
> +			if (!desc)
> +				continue;
> +
> +			ret = generate_features(fn, data, chip, desc);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
>  struct ds {
>  	int num;
>  	const char **argv;

Otherwise it looks good and I tested it successfully.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
