From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: [PATCH 2.6] I2C sysfs interface documentation
Message-Id: <20031116203250.4bce6b7e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > --- linux-2.6.0-test9/Documentation/i2c/sysfs-interface
> > +++ linux-2.6.0-test9/Documentation/i2c/sysfs-interface.lm83
> 
> Should I still apply this patch?

Actually, no, don't apply it. The new patch to sysfs-interface (below)
includes it. I did it that way because both sets of changes modify a
common part of the file and the second patch might have been rejected
because of that.

Summary of what the patch does:
1* No more current hysteresis value. I don't think we ever saw a chip
   which monitors current, and if we ever do, I would be very, very
   surprised if it would have an hysteresis value.
2* Temperature input and max can have 4 values. [from the previous
   patch]
3* Split temperature min and hysteresis into two separate files.
4* New file temp_crit. [from previous patch]

The new file temp_crit is subject to change later as we decide more
precisely how we want to handle values that are common to more than one
temperature channels.

A patch to chipset drivers follows.

--- linux-2.6.0-test9/Documentation/i2c/sysfs-interface.orig	Sun Nov 16 19:51:12 2003
+++ linux-2.6.0-test9/Documentation/i2c/sysfs-interface	Sun Nov 16 19:57:41 2003
@@ -68,9 +68,7 @@
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read/Write.
 
-curr_min[1-n]	Current min or hysteresis value.
-		Preferably a hysteresis value, reported as a absolute
-		current, NOT a delta from the max value.
+curr_min[1-n]	Current min value.
 		Fixed point XXXXX, divide by 1000 to get Amps.
 		Read/Write.
 
@@ -144,25 +142,38 @@
 		Integers 1,2,3, or thermistor Beta value (3435)
 		Read/Write.
 
-temp_max[1-3]	Temperature max value.
+temp_max[1-4]	Temperature max value.
 		Fixed point value in form XXXXX and should be divided by
 		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp_min[1-3]	Temperature min or hysteresis value.
+temp_min[1-3]	Temperature min value.
 		Fixed point value in form XXXXX and should be divided by
-		1000 to get degrees Celsius.  This is preferably a
-		hysteresis value, reported as a absolute temperature,
-		NOT a delta from the max value.
+		1000 to get degrees Celsius.
 		Read/Write value.
 
-temp_input[1-3] Temperature input value.
+temp_hyst[1-3]	Temperature hysteresis value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.  Must be reported as an
+		absolute temperature, NOT a delta from the max value.
+		Read/Write value.
+
+temp_input[1-4] Temperature input value.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
 		Read only value.
 
+temp_crit	Temperature critical value, typically greater than all
+		temp_max values.
+		Fixed point value in form XXXXX and should be divided by
+		1000 to get degrees Celsius.
+		Common to all temperature channels.
+		Read/Write value.
+
 		If there are multiple temperature sensors, temp_*1 is
 		generally the sensor inside the chip itself, generally
-		reported as "motherboard temperature".  temp_*2 and
-		temp_*3 are generally sensors external to the chip
+		reported as "motherboard temperature".  temp_*2 to
+		temp_*4 are generally sensors external to the chip
 		itself, for example the thermal diode inside the CPU or
 		a thermistor nearby.
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
