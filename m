From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 05 Dec 2006 03:41:32 +0000
Subject: [lm-sensors] [PATCH libsensors] emit line number for each 'set'
Message-Id: <20061205034132.GE5592@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

You asked about this on IRC last Sunday, and unfortunately I gave you some bad
information.  Turns out it is trivial after all.  I completely forgot about
libsensors error.h.

Index: lib/access.c
=================================--- lib/access.c	(revision 4253)
+++ lib/access.c	(working copy)
@@ -460,6 +460,8 @@
 				continue;
 			}
 			if ((res = sensors_set_feature(name, feature_nr, value))) {
+				sensors_parse_error("Can't set feature.",
+						chip->sets[i].lineno);
 				err = res;
 				continue;
 			}


Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


