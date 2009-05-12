From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 19:43:20 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] sensord: Refactoring of loadConfig()
Message-Id: <20090512214320.720f4caf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160411.GF17530@ubuntu>
In-Reply-To: <20090511160411.GF17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 18:04:11 +0200, Andre Prendel wrote:
> This patch does some refactoring of the loadConfig()
> function.
> 
> * Simplifying the conditions makes code flow clearer and eliminates
> long lines (> 80 chars).
> * Removed useless stat() call.
> * Return -1 in error case, instead of several positive values (never defined).
> 
> Changes in v2:
> 
> Blank line before the first #include.
> Fix typo.
> Bring back logging (reload configuration).
> Consistent error messages.
> Drop reading configuration from stdin.
> Fix logging (if fopen() fails).
> Cleanup sensors before reloading configuration.
> Fix compile warning.
> Don't print error value if reloadLib() fails.

Looks almost OK, just one minor issue:

> ---
> 
>  lib.c     |   74 +++++++++++++++++++++++++++++++-------------------------------
>  sensord.c |    4 +--
>  2 files changed, 40 insertions(+), 38 deletions(-)
> 
> Index: quilt-sensors/prog/sensord/lib.c
> =================================> --- quilt-sensors.orig/prog/sensord/lib.c	2009-04-26 22:11:03.000000000 +0200
> +++ quilt-sensors/prog/sensord/lib.c	2009-04-26 22:13:09.000000000 +0200
> (...)
> + 	/* Load default configuration. */
> + 	if (!cfgPath) {
> + 		if (reload) {
>  			sensorLog(LOG_INFO, "configuration reloading");
> -			sensors_cleanup();
> +  			sensors_cleanup();

You're adding leading white spaces!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
