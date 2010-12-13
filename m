From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Dec 2010 15:20:56 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Compute MAX_SUBFEATURES
Message-Id: <20101213152056.GA26048@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101213135842.73b08221@endymion.delvare>
In-Reply-To: <20101213135842.73b08221@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 13, 2010 at 07:58:42AM -0500, Jean Delvare wrote:
> Reference: http://www.lm-sensors.org/ticket/2378
> 
> This is a candidate patch to let libsensors compute MAX_SUBFEATURES
> dynamically. This should avoid accidental overflows when we add new
> subfeatures.
> 
> An alternative is to keep it a constant and add code to check for
> overflows. I had a patch ready, but if we are going to add code, I'd
> rather add code that get things right than code which only spots when
> things are wrong.
> 
> Then we can discuss what do to with the other constants.
> 
> MAX_MAIN_SENSOR_TYPES and MAX_OTHER_SENSOR_TYPES could be easily
> computed in the same loops which now compute MAX_SUBFEATURES. It's only
> a few code lines to add. OTOH it can be discussed whether they are
> worth the runtime cost, given that adding a new feature is a rare
> event, so we should be able to deal with it. I would like to hear
> opinions about this.
> 
Added runtime cost is really negligible, so that isn't really an argument for me.
But it is a really rare event, so it doesn't seem to be worth the effort - at least
as long as compilation fails if the limit is exceeded.

> Lastly, making MAX_SENSORS_PER_TYPE dynamic would be very nice, as it
> would avoid allocating more memory than we need (and supporting
> virtually unlimited channel numbers, if people have really big sensor
> chips.) But this means reworking the discovery loop significantly, as
> we would need a first pass to find out the maximum channel number. This
> will come at a runtime cost which we want to minimize. And I do not
> have the time to work on this at the moment.
> 
Not sure if that is really worth it. I would not do it.

> ---
>  lib/sysfs.c |   36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> --- lm-sensors.orig/lib/sysfs.c	2010-12-13 10:50:42.000000000 +0100
> +++ lm-sensors/lib/sysfs.c	2010-12-13 11:40:05.000000000 +0100
> @@ -139,8 +139,8 @@ char sensors_sysfs_mount[NAME_MAX];
>  #define MAX_MAIN_SENSOR_TYPES	6
>  #define MAX_OTHER_SENSOR_TYPES	2
>  #define MAX_SENSORS_PER_TYPE	24
> -#define MAX_SUBFEATURES		8
> -#define FEATURE_SIZE		(MAX_SUBFEATURES * 2)
> +/* max_subfeatures is now computed dynamically */
> +#define FEATURE_SIZE		(max_subfeatures * 2)
>  #define FEATURE_TYPE_SIZE	(MAX_SENSORS_PER_TYPE * FEATURE_SIZE)
>  
>  /* Room for all 6 main types (in, fan, temp, power, energy, current) and 2
> @@ -337,6 +337,31 @@ sensors_subfeature_type sensors_subfeatu
>  	return SENSORS_SUBFEATURE_UNKNOWN;
>  }
>  
> +static void sensors_compute_max(int *max_subfeatures)
> +{

Maybe personal preference, but I think it would be better (and a bit more efficient)
to return the result as function result, and not write it into a pointer.

Otherwise, code looks good.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
