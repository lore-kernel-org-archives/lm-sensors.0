From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Apr 2011 20:56:40 +0000
Subject: [lm-sensors] [PATCH v2 2/2] isaset: Add support for word (16-bit)
Message-Id: <20110412225640.0d385e8b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sometimes the hardware expects 16-bit or 32-bit writes rather than byte
writes. Add support to isaset so that the user can ask for such writes.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 prog/dump/isaset.8 |   13 +++++++--
 prog/dump/isaset.c |   75 ++++++++++++++++++++++++++++------------------------
 prog/dump/util.c   |   15 ++++++++++
 prog/dump/util.h   |    1 
 4 files changed, 68 insertions(+), 36 deletions(-)

--- lm-sensors.orig/prog/dump/isaset.8	2011-04-12 18:54:42.000000000 +0200
+++ lm-sensors/prog/dump/isaset.8	2011-04-12 18:57:41.000000000 +0200
@@ -1,10 +1,11 @@
-.TH ISASET 8 "May 2005"
+.TH ISASET 8 "April 2011"
 .SH "NAME"
 isaset \- set ISA registers
 
 .SH SYNOPSIS
 .B isaset
 .RB [ -y ]
+.RB [ -W | -L ]
 .I addrreg
 .I datareg
 .I address
@@ -13,8 +14,10 @@ isaset \- set ISA registers
 #for I2C-like access
 .br
 .B isaset
+.B -f
 .RB [ -y ]
-.BI "-f " address
+.RB [ -W | -L ]
+.I address
 .I value
 .RI [ mask ]
 #for flat address space
@@ -33,6 +36,12 @@ Disable interactive mode. By default, is
 from the user before messing with the ISA bus. When this flag is used, it
 will perform the operation directly. This is mainly meant to be used in
 scripts.
+.TP
+.B -W
+Perform a 16-bit write.
+.TP
+.B -L
+Perform a 32-bit write.
 
 .SH OPTIONS (I2C-like access mode)
 Four options must be provided to isaset. \fIaddrreg\fR contains the
--- lm-sensors.orig/prog/dump/isaset.c	2011-04-12 18:54:42.000000000 +0200
+++ lm-sensors/prog/dump/isaset.c	2011-04-12 19:50:04.000000000 +0200
@@ -2,7 +2,7 @@
     isaset.c - isaset, a user-space program to write ISA registers
     Copyright (C) 2000  Frodo Looijaard <frodol@dds.nl>, and
                         Mark D. Studebaker <mdsxyz123@yahoo.com>
-    Copyright (C) 2004,2007  Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2004-2011  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -48,17 +48,22 @@ static void help(void)
 {
 	fprintf(stderr,
 	        "Syntax for I2C-like access:\n"
-	        "  isaset [-y] ADDRREG DATAREG ADDRESS VALUE [MASK]\n"
+	        "  isaset [OPTIONS] ADDRREG DATAREG ADDRESS VALUE [MASK]\n"
 	        "Syntax for flat address space:\n"
-	        "  isaset [-y] -f ADDRESS VALUE [MASK]\n");
+	        "  isaset -f [OPTIONS] ADDRESS VALUE [MASK]\n"
+		"Options:\n"
+		"  -f	Enable flat address space mode\n"
+		"  -y	Assume affirmative answer to all questions\n"
+		"  -W	Write a word (16-bit) value\n"
+		"  -L	Write a long (32-bit) value\n");
 }
 
 int main(int argc, char *argv[])
 {
-	int addrreg, datareg = 0, value, addr = 0, vmask = 0;
-	unsigned char res;
+	int addrreg, datareg = 0, addr = 0;
+	unsigned long value, vmask = 0, maxval = 0xff, res;
 	int flags = 0;
-	int flat = 0, yes = 0;
+	int flat = 0, yes = 0, width = 1;
 	char *end;
 
 	/* handle (optional) flags first */
@@ -66,6 +71,8 @@ int main(int argc, char *argv[])
 		switch (argv[1+flags][1]) {
 		case 'f': flat = 1; break;
 		case 'y': yes = 1; break;
+		case 'W': width = 2; maxval = 0xffff; break;
+		case 'L': width = 4; maxval = 0xffffffff; break;
 		default:
 			fprintf(stderr, "Warning: Unsupported flag "
 				"\"-%c\"!\n", argv[1+flags][1]);
@@ -128,29 +135,30 @@ int main(int argc, char *argv[])
 	if (!flat)
 		flags += 2;
 
-	value = strtol(argv[flags+2], &end, 0);
+	value = strtoul(argv[flags+2], &end, 0);
 	if (*end) {
 		fprintf(stderr, "Error: Invalid value!\n");
 		help();
 		exit(1);
 	}
-	if (value < 0 || value > 0xff) {
+	if (value > maxval) {
 		fprintf(stderr, "Error: Value out of range "
-			"(0x00-0xff)!\n");
+			"(0x%0*u-%0*lu)!\n", width * 2, 0, width * 2, maxval);
 		help();
 		exit(1);
 	}
 
 	if (flags+3 < argc) {
-		vmask = strtol(argv[flags+3], &end, 0);
+		vmask = strtoul(argv[flags+3], &end, 0);
 		if (*end) {
 			fprintf(stderr, "Error: Invalid mask!\n");
 			help();
 			exit(1);
 		}
-		if (vmask < 0 || vmask > 0xff) {
+		if (vmask > maxval) {
 			fprintf(stderr, "Error: Mask out of range "
-				"(0x00-0xff)!\n");
+				"(0x%0*u-%0*lu)!\n", width * 2, 0,
+				width * 2, maxval);
 			help();
 			exit(1);
 		}
@@ -167,13 +175,15 @@ int main(int argc, char *argv[])
 		        "system crashes, data loss and worse!\n");
 
 		if (flat)
-			fprintf(stderr, "I will write value 0x%02x%s to address "
-		                "0x%x.\n", value, vmask ? " (masked)" : "",
-			        addrreg);
+			fprintf(stderr,
+				"I will write value 0x%0*lx%s to address "
+		                "0x%x.\n", width * 2, value,
+				vmask ? " (masked)" : "", addrreg);
 		else
-			fprintf(stderr, "I will write value 0x%02x%s to address "
+			fprintf(stderr,
+				"I will write value 0x%0*lx%s to address "
 		                "0x%02x of chip with address register 0x%x\n"
-		                "and data register 0x%x.\n",
+		                "and data register 0x%x.\n", width * 2,
 		                value, vmask ? " (masked)" : "", addr,
 			        addrreg, datareg);
 
@@ -206,26 +216,22 @@ int main(int argc, char *argv[])
 #endif
 
 	if (vmask) {
-		int oldvalue;
+		unsigned long oldvalue;
 
 		if (flat) {
-			oldvalue = inb(addrreg);
+			oldvalue = inx(addrreg, width);
 		} else {	
 			outb(addr, addrreg);
-			oldvalue = inb(datareg);
-		}
-
-		if (oldvalue < 0) {
-			fprintf(stderr, "Error: Failed to read old value\n");
-			exit(1);
+			oldvalue = inx(datareg, width);
 		}
 
 		value = (value & vmask) | (oldvalue & ~vmask);
 
 		if (!yes) {
-			fprintf(stderr, "Old value 0x%02x, write mask "
-				"0x%02x: Will write 0x%02x to %s "
-				"0x%02x\n", oldvalue, vmask, value,
+			fprintf(stderr, "Old value 0x%0*lx, write mask "
+				"0x%0*lx: Will write 0x%0*lx to %s "
+				"0x%02x\n", width * 2, oldvalue,
+				width * 2, vmask, width * 2, value,
 				flat ? "address" : "register",
 				flat ? addrreg : addr);
 
@@ -241,20 +247,21 @@ int main(int argc, char *argv[])
 	/* do the real thing */
 	if (flat) {
 		/* write */
-		outb(value, addrreg);
+		outx(value, addrreg, width);
 		/* readback */
-		res = inb(addrreg);
+		res = inx(addrreg, width);
 	} else {	
 		/* write */
 		outb(addr, addrreg);
-		outb(value, datareg);
+		outx(value, datareg, width);
 		/* readback */
-		res = inb(datareg);
+		res = inx(datareg, width);
 	}
 
 	if (res != value) {
-		fprintf(stderr, "Data mismatch, wrote 0x%02x, "
-		        "read 0x%02x back.\n", value, res);
+		fprintf(stderr, "Data mismatch, wrote 0x%0*lx, "
+		        "read 0x%0*lx back.\n", width * 2, value,
+			width * 2, res);
 	}
 
 	exit(0);
--- lm-sensors.orig/prog/dump/util.c	2011-04-12 18:57:09.000000000 +0200
+++ lm-sensors/prog/dump/util.c	2011-04-12 19:02:28.000000000 +0200
@@ -67,3 +67,18 @@ unsigned long inx(int addr, int width)
 		return inb(addr);
 	}
 }
+
+/* I/O write of specified size */
+void outx(unsigned long value, int addr, int width)
+{
+	switch (width) {
+	case 2:
+		outw(value, addr);
+		break;
+	case 4:
+		outl(value, addr);
+		break;
+	default:
+		outb(value, addr);
+	}
+}
--- lm-sensors.orig/prog/dump/util.h	2011-04-12 18:56:00.000000000 +0200
+++ lm-sensors/prog/dump/util.h	2011-04-12 18:58:36.000000000 +0200
@@ -13,5 +13,6 @@
 
 extern int user_ack(int def);
 extern unsigned long inx(int addr, int width);
+extern void outx(unsigned long value, int addr, int width);
 
 #endif /* _UTIL_H */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
