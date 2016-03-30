From: Maxime Jayat <jayatmaxime@gmail.com>
Date: Wed, 30 Mar 2016 14:03:41 +0000
Subject: [lm-sensors] ncpXXxh103 compensation values?
Message-Id: <56FBDCBD.7080802@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joseph McNally <jmcna06@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hello Joseph,

You recently added support for the ncpXXxh103 in 
drivers/hwmon/ntc_thermistor.c with the following array of values:

+static const struct ntc_compensation ncpXXxh103[] = { 
+	{ .temp_c	= -40, .ohm	= 247565 }, 
+	{ .temp_c	= -35, .ohm	= 181742 }, 
+	{ .temp_c	= -30, .ohm	= 135128 }, 
+	{ .temp_c	= -25, .ohm	= 101678 }, 
+	{ .temp_c	= -20, .ohm	= 77373 }, 
+	{ .temp_c	= -15, .ohm	= 59504 }, 
+	{ .temp_c	= -10, .ohm	= 46222 }, 
+	{ .temp_c	= -5, .ohm	= 36244 }, 
+	{ .temp_c	= 0, .ohm	= 28674 }, 
+	{ .temp_c	= 5, .ohm	= 22878 }, 
+	{ .temp_c	= 10, .ohm	= 18399 }, 
+	{ .temp_c	= 15, .ohm	= 14910 }, 
+	{ .temp_c	= 20, .ohm	= 12169 }, 
+	{ .temp_c	= 25, .ohm	= 10000 }, 
+	{ .temp_c	= 30, .ohm	= 8271 }, 
+	{ .temp_c	= 35, .ohm	= 6883 }, 
+	{ .temp_c	= 40, .ohm	= 5762 }, 
+	{ .temp_c	= 45, .ohm	= 4851 }, 
+	{ .temp_c	= 50, .ohm	= 4105 }, 
+	{ .temp_c	= 55, .ohm	= 3492 }, 
+	{ .temp_c	= 60, .ohm	= 2985 }, 
+	{ .temp_c	= 65, .ohm	= 2563 }, 
+	{ .temp_c	= 70, .ohm	= 2211 }, 
+	{ .temp_c	= 75, .ohm	= 1915 }, 
+	{ .temp_c	= 80, .ohm	= 1666 }, 
+	{ .temp_c	= 85, .ohm	= 1454 }, 
+	{ .temp_c	= 90, .ohm	= 1275 }, 
+	{ .temp_c	= 95, .ohm	= 1121 }, 
+	{ .temp_c	= 100, .ohm	= 990 }, 
+	{ .temp_c	= 105, .ohm	= 876 }, 
+	{ .temp_c	= 110, .ohm	= 779 }, 
+	{ .temp_c	= 115, .ohm	= 694 }, 
+	{ .temp_c	= 120, .ohm	= 620 }, 
+	{ .temp_c	= 125, .ohm	= 556 }, 
+}; 
+ 

Where are these taken from? 
Unlike the other thermistors in the file, these values don't seem to
match anything in the Murata NTC Thermistor Datasheet.
See:
http://www.murata.com/~/media/webrenewal/support/library/catalog/products/thermistor/ntc/r44e.ashx

-- 
Maxime Jayat

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
