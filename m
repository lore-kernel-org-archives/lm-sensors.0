From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 15 Jun 2009 07:42:54 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: Add driver tmp421
Message-Id: <20090615074254.GA4667@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, hello Hans,

here is the tmp421 driver. It supports TI's TMP421/422/423 chips. I've
tested the driver with Hans' great welcome gift, the
tiny-usb-adapter. Further I played a bit with the dump to test remote
sensors, extended temperature range, etc.

Thanks,
Andre
---

 Documentation/hwmon/tmp421 |   36 ++++
 drivers/hwmon/Kconfig      |   10 +
 drivers/hwmon/Makefile     |    1 
 drivers/hwmon/tmp421.c     |  331 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 378 insertions(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
