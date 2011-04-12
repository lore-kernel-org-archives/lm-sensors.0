From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Apr 2011 15:52:21 +0000
Subject: [lm-sensors] [PATCH] isadump: Add support for word (16-bit) and
Message-Id: <20110412175221.15a4d92e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sometimes the hardware expects 16-bit or 32-bit reads rather than byte
reads. Add support to isadump so that the user can ask for such reads.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 prog/dump/isadump.8 |   13 +++++++++++--
 prog/dump/isadump.c |   50 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 14 deletions(-)

--- lm-sensors.orig/prog/dump/isadump.c	2009-04-19 09:08:14.000000000 +0200
+++ lm-sensors/prog/dump/isadump.c	2011-04-12 17:51:02.000000000 +0200
@@ -2,7 +2,7 @@
     isadump.c - isadump, a user-space program to dump ISA registers
     Copyright (C) 2000  Frodo Looijaard <frodol@dds.nl>, and
                         Mark D. Studebaker <mdsxyz123@yahoo.com>
-    Copyright (C) 2004,2007  Jean Delvare <khali@linux-fr.org>
+    Copyright (C) 2004-2011  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -52,9 +52,15 @@ static void help(void)
 {
 	fprintf(stderr,
 	        "Syntax for I2C-like access:\n"
-	        "  isadump [-y] [-k V1,V2...] ADDRREG DATAREG [BANK [BANKREG]]\n"
+	        "  isadump [OPTIONS] [-k V1,V2...] ADDRREG DATAREG [BANK [BANKREG]]\n"
 	        "Syntax for flat address space:\n"
-	        "  isadump [-y] -f ADDRESS [RANGE [BANK [BANKREG]]]\n");
+	        "  isadump -f [OPTIONS] ADDRESS [RANGE [BANK [BANKREG]]]\n"
+		"Options:\n"
+		"  -k	Super-I/O configuration access key\n"
+		"  -f	Enable flat address space mode\n"
+		"  -y	Assume affirmative answer to all questions\n"
+		"  -W	Read and display word (16-bit) values\n"
+		"  -L	Read and display long (32-bit) values\n");
 }
 
 static int default_bankreg(int flat, int addrreg, int datareg)
@@ -88,6 +94,20 @@ static int set_bank(int flat, int addrre
 	return oldbank;
 }
 
+static unsigned long inx(int addr, int width)
+{
+	switch (width) {
+	case 2:
+		return inw(addr);
+		break;
+	case 4:
+		return inl(addr);
+		break;
+	default:
+		return inb(addr);
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	int addrreg;        /* address in flat mode */
@@ -96,9 +116,10 @@ int main(int argc, char *argv[])
 	int bank = -1;      /* -1 means no bank operation */
 	int bankreg;
 	int oldbank = 0;
-	int i, j, res;
+	int i, j;
+	unsigned long res;
 	int flags = 0;
-	int flat = 0, yes = 0;
+	int flat = 0, yes = 0, width = 1;
 	char *end;
 	unsigned char enter_key[SUPERIO_MAX_KEY+1];
 
@@ -118,6 +139,8 @@ int main(int argc, char *argv[])
 			}
 			flags++;
 			break;
+		case 'W': width = 2; break;
+		case 'L': width = 4; break;
 		default:
 			fprintf(stderr, "Warning: Unsupported flag "
 				"\"-%c\"!\n", argv[1+flags][1]);
@@ -270,9 +293,12 @@ int main(int argc, char *argv[])
 	if (bank >= 0)
 		oldbank = set_bank(flat, addrreg, datareg, bank, bankreg);
 
-	if (flat)
-		printf("  ");
-	printf("     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f\n");
+	/* print column headers */
+	printf("%*s", flat ? 5 : 3, "");
+	for (j = 0; j < 16; j += width)
+		printf(" %*x", width * 2, j);
+	printf("\n");
+
 	for (i = 0; i < range; i += 16) {
 		if (flat)
 			printf("%04x: ", addrreg + i);
@@ -288,19 +314,19 @@ int main(int argc, char *argv[])
 		if (enter_key[0])
 			superio_write_key(addrreg, enter_key);
 
-		for (j = 0; j < 16; j++) {
+		for (j = 0; j < 16; j += width) {
 			fflush(stdout);
 			if (flat) {
-				res = inb(addrreg + i + j);
+				res = inx(addrreg + i + j, width);
 			} else {	
 				outb(i+j, addrreg);
 				if (i+j = 0 && inb(addrreg) = 0x80) {
 					/* Bit 7 appears to be a busy flag */
 					range = 128;
 				}
-				res = inb(datareg);
+				res = inx(datareg, width);
 			}
-			printf("%02x ", res);
+			printf("%0*lx ", width * 2, res);
 		}
 		printf("\n");
 	}
--- lm-sensors.orig/prog/dump/isadump.8	2007-06-26 08:24:02.000000000 +0200
+++ lm-sensors/prog/dump/isadump.8	2011-04-12 17:39:42.000000000 +0200
@@ -1,10 +1,11 @@
-.TH ISADUMP 8 "August 2004"
+.TH ISADUMP 8 "April 2011"
 .SH NAME
 isadump \- examine ISA registers
 
 .SH SYNOPSIS
 .B isadump
 .RB [ -y ]
+.RB [ -W | -L ]
 .RB [ "-k V1,V2..." ]
 .I addrreg
 .I datareg
@@ -12,8 +13,10 @@ isadump \- examine ISA registers
 #for I2C-like access
 .br
 .B isadump
+.B -f
 .RB [ -y ]
-.BI "-f " address
+.RB [ -W | -L ]
+.I address
 .RI [ "range " [ "bank " [ bankreg ]]]
 #for flat address space
 
@@ -39,6 +42,12 @@ Specify a comma-separated list of bytes
 the chip configuration mode. Most Super-I/O chips need this.
 Known key sequences are: 0x87,0x01,0x55,0x55 for ITE, 0x55 for SMSC, 0x87,0x87
 for Winbond and VIA, none needed for National Semiconductor.
+.TP
+.B -W
+Perform 16-bit reads.
+.TP
+.B -L
+Perform 32-bit reads.
 
 .SH OPTIONS (I2C-like access mode)
 At least two options must be provided to isadump. \fIaddrreg\fR contains the

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
