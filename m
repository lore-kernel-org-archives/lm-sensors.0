From: =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>
Date: Mon, 02 Sep 2019 11:48:00 +0000
Subject: Re: [PATCH] libsensors: Prevent warning with glibc >= 2.20
Message-Id: <flssgpe6hsf.fsf@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare <jdelvare@suse.de> writes:

> Since glibc 2.20, the usage of _BSD_SOURCE is deprecated. Fix it like
> described here:
>
> https://sourceware.org/glibc/wiki/Release/2.20#Deprecation_of__BSD_SOURCE_and__SVID_SOURCE_feature_macros
>
> Inspired from a similar patch by Wolfram Sang for i2c-tools.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  lib/init.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- lm-sensors.orig/lib/init.c	2016-08-03 13:25:00.101098040 +0200
> +++ lm-sensors/lib/init.c	2016-08-03 13:25:12.934237590 +0200
> @@ -20,7 +20,8 @@
>  */
>  
>  /* Needed for scandir() and alphasort() */
> -#define _BSD_SOURCE
> +#define _BSD_SOURCE 1 /* for glibc < 2.19 */
> +#define _DEFAULT_SOURCE 1 /* for glibc >= 2.19 */
>  
>  #include <sys/types.h>
>  #include <sys/stat.h>
>
>
> -- 
> Jean Delvare
> SUSE L3 Support

Thanks, Jean! Applied.

Ondřej Lysoněk
