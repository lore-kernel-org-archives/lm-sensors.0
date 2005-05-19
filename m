From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <Pine.GSO.4.40.0202071646550.14336-400000@e3000.ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I think all three we could use if you would like to submit patches.

Here they are.
Attached to this mail come 3 files.

1* lm_sensors2-eeprom256.diff

Patch to the eeprom driver, so that is reads 256 bytes instead of 128.

2* lm_sensors2-i2cdump.diff

Patch to i2cdump, so that it shows ASCII content of the eeproms, in
addition to the regular hex dump.

3* decode-vaio.pl

A perl script that will read the contents of a Sony Vaio EEPROM.  It is
*untested* so far, but should evolve when/if we can access other models
and/or are able to get specifications.

Please note that this script *cannot* be used before patch 1* has been
applied.

I think that this script could take place in prog/eeprom/.
BTW, I'd suggest that prog/xeon/decode-xeon.pl be also moved to
prog/eeprom/.  If we are to create a new subdirectory for each new eeprom
we hear about, it could be too many someday.

As usual, all commments, suggestions and so on are welcome.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________
-------------- next part --------------
diff -ruN CVS/kernel/chips/eeprom.c khali/kernel/chips/eeprom.c
--- CVS/kernel/chips/eeprom.c	Thu Jan 31 23:14:46 2002
+++ khali/kernel/chips/eeprom.c	Wed Feb  6 17:57:10 2002
@@ -69,7 +69,7 @@
 
 /* Conversions */
 /* Size of EEPROM in bytes */
-#define EEPROM_SIZE 128
+#define EEPROM_SIZE 256
 
 /* Each client has this additional data */
 struct eeprom_data {
@@ -80,7 +80,9 @@
 	unsigned long last_updated;	/* In jiffies */
 
 	u8 data[EEPROM_SIZE];	/* Register values */
+#if 0
 	int memtype;
+#endif
 };
 
 #ifdef MODULE
@@ -150,6 +152,22 @@
 	 &i2c_sysctl_real, NULL, &eeprom_contents},
 	{EEPROM_SYSCTL8, "data112-127", NULL, 0, 0444, NULL, &i2c_proc_real,
 	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL9, "data128-143", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL10, "data144-159", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL11, "data160-175", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL12, "data176-191", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL13, "data192-207", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL14, "data208-223", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL15, "data224-239", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
+	{EEPROM_SYSCTL16, "data240-255", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &eeprom_contents},
 	{0}
 };
 
@@ -349,26 +367,52 @@
 	int base = 0;
 	struct eeprom_data *data = client->data;
 
-	if (ctl_name = EEPROM_SYSCTL2) {
-		base = 16;
-	}
-	if (ctl_name = EEPROM_SYSCTL3) {
-		base = 32;
-	}
-	if (ctl_name = EEPROM_SYSCTL4) {
-		base = 48;
-	}
-	if (ctl_name = EEPROM_SYSCTL5) {
-		base = 64;
-	}
-	if (ctl_name = EEPROM_SYSCTL6) {
-		base = 80;
-	}
-	if (ctl_name = EEPROM_SYSCTL7) {
-		base = 96;
-	}
-	if (ctl_name = EEPROM_SYSCTL8) {
-		base = 112;
+	switch (ctl_name) {
+		case EEPROM_SYSCTL2:
+			base = 16;
+			break;
+		case EEPROM_SYSCTL3:
+			base = 32;
+			break;
+		case EEPROM_SYSCTL4:
+			base = 48;
+			break;
+		case EEPROM_SYSCTL5:
+			base = 64;
+			break;
+		case EEPROM_SYSCTL6:
+			base = 80;
+			break;
+		case EEPROM_SYSCTL7:
+			base = 96;
+			break;
+		case EEPROM_SYSCTL8:
+			base = 112;
+			break;
+		case EEPROM_SYSCTL9:
+			base = 128;
+			break;
+		case EEPROM_SYSCTL10:
+			base = 144;
+			break;
+		case EEPROM_SYSCTL11:
+			base = 160;
+			break;
+		case EEPROM_SYSCTL12:
+			base = 176;
+			break;
+		case EEPROM_SYSCTL13:
+			base = 192;
+			break;
+		case EEPROM_SYSCTL14:
+			base = 208;
+			break;
+		case EEPROM_SYSCTL15:
+			base = 224;
+			break;
+		case EEPROM_SYSCTL16:
+			base = 240;
+			break;
 	}
 
 	if (operation = SENSORS_PROC_REAL_INFO)
diff -ruN CVS/kernel/include/sensors.h khali/kernel/include/sensors.h
--- CVS/kernel/include/sensors.h	Thu Jan 31 23:16:15 2002
+++ khali/kernel/include/sensors.h	Wed Feb  6 17:20:40 2002
@@ -170,6 +170,14 @@
 #define EEPROM_SYSCTL6 1005
 #define EEPROM_SYSCTL7 1006
 #define EEPROM_SYSCTL8 1007
+#define EEPROM_SYSCTL9 1008
+#define EEPROM_SYSCTL10 1009
+#define EEPROM_SYSCTL11 1010
+#define EEPROM_SYSCTL12 1011
+#define EEPROM_SYSCTL13 1012
+#define EEPROM_SYSCTL14 1013
+#define EEPROM_SYSCTL15 1014
+#define EEPROM_SYSCTL16 1015
 
 #define LM80_SYSCTL_IN0 1000	/* Volts * 100 */
 #define LM80_SYSCTL_IN1 1001
-------------- next part --------------
diff -ruN CVS/prog/dump/i2cdump.c khali/prog/dump/i2cdump.c
--- CVS/prog/dump/i2cdump.c	Thu Jan 31 23:16:52 2002
+++ khali/prog/dump/i2cdump.c	Tue Feb  5 13:33:25 2002
@@ -293,7 +293,7 @@
         block[i] = -1;
     }
 
-    printf("     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f\n");
+    printf("     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef\n");
     for (i = 0; i < 256; i+) {
       printf("%02x: ",i);
       for(j = 0; j < 16; j++) {
@@ -305,6 +305,21 @@
           printf("XX ");
         else
           printf("%02x ",res & 0xff);
+      }
+      printf("   ");
+      for(j = 0; j < 16; j++) {
+        if(size = I2C_SMBUS_BYTE_DATA)
+          res = i2c_smbus_read_byte_data(file,i+j);
+        else
+          res = block[i+j];
+        if (res < 0)
+          printf("X");
+        else if (((res & 0xff) = 0x00) || ((res & 0xff) = 0xff))
+          printf(".");
+        else if (((res & 0xff) < 32) || ((res & 0xff) > 127))
+          printf("?");
+        else
+          printf("%c",res & 0xff);
       }
       printf("\n");
     }
-------------- next part --------------
#!/usr/bin/perl -w
#
# Copyright 2002 Jean Delvare <khali@linux-fr.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# Version 0.1  2002-02-06  Jean Delvare <khali@linux-fr.org>
#
# EEPROM data decoding for Sony Vaio laptops. 
#
# Two assumptions: lm_sensors-2.x installed,
# and Perl is at /usr/bin/perl
#
# Please note that this is a guess-only work.  I don't expect much help from
# Sony, so if someone can provide information, please contact me.  I used my
# PCG-GR214EP as a base, but I can't promise that this script will work with
# other models.  Any feedback appreciated anyway.
#

use strict;

sub print_item
{
	my ($label,$value) = @_;
	
	printf("\%20s : \%s\n",$label,$value);
}

sub decode_char
{
	my ($bus,$addr,$base,$offset,$length) = @_;
	
	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data$base-".($base+15);
	open(FH,$filename) || die "Can't open $filename";
	my $line=<FH>;
	close(FH);
	
	my @bytes=split(/[ \n]/,$line);
	@bytes=@bytes[$offset..$offset+$length-1];
	my $string='';
	my $item;
	while(defined($item=shift(@bytes)))
	{
		$string.=chr($item);
	}
	
	return($string);
}

sub decode_string
{
	my ($bus,$addr,$base,$offset,$length) = @_;

	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data$base-".($base+15);
	open(FH,$filename) || die "Can't open $filename";
	my $line=<FH>;
	close(FH);

	my @bytes=split(/[ \n]/,$line);
	@bytes=@bytes[$offset..$offset+$length-1];
	my $string='';
	my $item;
	while(defined($item=shift(@bytes)) && ($item!=0))
	{
		$string.=chr($item);
	}
	
	return($string);
}

sub decode_string32
{
	my ($bus,$addr,$base) = @_;

	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data$base-".($base+15);
	open(FH,$filename) || die "Can't open $filename";
	my $line=<FH>;
	close(FH);
	$filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data".($base+16).'-'.($base+31);
	open(FH,$filename) || die "Can't open $filename";
	$line.=<FH>;
	close(FH);

	my @bytes=split(/[ \n]/,$line);
	my $string='';
	my $item;
	while(defined($item=shift(@bytes)) && ($item!=0))
	{
		$string.=chr($item);
	}
	
	return($string);
}

sub vaio_decode
{
	my ($bus,$addr) = @_;
	
	print_item('Model name',decode_string32($bus,$addr,128).' ['.decode_char($bus,$addr,160,10,4).']');
	print_item('Revision',decode_string($bus,$addr,160,0,10));
	print_item('Serial number',decode_string32($bus,$addr,192));
	print_item('Timestamp',decode_string32($bus,$addr,224));
}

print("Sony Vaio EEPROM Decoder\n");
print("Written by Jean Delvare.  Copyright 2002.\n");
print("Version 0.1\n\n");

if ( -r '/proc/sys/dev/sensors/eeprom-i2c-0-57')
{
	vaio_decode('0','57');
}
else
{
	print("Vaio eeprom not found.  Please make sure that the eeprom module is loaded.\n");
	print("If you believe this is an error, please contact me <khali\@linux-fr.org>\n");
	print("so that we may see how to fix the problem.\n");
}

print("\n");
