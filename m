From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [PATCH] fix base address hinting in via686a docs
Message-Id: <Pine.LNX.4.58.0410142059130.9204@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

According to google, 307 hits place the 686a chip to 0x6000
two to 0xC00 and one hit to 0xe200. I also add some info to
sensors-detect.

I would like to thank Khali for advices about perl ;)

regards

Rudolf

diff -Naur lm_sensors-2.8.8/doc/chips/via686a lm_sensors-2.8.8new/doc/chips/via686a
--- lm_sensors-2.8.8/doc/chips/via686a	2002-08-22 04:15:07.000000000 +0200
+++ lm_sensors-2.8.8new/doc/chips/via686a	2004-10-14 20:43:54.000000000 +0200
@@ -23,7 +23,7 @@
 			PCI force; the via686a must still be present in lspci.
 			Don't use this unless the driver complains that the
 			base address is not set.
-			Example: 'modprobe via686a force_addr=0x290'
+			Example: 'modprobe via686a force_addr=0x6000'


 Description
diff -Naur lm_sensors-2.8.8/prog/detect/sensors-detect lm_sensors-2.8.8new/prog/detect/sensors-detect
--- lm_sensors-2.8.8/prog/detect/sensors-detect	2004-10-03 22:51:47.000000000 +0200
+++ lm_sensors-2.8.8new/prog/detect/sensors-detect	2004-10-14 20:57:00.000000000 +0200
@@ -4440,7 +4440,9 @@
         printf "ISA bus address 0x%04x (Busdriver `i2c-isa')\n",
                $data->{isa_addr};
       } else {
-        printf "ISA bus, undetermined address (Busdriver `i2c-isa')\n"
+        print "ISA bus, undetermined address (Busdriver `i2c-isa')\n".
+              "Hint: Try forcing the chip address. Consult the documentation\n".
+              "of particular chip for details and address value.\n";
       }
     }
     printf "    Chip `%s' (confidence: %d)\n",
