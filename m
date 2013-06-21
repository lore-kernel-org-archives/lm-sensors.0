From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 21 Jun 2013 09:11:58 +0000
Subject: [lm-sensors] [PATCH] libsensors: Better documentation for sensors_init() and sensors_get_adapter_nam
Message-Id: <20130621111158.30360f3c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Extend the documentation of sensors_init() and
sensors_get_adapter_name(). Paul Crawford asked questions about these
as he found the original documentation unclear. I'm including my
answers to his questions here, reformatted, so that other developers
can benefit from them too.
---
Paul, is this OK with you?

 lib/init.c       |    2 ++
 lib/libsensors.3 |   27 +++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

--- lm-sensors.orig/lib/init.c	2010-07-01 13:39:06.000000000 +0200
+++ lm-sensors/lib/init.c	2013-06-21 10:43:18.433261917 +0200
@@ -175,6 +175,8 @@ static int add_config_from_dir(const cha
 	return res;
 }
 
+/* Ideally, initialization and configuraton file loading should be exposed
+   separately, to make it possible to load several configuration files. */
 int sensors_init(FILE *input)
 {
 	int res;
--- lm-sensors.orig/lib/libsensors.3	2010-07-01 13:39:18.000000000 +0200
+++ lm-sensors/lib/libsensors.3	2013-06-21 11:10:00.014441423 +0200
@@ -1,5 +1,5 @@
 .\" Copyright (C) 1998, 1999  Adrian Baugh <adrian.baugh@keble.ox.ac.uk>
-.\" Copyright (C) 2007, 2009  Jean Delvare <khali@linux-fr.org>
+.\" Copyright (C) 2007, 2009, 2013  Jean Delvare <khali@linux-fr.org>
 .\" based on sensors.h, part of libsensors by Frodo Looijaard
 .\" libsensors is distributed under the LGPL
 .\"
@@ -25,7 +25,7 @@
 .\"
 .\" References consulted:
 .\"     libsensors source code
-.TH libsensors 3  "February 2009" "lm-sensors 3" "Linux Programmer's Manual"
+.TH libsensors 3  "June 2013" "lm-sensors 3" "Linux Programmer's Manual"
 
 .SH NAME
 libsensors \- publicly accessible functions provided by the sensors library
@@ -88,8 +88,12 @@ libsensors \- publicly accessible functi
 .B sensors_init()
 loads the configuration file and the detected chips list. If this returns a
 value unequal to zero, you are in trouble; you can not assume anything will
-be initialized properly. If you want to reload the configuration file, call
-sensors_cleanup() below before calling sensors_init() again.
+be initialized properly. If you want to reload the configuration file, or
+load a different configuration file, call sensors_cleanup() below before
+calling sensors_init() again. This means you can't load multiple configuration
+files at once by calling sensors_init() multiple times.
+
+The configuration file format is described in sensors.conf(5).
 
 If FILE is NULL, the default configuration files are used (see the FILES
 section below). Most applications will want to do that.
@@ -117,9 +121,20 @@ not contain wildcard values! Return the
 success (same as snprintf), <0 on error.
 
 .B sensors_get_adapter_name()
-returns the adapter name of a bus number, as used within the
+returns the adapter name of a bus type, number pair, as used within the
 sensors_chip_name structure. If it could not be found, it returns NULL.
 
+Adapters describe how a monitoring chip is hooked up to the system.
+This is particularly relevant for I2C/SMBus sensor chips (bus type "i2c"),
+which must be accessed over an I2C/SMBus controller. Each such controller
+has a different number, assigned by the system at initialization time,
+so that they can be referenced individually.
+
+Super\-I/O or CPU\-embedded sensors, on the other hand, can be accessed
+directly and technically don't use any adapter. They have only a bus type
+but no bus number, and sensors_get_adapter_name() will return a generic
+adapter name for them.
+
 .B sensors_get_detected_chips()
 returns all detected chips that match a given chip name,
 one by one. If no chip name is provided, all detected chips are returned.
@@ -258,6 +273,6 @@ ignored.
 sensors.conf(5)
 
 .SH AUTHOR
-Frodo Looijaard and the lm_sensors group
+Frodo Looijaard, Jean Delvare and others
 http://www.lm-sensors.org/
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
