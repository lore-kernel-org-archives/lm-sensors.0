From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Apr 2009 08:10:26 +0000
Subject: Re: [lm-sensors] [PATCH 5/8] sensord: Refactoring of parseChips()
Message-Id: <20090419101026.268717fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075733.GF4734@ubuntu>
In-Reply-To: <20090406075733.GF4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 6 Apr 2009 09:57:33 +0200, Andre Prendel wrote:
> Did some refactoring in parseChips(). This fixes some deep indentation
> levels.
> ---
> 
>  args.c |   37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> --- quilt-sensors.orig/prog/sensord/args.c	2009-03-24 22:01:55.000000000 +0100
> +++ quilt-sensors/prog/sensord/args.c	2009-03-24 22:02:56.000000000 +0100
> @@ -279,6 +279,8 @@
>  
>  int parseChips(int argc, char **argv)
>  {
> +	int i, n = argc - optind, err;
> +
>  	if (optind = argc) {

Could be replaced with "if (n = 0)", easier to read.

>  		sensord_args.chipNames[0].prefix >  			SENSORS_CHIP_NAME_PREFIX_ANY;
> @@ -286,26 +288,25 @@
>  		sensord_args.chipNames[0].bus.nr = SENSORS_BUS_NR_ANY;
>  		sensord_args.chipNames[0].addr = SENSORS_CHIP_NAME_ADDR_ANY;
>  		sensord_args.numChipNames = 1;
> -	} else {
> -		int i, n = argc - optind, err;
> -		if (n > MAX_CHIP_NAMES) {
> -			fprintf(stderr, "Too many chip names.\n");
> -			return -1;
> -		}
> -		for (i = 0; i < n; ++ i) {
> -			char *arg = argv[optind + i];
>  
> -			err = sensors_parse_chip_name(arg,
> -						      sensord_args.chipNames +
> -						      i);
> -			if (err) {
> -				fprintf(stderr,
> -					"Invalid chip name `%s': %s\n", arg,
> -					sensors_strerror(err));
> -				return -1;
> -			}
> +		return 0;
> +	}
> +
> +	if (n > MAX_CHIP_NAMES) {
> +		fprintf(stderr, "Too many chip names.\n");
> +		return -1;
> +	}
> +	for (i = 0; i < n; ++ i) {

While you're here: no space between ++ and i.

> +		char *arg = argv[optind + i];
> +
> +		err = sensors_parse_chip_name(arg, sensord_args.chipNames + i);
> +		if (err) {
> +			fprintf(stderr,	"Invalid chip name `%s': %s\n", arg,
> +				sensors_strerror(err));
> +			return -1;
>  		}
> -		sensord_args.numChipNames = n;
>  	}
> +	sensord_args.numChipNames = n;
> +
>  	return 0;
>  }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
