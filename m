From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 22 Aug 2007 11:22:57 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] libsensors4: No longer allow reloading
Message-Id: <46CC1C91.4020302@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070821212536.61ce7a69@hyperion.delvare>
In-Reply-To: <20070821212536.61ce7a69@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Drop support for reloading the configuration with sensors_init().
> Instead, the application will have to call sensors_exit() explicitly
> before calling sensors_init() again. Most applications don't offer
> any way to reload the configuration file, so better optimize for the
> initial load.
> 

Looks good to me. This reminds me I still need to test current svn, but I'm 
awefully busy atm (back at work from vacation), I'll give svn a spin when I 
find the time.

Regards,

Hans

> ---
>  lib/init.c         |    2 +-
>  lib/libsensors.3   |    5 ++++-
>  lib/sensors.h      |    8 +++++---
>  prog/sensord/lib.c |    4 +++-
>  4 files changed, 13 insertions(+), 6 deletions(-)
> 
> --- lm-sensors-3.orig/lib/init.c	2007-08-21 20:08:05.000000000 +0200
> +++ lm-sensors-3/lib/init.c	2007-08-21 20:08:27.000000000 +0200
> @@ -40,7 +40,7 @@ static void free_expr(sensors_expr *expr
>  int sensors_init(FILE *input)
>  {
>    int res;
> -  sensors_cleanup();
> +
>    if (!sensors_init_sysfs())
>      return -SENSORS_ERR_PROC;
>    if ((res = sensors_read_sysfs_bus()) || (res = sensors_read_sysfs_chips()))
> --- lm-sensors-3.orig/lib/libsensors.3	2007-08-21 20:08:05.000000000 +0200
> +++ lm-sensors-3/lib/libsensors.3	2007-08-21 21:24:11.000000000 +0200
> @@ -53,7 +53,10 @@ libsensors \- publicly accessible functi
>  .SH DESCRIPTION
>  .B int sensors_init(FILE *input);
>  .br
> -(Re)load the configuration file and the detected chips list. If this returns a value unequal to zero, you are in trouble; you can not assume anything will be initialized properly.
> +Load the configuration file and the detected chips list. If this returns a
> +value unequal to zero, you are in trouble; you can not assume anything will
> +be initialized properly. If you want to reload the configuration file, call
> +sensors_cleanup() below before calling sensors_init() again.
>  
>  .B void sensors_cleanup(void);
>  .br
> --- lm-sensors-3.orig/lib/sensors.h	2007-08-21 20:08:05.000000000 +0200
> +++ lm-sensors-3/lib/sensors.h	2007-08-21 21:24:11.000000000 +0200
> @@ -56,9 +56,11 @@ typedef struct sensors_chip_name {
>  	char *path;
>  } sensors_chip_name;
>  
> -/* (Re)load the configuration file and the detected chips list. If this
> -    returns a value unequal to zero, you are in trouble; you can not
> -    assume anything will be initialized properly. */
> +/* Load the configuration file and the detected chips list. If this
> +   returns a value unequal to zero, you are in trouble; you can not
> +   assume anything will be initialized properly. If you want to
> +   reload the configuration file, call sensors_cleanup() below before
> +   calling sensors_init() again. */
>  int sensors_init(FILE *input);
>  
>  /* Clean-up function: You can't access anything after
> --- lm-sensors-3.orig/prog/sensord/lib.c	2007-04-02 13:20:58.000000000 +0200
> +++ lm-sensors-3/prog/sensord/lib.c	2007-08-21 20:29:01.000000000 +0200
> @@ -90,8 +90,10 @@ loadConfig
>      sensorLog (LOG_ERR, "Error stating sensors configuration file: %s", cfgPath);
>      ret = 10;
>    } else if (!reload || (difftime (stats.st_mtime, cfgLastModified) > 0.0)) {
> -    if (reload)
> +    if (reload) {
>        sensorLog (LOG_INFO, "configuration reloading");
> +      sensors_cleanup ();
> +    }
>      if (!(cfg = fopen (cfgPath, "r"))) {
>        sensorLog (LOG_ERR, "Error opening sensors configuration file: %s", cfgPath);
>        ret = 11;
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
