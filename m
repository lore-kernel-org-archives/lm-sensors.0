From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 09 Mar 2009 08:46:20 +0000
Subject: [lm-sensors] [PATCH 7/7] sensord: Coding style conversion (gnu ->
Message-Id: <20090309084620.GH4636@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix coding style in sensord.h

---
 prog/sensord/sensord.h |   61 ++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

--- quilt-sensors.orig/prog/sensord/sensord.h	2009-03-07 23:41:17.000000000 +0100
+++ quilt-sensors/prog/sensord/sensord.h	2009-03-07 23:44:49.000000000 +0100
@@ -23,7 +23,7 @@
 
 #include "lib/sensors.h"
 
-extern void sensorLog (int priority, const char *fmt, ...);
+extern void sensorLog(int priority, const char *fmt, ...);
 
 /* from args.c */
 
@@ -45,59 +45,60 @@
 extern sensors_chip_name chipNames[];
 extern int numChipNames;
 
-extern int parseArgs (int argc, char **argv);
-extern int parseChips (int argc, char **argv);
+extern int parseArgs(int argc, char **argv);
+extern int parseChips(int argc, char **argv);
 
 /* from lib.c */
 
-extern int loadLib (const char *cfgPath);
-extern int reloadLib (const char *cfgPath);
-extern int unloadLib (void);
+extern int loadLib(const char *cfgPath);
+extern int reloadLib(const char *cfgPath);
+extern int unloadLib(void);
 
 /* from sense.c */
 
-extern int readChips (void);
-extern int scanChips (void);
-extern int setChips (void);
-extern int rrdChips (void);
+extern int readChips(void);
+extern int scanChips(void);
+extern int setChips(void);
+extern int rrdChips(void);
 
 /* from rrd.c */
 
 extern char rrdBuff[];
-extern int rrdInit (void);
-extern int rrdUpdate (void);
-extern int rrdCGI (void);
+extern int rrdInit(void);
+extern int rrdUpdate(void);
+extern int rrdCGI(void);
 
 /* from chips.c */
 
 #define MAX_DATA 5
 
-typedef const char * (*FormatterFN) (const double values[], int alarm, int beep);
+typedef const char *(*FormatterFN) (const double values[], int alarm,
+				     int beep);
 
-typedef const char * (*RRDFN) (const double values[]);
+typedef const char *(*RRDFN) (const double values[]);
 
 typedef enum {
-  DataType_voltage = 0,
-  DataType_rpm,
-  DataType_temperature,
-  DataType_other = -1
+	DataType_voltage = 0,
+	DataType_rpm,
+	DataType_temperature,
+	DataType_other = -1
 } DataType;
 
 typedef struct {
-  FormatterFN format;
-  RRDFN rrd;
-  DataType type;
-  int alarmNumber;
-  int beepNumber;
-  const sensors_feature *feature;
-  int dataNumbers[MAX_DATA + 1];
+	FormatterFN format;
+	RRDFN rrd;
+	DataType type;
+	int alarmNumber;
+	int beepNumber;
+	const sensors_feature *feature;
+	int dataNumbers[MAX_DATA + 1];
 } FeatureDescriptor;
 
 typedef struct {
-  const sensors_chip_name *name;
-  FeatureDescriptor *features;
+	const sensors_chip_name *name;
+	FeatureDescriptor *features;
 } ChipDescriptor;
 
 extern ChipDescriptor * knownChips;
-extern int initKnownChips (void);
-extern void freeKnownChips (void);
+extern int initKnownChips(void);
+extern void freeKnownChips(void);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
