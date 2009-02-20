From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Feb 2009 10:58:56 +0000
Subject: Re: [lm-sensors] [Patch 1/2] libsensors: Exit with fatal error if
Message-Id: <20090220115856.52e85a00@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090220090153.GA4260@ubuntu>
In-Reply-To: <20090220090153.GA4260@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On Fri, 20 Feb 2009 10:01:53 +0100, Andre Prendel wrote:
> If str(n)dup fails, there is no more memory left. We should exit with
> "Out of memory".
> 
> ---
>  init.c  |    3 +++
>  sysfs.c |    8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> --- lm-sensors-dev/lib/init.c	2009-02-18 11:47:34.000000000 +0100
> +++ my-sensors/lib/init.c	2009-02-19 22:04:32.000000000 +0100
> @@ -53,6 +53,9 @@ static int sensors_parse(void)
>  	locale = setlocale(LC_ALL, NULL);
>  	if (locale) {
>  		locale = strdup(locale);
> +		if (!locale)
> +			sensors_fatal_error(__func__, "Out of memory");
> +
>  		setlocale(LC_ALL, "C");
>  	}
>  
> --- lm-sensors-dev/lib/sysfs.c	2009-02-07 16:47:34.000000000 +0100
> +++ my-sensors/lib/sysfs.c	2009-02-19 22:02:45.000000000 +0100
> @@ -188,9 +188,14 @@ char *get_feature_name(sensors_feature_t
>  	case SENSORS_FEATURE_CURR:
>  		underscore = strchr(sfname, '_');
>  		name = strndup(sfname, underscore - sfname);
> +		if (!name)
> +			sensors_fatal_error(__func__, "Out of memory");
> +
>  		break;
>  	default:
>  		name = strdup(sfname);
> +		if (!name)
> +			sensors_fatal_error(__func__, "Out of memory");
>  	}
>  
>  	return name;
> @@ -419,6 +424,9 @@ static int sensors_read_dynamic_chip(sen
>  		/* fill in the subfeature members */
>  		all_subfeatures[i].type = sftype;
>  		all_subfeatures[i].name = strdup(name);
> +		if (!all_subfeatures[i].name)
> +			sensors_fatal_error(__func__, "Out of memory");
> +
>  		if (!(sftype & 0x80))
>  			all_subfeatures[i].flags |= SENSORS_COMPUTE_MAPPING;
>  		all_subfeatures[i].flags |= sensors_get_attr_mode(dev_path, name);

Looks good. Applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
