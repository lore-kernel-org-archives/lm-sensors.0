From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Fix for libsensors.3
Message-Id: <20040320175110.GB20666@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi alln

The include line given in libsensors.3 is wrong. It should be
#include <sensors/sensors.h> instead of #include <sensors.h>

The attached patch against the current CVS fixes that.

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: lib/libsensors.3
=================================RCS file: /home/cvs/lm_sensors2/lib/libsensors.3,v
retrieving revision 1.3
diff -u -1 -b -p -r1.3 libsensors.3
--- lib/libsensors.3	23 Nov 2003 21:26:37 -0000	1.3
+++ lib/libsensors.3	20 Mar 2004 17:47:04 -0000
@@ -31,3 +31,3 @@ libsensors \- publically accessible func
 .nf
-.B #include <sensors.h>
+.B #include <sensors/sensors.h>
 
