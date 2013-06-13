From: Reinhard Pfau <reinhard.pfau@gdsys.cc>
Date: Thu, 13 Jun 2013 10:40:18 +0000
Subject: [lm-sensors] hwmon: add support for SMSC EMC2305/03/02/01 fan controller
Message-Id: <1371120019-1744-1-git-send-email-reinhard.pfau@gdsys.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, Dirk Eibach <eibach@gdsys.de>, Dirk Eibach <dirk.eibach@gdsys.cc>

Hi,

I would like to provide a driver for the SMSC EMC2305 fan controller which
we use in our devices in the hope that others might find it useful, too.                 

The driver also supports the SMSC EMC2303, EMC2302 and EMC2301 fan
controller chips which have same functionality and register layout, but
support less fans.

Testing is done only with EMC2305 fan controller (since this is the chip we
use; support for the other chips was included by using data sheets only) on
a PowerPC platform. Driver was tested as module and builtin.

The patch also adds me to the MAINTAINERS for this driver.

Greetings,
Reinhard Pfau

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
