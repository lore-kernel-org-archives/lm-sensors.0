From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Jun 2009 10:02:56 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] sensord: Convert CGI script to lower
Message-Id: <20090623120256.6aa06000@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090615074755.GF4667@ubuntu>
In-Reply-To: <20090615074755.GF4667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 15 Jun 2009 09:47:55 +0200, Andre Prendel wrote:
> This patch converts HTML code in the generated CGI script to lower
> case. This makes us a bit more XHTML compatible.
> ---
> 
>  rrd.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Index: sensors/prog/sensord/rrd.c
> =================================> --- sensors.orig/prog/sensord/rrd.c	2009-06-09 20:31:13.000000000 +0200
> +++ sensors/prog/sensord/rrd.c	2009-06-09 22:05:04.000000000 +0200
> @@ -449,16 +449,16 @@
>  {
>  	int ret = 0, i;
>  
> -	printf("#!" RRDCGI "\n\n<HTML>\n"
> -	       "<HEAD>\n<TITLE>sensord</TITLE>\n</HEAD>\n"
> -	       "<BODY>\n<H1>sensord</H1>\n");
> +	printf("#!" RRDCGI "\n\n<html>\n"
> +	       "<head>\n<title>sensord</title>\n</head>\n"
> +	       "<body>\n<h1>sensord</h1>\n");
>  
>  	for (i = 0; i < ARRAY_SIZE(graphs); i++) {
>  		struct gr *graph = &graphs[i];
>  
> -		printf("<H2>%s</H2>\n", graph->h2);
> -		printf("<P>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '"
> -		       "<IMG SRC=" WWWDIR "/%%s WIDTH=%%lu HEIGHT=%%lu>'"
> +		printf("<h2>%s</h2>\n", graph->h2);
> +		printf("<p>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '"
> +		       "<IMG src=" WWWDIR "/%%s WIDTH=%%lu HEIGHT=%%lu>'"

Not sure why you didn't lowercase IMG, WIDTH and HEIGHT here?

>  		       "\n\t-a PNG\n\t-h 200 -w 800\n",
>  		       sensord_args.cgiDir, graph->image);
>  
> @@ -473,7 +473,7 @@
>  			ret = applyToFeatures(rrdCGI_LINE, graph);
>  		if (!ret && sensord_args.doLoad && graph->loadAvg)
>  			ret = rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
> -		printf (">\n</P>\n");
> +		printf (">\n</p>\n");
>  	}
>  	printf("<p>\n<small><b>sensord</b> by "
>  	       "<a href=\"mailto:merlin@merlin.org\">Merlin Hughes</a>"
> @@ -481,7 +481,7 @@
>  	       "<a href=\"http://www.lm-sensors.org/\">lm_sensors</a> "
>  	       "crew.</small>\n</p>\n");
>  
> -	printf("</BODY>\n</HTML>\n");
> +	printf("</body>\n</html>\n");
>  
>  	return ret;
>  }

Otherwise it looks good.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
