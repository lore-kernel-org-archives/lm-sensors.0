From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [PATCH 2.6] Update I2C maintainers entry
Message-Id: <20040205225214.271dff1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I propose the following update of the "I2C AND SENSORS DRIVERS" entry in
MAINTAINERS:

* Remove Frodo Looijaard. He isn't active in the project anymore, and
forwards everythings he receives to the mailing-list. More work for
everyone, and increased latency.

* Move your name to the top. This is more realistic since you are the
real maintainer of the i2c subsystem in 2.6.

* Reindent. Spaces were used instead of tabs.

Please apply,
Thanks.

--- linux-2.6.2/MAINTAINERS.orig	Thu Feb  5 22:24:46 2004
+++ linux-2.6.2/MAINTAINERS	Thu Feb  5 22:46:09 2004
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

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
