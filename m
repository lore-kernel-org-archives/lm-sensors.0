From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 09 May 2014 08:28:30 +0000
Subject: [lm-sensors] [PATCH 2/3] libsensors: Add an interface to retrieve the kernel device name of a chip
Message-Id: <20140509102830.2aff3621@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets applications match a kernel class device to a each chip.
---
 lib/access.c       |   16 +++++++++++++++-
 lib/libsensors.3   |   12 ++++++++++--
 lib/libsensors.map |    1 +
 lib/sensors.h      |    5 +++++
 4 files changed, 31 insertions(+), 3 deletions(-)

--- lm-sensors.orig/lib/sensors.h	2014-05-09 07:50:24.468125017 +0200
+++ lm-sensors/lib/sensors.h	2014-05-09 09:28:52.568025245 +0200
@@ -90,6 +90,11 @@ void sensors_free_chip_name(sensors_chip
 int sensors_snprintf_chip_name(char *str, size_t size,
 			       const sensors_chip_name *chip);
 
+/* This returns the kernel class device associated with the given
+   chip name. Only works with kernel 2.6.14 and later. */
+const char *
+sensors_get_kernel_name(const sensors_chip_name *chip);
+
 /* This function returns the adapter name of a bus,
    as used within the sensors_chip_name structure. If it could not be found,
    it returns NULL */
--- lm-sensors.orig/lib/access.c	2014-05-09 07:50:24.468125017 +0200
+++ lm-sensors/lib/access.c	2014-05-09 09:29:43.269061035 +0200
@@ -1,7 +1,7 @@
 /*
     access.c - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
-    Copyright (C) 2007-2010   Jean Delvare <jdelvare@suse.de>
+    Copyright (C) 2007-2014   Jean Delvare <jdelvare@suse.de>
 
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
@@ -559,3 +559,17 @@ int sensors_do_chip_sets(const sensors_c
 	}
 	return res;
 }
+
+/* Would rather live in data.c, but can't be moved there as long as
+   we need to call sensors_lookup_chip */
+const char *
+sensors_get_kernel_name(const sensors_chip_name *chip)
+{
+	const sensors_chip_features *chip_features;
+
+	chip_features = sensors_lookup_chip(chip);
+	if (!chip_features)
+		return NULL;	/* No such chip */
+
+	return chip_features->kernel_name;
+}
--- lm-sensors.orig/lib/libsensors.map	2014-05-09 07:50:24.468125017 +0200
+++ lm-sensors/lib/libsensors.map	2014-05-09 09:10:59.020480133 +0200
@@ -10,6 +10,7 @@ global:
   sensors_get_features;
   sensors_get_label;
   sensors_get_subfeature;
+  sensors_get_kernel_name;
   sensors_get_value;
   sensors_init;
   sensors_parse_chip_name;
--- lm-sensors.orig/lib/libsensors.3	2014-03-20 11:10:13.935746379 +0100
+++ lm-sensors/lib/libsensors.3	2014-05-09 09:30:52.137478625 +0200
@@ -1,5 +1,5 @@
 .\" Copyright (C) 1998, 1999  Adrian Baugh <adrian.baugh@keble.ox.ac.uk>
-.\" Copyright (C) 2007, 2009, 2013  Jean Delvare <jdelvare@suse.de>
+.\" Copyright (C)  2007-2014  Jean Delvare <jdelvare@suse.de>
 .\" based on sensors.h, part of libsensors by Frodo Looijaard
 .\" libsensors is distributed under the LGPL
 .\"
@@ -25,7 +25,7 @@
 .\"
 .\" References consulted:
 .\"     libsensors source code
-.TH libsensors 3  "September 2013" "lm-sensors 3" "Linux Programmer's Manual"
+.TH libsensors 3  "May 2014" "lm-sensors 3" "Linux Programmer's Manual"
 
 .SH NAME
 libsensors \- publicly accessible functions provided by the sensors library
@@ -45,6 +45,7 @@ libsensors \- publicly accessible functi
 .BI "void sensors_free_chip_name(sensors_chip_name *" chip ");"
 .BI "int sensors_snprintf_chip_name(char *" str ", size_t " size ","
 .BI "                               const sensors_chip_name *" chip ");"
+.BI "const char *sensors_get_kernel_name(const sensors_chip_name *" chip ");"
 .BI "const char *sensors_get_adapter_name(const sensors_bus_id *" bus ");"
 
 /* Chips and features enumeration */
@@ -120,6 +121,13 @@ prints a chip name from its internal rep
 not contain wildcard values! Return the number of characters printed on
 success (same as snprintf), <0 on error.
 
+.B sensors_get_kernel_name()
+returns the name of the kernel class device associated with a given chip;
+NULL is returned if no such chip exists.
+
+Note that this only works with kernel 2.6.14 or newer. Older kernels will
+return NULL all the time.
+
 .B sensors_get_adapter_name()
 returns the adapter name of a bus type, number pair, as used within the
 sensors_chip_name structure. If it could not be found, it returns NULL.


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
