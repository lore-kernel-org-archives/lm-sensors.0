From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 29 Oct 2009 08:00:42 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/6] sensord: Refactoring of file
Message-Id: <20091029090042.6ba91f55@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091026205743.GF4725@ubuntu>
In-Reply-To: <20091026205743.GF4725@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Oct 2009 21:57:43 +0100, Andre Prendel wrote:
> This patch does some refactoring of functions doKnownChip().
> 
> * doKnownChip() is a huge function with deep indentation
> levels. Splitting this funcion up into smaller ones makes code much
> more readable.
> 
> Changes in v2:
> 
> * Move breaking long lines in a separate patch.
> * Unite get_alarm() and get_beep() to get_flag() function.
> * Add error message if feature->format() fails.
> * Return value of get_features directly.
> * Fix missing initialization of ret in doKnownChip().
> * Fix permanent alarms.
> * Remove temporary variable feature in doKnownChip().
> * Fix some coding style issues.
> 
> NOTE: Jean, there's a comment in your review using sprintf instead of
> strcat would be more efficient. I don't know what exactly you mean.

I don't remember exactly what I meant either, and it might as well be
that I had no precise idea back then.

> Replacing the inner strcat by sprintf and using a temporary buffer
> like this?
> 
> char buf[64];
> 
> snprintf(buf, 64, ":%s", rrded ? rrded : "U");
> strcat(rrdbuf, buf);
> 
> I've marked the corresponding part with a FIXME comment.

No temporary buffer, that would make things even uglier and slower.

Probably what I had in mind was more along the line of:

	int len = strlen(rrdBuff);
	sprintf(rrdBuff + len, ":%s", rrded ? rrded : "U");

But it's really up to you. If we really cared about ultimate
performance, we would keep track of rrdBuff's length all the time
anyway.

Some more comments below:

> ---
> 
>  prog/sensord/sense.c |  182 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 102 insertions(+), 80 deletions(-)
> 
> Index: sensors/prog/sensord/sense.c
> =================================> --- sensors.orig/prog/sensord/sense.c	2009-10-26 21:33:38.000000000 +0100
> +++ sensors/prog/sensord/sense.c	2009-10-26 21:48:49.000000000 +0100
> @@ -47,7 +47,7 @@
>  {
>  	const char *adapter;
>  
> -	sensorLog(LOG_INFO, "Chip: %s", chipName (chip));
> +	sensorLog(LOG_INFO, "Chip: %s", chipName(chip));
>  	adapter = sensors_get_adapter_name(&chip->bus);
>  	if (adapter)
>  		sensorLog(LOG_INFO, "Adapter: %s", adapter);
> @@ -55,92 +55,111 @@
>  	return 0;
>  }
>  
> -static int doKnownChip(const sensors_chip_name *chip,
> -		       const ChipDescriptor *descriptor, int action)
> +static int get_flag(const sensors_chip_name *chip, int num)
>  {
> -	const FeatureDescriptor *features = descriptor->features;
> -	int index0, subindex;
> -	int ret = 0;
> -	double tmp;
> +	double val;
> +	int ret;
>  
> -	if (action = DO_READ)
> -		ret = idChip(chip);
> -	for (index0 = 0; (ret = 0) && features[index0].format; ++ index0) {
> -		const FeatureDescriptor *feature = features + index0;
> -		int alarm, beep;
> -		char *label = NULL;
> +	if (num = -1)
> +		return 0;
> +
> +	ret = sensors_get_value(chip, num, &val);
> +	if (ret) {
> +		sensorLog(LOG_ERR, "Error getting sensor data: %s/#%d: %s",
> +			  chip->prefix, num, sensors_strerror(ret));
> +		return -1;
> +	}
> +
> +	return (int) (val + 0.5);
> +}
> +
> +static int get_features(const sensors_chip_name *chip,
> +			const FeatureDescriptor *feature, int action,
> +			char *label, int alarm, int beep)
> +{
> +	int i, ret;
> +	double val[MAX_DATA];
>  
> -		if (!(label = sensors_get_label(chip, feature->feature))) {
> +	for (i = 0; feature->dataNumbers[i] >= 0; i++) {
> +		ret = sensors_get_value(chip, feature->dataNumbers[i],
> +					val + i);
> +		if (ret) {
>  			sensorLog(LOG_ERR,
> -				  "Error getting sensor label: %s/%s",
> -				  chip->prefix, feature->feature->name);
> -			ret = 22;
> -		} else {
> -			double values[MAX_DATA];
> +				  "Error getting sensor data: %s/#%d: %s",
> +				  chip->prefix, feature->dataNumbers[i],
> +				  sensors_strerror(ret));
> +			return -1;
> +		}
> +	}
>  
> -			alarm = 0;
> -			if (!ret && feature->alarmNumber != -1) {
> -				if ((ret = sensors_get_value(chip,
> -							     feature->alarmNumber,
> -							     &tmp))) {
> -					sensorLog(LOG_ERR,
> -						  "Error getting sensor data: %s/#%d: %s",
> -						  chip->prefix,
> -						  feature->alarmNumber,
> -						  sensors_strerror(ret));
> -					ret = 20;
> -				} else {
> -					alarm = (int) (tmp + 0.5);
> -				}
> -			}
> -			if ((action = DO_SCAN) && !alarm)
> -				continue;
> +	if (action = DO_RRD) {
> +		if (feature->rrd) {
> +			const char *rrded = feature->rrd(val);
>  
> -			beep = 0;
> -			if (!ret && feature->beepNumber != -1) {
> -				if ((ret = sensors_get_value(chip,
> -							     feature->beepNumber,
> -							     &tmp))) {
> -					sensorLog(LOG_ERR,
> -						  "Error getting sensor data: %s/#%d: %s",
> -						  chip->prefix,
> -						  feature->beepNumber,
> -						  sensors_strerror(ret));
> -					ret = 21;
> -				} else {
> -					beep = (int) (tmp + 0.5);
> -				}
> -			}
> +			/* FIXME: Jean's review comment:
> +			 * sprintf would me more efficient.
> +			 */
> +			strcat(strcat (rrdBuff, ":"), rrded ? rrded : "U");
> +		}
> +	} else {
> +		const char *formatted = feature->format(val, alarm, beep);
>  
> -			for (subindex = 0; !ret &&
> -				     (feature->dataNumbers[subindex] >= 0); ++ subindex) {
> -				if ((ret = sensors_get_value(chip, feature->dataNumbers[subindex], values + subindex))) {
> -					sensorLog(LOG_ERR, "Error getting sensor data: %s/#%d: %s", chip->prefix, feature->dataNumbers[subindex], sensors_strerror(ret));
> -					ret = 23;
> -				}
> -			}
> -			if (ret = 0) {
> -				if (action = DO_RRD) { // arse = "N:"
> -					if (feature->rrd) {
> -						const char *rrded = feature->rrd (values);
> -						strcat(strcat (rrdBuff, ":"),
> -						       rrded ? rrded : "U");
> -					}
> -				} else {
> -					const char *formatted = feature->format (values, alarm, beep);
> -					if (formatted) {
> -						if (action = DO_READ) {
> -							sensorLog(LOG_INFO, "  %s: %s", label, formatted);
> -						} else {
> -							sensorLog(LOG_ALERT, "Sensor alarm: Chip %s: %s: %s", chipName(chip), label, formatted);
> -						}
> -					}
> -				}
> -			}
> +		if (!formatted) {
> +			sensorLog(LOG_ERR, "Error formatting sensor data");
> +			return -1;
> +		}
> +
> +		if (action = DO_READ) {
> +			sensorLog(LOG_INFO, "  %s: %s", label, formatted);
> +		} else {
> +			sensorLog(LOG_ALERT, "Sensor alarm: Chip %s: %s: %s",
> +				  chipName(chip), label, formatted);
>  		}
> -		if (label)
> -			free(label);
>  	}
> +	return 0;
> +}
> +
> +static int do_features(const sensors_chip_name *chip,
> +		       const FeatureDescriptor *feature, int action)
> +{
> +	char *label;
> +	int alarm, beep;
> +
> +	label = sensors_get_label(chip, feature->feature);
> +	if (!label) {
> +		sensorLog(LOG_ERR, "Error getting sensor label: %s/%s",
> +			  chip->prefix, feature->feature->name);
> +		return -1;
> +	}
> +
> +	alarm = get_flag(chip, feature->alarmNumber);
> +	if (alarm = -1)
> +		return -1;
> +	else if (action = DO_SCAN && !alarm)
> +		return 0;
> +
> +	beep = get_flag(chip, feature->beepNumber);
> +	if (beep = -1)
> +		return -1;
> +
> +	return get_features(chip, feature, action, label, alarm, beep);
> +}
> +
> +static int doKnownChip(const sensors_chip_name *chip,
> +		       const ChipDescriptor *descriptor, int action)
> +{
> +	const FeatureDescriptor *features = descriptor->features;
> +	int i, ret;
> +
> +	if (action = DO_READ)
> +		ret = idChip(chip);

You don't do anything with ret? Apparently the original code had the
same issue, but it's probably the right time to fix it.

> +
> +	for (i = 0; features[i].format; i++) {
> +		ret = do_features(chip, features + i, action);
> +		if (ret = -1)
> +			break;
> +	}
> +
>  	return ret;

I'm surprised gcc doesn't complain about it, but ret may be
uninitialized at this point.

>  }
>  
> @@ -167,7 +186,7 @@
>  		ret = setChip(chip);
>  	} else {
>  		int index0, chipindex = -1;
> -		for (index0 = 0; knownChips[index0].features; ++ index0)
> +		for (index0 = 0; knownChips[index0].features; ++ index0) {

Remove space after ++ while you're here.

>  			/*
>  			 * Trick: we compare addresses here. We know it works
>  			 * because both pointers were returned by
> @@ -178,9 +197,12 @@
>  				chipindex = index0;
>  				break;
>  			}
> -		if (chipindex >= 0)
> +		}
> +
> +		if (chipindex >= 0) {
>  			ret = doKnownChip(chip, &knownChips[chipindex],
>  					  action);
> +		}
>  	}
>  	return ret;
>  }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
