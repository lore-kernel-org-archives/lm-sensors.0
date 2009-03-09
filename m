From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Mar 2009 10:22:45 +0000
Subject: Re: [lm-sensors] [PATCH 6/7] sensord: Coding style conversion (gnu
Message-Id: <20090309112245.74b0c05b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090309084612.GG4636@ubuntu>
In-Reply-To: <20090309084612.GG4636@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 9 Mar 2009 09:46:12 +0100, Andre Prendel wrote:
> Fix coding style in sensord.c
> (...)
> +static void daemonize(void)
> +{
> +	int pid;
> +	struct stat fileStat;
> +	FILE *file;
> +
> +	if (chdir("/") < 0) {
> +		perror("chdir()");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (!(stat(pidFile, &fileStat)) &&
> +	    ((!S_ISREG(fileStat.st_mode)) || (fileStat.st_size > 11))) {
> +		fprintf(stderr,
> +			"Error: PID file `%s' already exists and looks suspicious.\n",
> +			pidFile);
> +		exit(EXIT_FAILURE);
> +	}
>   

Trailing white space, could be stripped (and a few other occurrences in
this file.)

> -  if (!(file = fopen (pidFile, "w"))) {
> -    fprintf (stderr, "fopen(\"%s\"): %s\n", pidFile, strerror (errno));
> -    exit (EXIT_FAILURE);
> -  }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
