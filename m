From: h-iwamoto@kit.hi-ho.ne.jp (Hideki IWAMOTO)
Date: Sat, 08 Oct 2005 06:00:40 +0000
Subject: [lm-sensors] [PATCH] protocol.html
Message-Id: <200510080359.AA01326@k7.kit.hi-ho.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- This page has not described the status of vanilla kernel.
- The user space i2c-dev.h is provided by the lm_sensors package.

Index: protocol.html
=================================RCS file: /home/cvs/website/protocol.html,v
retrieving revision 1.9
diff -u -p -r1.9 protocol.html
--- protocol.html	27 Sep 2005 17:55:57 -0000	1.9
+++ protocol.html	8 Oct 2005 03:47:41 -0000
@@ -9,7 +9,7 @@
 <center><b><font size="+2">SMBus Protocol Status Page</font></b></center>
 
 <p>This is the status page for the
-implementation of the SMBus protocol in the i2c package and the kernel.</p>
+implementation of the SMBus protocol in the i2c package and the lm_sensors package.</p>
 
 <p>If you would like us to support
 additional commands or have code to contribute, please send us email. Please

----
Hideki IWAMOTO  h-iwamoto@kit.hi-ho.ne.jp
