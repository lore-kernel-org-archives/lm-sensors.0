From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] sensors.conf for an Abit BP6 motherboard
Message-Id: <20040416192633.GC31563@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all !

I have attached a patch that adds comments to sensors.conf to explain
how to configure it for an Abit BP6 motherboard. Please feel free to
apply it or not.

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/etc/sensors.conf.eg lm_sensors2/etc/sensors.conf.eg
--- lm_sensors2.orig/etc/sensors.conf.eg	2004-04-16 20:32:04.000000000 +0200
+++ lm_sensors2/etc/sensors.conf.eg	2004-04-16 20:33:19.000000000 +0200
@@ -404,6 +404,12 @@
     label in7 "V5SB"
     label in8 "VBat"
 
+# Abit BP6 motherboard has a few differences. VCore1 and VCore2 are the core
+# voltages of the two processors. Vtt is memory bus termination resistors
+# voltage.
+#    label in1 "Vtt"
+#    label in8 "VCore2"
+
     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
     compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
