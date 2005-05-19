From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: [PATCH] i2c/CHANGES
Message-Id: <200405231420.AA00975@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: CHANGES
=================================RCS file: /home/cvs/i2c/CHANGES,v
retrieving revision 1.110
diff -u -r1.110 CHANGES
--- CHANGES	23 May 2004 07:27:49 -0000	1.110
+++ CHANGES	23 May 2004 14:23:34 -0000
@@ -19,7 +19,7 @@
 
 2.8.5 (2004xxxx)
   Makefile: Do not run depmod on staged installs (Peter Breitenlohner)
-  i2c-core.c: Fail to compile is kernel lacks sysctl support
+  i2c-proc.c: Fail to compile is kernel lacks sysctl support
 
 2.8.4 (20040207)
   i2c-id.h: Add IDs for the OV511 project


----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
