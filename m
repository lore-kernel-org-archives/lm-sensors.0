From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Oct 2009 10:31:28 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/6] sensord: Convert CGI script to
Message-Id: <20091028113128.716c5f43@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091026205647.GC4725@ubuntu>
In-Reply-To: <20091026205647.GC4725@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Oct 2009 21:56:47 +0100, Andre Prendel wrote:
> This patch converts HTML code in the generated CGI script to lower
> case. This makes us a bit more XHTML compatible.
> 
> Changes in v2:
> 
> Make img, width, height lowercase to.
> ---
> 
>  prog/sensord/rrd.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Index: sensors/prog/sensord/rrd.c
> =================================> --- sensors.orig/prog/sensord/rrd.c	2009-10-26 21:33:40.000000000 +0100
> +++ sensors/prog/sensord/rrd.c	2009-10-26 21:34:00.000000000 +0100
> @@ -449,16 +449,16 @@
> (...)
> -		printf("<H2>%s</H2>\n", graph->h2);
> -		printf("<P>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '"
> -		       "<IMG SRC=" WWWDIR "/%%s WIDTH=%%lu HEIGHT=%%lu>'"
> +		printf("<h2>%s</h2>\n", graph->h2);
> +		printf("<p>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '"
> +		       "<img src=" WWWDIR "/%%s width=%%lu heigt=%%lu>'"

Typo here: heigt -> height.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
