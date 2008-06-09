From: Ben Hutchings <bhutchings@solarflare.com>
Date: Mon, 09 Jun 2008 11:13:31 +0000
Subject: [lm-sensors] [PATCH] max664x driver [2nd try]
Message-Id: <20080609111329.GB11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since the first version, I have renamed the device attributes to match
the patterns that libsensors expects and changed some structure members
into arrays to match these.  Tested with lm_sensors 3.0.2.

Ben.

Ben Hutchings (1):
  max664x: New driver for Maxim MAX6646/6647/6649 sensor chips

 drivers/hwmon/Kconfig   |   10 ++
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/max664x.c |  355 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/max664x.h |   92 ++++++++++++
 4 files changed, 458 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/max664x.c
 create mode 100644 include/linux/max664x.h

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
