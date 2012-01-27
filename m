From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 Jan 2012 16:44:44 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: More reliable detection of sysfs being mounted
Message-Id: <1327682684.2649.237.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120127171605.6bd22acf@endymion.delvare>
In-Reply-To: <20120127171605.6bd22acf@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2012-01-27 at 11:16 -0500, Jean Delvare wrote:
> Upcoming change in sysfs will break the way libsensors detects if
> sysfs is mounted. Adjust the implementation so that it still works after
> said change.
> 
> ---
>  lib/sysfs.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- lm-sensors.orig/lib/sysfs.c	2012-01-27 11:49:37.000000000 +0100
> +++ lm-sensors/lib/sysfs.c	2012-01-27 16:20:12.125482157 +0100
> @@ -24,6 +24,7 @@
>  
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/vfs.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdlib.h>
> @@ -40,6 +41,7 @@
>  /****************************************************************************/
>  
>  #define ATTR_MAX	128
> +#define SYSFS_MAGIC	0x62656572
>  
>  /*
>   * Read an attribute from sysfs
> @@ -593,11 +595,11 @@ exit_free:
>  /* returns !0 if sysfs filesystem was found, 0 otherwise */
>  int sensors_init_sysfs(void)
>  {
> -	struct stat statbuf;
> +	struct statfs statfsbuf;
>  
>  	snprintf(sensors_sysfs_mount, NAME_MAX, "%s", "/sys");
> -	if (stat(sensors_sysfs_mount, &statbuf) < 0
> -	 || statbuf.st_nlink <= 2)	/* Empty directory */
> +	if (statfs(sensors_sysfs_mount, &statfsbuf) < 0
> +	 || statfsbuf.f_type != SYSFS_MAGIC)
>  		return 0;
>  
>  	return 1;
> 
Looks good. Hope that won't bite us too much after 3.4 is released.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
