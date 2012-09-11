From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 04:17:27 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: add humidity data to output of sensors command
Message-Id: <20120911041727.GA450@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE063E1.5050301@gmail.com>
In-Reply-To: <4FE063E1.5050301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, Jun 19, 2012 at 11:34:57AM +0000, Iain Paton wrote:
> Testing out a humidity sensor recently and was thinking the driver wasn't working somehow. 
> Discovered instead that the driver works fine, but the sensors command was ignoring the 
> humidity data.
> This adds output of humidity data for sensors that support it.
> 
> Please consider applying it.
> 
> Thanks,
> Iain 
> 
mind if I apply this patch to lm-sensors ?

Thanks,
Guenter

> diff -Naur lm_sensors-3.3.2-org/prog/sensors/chips.c lm_sensors-3.3.2/prog/sensors/chips.c
> --- lm_sensors-3.3.2-org/prog/sensors/chips.c	2012-03-07 16:12:56.000000000 +0000
> +++ lm_sensors-3.3.2/prog/sensors/chips.c	2012-06-18 17:35:15.769803432 +0100
> @@ -658,6 +658,27 @@
>  	free(label);
>  }
>  
> +static void print_chip_humidity(const sensors_chip_name *name,
> +			   const sensors_feature *feature,
> +			   int label_size)
> +{
> +	char *label;
> +	const sensors_subfeature *subfeature;
> +	double vid;
> +
> +	subfeature = sensors_get_subfeature(name, feature,
> +					    SENSORS_SUBFEATURE_HUMIDITY_INPUT);
> +	if (!subfeature)
> +		return;
> +
> +	if ((label = sensors_get_label(name, feature))
> +	 && !sensors_get_value(name, subfeature->number, &vid)) {
> +		print_label(label, label_size);
> +		printf("%6.1f \%RH\n", vid);
> +	}
> +	free(label);
> +}
> +
>  static void print_chip_beep_enable(const sensors_chip_name *name,
>  				   const sensors_feature *feature,
>  				   int label_size)
> @@ -792,6 +813,9 @@
>  		case SENSORS_FEATURE_INTRUSION:
>  			print_chip_intrusion(name, feature, label_size);
>  			break;
> +		case SENSORS_FEATURE_HUMIDITY:
> +			print_chip_humidity(name, feature, label_size);
> +			break;
>  		default:
>  			continue;
>  		}
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
