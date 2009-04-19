From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Apr 2009 08:07:14 +0000
Subject: Re: [lm-sensors] [PATCH 4/8] sensord: Fix switch statement
Message-Id: <20090419100714.1a1d821d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075658.GD4734@ubuntu>
In-Reply-To: <20090406075658.GD4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 6 Apr 2009 09:56:58 +0200, Andre Prendel wrote:
> Removed useless breaks after some exit() calls.
> ---
> 
>  args.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> --- quilt-sensors.orig/prog/sensord/args.c	2009-03-24 16:37:00.000000000 +0100
> +++ quilt-sensors/prog/sensord/args.c	2009-03-24 16:51:25.000000000 +0100
> @@ -221,23 +221,19 @@
>  		case 'v':
>  			printf("sensord version %s\n", LM_VERSION);
>  			exit(EXIT_SUCCESS);
> -			break;
>  		case 'h':
>  			printf("Syntax: %s {options} {chips}\n%s", argv[0],
>  			       daemonSyntax);
>  			exit(EXIT_SUCCESS);
> -			break;
>  		case ':':
>  		case '?':
>  			printf("Try `%s --help' for more information.\n",
>  			       argv[0]);
>  			return -1;
> -			break;
>  		default:
>  			fprintf(stderr,
>  				"Internal error while parsing options.\n");
>  			return -1;
> -			break;
>  		}
>  	}
>  

Looks good, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
