From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 04 May 2009 09:22:51 +0000
Subject: Re: [lm-sensors] [PATCH 7/8] sensord: Use sigaction() for
Message-Id: <20090504092251.GA4884@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 06, 2009 at 09:57:58AM +0200, Andre Prendel wrote:
> Replace the deprecated signal() function by sigaction().
> 
> The signal() function has some disadvantages. This patch replaces
> signal() by sigaction() to install the signal handlers.

Hi Jean,

there are two patches left for reviewing (7/8, 8/8).

Maybe you have forgotten about that. So here is the reminder ;)

Thanks
Andre

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
> +	sigemptyset(&new.sa_mask);
> +	new.sa_flags = SA_RESTART;
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
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
