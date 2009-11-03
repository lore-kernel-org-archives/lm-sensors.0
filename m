From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 03 Nov 2009 20:03:14 +0000
Subject: [lm-sensors] [PATCH v3 5/8] sensord: Change signature of
Message-Id: <20091103200314.GG4724@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch changes the signature of function pointer (*FeatureFN) and
the related functions:

  rrdGetSensors_DS()
  rrdCGI_DEF()
  rrdCGI_LINE()

Return type is now void because none of the functions return an error
code.
---
 prog/sensord/rrd.c |   29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

Index: sensors/prog/sensord/rrd.c
=================================--- sensors.orig/prog/sensord/rrd.c	2009-10-30 20:03:21.000000000 +0100
+++ sensors/prog/sensord/rrd.c	2009-10-30 20:04:48.000000000 +0100
@@ -68,8 +68,8 @@
 #define LOADAVG "loadavg"
 #define LOAD_AVERAGE "Load Average"
 
-typedef int (*FeatureFN) (void *data, const char *rawLabel, const char *label,
-			  const FeatureDescriptor *feature);
+typedef void (*FeatureFN) (void *data, const char *rawLabel, const char *label,
+			   const FeatureDescriptor *feature);
 
 static char rrdNextChar(char c)
 {
@@ -141,7 +141,7 @@
 			    const sensors_chip_name *chip,
 			    const ChipDescriptor *desc)
 {
-	int i, ret;
+	int i;
 	const FeatureDescriptor *features = desc->features;
 	const FeatureDescriptor *feature;
 	const char *rawLabel;
@@ -159,7 +159,7 @@
 		}
 
 		rrdCheckLabel(rawLabel, i);
-		ret = fn(data, rrdLabels[i], label, feature);
+		fn(data, rrdLabels[i], label, feature);
 		free(label);
 	}
 	return 0;
@@ -210,9 +210,9 @@
 	const char **argv;
 };
 
-static int rrdGetSensors_DS(void *_data, const char *rawLabel,
-			    const char *label,
-			    const FeatureDescriptor *feature)
+static void rrdGetSensors_DS(void *_data, const char *rawLabel,
+			     const char *label,
+			     const FeatureDescriptor *feature)
 {
 	(void) label; /* no warning */
 	if (!feature || feature->rrd) {
@@ -247,7 +247,6 @@
 		sprintf(ptr, "DS:%s:GAUGE:%d:%s:%s", rawLabel, 5 *
 			sensord_args.rrdTime, min, max);
 	}
-	return 0;
 }
 
 static int rrdGetSensors(const char **argv)
@@ -256,7 +255,7 @@
 	struct ds data = { 0, argv};
 	ret = applyToFeatures(rrdGetSensors_DS, &data);
 	if (!ret && sensord_args.doLoad)
-		ret = rrdGetSensors_DS(&data, LOADAVG, LOAD_AVERAGE, NULL);
+		rrdGetSensors_DS(&data, LOADAVG, LOAD_AVERAGE, NULL);
 	return ret ? -1 : data.num;
 }
 
@@ -323,15 +322,14 @@
 	int loadAvg;
 };
 
-static int rrdCGI_DEF(void *_data, const char *rawLabel, const char *label,
-		      const FeatureDescriptor *feature)
+static void rrdCGI_DEF(void *_data, const char *rawLabel, const char *label,
+		       const FeatureDescriptor *feature)
 {
 	struct gr *data = _data;
 	(void) label; /* no warning */
 	if (!feature || (feature->rrd && (feature->type = data->type)))
 		printf("\n\tDEF:%s=%s:%s:AVERAGE", rawLabel,
 		       sensord_args.rrdFile, rawLabel);
-	return 0;
 }
 
 /*
@@ -359,14 +357,13 @@
 	return color;
 }
 
-static int rrdCGI_LINE(void *_data, const char *rawLabel, const char *label,
-		       const FeatureDescriptor *feature)
+static void rrdCGI_LINE(void *_data, const char *rawLabel, const char *label,
+			const FeatureDescriptor *feature)
 {
 	struct gr *data = _data;
 	if (!feature || (feature->rrd && (feature->type = data->type)))
 		printf("\n\tLINE2:%s#%.6x:\"%s\"", rawLabel,
 		       rrdCGI_color(label), label);
-	return 0;
 }
 
 static struct gr graphs[] = {
@@ -488,11 +485,11 @@
 		if (!ret)
 			ret = applyToFeatures(rrdCGI_DEF, graph);
 		if (!ret && sensord_args.doLoad && graph->loadAvg)
-			ret = rrdCGI_DEF(graph, LOADAVG, LOAD_AVERAGE, NULL);
+			rrdCGI_DEF(graph, LOADAVG, LOAD_AVERAGE, NULL);
 		if (!ret)
 			ret = applyToFeatures(rrdCGI_LINE, graph);
 		if (!ret && sensord_args.doLoad && graph->loadAvg)
-			ret = rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
+			rrdCGI_LINE(graph, LOADAVG, LOAD_AVERAGE, NULL);
 		printf (">\n</p>\n");
 	}
 	printf("<p>\n<small><b>sensord</b> by "

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
