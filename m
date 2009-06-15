From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 15 Jun 2009 07:49:19 +0000
Subject: [lm-sensors] [PATCH 3/5] sensord: Remove needless casts
Message-Id: <20090615074919.GG4667@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch removes some needless casts. We don't have to cast
explicitly from void * (in C).
---

 rrd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: sensors/prog/sensord/rrd.c
=================================--- sensors.orig/prog/sensord/rrd.c	2009-06-09 22:11:20.000000000 +0200
+++ sensors/prog/sensord/rrd.c	2009-06-10 11:31:02.000000000 +0200
@@ -196,7 +196,7 @@
 {
 	(void) label; /* no warning */
 	if (!feature || feature->rrd) {
-		struct ds *data = (struct ds *) _data;
+		struct ds *data = _data;
 		char *ptr = rrdBuff + data->num * RRD_BUFF;
 		const char *min, *max;
 		data->argv[data->num ++] = ptr;
@@ -306,7 +306,7 @@
 static int rrdCGI_DEF(void *_data, const char *rawLabel, const char *label,
 		      const FeatureDescriptor *feature)
 {
-	struct gr *data = (struct gr *) _data;
+	struct gr *data = _data;
 	(void) label; /* no warning */
 	if (!feature || (feature->rrd && (feature->type = data->type)))
 		printf("\n\tDEF:%s=%s:%s:AVERAGE", rawLabel,
@@ -342,7 +342,7 @@
 static int rrdCGI_LINE(void *_data, const char *rawLabel, const char *label,
 		       const FeatureDescriptor *feature)
 {
-	struct gr *data = (struct gr *) _data;
+	struct gr *data = _data;
 	if (!feature || (feature->rrd && (feature->type = data->type)))
 		printf("\n\tLINE2:%s#%.6x:\"%s\"", rawLabel,
 		       rrdCGI_color(label), label);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
