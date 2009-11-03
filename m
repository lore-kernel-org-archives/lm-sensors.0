From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 03 Nov 2009 20:02:54 +0000
Subject: [lm-sensors] [PATCH v3 3/8] sensord: Remove needless casts
Message-Id: <20091103200254.GE4724@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch removes some needless casts. We don't have to cast
explicitly from void * (in C).
---

 prog/sensord/rrd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: sensors/prog/sensord/rrd.c
=================================--- sensors.orig/prog/sensord/rrd.c	2009-10-26 21:34:00.000000000 +0100
+++ sensors/prog/sensord/rrd.c	2009-10-26 21:34:18.000000000 +0100
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
