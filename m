From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: eeprom driver
Message-Id: <Pine.GSO.4.40.0202162112300.22793-200000@e450.ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I made the naming change you suggested in eeprom.c
> and fixed decode-dimms and decode-xeon,
> unfortunately I don't have a Perl book at home
> so I need your help to fix decode-vaio, if you
> would please send me a patch that would be great.

Here you are.

I supposed that the new names will be from 00 to f0 (not F0). If I'm
wrong, just change %02x with %02X in sprintf calls.

Tell me if there's anything wrong.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________
-------------- next part --------------
diff -ruN 0.1/prog/eeprom/decode-vaio.pl 0.2/prog/eeprom/decode-vaio.pl
--- 0.1/prog/eeprom/decode-vaio.pl	Sat Feb 16 21:49:45 2002
+++ 0.2/prog/eeprom/decode-vaio.pl	Sat Feb 16 22:05:17 2002
@@ -16,18 +16,26 @@
 #    along with this program; if not, write to the Free Software
 #    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 #
-# Version 0.1  2002-02-06  Jean Delvare <khali@linux-fr.org>
+# Version 0.2  2002-02-06  Jean Delvare <khali@linux-fr.org>
 #
 # EEPROM data decoding for Sony Vaio laptops. 
 #
 # Two assumptions: lm_sensors-2.x installed,
 # and Perl is at /usr/bin/perl
 #
-# Please note that this is a guess-only work.  I don't expect much help from
-# Sony, so if someone can provide information, please contact me.  I used my
+# Please note that this is a guess-only work.  Sony support refused to help
+# me, so if someone can provide information, please contact me.  I used my
 # PCG-GR214EP as a base, but I can't promise that this script will work with
 # other models.  Any feedback appreciated anyway.
 #
+# History:
+#
+# 2002-02-06  0.1   Initial release.
+#
+# 2002-02-16  0.2   Fixed to work with the new, simplified /proc interface
+#                   names of the eeprom driver (lm_sensors 2.6.3 and later.)
+#                   Shifted data display by 4 columns left.
+#
 
 use strict;
 
@@ -35,14 +43,14 @@
 {
 	my ($label,$value) = @_;
 	
-	printf("\%20s : \%s\n",$label,$value);
+	printf("\%16s : \%s\n",$label,$value);
 }
 
 sub decode_char
 {
 	my ($bus,$addr,$base,$offset,$length) = @_;
 	
-	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data$base-".($base+15);
+	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/".sprintf('%02x',$base);
 	open(FH,$filename) || die "Can't open $filename";
 	my $line=<FH>;
 	close(FH);
@@ -63,7 +71,7 @@
 {
 	my ($bus,$addr,$base,$offset,$length) = @_;
 
-	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data$base-".($base+15);
+	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/".sprintf('%02x',$base);
 	open(FH,$filename) || die "Can't open $filename";
 	my $line=<FH>;
 	close(FH);
@@ -84,11 +92,11 @@
 {
 	my ($bus,$addr,$base) = @_;
 
-	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data$base-".($base+15);
+	my $filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/".sprintf('%02x',$base);
 	open(FH,$filename) || die "Can't open $filename";
 	my $line=<FH>;
 	close(FH);
-	$filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/data".($base+16).'-'.($base+31);
+	$filename="/proc/sys/dev/sensors/eeprom-i2c-$bus-$addr/".sprintf('%02x',$base+16);
 	open(FH,$filename) || die "Can't open $filename";
 	$line.=<FH>;
 	close(FH);
@@ -116,7 +124,7 @@
 
 print("Sony Vaio EEPROM Decoder\n");
 print("Written by Jean Delvare.  Copyright 2002.\n");
-print("Version 0.1\n\n");
+print("Version 0.2\n\n");
 
 if ( -r '/proc/sys/dev/sensors/eeprom-i2c-0-57')
 {
