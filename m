From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 19 Dec 2006 13:11:01 +0000
Subject: [lm-sensors] generic chip support for sensors
Message-Id: <20061219131101.GB5240@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
In-Reply-To: <20061210000539.1f2f2bbd@ws01.atreidis.nl.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bob:

* Bob Schl?rmann <bob2 at dsv.nl> [2006-12-10 00:05:39 +0100]:
> These patches add generic chip support to sensors. It also adds a
> function to libsensors that returns the current feature type based on
> its name.
> 
> Although we are not finished yet, it should work for most chips except
> for alarms.
> 
> More info and a copy of the patches can be found at: 
> http://www.atreidis.nl.eu.org/lm_sensors/
> 
> If the new output of sensors is not what it should be, please let us
> know.

I finally had some time to start reviewing these patches (during a long car
ride actually).  Starting with the libsensors patch... the new function is a
nice addition to the API.

diff -ux '*~' /usr/src/lm-sensors/lib/access.c lib/access.c
--- /usr/src/lm-sensors/lib/access.c	2006-11-27 16:50:43.000000000 +0100
+++ lib/access.c	2006-12-07 14:47:29.000000000 +0100
@@ -495,3 +495,67 @@
 	};
 	return sensors_do_chip_sets(name);
 }
+
+/* Return the feature type based on the feature name */
+sensors_feature_type sensors_feature_get_type(
+	const sensors_feature_data *feature)
+{
+	const char *name;	
+	
+	/* this will only work when the sensors_chip_feature is obtained through 
+		sensors_get_all_features */
+	if (((const struct sensors_chip_feature *)feature)->sysname)
+		name = ((const struct sensors_chip_feature *)feature)->sysname;
+	else
+		name = feature->name;

That cast in the if statement is no good.  I completely understand why you
tried to do it that way... the existing libsensors code casts from one struct
type to the other before returning it to the user.  The last time I noticed
that, I made a note to myself to fix it because it's very fragile.  

Here's what we should be doing:

--- data.h	(revision 4253)
+++ data.h	(working copy)
@@ -150,11 +150,7 @@
      Scaling can be positive or negative but negative values aren't
      very useful because the driver can scale that direction itself. */
 typedef struct sensors_chip_feature {
-  int number;
-  const char *name;
-  int logical_mapping;
-  int compute_mapping;
-  int mode;
+  sensors_feature_data data;
   int sysctl;
   int offset;
   int scaling;

Of course, a lot of other code will need to be fixed up to accomodate that
change.  Would you mind doing this in a separate patch?  Otherwise I'll do it.

OK, back to the cast in your patch above.  Once you have one structure as a
proper member of the other, you can use something like the container_of
mechanism from the Linux kernel source (include/linux/kernel.h).

+	
+	if (strstr(name, "temp")) {

I would prefer (!strncmp(name, "temp", 4))

+		if (strlen(name) = 5)
+			return SENSORS_FEATURE_TEMP;
+		

That test will fail to recognize temp10.  I'm not sure we have any chip with
more than 9 temp sensors, but we should be able to handle it if we did.  How
about something like (!strchr(name+5, '_')) ?

In fact, given the code below... you could do something like this for the sake
of efficiency:

		if (name = strchr(name + 5, '_'))
			return SENSORS_FEATURE_TEMP;

+		if (strstr(name, "hyst"))
+			return SENSORS_FEATURE_TEMP_HYST;

And then the above would become:

		if (!strncmp(name + 1, "hyst", 4))

etc.

However... maybe you would be better off just using regular expressions to do
all this pattern matching.  It certainly would be easier to read and maintain.
Plus, there are other places in libsensors that would benefit from regex.  Try
'man 3 regcomp'.

+		
+		if (strstr(name, "over"))
+			return SENSORS_FEATURE_TEMP_OVER;
+		
+		if (strstr(name, "max"))
+			return SENSORS_FEATURE_TEMP_MAX;
+		
+		if (strstr(name, "min"))
+			return SENSORS_FEATURE_TEMP_MIN;
+		
+		if (strstr(name, "low"))
+			return SENSORS_FEATURE_TEMP_LOW;
+		
+		if (strstr(name, "crit"))
+			return SENSORS_FEATURE_TEMP_CRIT;

I like to put a blank line here... it's easier on my eyes.

+	} else if (strstr(name, "in") && name[0] != 'f') {

Again, I would rather see strncmp() there.

+		if (strlen(name) = 3 || strstr(name, "input"))
+			return SENSORS_FEATURE_IN;
+		

Same comments as above, etc.

+		if (strstr(name, "max"))
+			return SENSORS_FEATURE_IN_MAX;
+		
+		if (strstr(name, "min"))
+			return SENSORS_FEATURE_IN_MIN;
+		
+		if (strstr(name, "alarm"))
+			return SENSORS_FEATURE_IN_ALARM;
+	} else if (strstr(name, "fan")) {
+		if (strlen(name) = 4)
+			return SENSORS_FEATURE_FAN;
+		
+		if (strstr(name, "min"))
+			return SENSORS_FEATURE_FAN_MIN;
+		
+		if (strstr(name, "div"))
+			return SENSORS_FEATURE_FAN_DIV;
+	} else if (!strcmp(name, "vrm")) {
+		return SENSORS_FEATURE_VRM;
+	} else if (strstr(name, "vid")) {
+		return SENSORS_FEATURE_VID;
+	}
+	
+	return SENSORS_FEATURE_UNKNOWN;
+}
diff -ux '*~' /usr/src/lm-sensors/lib/sensors.h lib/sensors.h
--- /usr/src/lm-sensors/lib/sensors.h	2006-11-27 16:50:43.000000000 +0100
+++ lib/sensors.h	2006-12-09 22:48:06.407882776 +0100
@@ -146,6 +146,38 @@
 extern const sensors_feature_data *sensors_get_all_features 
              (sensors_chip_name name, int *nr1,int *nr2);
 
+typedef enum sensors_feature_type {
+  SENSORS_FEATURE_TEMP = 0,
+  SENSORS_FEATURE_TEMP_ALARM,
+  SENSORS_FEATURE_TEMP_HYST,
+  SENSORS_FEATURE_TEMP_OVER,
+  SENSORS_FEATURE_TEMP_MAX,
+  SENSORS_FEATURE_TEMP_MIN,
+  SENSORS_FEATURE_TEMP_HIGH,
+  SENSORS_FEATURE_TEMP_LOW,
+  SENSORS_FEATURE_TEMP_LIM,
+  SENSORS_FEATURE_TEMP_CRIT,
+  
+  SENSORS_FEATURE_IN,

I would do SENSORS_FEATURE_IN = 0x100 here and likewise at the beginning of the
other groups.  These constants become part of the binary interface of the
library, and therefore set in stone.  Leaving some space between the groups
allows for expansion.  We should also make a note in the man page that the user
of this API must treat any return value that it doesn't understand as UNKNOWN.
That will allow the library to be upgraded without breaking the application.

+  SENSORS_FEATURE_IN_ALARM,
+  SENSORS_FEATURE_IN_MIN,
+  SENSORS_FEATURE_IN_MAX,
+  SENSORS_FEATURE_IN_MIN_ALARM,
+  SENSORS_FEATURE_IN_MAX_ALARM,
+  
+  SENSORS_FEATURE_FAN,
+  SENSORS_FEATURE_FAN_ALARM,
+  SENSORS_FEATURE_FAN_MIN,
+  SENSORS_FEATURE_FAN_DIV,
+  
+  SENSORS_FEATURE_VID,
+  SENSORS_FEATURE_VRM,
+  
+  SENSORS_FEATURE_UNKNOWN
+} sensors_feature_type;
+

I've never been too comfortable exposing an enum as part of a binary interface.
Take a look at the option -fshort-enums in the GCC man page to see why.  One
solution is to just use #defines, but that's not as nice for symbolic debug.

Another trick would be SENSORS_FEATURE_UNKNOWN = INT_MAX.  Then GCC will be
forced to use int for this enum even with -fshort-enums.  And it's not a bad
idea to use this value for UNKNOWN anyway.

+sensors_feature_type sensors_feature_get_type(
+  const sensors_feature_data *feature);
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */

I'll review the other two patches as I have time.  Thanks for your work!

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


