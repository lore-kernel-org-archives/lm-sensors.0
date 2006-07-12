From: gregkh@suse.de (gregkh at suse.de)
Date: Wed, 12 Jul 2006 21:17:06 +0000
Subject: [lm-sensors] patch hwmon-w83791d-maintainer.patch added to
Message-Id: <20060712212128.F034D7C5165@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: hwmon: New maintainer for w83791d

to my gregkh-2.6 tree.  Its filename is

     hwmon-w83791d-maintainer.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Wed Jul  5 09:05:22 2006
Date: Wed, 5 Jul 2006 18:05:15 +0200
From: Charles Spirakis <bezaur at gmail.com>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>, Charles Spirakis <bezaur at gmail.com>
Subject: hwmon: New maintainer for w83791d
Message-Id: <20060705180515.97a0691d.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-w83791d-maintainer.patch

From: Charles Spirakis <bezaur at gmail.com>

Add Charles Spirakis as the maintainer for the w83791d sensor chip
driver.

Signed-off-by: Charles Spirakis <bezaur at gmail.com>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- gregkh-2.6.orig/MAINTAINERS
+++ gregkh-2.6/MAINTAINERS
@@ -3182,6 +3182,12 @@ P:	Evgeniy Polyakov
 M:	johnpol at 2ka.mipt.ru
 S:	Maintained
 
+W83791D HARDWARE MONITORING DRIVER
+P:	Charles Spirakis
+M:	bezaur at gmail.com
+L:	lm-sensors at lm-sensors.org
+S:	Maintained
+
 W83L51xD SD/MMC CARD INTERFACE DRIVER
 P:	Pierre Ossman
 M:	drzeus-wbsd at drzeus.cx


Patches currently in gregkh-2.6 which might be from bezaur at gmail.com are

i2c/hwmon-w83791d-maintainer.patch

