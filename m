From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 06 May 2010 19:42:30 +0000
Subject: Re: [lm-sensors] 3.1.2 sensord duplicate RRD name problem
Message-Id: <20100506194230.GA2062@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
In-Reply-To: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 06, 2010 at 06:12:52PM +0200, Jean Delvare wrote:
> On Thu, 6 May 2010 14:20:56 +0200, Jean Delvare wrote:
> > I have a patch ready, I'll give it some testing to make sure I got it
> > right, and then I'll post it here.
> 
> Andre, can you please comment on the patch below? Sergey, any chance
> you could test it? It works for me on two different machines, but I may
> not have covered all possible cases.

Jean, the patch works for me with two sensor chips :)

So I think it's enough for the moment. I've just realised that the code is 
still difficult to read. I hope we will find some time for more
simplification/cleanups.
 
> ---
>  prog/sensord/rrd.c |   19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> --- lm-sensors.orig/prog/sensord/rrd.c	2009-11-05 10:18:11.000000000 +0100
> +++ lm-sensors/prog/sensord/rrd.c	2010-05-06 17:54:06.000000000 +0200
> @@ -137,9 +137,11 @@ static void rrdCheckLabel(const char *ra
>  	}
>  }
>  
> +/* Returns the number of features processed, or -1 on error */
>  static int _applyToFeatures(FeatureFN fn, void *data,
>  			    const sensors_chip_name *chip,
> -			    const ChipDescriptor *desc)
> +			    const ChipDescriptor *desc,
> +			    int labelOffset)
>  {
>  	int i;
>  	const FeatureDescriptor *features = desc->features;
> @@ -147,7 +149,7 @@ static int _applyToFeatures(FeatureFN fn
>  	const char *rawLabel;
>  	char *label;
>  
> -	for (i = 0; i < MAX_RRD_SENSORS && features[i].format; ++i) {
> +	for (i = 0; labelOffset + i < MAX_RRD_SENSORS && features[i].format; ++i) {
>  		feature = features + i;
>  		rawLabel = feature->feature->name;
>  
> @@ -158,11 +160,11 @@ static int _applyToFeatures(FeatureFN fn
>  			return -1;
>  		}
>  
> -		rrdCheckLabel(rawLabel, i);
> -		fn(data, rrdLabels[i], label, feature);
> +		rrdCheckLabel(rawLabel, labelOffset + i);
> +		fn(data, rrdLabels[labelOffset + i], label, feature);
>  		free(label);
>  	}
> -	return 0;
> +	return i;
>  }
>  
>  static ChipDescriptor *lookup_known_chips(const sensors_chip_name *chip)
> @@ -184,7 +186,7 @@ static ChipDescriptor *lookup_known_chip
>  
>  static int applyToFeatures(FeatureFN fn, void *data)
>  {
> -	int i, i_detected, ret;
> +	int i, i_detected, ret, labelOffset = 0;
>  	const sensors_chip_name *chip, *chip_arg;
>  	ChipDescriptor *desc;
>  
> @@ -197,9 +199,10 @@ static int applyToFeatures(FeatureFN fn,
>  			if (!desc)
>  				continue;
>  
> -			ret = _applyToFeatures(fn, data, chip, desc);
> -			if (ret)
> +			ret = _applyToFeatures(fn, data, chip, desc, labelOffset);
> +			if (ret < 0)
>  				return ret;
> +			labelOffset += ret;
>  		}
>  	}
>  	return 0;
> 
> 
> 
> -- 
> Jean Delvare

Regards,
Andre


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
