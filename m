From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 19 May 2009 08:05:56 +0000
Subject: [lm-sensors] [PATCH v2 0/3] tmp401: Add support for TI's TMP401/411
Message-Id: <20090519080556.GA5200@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, Hans,

this is version v2 of the tmp401 driver patch series.

I've added some documentation and fixed the issues of your review (see
changes in patch 2/3).

Thanks,
Andre
---
 Documentation/hwmon/sysfs-interface |   19 
 Documentation/hwmon/tmp401          |   42 ++
 drivers/hwmon/Kconfig               |   10 
 drivers/hwmon/Makefile              |    1 
 drivers/hwmon/tmp401.c              |  689 ++++++++++++++++++++++++++++++++++++
 5 files changed, 761 insertions(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
