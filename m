From: Trent Piepho <xyzzy@speakeasy.org>
Date: Thu, 28 Feb 2008 22:19:11 +0000
Subject: [lm-sensors] [PATCH] Read SPD data from a hexdump
Message-Id: <Pine.LNX.4.58.0802281405040.14140@shell4.speakeasy.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
file names to read SPD data from.  It can parse various hexdump formats,
such as the output from i2cdump and the util-linux and Busybox hexdump
progams run on a sysfs eeprom file.

Useful for decoding SPD data that you cut and pasted from a manufacturer's
website or from a DIMM installed on an embeded system that does not have
perl/etc, but does have a serial console with busybox.

--- i2c-tools/eeprom/decode-dimms.pl.orig	2008-02-28 13:45:43.000000000 -0800
+++ i2c-tools/eeprom/decode-dimms.pl	2008-02-28 13:46:03.000000000 -0800
@@ -46,7 +46,7 @@
 use strict;
 use POSIX;
 use Fcntl qw(:DEFAULT :seek);
-use vars qw($opt_html $opt_body $opt_bodyonly $opt_igncheck $use_sysfs
+use vars qw($opt_html $opt_body $opt_bodyonly $opt_igncheck $use_sysfs $use_hexdump
 	    @vendors %decode_callback $revision);

 $revision = '$Revision: 5089 $ ($Date: 2008-01-04 08:34:36 -0800 (Fri, 04 Jan 2008) $)';
@@ -1084,7 +1084,38 @@
 sub readspd64 ($$) { # reads 64 bytes from SPD-EEPROM
 	my ($offset, $dimm_i) = @_;
 	my @bytes;
-	if ($use_sysfs) {
+	if ($use_hexdump) {
+	    my $addr = 0;
+	    my $repstart = 0;
+	    open F, '<', "$dimm_i" or die;
+	    while(<F>) {
+		chomp;
+		if(/^\*$/) {
+		    $repstart = $addr;
+		    next;
+		}
+		/^([a-fA-F\d]{2,7}):? ((:?[a-fA-F\d]{4}\s*){8}|(:?[a-fA-F\d]{2}\s*){16})/ ||
+		/^([a-fA-F\d]{2,7}):?\s*$/ or die "Can't parse data";
+		$addr = hex $1;
+		if ($repstart) {
+		    @bytes[$repstart .. ($addr-1)] = ($bytes[$repstart-1]) x ($addr-$repstart);
+		    $repstart = 0;
+		}
+		last unless defined $2;
+		foreach (split(/\s+/, $2)) {
+		    if(/^(..)(..)$/) {
+			$bytes[$addr++] = hex($1);
+			$bytes[$addr++] = hex($2);
+		    } elsif(/^(..)$/) {
+			$bytes[$addr++] = hex($1);
+		    } else {
+			print "Can't parse hex word '$_'\n";
+		    }
+		}
+	    }
+	    close F;
+	    return @bytes[$offset..($offset+63)];
+	} elsif ($use_sysfs) {
 		# Kernel 2.6 with sysfs
 		sysopen(HANDLE, "/sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom", O_RDONLY)
 			or die "Cannot open /sys/bus/i2c/drivers/eeprom/$dimm_i/eeprom";
@@ -1103,20 +1134,25 @@
 	return @bytes;
 }

+my @dimm_list;
+
 for (@ARGV) {
     if (/-h/) {
-		print "Usage: $0 [-c] [-f [-b]]\n",
+		print "Usage: $0 [-c] [-f [-b]] [-x file [files..]]\n",
 			"       $0 -h\n\n",
 			"  -f, --format            print nice html output\n",
 			"  -b, --bodyonly          don't print html header\n",
 			"                          (useful for postprocessing the output)\n",
 			"  -c, --checksum          decode completely even if checksum fails\n",
+			"  -x,                     Read data from hexdump files\n",
 			"  -h, --help              display this usage summary\n";
 		exit;
     }
     $opt_html = 1 if (/-f/);
     $opt_bodyonly = 1 if (/-b/);
     $opt_igncheck = 1 if (/-c/);
+    $use_hexdump = 1 if(/-x/);
+    push @dimm_list, $_ if($use_hexdump && !/^-[fbcx]$/);
 }
 $opt_body = $opt_html && ! $opt_bodyonly;

@@ -1136,21 +1172,24 @@


 my $dimm_count=0;
-my @dimm_list;
 my $dir;
-if ($use_sysfs) { $dir = '/sys/bus/i2c/drivers/eeprom'; }
-else { $dir = '/proc/sys/dev/sensors'; }
-if (-d $dir) {
-	@dimm_list = split(/\s+/, `ls $dir`);
-} elsif (! -d '/sys/module/eeprom') {
-	print "No EEPROM found, are you sure the eeprom module is loaded?\n";
-	exit;
+
+if (!$use_hexdump) {
+	if ($use_sysfs) { $dir = '/sys/bus/i2c/drivers/eeprom'; }
+	else { $dir = '/proc/sys/dev/sensors'; }
+	if (-d $dir) {
+		@dimm_list = split(/\s+/, `ls $dir`);
+	} elsif (! -d '/sys/module/eeprom') {
+		print "No EEPROM found, are you sure the eeprom module is loaded?\n";
+		exit;
+	}
 }

 for my $i ( 0 .. $#dimm_list ) {
 	$_=$dimm_list[$i];
 	if (($use_sysfs && /^\d+-\d+$/)
-	 || (!$use_sysfs && /^eeprom-/)) {
+	 || (!$use_sysfs&& /^eeprom-/)
+	 || $use_hexdump) {
 		my @bytes = readspd64(0, $dimm_list[$i]);
 		my $dimm_checksum = 0;
 		$dimm_checksum += $bytes[$_] foreach (0 .. 62);
@@ -1160,15 +1199,18 @@
 		$dimm_count++;

 		print "<b><u>" if $opt_html;
-		printl2 "\n\nDecoding EEPROM", ($use_sysfs ?
+		printl2 "\n\nDecoding EEPROM",
+		        $use_hexdump ? $dimm_list[$i] : ($use_sysfs ?
 			"/sys/bus/i2c/drivers/eeprom/$dimm_list[$i]" :
 			"/proc/sys/dev/sensors/$dimm_list[$i]");
 		print "</u></b>" if $opt_html;
 		print "<table border=1>\n" if $opt_html;
-		if (($use_sysfs && /^[^-]+-([^-]+)$/)
-		 || (!$use_sysfs && /^[^-]+-[^-]+-[^-]+-([^-]+)$/)) {
-			my $dimm_num=$1 - 49;
-			printl "Guessing DIMM is in", "bank $dimm_num";
+		if (!$use_hexdump) {
+			if (($use_sysfs && /^[^-]+-([^-]+)$/)
+			 || (!$use_sysfs && /^[^-]+-[^-]+-[^-]+-([^-]+)$/)) {
+				my $dimm_num=$1 - 49;
+				printl "Guessing DIMM is in", "bank $dimm_num";
+			}
 		}

 # Decode first 3 bytes (0-2)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
