From: nickols_k@mail.ru (Nick Kurshev)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: [PATCH] SPD report slightly improved
Message-Id: <20021108103703.03c46fbc.nickols_k@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

This patch improves HTML form of SPD information report by
locating info about every chip in independed table.
IMHO it improves readability of report!
Please apply this patch into the next release of lm_sensors.

Best regards! Nick


--- prog/eeprom/decode-dimms.pl.old	Sat Feb 16 19:41:54 2002
+++ prog/eeprom/decode-dimms.pl	Fri Nov  8 10:33:04 2002
@@ -100,10 +100,9 @@
 PC DIMM Serial Presence Detect Tester/Decoder
 Written by Philip Edelbrock.  Copyright 1998, 1999.
 Modified by Christian Zuckschwerdt <zany@triq.net>
-Version 2.6.3
+Version 2.6.3.1
 ';
 
-print "<table border=1>\n" if $opt_html;
 
 $dimm_count=0;
 $_=`ls /proc/sys/dev/sensors/`;
@@ -115,7 +114,10 @@
 		$dimm_checksum=0;
 		$dimm_count=$dimm_count + 1;
 		
-		printl "Decoding EEPROM", "/proc/sys/dev/sensors/$dimm_list[$i]";
+		print "<B><U><BR><BR>" if $opt_html;
+		printl "Decoding EEPROM" , " /proc/sys/dev/sensors/$dimm_list[$i]";
+		print "</B></U>" if $opt_html;
+		print "<table border=1>\n" if $opt_html;
 		if (/^[^-]+-[^-]+-[^-]+-([^-]+)$/) {
 			$dimm_num=$1 - 49;
 			printl "Guessing DIMM is in", "bank $dimm_num";
@@ -472,10 +474,10 @@
 		printl $l, $temp;
 		
 		
+print "</table>\n" if $opt_html;
 	}
 }
-printl "Number of SDRAM DIMMs detected and decoded", $dimm_count;
+printl "Number of SDRAM DIMMs detected and decoded ", $dimm_count;
 
-print "</table>\n" if $opt_html;
 print "</body></html>\n" if $opt_body;
 print "\nTry '$0 --format' for html output.\n" unless $opt_html;

