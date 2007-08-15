From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 15:48:49 +0000
Subject: [lm-sensors] [PATCH 6/6] libsensors4: Rewrite
Message-Id: <20070815174849.704e05ca@hyperion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Chip types can no longer contain dashes. This makes it possible to
rewrite sensors_parse_chip_name() with a simpler algorithm. The new
code is smaller by about one third, and twice as fast on average
(5 times as fast in the most frequent case "foo-*".)

---
 lib/data.c         |  152 +++++++++++++++++++++++-----------------------------
 lib/sensors.conf.5 |   16 +----
 2 files changed, 74 insertions(+), 94 deletions(-)

--- lm-sensors-3.orig/lib/data.c	2007-08-15 16:21:16.000000000 +0200
+++ lm-sensors-3/lib/data.c	2007-08-15 16:22:03.000000000 +0200
@@ -1,6 +1,7 @@
 /*
     data.c - Part of libsensors, a Linux library for reading sensor data.
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+    Copyright (C) 2007        Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -17,6 +18,9 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+/* this define needed for strndup() */
+#define _GNU_SOURCE
+
 #include <stdlib.h>
 #include <string.h>
 
@@ -46,8 +50,8 @@ int sensors_proc_bus_max = 0;
 
 static int sensors_substitute_chip(sensors_chip_name *name,int lineno);
 
-/* Wow, this must be one of the ugliest functions I have ever written.
-   The idea is that it parses a chip name. These are valid names:
+/*
+   Parse a chip name to the internal representation. These are valid names:
 
      lm78-i2c-10-5e		*-i2c-10-5e
      lm78-i2c-10-*		*-i2c-10-*
@@ -56,103 +60,85 @@ static int sensors_substitute_chip(senso
      lm78-isa-10dd		*-isa-10dd
      lm78-isa-*			*-isa-*
      lm78-*			*-*
-     				*
-   Here 'lm78' can be any prefix. To complicate matters, such a prefix
-   can also contain dashes (like lm78-j, for example!). 'i2c' and 'isa' are
+
+   Here 'lm78' can be any prefix. 'i2c' and 'isa' are
    literal strings, just like all dashes '-' and wildcards '*'. '10' can
    be any decimal i2c bus number. '5e' can be any hexadecimal i2c device
    address, and '10dd' any hexadecimal isa address.
 
-   If '*' is used in prefixes, together with dashes, ambigious parses are
-   introduced. In that case, the prefix is kept as small as possible.
-
    The 'prefix' part in the result is freshly allocated. All old contents
    of res is overwritten. res itself is not allocated. In case of an error
    return (ie. != 0), res is undefined, but all allocations are undone.
-
-   Don't tell me there are bugs in here, because I'll start screaming :-)
 */
 
-int sensors_parse_chip_name(const char *orig_name, sensors_chip_name *res)
+int sensors_parse_chip_name(const char *name, sensors_chip_name *res)
 {
-  char *part2, *part3, *part4;
-  char *name = strdup(orig_name);
-  char *endptr;
+	char *dash;
 
-  if (! name)
-    sensors_fatal_error("sensors_parse_chip_name","Allocating new name");
-  /* First split name in upto four pieces. */
-  if ((part4 = strrchr(name,'-')))
-    *part4++ = '\0';
-  if ((part3 = strrchr(name,'-')))
-    *part3++ = '\0';
-  if ((part2 = strrchr(name,'-'))) 
-    *part2++ = '\0';
-
-  /* No dashes found? */
-  if (! part4) {
-    if (!strcmp(name,"*")) {
-      res->prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
-      res->bus = SENSORS_CHIP_NAME_BUS_ANY;
-      res->addr = SENSORS_CHIP_NAME_ADDR_ANY;
-      goto SUCCES;
-    } else 
-      goto ERROR;
-  }
+	/* First, the prefix. It's either "*" or a real chip name. */
+	if (!strncmp(name, "*-", 2)) {
+		res->prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
+		name += 2;
+	} else {
+		if (!(dash = strchr(name, '-')))
+			return -SENSORS_ERR_CHIP_NAME;
+		res->prefix = strndup(name, dash - name);
+		if (!res->prefix)
+			sensors_fatal_error("sensors_parse_chip_name",
+					    "Allocating name prefix");
+		name = dash + 1;
+	}
 
-  /* At least one dash found. Now part4 is either '*', or an address */
-  if (!strcmp(part4,"*"))
-    res->addr = SENSORS_CHIP_NAME_ADDR_ANY;
-  else {
-    res->addr = strtoul(part4, &endptr, 16);
-    if (*part4 = '\0' || *endptr != '\0' || res->addr < 0)
-      goto ERROR;
-  }
+	/* Then we have either a sole "*" (all chips with this name) or a bus
+	   type and an address. */
+	if (!strcmp(name, "*")) {
+		res->bus = SENSORS_CHIP_NAME_BUS_ANY;
+		res->addr = SENSORS_CHIP_NAME_ADDR_ANY;
+		return 0;
+	}
 
-  /* OK. So let's look at part3. It must either be the number of the
-     i2c bus (and then part2 *must* be "i2c"), or it must be "isa",
-     or, if part4 was "*", it belongs to 'prefix'. Or no second dash
-     was found at all, of course. */
-  if (! part3) {
-    if (res->addr = SENSORS_CHIP_NAME_ADDR_ANY) {
-      res->bus = SENSORS_CHIP_NAME_BUS_ANY;
-    } else
-      goto ERROR;
-  } else if (!strcmp(part3,"isa")) {
-    res->bus = SENSORS_CHIP_NAME_BUS_ISA;
-    if (part2)
-      *(part2-1) = '-';
-  } else if (!strcmp(part3,"pci")) {
-    res->bus = SENSORS_CHIP_NAME_BUS_PCI;
-    if (part2)
-      *(part2-1) = '-';
-  } else if (part2 && !strcmp(part2,"i2c") && !strcmp(part3,"*"))
-    res->bus = SENSORS_CHIP_NAME_BUS_ANY_I2C;
-  else if (part2 && !strcmp(part2,"i2c")) {
-    res->bus = strtoul(part3, &endptr, 10);
-    if (*part3 = '\0' || *endptr != '\0' || res->bus < 0)
-      goto ERROR;
-  } else if (res->addr = SENSORS_CHIP_NAME_ADDR_ANY) {
-    res->bus = SENSORS_CHIP_NAME_BUS_ANY;
-    if (part2)
-      *(part2-1) = '-';
-    *(part3-1) = '-';
-  } else
-    goto ERROR;
-    
-  if (!strcmp(name,"*"))
-    res->prefix = SENSORS_CHIP_NAME_PREFIX_ANY;
-  else if (! (res->prefix = strdup(name)))
-    sensors_fatal_error("sensors_parse_chip_name","Allocating new name");
-  goto SUCCES;
+	if (!(dash = strchr(name, '-')))
+		goto ERROR;
+	if (!strncmp(name, "i2c", dash - name))
+		res->bus = SENSORS_CHIP_NAME_BUS_ANY_I2C;
+	else if (!strncmp(name, "isa", dash - name))
+		res->bus = SENSORS_CHIP_NAME_BUS_ISA;
+	else if (!strncmp(name, "pci", dash - name))
+		res->bus = SENSORS_CHIP_NAME_BUS_PCI;
+	else
+		goto ERROR;
+	name = dash + 1;
+
+	/* Some bus types (i2c) have an additional bus number. For these, the
+	   next part is either a "*" (any bus of that type) or a decimal
+	   number. */
+	switch (res->bus) {
+	case SENSORS_CHIP_NAME_BUS_ANY_I2C:
+		if (!strncmp(name, "*-", 2)) {
+			name += 2;
+			break;
+		}
+
+		res->bus = strtoul(name, &dash, 10);
+		if (*name = '\0' || *dash != '-' || res->bus < 0)
+			goto ERROR;
+		name = dash + 1;
+	}
 
-SUCCES:
-  free(name);
-  return 0;
+	/* Last part is the chip address, or "*" for any address. */
+	if (!strcmp(name, "*")) {
+		res->addr = SENSORS_CHIP_NAME_ADDR_ANY;
+	} else {
+		res->addr = strtoul(name, &dash, 16);
+		if (*name = '\0' || *dash != '\0' || res->addr < 0)
+			goto ERROR;
+	}
+
+	return 0;
 
 ERROR:
-  free(name);
-  return -SENSORS_ERR_CHIP_NAME;
+	free(res->prefix);
+	return -SENSORS_ERR_CHIP_NAME;
 }
 
 int sensors_snprintf_chip_name(char *str, size_t size,
--- lm-sensors-3.orig/lib/sensors.conf.5	2007-06-25 16:12:05.000000000 +0200
+++ lm-sensors-3/lib/sensors.conf.5	2007-08-15 16:52:05.000000000 +0200
@@ -186,9 +186,7 @@ statement is ignored upto the next
 statement.
 
 A chip description is built from a couple of elements, separated by
-dashes. To complicate matters, sometimes an element can also contain
-dashes. This complicates the parsing algorithm, but is not too confusing
-for humans (we hope!).
+dashes.
 
 The first element is the name of the chip type. Sometimes a single driver
 implements several chip types, with several names. The driver documentation
@@ -216,10 +214,10 @@ the wildcard operator
 .I *
 for this element. 
 
-There are some folding rules for wildcards to make things easier for humans
-to read. Also, you can't specify the address if you wildcard the complete
-second element. The following are all valid chip type specification based
-on 
+Note that it wouldn't make any sense to specify the address without the
+bus type. For this reason, the address part is plain omitted when the bus
+type isn't specified.
+The following are all valid chip type specification based on
 .I lm78\-i2c\-1\-2d
 or
 .IR lm78\-isa\-0290 :
@@ -250,10 +248,6 @@ lm78\-*       
 *\-isa\-0290
 .sp 0
 *\-isa\-*
-.sp 0
-*\-*
-.sp 0
-*
 .RE
 
 .SS COMPUTE STATEMENT


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
