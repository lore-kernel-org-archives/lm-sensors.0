From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Apr 2008 14:56:34 +0000
Subject: Re: [lm-sensors] [PATCH] Parse the configuration file in C locale
Message-Id: <20080408165634.3a2cf0fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406205839.GA31929@volta.aurel32.net>
In-Reply-To: <20080406205839.GA31929@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Apr 2008 22:03:55 +0200, Jean Delvare wrote:
> I've come up with a variant where we don't need to duplicate the
> clear-up step in the error path:
> 
> ---
>  lib/init.c |   31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> --- lib/init.c.orig	2008-04-07 21:32:53.000000000 +0200
> +++ lib/init.c	2008-04-07 21:48:18.000000000 +0200
> @@ -19,8 +19,10 @@
>      MA 02110-1301 USA.
>  */
>  
> +#include <locale.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> +#include <string.h>
>  #include <errno.h>
>  #include "sensors.h"
>  #include "data.h"
> @@ -34,6 +36,31 @@
>  #define DEFAULT_CONFIG_FILE	ETCDIR "/sensors3.conf"
>  #define ALT_CONFIG_FILE		ETCDIR "/sensors.conf"
>  
> +/* Wrapper around sensors_yyparse(), which clears the locale so that
> +   the decimal numbers are always parsed properly. */
> +static int sensors_parse(void)
> +{
> +	int res;
> +	char *locale;
> +
> +	/* Remember the current locale and clear it */
> +	locale = setlocale(LC_ALL, NULL);
> +	if (locale) {
> +		locale = strdup(locale);
> +		setlocale(LC_ALL, "C");
> +	}
> +
> +	res = sensors_yyparse();
> +
> +	/* Restore the old locale */
> +	if (locale) {
> +		setlocale(LC_ALL, locale);
> +		free(locale);
> +	}
> +
> +	return res;
> +}
> +
>  int sensors_init(FILE *input)
>  {
>  	int res;
> @@ -47,7 +74,7 @@ int sensors_init(FILE *input)
>  	res = -SENSORS_ERR_PARSE;
>  	if (input) {
>  		if (sensors_scanner_init(input) ||
> -		    sensors_yyparse())
> +		    sensors_parse())
>  			goto exit_cleanup;
>  	} else {
>  		/* No configuration provided, use default */
> @@ -56,7 +83,7 @@ int sensors_init(FILE *input)
>  			input = fopen(ALT_CONFIG_FILE, "r");
>  		if (input) {
>  			if (sensors_scanner_init(input) ||
> -			    sensors_yyparse()) {
> +			    sensors_parse()) {
>  				fclose(input);
>  				goto exit_cleanup;
>  			}
> 
> I've also changed LC_NUMERIC for LC_ALL, as discussed on IRC. Otherwise
> it's the same as your original patch.
> 
> I'll apply this patch tomorrow if nobody objects.

Done:
http://www.lm-sensors.org/changeset/5169

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
