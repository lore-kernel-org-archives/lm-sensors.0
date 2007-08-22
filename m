From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 22 Aug 2007 12:04:50 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] libsensors4: Drop SENSORS_MODE_NO_RW
Message-Id: <46CC2662.2080909@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070821212900.6d1fd920@hyperion.delvare>
In-Reply-To: <20070821212900.6d1fd920@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Drop SENSORS_MODE_NO_RW and SENSORS_MODE_RW. The mode is a bitfield,
> we typically set, or test for, a specific bit.
> 

Looks good to me,

Regards,

Hans

> ---
>  lib/data.h       |    5 ++---
>  lib/libsensors.3 |    5 ++---
>  lib/sensors.h    |    2 --
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> --- lm-sensors-3.orig/lib/data.h	2007-08-19 22:30:19.000000000 +0200
> +++ lm-sensors-3/lib/data.h	2007-08-21 21:15:57.000000000 +0200
> @@ -130,9 +130,8 @@ typedef struct sensors_bus {
>     compute_mapping is like logical_mapping, only it refers to another
>       feature whose compute line will be inherited (a group could be fan and
>       fan_max, but not fan_div)
> -   mode is SENSORS_MODE_NO_RW, SENSORS_MODE_R, SENSORS_MODE_W or
> -     SENSORS_MODE_RW, for unaccessible, readable, writable, and both readable
> -     and writable.
> +   mode is a bitfield, its value is a combination of SENSORS_MODE_R (readable)
> +     and SENSORS_MODE_W (writable).
>     scaling is the number of decimal points to scale by.
>       Divide the read value by 10**scaling to get the real value. */
>  typedef struct sensors_chip_feature {
> --- lm-sensors-3.orig/lib/libsensors.3	2007-08-21 20:46:37.000000000 +0200
> +++ lm-sensors-3/lib/libsensors.3	2007-08-21 21:15:57.000000000 +0200
> @@ -121,9 +121,8 @@ This structure is used when you want to 
>  .br
>  } sensors_feature_data;\fP
>  .br
> -The mode field can be one of:
> -.br
> -SENSORS_MODE_NO_RW, SENSORS_MODE_R, SENSORS_MODE_W or SENSORS_MODE_RW.
> +The mode field is a bitfield, its value is a combination of
> +SENSORS_MODE_R (readable) and SENSORS_MODE_W (writable).
>  
>  \fBconst sensors_feature_data *sensors_get_all_features
>        (const sensors_chip_name *name, int *nr);\fP
> --- lm-sensors-3.orig/lib/sensors.h	2007-08-21 20:46:50.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2007-08-21 21:15:57.000000000 +0200
> @@ -116,10 +116,8 @@ int sensors_do_chip_sets(const sensors_c
>  const sensors_chip_name *sensors_get_detected_chips(int *nr);
>  
>  /* These defines are used in the mode field of sensors_feature_data */
> -#define SENSORS_MODE_NO_RW 0
>  #define SENSORS_MODE_R 1
>  #define SENSORS_MODE_W 2
> -#define SENSORS_MODE_RW 3
>  
>  /* This define is used in the mapping field of sensors_feature_data if no
>     mapping is available */
> 
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
