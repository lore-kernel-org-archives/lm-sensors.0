From: Ben Hutchings <bhutchings@solarflare.com>
Date: Wed, 04 Jun 2008 18:38:49 +0000
Subject: [lm-sensors] [PATCH 0/2] Hardware monitor drivers for Solarflare
Message-Id: <20080604183848.GF11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patches add support for the hardware monitors used on
Solarflare NIC reference designs.

The NatSemi LM87 is already well supported as a PC hardware monitor but the
lm87 driver requires the BIOS to initialise it.

The Maxim MAX6647 is not supported by any existing driver.

These add platform data structures and polling functions for these
drivers, which no other hwmon drivers currently have.  It may be that
there should be a generic API for in-kernel hwmon polling.

Ben. 

Ben Hutchings (2):
  lm87: Converted into a new-style driver configurable through
    platform_data.
  max664x: New driver for Maxim MAX6646/6647/6649 sensor chips

 drivers/hwmon/Kconfig   |   10 +
 drivers/hwmon/Makefile  |    1 +
 drivers/hwmon/lm87.c    |  460 +++++++++++++++++++++++++++--------------------
 drivers/hwmon/max664x.c |  353 ++++++++++++++++++++++++++++++++++++
 include/linux/lm87.h    |  132 ++++++++++++++
 include/linux/max664x.h |   97 ++++++++++
 6 files changed, 861 insertions(+), 192 deletions(-)
 create mode 100644 drivers/hwmon/max664x.c
 create mode 100644 include/linux/lm87.h
 create mode 100644 include/linux/max664x.h

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
