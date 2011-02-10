From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Feb 2011 08:20:20 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add support for humidity
Message-Id: <20110210092020.56d98bef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210054256.GA23546@ericsson.com>
In-Reply-To: <20110210054256.GA23546@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 9 Feb 2011 21:42:56 -0800, Guenter Roeck wrote:
> This patch adds support for humidity sensors to libsensors.

Maybe it's a little late to discuss this now that humidity[1-*]_input
is already described in Documentation/hwmon/sysfs-interface, but... do
humidity sensors really belong to the hardware monitoring framework?
What are the use cases of these sensors in practice?

We let the accelerometer drivers slip in in the past (thankfully
without documenting their attributes), and now we have a hard time
getting them moved to the right place. I wouldn't want to do the same
mistake with humidity sensors. My feeling is that they don't belong to
hwmon.

> --
> Index: doc/libsensors-API.txt
> =================================> --- doc/libsensors-API.txt	(revision 5917)
> +++ doc/libsensors-API.txt	(working copy)
> @@ -33,6 +33,9 @@
>    enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_CRIT
>    enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_LCRIT_ALARM
>    enum sensors_subfeature_type SENSORS_SUBFEATURE_CURR_CRIT_ALARM
> +* Added support for humidity sensors
> +  enum sensors_feature_type SENSORS_FEATURE_HUMIDITY
> +  enum sensors_subfeature_type SENSORS_SUBFEATURE_HUMIDITY_INPUT
>  
>  0x430	lm-sensors 3.2.0
>  * License changed from GPL to LGPL
> Index: lib/sensors.h
> =================================> --- lib/sensors.h	(revision 5917)
> +++ lib/sensors.h	(working copy)
> @@ -140,6 +140,7 @@
>  	SENSORS_FEATURE_POWER		= 0x03,
>  	SENSORS_FEATURE_ENERGY		= 0x04,
>  	SENSORS_FEATURE_CURR		= 0x05,
> +	SENSORS_FEATURE_HUMIDITY	= 0x06,
>  	SENSORS_FEATURE_MAX_MAIN,
>  	SENSORS_FEATURE_VID		= 0x10,
>  	SENSORS_FEATURE_INTRUSION	= 0x11,
> @@ -220,6 +221,8 @@
>  	SENSORS_SUBFEATURE_CURR_LCRIT_ALARM,
>  	SENSORS_SUBFEATURE_CURR_CRIT_ALARM,
>  
> +	SENSORS_SUBFEATURE_HUMIDITY_INPUT = SENSORS_FEATURE_HUMIDITY << 8,
> +
>  	SENSORS_SUBFEATURE_VID = SENSORS_FEATURE_VID << 8,
>  
>  	SENSORS_SUBFEATURE_INTRUSION_ALARM = SENSORS_FEATURE_INTRUSION << 8,
> Index: lib/sysfs.c
> =================================> --- lib/sysfs.c	(revision 5917)
> +++ lib/sysfs.c	(working copy)
> @@ -158,6 +158,7 @@
>  	case SENSORS_SUBFEATURE_IN_INPUT:
>  	case SENSORS_SUBFEATURE_TEMP_INPUT:
>  	case SENSORS_SUBFEATURE_CURR_INPUT:
> +	case SENSORS_SUBFEATURE_HUMIDITY_INPUT:
>  		return 1000;
>  	case SENSORS_SUBFEATURE_FAN_INPUT:
>  		return 1;
> @@ -190,6 +191,7 @@
>  	case SENSORS_FEATURE_POWER:
>  	case SENSORS_FEATURE_ENERGY:
>  	case SENSORS_FEATURE_CURR:
> +	case SENSORS_FEATURE_HUMIDITY:
>  	case SENSORS_FEATURE_INTRUSION:
>  		underscore = strchr(sfname, '_');
>  		name = strndup(sfname, underscore - sfname);
> @@ -306,6 +308,11 @@
>  	{ NULL, 0 }
>  };
>  
> +static const struct subfeature_type_match humidity_matches[] = {
> +	{ "input", SENSORS_SUBFEATURE_HUMIDITY_INPUT },
> +	{ NULL, 0 }
> +};
> +
>  static const struct subfeature_type_match cpu_matches[] = {
>  	{ "vid", SENSORS_SUBFEATURE_VID },
>  	{ NULL, 0 }
> @@ -325,6 +332,7 @@
>  	{ "curr%d%c", curr_matches },
>  	{ "energy%d%c", energy_matches },
>  	{ "intrusion%d%c", intrusion_matches },
> +	{ "humidity%d%c", humidity_matches },
>  };
>  
>  /* Return the subfeature type and channel number based on the subfeature
> @@ -451,6 +459,7 @@
>  		case SENSORS_FEATURE_POWER:
>  		case SENSORS_FEATURE_ENERGY:
>  		case SENSORS_FEATURE_CURR:
> +		case SENSORS_FEATURE_HUMIDITY:
>  			nr--;
>  			break;
>  		default:

_If_ we decide that humidity sensors belong to the hwmon framework,
then this patch looks good good. Except for the following comment in
lib/sysfs.c which would have to be updated:

/* Room for all 6 main types (in, fan, temp, power, energy, current) and 2
   other types (VID, intrusion) with all their subfeatures + misc features */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
