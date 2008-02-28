From: Trent Piepho <xyzzy@speakeasy.org>
Date: Thu, 28 Feb 2008 22:19:02 +0000
Subject: [lm-sensors] [PATCH] More DDR2 data for decode-dimms.pl
Message-Id: <Pine.LNX.4.58.0802281401020.14140@shell4.speakeasy.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This lets decode-dimms.pl decode almost all of the SPD data for DDR2 dimms.
Including all the detailed timing parameters with their standard tXXX
names, useful if one is trying to program a DDR memory controller for
example.


Index: decode-dimms.pl
=================================--- i2c-tools/eeprom/decode-dimms.pl	(revision 5132)
+++ i2c-tools/eeprom/decode-dimms.pl	(working copy)
@@ -834,6 +834,20 @@
 	return $atime;
 }

+sub ddrx_sdram_rtime($$$)
+{
+	my ($t, $b1, $b2) = @_;
+	my $rtime = $b1;
+	if($t = 2) {
+		$rtime += ($b2 & 1) * 256;
+		my @table = (0, .250, .330, .500, .660, .750);
+		$rtime += $table[($b2>>1)&7];
+	}
+	return $rtime;
+}
+
+sub tns($) { return sprintf("%3.2f ns", $_[0]); }
+
 # Parameter: bytes 0-63
 sub decode_ddr2_sdram($)
 {
@@ -875,6 +889,40 @@
 				       $bytes->[5] . "," . $bytes->[17];
 	}

+	printl "Banks x Rows x Columns x Bits",
+	       join(' x ', $bytes->[17], $bytes->[3], $bytes->[4], $bytes->[6]);
+	printl "Ranks", ($bytes->[5]&7) + 1;
+
+	printl "SDRAM Device Width", $bytes->[13]." bits";
+
+	my @heights = ("< 25.4", "25.4", "25.4 - 30.0", "30.0", "30.5", "> 30.5");
+	printl "Module Height", $heights[$bytes->[5]>>5]." mm";
+	my @types = ("RDIMM", "UDIMM", "SO-DIMM", "Micro-DIMM",
+		     "Mini-RDIMM", "Mini-UDIMM");
+	my @widths = (133.35, 133.25, 67.6, 45.5, 82.0, 82.0);
+	my @suptypes;
+	foreach $ii (0..5) {
+		push @suptypes, "$types[$ii] ($widths[$ii] mm)"
+			if($bytes->[20] & (1<<$ii));
+	}
+	printl "Module Type".(@suptypes>1?'s':''),  join(', ', @suptypes);
+	printl "DRAM Package", $bytes->[5]&0x10 ? "Stack" : "Planar";
+
+	my @volts = ("TTL/5V Tolerant", "LVTTL", "HSTL 1.5V",
+		     "SSTL 3.3V", "SSTL 2.5V", "SSTL 1.8V", "TBD");
+	printl "Voltage Interface Level", $volts[$bytes->[8]];
+
+	my @refresh = qw(Normal Reduced Reduced Extended Extended Extended);
+	my @refresht = (15.625,3.9,7.8,31.3,62.5,125);
+	printl "Refresh Rate",
+	       "$refresh[$bytes->[12]&0x7f] ($refresht[$bytes->[12]&0x7f] us)".
+	       ($bytes->[12]&0x80 ? " - Self Refresh" : "");
+
+	my @burst;
+	push @burst, 4 if ($bytes->[16] & 4);
+	push @burst, 8 if ($bytes->[16] & 8);
+	printl "Burst lengths supported", join(', ', @burst);
+
 	my $highestCAS = 0;
 	my %cas;
 	for ($ii = 2; $ii < 7; $ii++) {
@@ -899,31 +947,59 @@
 		ceil($tras/$ctime);

 # latencies
-	if (keys %cas) { $temp = join ', ', sort { $b <=> $a } keys %cas; }
+	if (keys %cas) { $temp = join ', ', map("${_}T",sort { $b <=> $a } keys %cas); }
 	else { $temp = "None"; }
-	printl "Supported CAS Latencies", $temp;
+	printl "Supported CAS Latencies (tCL)", $temp;

 # timings
 	if (exists $cas{$highestCAS}) {
-		printl "Minimum Cycle Time (CAS $highestCAS)",
-		       "$ctime ns";
-		printl "Maximum Access Time (CAS $highestCAS)",
-		       ddr2_sdram_atime($bytes->[10]) . " ns";
+		printl "Minimum Cycle Time @ CAS $highestCAS (tCK min)",
+		       tns($ctime);
+		printl "Maximum Access Time @ CAS $highestCAS (tAC)",
+		       tns(ddr2_sdram_atime($bytes->[10]));
 	}

 	if (exists $cas{$highestCAS-1} && spd_written(@$bytes[23..24])) {
-		printl "Minimum Cycle Time (CAS ".($highestCAS-1).")",
-		       ddr2_sdram_ctime($bytes->[23]) . " ns";
-		printl "Maximum Access Time (CAS ".($highestCAS-1).")",
-		       ddr2_sdram_atime($bytes->[24]) . " ns";
+		printl "Minimum Cycle Time @ CAS ".($highestCAS-1),
+		       tns(ddr2_sdram_ctime($bytes->[23]));
+		printl "Maximum Access Time @ CAS ".($highestCAS-1),
+		       tns(ddr2_sdram_atime($bytes->[24]));
 	}

 	if (exists $cas{$highestCAS-2} && spd_written(@$bytes[25..26])) {
-		printl "Minimum Cycle Time (CAS ".($highestCAS-2).")",
-		       ddr2_sdram_ctime($bytes->[25]) . " ns";
-		printl "Maximum Access Time (CAS ".($highestCAS-2).")",
-		       ddr2_sdram_atime($bytes->[26]) . " ns";
+		printl "Minimum Cycle Time @ CAS ".($highestCAS-2),
+		       tns(ddr2_sdram_ctime($bytes->[25]));
+		printl "Maximum Access Time @ CAS ".($highestCAS-2),
+		       tns(ddr2_sdram_atime($bytes->[26]));
 	}
+	printl "Maximim Device Cycle Time (tCK max)",
+	       tns(ddr2_sdram_ctime($bytes->[43]));
+
+	# Some timing information
+	prints("Timing Parameters");
+	printl "Address/Command Setup Time Before Clock (tIS)",
+	       tns(ddr2_sdram_atime($bytes->[32]));
+	printl "Address/Command Hold Time After Clock (tIH)",
+	       tns(ddr2_sdram_atime($bytes->[33]));
+	printl "Data Input Setup Time Before Strobe (tDS)",
+	       tns(ddr2_sdram_atime($bytes->[34]));
+	printl "Data Input Hold Time After Strobe (tDH)",
+	       tns(ddr2_sdram_atime($bytes->[35]));
+	printl "Minimum Row Precharge Delay (tRP)", tns($trp);
+	printl "Minimum Row Active to Row Active Delay (tRRD)",
+	       tns($bytes->[28]/4);
+	printl "Minimum RAS# to CAS# Delay (tRCD)", tns($trcd);
+	printl "Minimum RAS# Pulse Width (tRAS)", tns($tras);
+	printl "Write Recovery Time (tWR)", tns($bytes->[36]/4);
+	printl "Minimum Write to Read CMD Delay (tWTR)", tns($bytes->[37]/4);
+	printl "Minimum Read to Pre-charge CMD Delay (tRTP)", tns($bytes->[38]/4);
+	printl "Minimum Active to Auto-refresh Delay (tRC)",
+	       tns(ddrx_sdram_rtime(2, $bytes->[41], ($bytes->[40]>>3)&0xe));
+	printl "Minimum Recovery Delay (tRFC)",
+	       tns(ddrx_sdram_rtime(2, $bytes->[42], $bytes->[40]));
+	printl "Maximum DQS to DQ Skew (tDQSQ)", tns($bytes->[44]/100);
+	printl "Maximum Read Data Hold Skew (tQHS)", tns($bytes->[45]/100);
+	printl "PLL Relock Time", $bytes->[46] . " us" if ($bytes->[46]);
 }

 # Parameter: bytes 0-63

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
