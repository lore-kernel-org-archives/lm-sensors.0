From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Opteron VRM spec
Message-Id: <3ED3EE50.2030502@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The Opteron processors don't use an "Intel spec" VRM encoding.  (Big 
surprise there...)

So this patch adds a "2.4" VRM standard (for the Opteron 24x processors) 
that allows chips that use the include/sensors_vid.h functions to 
calculate the VID voltage correctly...

It's small enough that it should apply to CVS...

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
-------------- next part --------------
diff -ru --new-file ../_relion1x/lm_sensors-2.7.0/kernel/include/sensors_vid.h lm_sensors-2.7.0.adm1026/kernel/include/sensors_vid.h
--- ../_relion1x/lm_sensors-2.7.0/kernel/include/sensors_vid.h	Fri Apr 19 19:59:12 2002
+++ lm_sensors-2.7.0.adm1026/kernel/include/sensors_vid.h	Wed May 21 21:38:02 2003
@@ -29,6 +29,21 @@
 */
 
 /*
+    AMD Opteron processors don't follow the Intel VRM spec.
+    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
+    No good reason just a mnemonic for the 24x Opteron processor
+    series
+
+    Opteron VID encoding is:
+
+       00000  =  1.550 V
+       00001  =  1.525 V
+        . . . .
+       11110  =  0.800 V
+       11111  =  0.000 V (off)
+ */
+
+/*
     Legal val values 00 - 1F.
     vrm is the Intel VRM document version.
     Note: vrm version is scaled by 10 and the return value is scaled by 1000
@@ -43,6 +58,9 @@
 {
 	switch(vrm) {
 
+	case 24:		/* Opteron processor */
+		return(val = 0x1f ? 0 : 1550 - val * 25);
+
 	case 91:		/* VRM 9.1 */
 	case 90:		/* VRM 9.0 */
 		return(val = 0x1f ? 0 :
