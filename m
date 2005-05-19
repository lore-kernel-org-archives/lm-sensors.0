From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [PATCH] i2c driver changes for 2.5.69
Message-Id: <10522676151566@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10522676152488@kroah.com>
References: <10522676142536@kroah.com>
In-Reply-To: <10522676142536@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1042.48.4, 2003/04/29 10:19:14-07:00, greg@kroah.com

i2c: fix up the MAINTAINERS i2c entry

Removed the dead web page and email address, and merged with the sensors entry
and added myself.


 MAINTAINERS |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue May  6 17:24:51 2003
+++ b/MAINTAINERS	Tue May  6 17:24:51 2003
@@ -790,20 +790,13 @@
 M:	drivers@neukum.org
 S:	Maintained
 
-I2C DRIVERS
-P:	Simon Vogl
-M:	simon@tk.uni-linz.ac.at
-P:	Frodo Looijaard
-M:	frodol@dds.nl
-L:	linux-i2c@pelican.tk.uni-linz.ac.at
-W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
-S:	Maintained
-
-SENSORS DRIVERS
+I2C AND SENSORS DRIVERS
 P:      Frodo Looijaard
 M:      frodol@dds.nl
 P:      Philip Edelbrock
 M:      phil@netroedge.com
+P:	Greg Kroah-Hartman
+M:	greg@kroah.com
 L:      sensors@stimpy.netroedge.com
 W:      http://www.lm-sensors.nu/
 S:      Maintained

