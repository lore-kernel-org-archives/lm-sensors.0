From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 15 Jun 2009 07:47:13 +0000
Subject: [lm-sensors] [PATCH 1/5] sensord: Fix coding style
Message-Id: <20090615074713.GE4667@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch fixes some coding style issues.

* Remove whitespaces between variable and increment operator.
* Break long lines.
---

 rrd.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

Index: sensors/prog/sensord/rrd.c
=================================--- sensors.orig/prog/sensord/rrd.c	2009-06-09 19:45:56.000000000 +0200
+++ sensors/prog/sensord/rrd.c	2009-06-09 20:27:00.000000000 +0200
@@ -99,7 +99,7 @@
 		} else {
 			buffer[i] = '_';
 		}
-		++ i;
+		++i;
 	}
 	buffer[i] = '\0';
 
@@ -108,7 +108,7 @@
 
 	/* locate duplicates */
 	while (okay && (j < index0))
-		okay = strcmp(rrdLabels[j ++], buffer);
+		okay = strcmp(rrdLabels[j++], buffer);
 
 	/* uniquify duplicate labels with _? or _?? */
 	while (!okay) {
@@ -449,13 +449,19 @@
 {
 	int ret = 0, i;
 
-	printf("#!" RRDCGI "\n\n<HTML>\n<HEAD>\n<TITLE>sensord</TITLE>\n</HEAD>\n<BODY>\n<H1>sensord</H1>\n");
+	printf("#!" RRDCGI "\n\n<HTML>\n"
+	       "<HEAD>\n<TITLE>sensord</TITLE>\n</HEAD>\n"
+	       "<BODY>\n<H1>sensord</H1>\n");
+
 	for (i = 0; i < ARRAY_SIZE(graphs); i++) {
 		struct gr *graph = &graphs[i];
 
 		printf("<H2>%s</H2>\n", graph->h2);
-		printf("<P>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '<IMG SRC=" WWWDIR "/%%s WIDTH=%%lu HEIGHT=%%lu>'\n\t-a PNG\n\t-h 200 -w 800\n",
+		printf("<P>\n<RRD::GRAPH %s/%s.png\n\t--imginfo '"
+		       "<IMG SRC=" WWWDIR "/%%s WIDTH=%%lu HEIGHT=%%lu>'"
+		       "\n\t-a PNG\n\t-h 200 -w 800\n",
 		       sensord_args.cgiDir, graph->image);
+
 		printf("\t--lazy\n\t-v '%s'\n\t-t '%s'\n\t-x '%s'\n\t%s",
 		       graph->axisTitle, graph->title, graph->axisDefn,
 		       graph->options);
@@ -469,7 +475,12 @@
 			ret = rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
 		printf (">\n</P>\n");
 	}
-	printf("<p>\n<small><b>sensord</b> by <a href=\"mailto:merlin@merlin.org\">Merlin Hughes</a>, all credit to the <a href=\"http://www.lm-sensors.org/\">lm_sensors</a> crew.</small>\n</p>\n");
+	printf("<p>\n<small><b>sensord</b> by "
+	       "<a href=\"mailto:merlin@merlin.org\">Merlin Hughes</a>"
+	       ", all credit to the "
+	       "<a href=\"http://www.lm-sensors.org/\">lm_sensors</a> "
+	       "crew.</small>\n</p>\n");
+
 	printf("</BODY>\n</HTML>\n");
 
 	return ret;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
