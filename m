From: kronos@kronoz.cjb.net (Kronos)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] Update sensors.conf.eg for Epox 8K3A
Message-Id: <20040210183436.GA15475@dreamland.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
my motherboard  (Epox 8K3A) has  a w83697hf. I  need the same  labels as
Tyan Trinity  S2495 except that  in7 and in8 are  swapped. The following
patch documents this little difference:

--- lm_sensors-2.8.4/etc/sensors.conf.eg.orig	Tue Feb 10 19:26:10 2004
+++ lm_sensors-2.8.4/etc/sensors.conf.eg	Tue Feb 10 19:28:03 2004
@@ -533,6 +533,11 @@
 #    label in6 "Vdimm"
 #    label in7 "VBat"
 #    label in8 "V5SB"
+#
+# For Epox 8K3A you should swap in7 and in8:
+#    label in7 "V5SB"
+#    label in8 "VBat"
+#
 # You'll also want to comment out the in5 and in6 compute lines right below.
 
     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Fare l'amore con dieci donne e` fantastico, soprattutto perche` ti
 presentano un sacco di amiche." -- Fabio Di Iorio
