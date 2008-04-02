From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Apr 2008 12:40:50 +0000
Subject: Re: [lm-sensors] [PATCH 3/4 v2] sensors: Print energy and power
Message-Id: <20080402144050.4414417a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

On Mon, 31 Mar 2008 16:53:02 -0700, Darrick J. Wong wrote:
> Display power and energy meters in sensors.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> 
> Index: lm-sensors-3.0.0/prog/sensors/chips.c
> =================================> --- lm-sensors-3.0.0.orig/prog/sensors/chips.c	2008-03-31 16:05:53.000000000 -0700
> +++ lm-sensors-3.0.0/prog/sensors/chips.c	2008-03-31 16:06:09.000000000 -0700
> @@ -401,6 +401,85 @@
>  	printf("\n");
>  }
>  
> +static void print_chip_power(const sensors_chip_name *name,
> +			     const sensors_feature *feature,
> +			     int label_size)
> +{
> +	int need_space = 0;
> +	const sensors_subfeature *sf, *sfmin, *sfmax, *sfint;
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
> +		printf("%6.2f W", get_value(name, sf));
> +	else
> +		printf("     N/A");
> +
> +	sfmin = sensors_get_subfeature(name, feature,
> +				      SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST);
> +	sfmax = sensors_get_subfeature(name, feature,
> +				       SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST);
> +	sfint = sensors_get_subfeature(name, feature,
> +				     SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
> +	if (sfmin || sfmax || sfint) {
> +		printf("  (");
> +
> +		if (sfmin) {
> +			printf("min = %6.2f W", get_value(name, sfmin));
> +			need_space = 1;
> +		}
> +
> +		if (sfmax) {
> +			printf("%smax = %6.2f W", (need_space ? ", " : ""),
> +			       get_value(name, sfmax));
> +			need_space = 1;
> +		}
> +
> +		if (sfint) {
> +			printf("%sinterval = %6.2f s", (need_space ? ", " : ""),
> +			       get_value(name, sfint));
> +			need_space = 1;
> +		}
> +		printf(")");
> +	}
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
> +		printf("%6.2f J", get_value(name, sf));
> +	else
> +		printf("     N/A");
> +
> +	printf("\n");
> +}
> +
>  static void print_chip_vid(const sensors_chip_name *name,
>  			   const sensors_feature *feature,
>  			   int label_size)
> @@ -468,6 +547,12 @@
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

Looks alright to me. The exact line layout may need some tweaking but
better wait to see enough real-world example before we do that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
