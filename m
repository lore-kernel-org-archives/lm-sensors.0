From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 May 2009 13:06:34 +0000
Subject: Re: [lm-sensors] [PATCH 7/8] sensord: Use sigaction() for signal
Message-Id: <20090508150634.4dac92dc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090406075758.GH4734@ubuntu>
In-Reply-To: <20090406075758.GH4734@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

Sorry for the late review.

On Mon, 6 Apr 2009 09:57:58 +0200, Andre Prendel wrote:
> Replace the deprecated signal() function by sigaction().
> 
> The signal() function has some disadvantages. This patch replaces
> signal() by sigaction() to install the signal handlers.
> ---
> 
>  sensord.c |   32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> --- quilt-sensors.orig/prog/sensord/sensord.c	2009-04-04 18:25:22.000000000 +0200
> +++ quilt-sensors/prog/sensord/sensord.c	2009-04-05 17:07:19.000000000 +0200
> @@ -65,7 +65,6 @@
>  
>  static void signalHandler(int sig)
>  {
> -	signal(sig, signalHandler);
>  	switch (sig) {
>  	case SIGTERM:
>  		done = 1;
> @@ -147,6 +146,30 @@
>  	logOpened = 1;
>  }
>  
> +static void install_sighandler(void)
> +{
> +	struct sigaction new;
> +	int ret;
> +
> +	new.sa_handler = signalHandler;

"new" is a structure on the stack, it is uninitialized, you must zero
it using memset() before using it.

> +	sigemptyset(&new.sa_mask);
> +	new.sa_flags = SA_RESTART;

Why do we need this?

> +
> +	ret = sigaction(SIGTERM, &new, NULL);
> +	if (ret = -1) {
> +		fprintf(stderr, "Could not set sighandler for SIGTERM: %s\n",
> +			strerror(errno));
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ret = sigaction(SIGHUP, &new, NULL);
> +	if (ret = -1) {
> +		fprintf(stderr, "Could not set sighandler for SIGHUP: %s\n",
> +			strerror(errno));
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
>  static void daemonize(void)
>  {
>  	int pid;
> @@ -172,12 +195,7 @@
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	/* I should use sigaction but... */
> -	if (signal(SIGTERM, signalHandler) = SIG_ERR ||
> -	    signal (SIGHUP, signalHandler) = SIG_ERR) {
> -		perror("signal");
> -		exit(EXIT_FAILURE);
> -	}
> +	install_sighandler();
>  
>  	if ((pid = fork()) = -1) {
>  		perror("fork()");

Looks otherwise good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
