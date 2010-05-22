From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 22 May 2010 11:53:50 +0000
Subject: Re: [lm-sensors] [PATCH 0/2 v2] hwmon: (ltc4245) fix GPIO support
Message-Id: <20100522135350.6ead92f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1271199569-3880-1-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1271199569-3880-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Fri, 21 May 2010 08:02:27 -0700, Ira W. Snyder wrote:
> On Fri, May 21, 2010 at 11:04:52AM +0200, Jean Delvare wrote:
> > I still think the current error handling is less than ideal. If it
> > becomes common that hwmon drivers return errors, I'd prefer them to
> > look nice in the output of "sensors". Something like:
> > 
> > Dig 3.30v Output: +3.26 V
> > Dig 2.25v Output:     N/A
> > Dig 1.80v Output:     N/A
> > 
> > Hopefully this wouldn't be too hard to implement. What do you think?
> > 
> > We might have to invent new libsensors error codes to differentiate
> > between error cases, or give callers a way to retrieve the original
> > error code.
> 
> I agree, that would be nice. That's a libsensors patch, not a kernel
> patch though.

A more immediate action would actually be a sensors patch. I get the
following output for my thinkpad with the attached patch applied:

thinkpad-isa-0000
Adapter: ISA adapter
fan1:       3430 RPM
temp1:       +62.0°C                                    
temp2:       +46.0°C                                    
temp3:       +44.0°C                                    
temp4:       +75.0°C                                    
temp5:       +50.0°C                                    
temp6:           N/A                                    
temp7:       +37.0°C                                    
temp8:           N/A                                    
temp9:       +48.0°C                                    
temp10:      +58.0°C                                    
temp11:      +58.0°C                                    
temp12:          N/A                                    
temp13:          N/A                                    
temp14:          N/A                                    
temp15:          N/A                                    
temp16:          N/A                                    

Would this be OK with you?

---
 prog/sensors/chips.c |   42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

--- lm-sensors.orig/prog/sensors/chips.c	2010-05-21 17:38:36.000000000 +0200
+++ lm-sensors/prog/sensors/chips.c	2010-05-21 17:49:22.000000000 +0200
@@ -91,6 +91,21 @@ static double get_value(const sensors_ch
 	return val;
 }
 
+/* A variant for input values, where we want to handle errors gracefully */
+static int get_input_value(const sensors_chip_name *name,
+			   const sensors_subfeature *sub,
+			   double *val)
+{
+	int err;
+
+	err = sensors_get_value(name, sub->number, val);
+	if (err && err != -SENSORS_ERR_ACCESS_R) {
+		fprintf(stderr, "ERROR: Can't get value of subfeature %s: %s\n",
+			sub->name, sensors_strerror(err));
+	}
+	return err;
+}
+
 static int get_label_size(const sensors_chip_name *name)
 {
 	int i;
@@ -230,8 +245,8 @@ static void print_chip_temp(const sensor
 	} else {
 		sf = sensors_get_subfeature(name, feature,
 					    SENSORS_SUBFEATURE_TEMP_INPUT);
-		if (sf) {
-			val = get_value(name, sf);
+		if (sf && get_input_value(name, sf, &val) = 0) {
+			get_input_value(name, sf, &val);
 			if (fahrenheit)
 				val = deg_ctof(val);
 			printf("%+6.1f%s  ", val, degstr);
@@ -289,7 +304,7 @@ static void print_chip_in(const sensors_
 			  int label_size)
 {
 	const sensors_subfeature *sf, *sfmin, *sfmax;
-	double alarm_max, alarm_min;
+	double val, alarm_max, alarm_min;
 	char *label;
 
 	if (!(label = sensors_get_label(name, feature))) {
@@ -302,8 +317,8 @@ static void print_chip_in(const sensors_
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_IN_INPUT);
-	if (sf)
-		printf("%+6.2f V", get_value(name, sf));
+	if (sf && get_input_value(name, sf, &val) = 0)
+		printf("%+6.2f V", val);
 	else
 		printf("     N/A");
 
@@ -355,6 +370,7 @@ static void print_chip_fan(const sensors
 			   int label_size)
 {
 	const sensors_subfeature *sf, *sfmin, *sfdiv;
+	double val;
 	char *label;
 
 	if (!(label = sensors_get_label(name, feature))) {
@@ -372,8 +388,8 @@ static void print_chip_fan(const sensors
 	else {
 		sf = sensors_get_subfeature(name, feature,
 					    SENSORS_SUBFEATURE_FAN_INPUT);
-		if (sf)
-			printf("%4.0f RPM", get_value(name, sf));
+		if (sf && get_input_value(name, sf, &val) = 0)
+			printf("%4.0f RPM", val);
 		else
 			printf("     N/A");
 	}
@@ -471,8 +487,7 @@ static void print_chip_power(const senso
 					       SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL);
 	}
 
-	if (sf) {
-		val = get_value(name, sf);
+	if (sf && get_input_value(name, sf, &val) = 0) {
 		scale_value(&val, &unit);
 		printf("%6.2f %sW", val, unit);
 	} else
@@ -526,8 +541,7 @@ static void print_chip_energy(const sens
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_ENERGY_INPUT);
-	if (sf) {
-		val = get_value(name, sf);
+	if (sf && get_input_value(name, sf, &val) = 0) {
 		scale_value(&val, &unit);
 		printf("%6.2f %sJ", val, unit);
 	} else
@@ -583,7 +597,7 @@ static void print_chip_curr(const sensor
 			    int label_size)
 {
 	const sensors_subfeature *sf, *sfmin, *sfmax;
-	double alarm_max, alarm_min;
+	double alarm_max, alarm_min, val;
 	char *label;
 
 	if (!(label = sensors_get_label(name, feature))) {
@@ -596,8 +610,8 @@ static void print_chip_curr(const sensor
 
 	sf = sensors_get_subfeature(name, feature,
 				    SENSORS_SUBFEATURE_CURR_INPUT);
-	if (sf)
-		printf("%+6.2f A", get_value(name, sf));
+	if (sf && get_input_value(name, sf, &val) = 0)
+		printf("%+6.2f A", val);
 	else
 		printf("     N/A");
 



-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
