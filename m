From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [PATCH] i2c driver fixes for 2.6.3-rc1
Message-Id: <10763687753233@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10763687752678@kroah.com>
References: <10763687741938@kroah.com>
In-Reply-To: <10763687741938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1500.11.7, 2004/02/05 17:04:24-08:00, khali@linux-fr.org

[PATCH] I2C: Update I2C maintainers entry

I propose the following update of the "I2C AND SENSORS DRIVERS" entry in
MAINTAINERS:

* Remove Frodo Looijaard. He isn't active in the project anymore, and
forwards everythings he receives to the mailing-list. More work for
everyone, and increased latency.

* Move your name to the top. This is more realistic since you are the
real maintainer of the i2c subsystem in 2.6.

* Reindent. Spaces were used instead of tabs.


 MAINTAINERS |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Mon Feb  9 15:05:41 2004
+++ b/MAINTAINERS	Mon Feb  9 15:05:41 2004
@@ -922,15 +922,13 @@
 S:	Maintained
 
 I2C AND SENSORS DRIVERS
-P:      Frodo Looijaard
-M:      frodol@dds.nl
-P:      Philip Edelbrock
-M:      phil@netroedge.com
 P:	Greg Kroah-Hartman
 M:	greg@kroah.com
-L:      sensors@stimpy.netroedge.com
-W:      http://www.lm-sensors.nu/
-S:      Maintained
+P:	Philip Edelbrock
+M:	phil@netroedge.com
+L:	sensors@stimpy.netroedge.com
+W:	http://www.lm-sensors.nu/
+S:	Maintained
 
 i386 BOOT CODE
 P:	Riley H. Williams

