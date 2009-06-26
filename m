From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 26 Jun 2009 08:10:31 +0000
Subject: [lm-sensors] [PATCH v2 0/2] hwmon: Add support for TI's
Message-Id: <20090626081031.GA4510@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean, Hans,

Here is an updated version of the tmp421 driver. I've fixed the issues
according to your review. Please take a closer look at the
is_visible() callback of the sysfs group. I'm using the attributes' index
to decide whether the file is visible or not.

Jean, I know you're on vacation, so take your time :)

BTW I spend some time with my girlfriend at the Cote d'Azur last
year. Probably the best vacation I've ever had. But speaking french is
very difficult :)

Thanks,
Andre

---
 Documentation/hwmon/tmp421 |   36 ++++
 drivers/hwmon/Kconfig      |   10 +
 drivers/hwmon/Makefile     |    1 
 drivers/hwmon/tmp421.c     |  349 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 396 insertions(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
