From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 17 Jan 2006 07:31:14 +0000
Subject: [lm-sensors] ISA vs. SMBus
Message-Id: <20060117083114.7f2e826b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After all detections have been done, sensors-detect currently asks the
user whether he/she prefers ISA access or SMBus access when both are
possible. This option only makes sense for "hybrid" drivers (lm78,
w83781d, it87), and only in a few cases (i.e. at least one alias has
been detected by sensors-detect).

This question tends to confuse people, precisely due to the fact that
it is asked unconditionally while most people simply don't need to
care. Also, I see very little reason why someone would prefer not to
use the ISA access, given the increased speed and reliability. Thus, I
propose that we drop this question and assume "ISA" as the answer for
everyone:

--- sensors-detect.orig	2006-01-16 08:46:44.000000000 +0100
+++ sensors-detect	2006-01-16 13:49:13.000000000 +0100
@@ -5226,17 +5226,9 @@
   }
 
   print "\n\n",
-        " I will now generate the commands needed to load the I2C modules.\n",
-        " Sometimes, a chip is available both through the ISA bus and an ",
-        "I2C bus.\n",
-        " ISA bus access is faster, but you need to load an additional driver ",
-        "module\n",
-        " for it. If you have the choice, do you want to use the ISA bus or ",
-        "the\n",
-        " I2C/SMBus (ISA/smbus)? ";
-  my $use_isa = not <STDIN> =~ /\s*[Ss]/;
+        " I will now generate the commands needed to load the I2C modules.\n";
      
-  my ($modprobes,$configfile) = generate_modprobes $use_isa;
+  my ($modprobes, $configfile) = generate_modprobes 1;	# 1 = prefer ISA
   print "\nTo make the sensors modules behave correctly, add these lines to\n",
         "$modules_conf:\n\n";
   print "#----cut here----\n";

Note that I didn't discard all the now-dead code in sub
generate_modprobes, just in case anyone needs to manually revert to
SMBus preference. If no problem arises in the next year we may drop that
additional code.

Thanks,
-- 
Jean Delvare

