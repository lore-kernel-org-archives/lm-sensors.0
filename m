From: Reinhard Nissl <rnissl@gmx.de>
Date: Sat, 13 Dec 2008 17:29:02 +0000
Subject: [lm-sensors] PATCH: update sensors-detect for Intel Core i7 CPUs
Message-Id: <4943F0DE.9000804@gmx.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080706000300000104050309"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080706000300000104050309
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

the attached patch adds a further model number to sensors-detect
for having this new CPUs detected. Tested with I7-965 CPU.

Signed-off-by: Reinhard Nissl <rnissl@gmx.de>

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de

--------------080706000300000104050309
Content-Type: text/x-patch;
 name="detect_corei7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="detect_corei7.patch"

Index: prog/detect/sensors-detect
===================================================================
--- prog/detect/sensors-detect	(Revision 5562)
+++ prog/detect/sensors-detect	(Arbeitskopie)
@@ -4940,7 +4940,8 @@
 				($probecpu->{model} == 14 ||
 				 $probecpu->{model} == 15 ||
 				 $probecpu->{model} == 0x16 ||
-				 $probecpu->{model} == 0x17)) {
+				 $probecpu->{model} == 0x17 ||
+				 $probecpu->{model} == 0x1a)) {
 			return 9;
 		}
 	}

--------------080706000300000104050309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080706000300000104050309--
