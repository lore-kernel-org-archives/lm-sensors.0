From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Portion of the distribution of i2c refuses to compile
Message-Id: <3D8C8631.B8C2FE5F@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ticket #1005
Hello Slackware 7.0 user,
i2c-2.6.5 package needs a small patch in order to
compile against linux-2.2.xx correctly.

We will fix this in CVS for the next release.
Sorry,
Albert
--- kernel/i2c.h.orig  2002-09-21 10:41:36.000000000 -0400
+++ kernel/i2c.h       2002-09-21 10:42:08.000000000 -0400
@@ -70,6 +70,9 @@
 struct i2c_client_address_data;
 union i2c_smbus_data;
 
+#ifndef __exit
+#define __exit
+#endif
 
 /*
  * The master routines are the ones normally used to transmit data to devices

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
