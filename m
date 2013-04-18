From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 18 Apr 2013 22:27:57 +0000
Subject: [lm-sensors] [RFC, PATCHv0 0/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <cover.1366322287.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Olivier Mouchet <olivier.mouchet@gmail.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>

Hi,

This series adds support for GMT G762/G763. This work is based on a
basic version for 2.6.31 kernel developed Olivier Mouchet (kept as
author for this reason in g762.c) for LaCie NAS. Updates have been
performed to run on recent kernels. Supported has been completed and
additional features added: ability to configure various characteristics
from .dts file, better initialization, alarms and error reporting
support, gear mode, polarity, fan pulse per revolution, fan startup
voltage control. The following detailed datasheet has been used as a
basis for this work:

  http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf

The purpose for this v0 is to get some feedback on the mistakes I may
have made or missing things to get the patch accepted.

The patch was developed for and tested against the GMT G762 fan
controller used in a Netgear ReadyNAS Duo v2 (kirkwood 88F6282-based
NAS). This is the main reason for the device tree bindings provided in
first patch. The patches are against current ARM tree; tell me if you
need me to rebase it against something else.

Patch 2/3 provides documentation for DT bindings. Documentation for the
sysfs interface provided by the driver is available in patch 3/3.

As a side note, I found it difficult to extend g760a driver to add g762
features; hence the new g762.c file.

Comments welcome,

Cheers,

a+

Arnaud Ebalard (3):
  Add support for GMT G72/G763 PWM fan controller
  Add DT documentation for G762 PWM fan controller
  Add documentation for g762 driver

 Documentation/devicetree/bindings/hwmon/g762.txt |   37 +
 Documentation/hwmon/g762                         |   89 ++
 drivers/hwmon/Kconfig                            |   10 +
 drivers/hwmon/Makefile                           |    1 +
 drivers/hwmon/g762.c                             | 1159 ++++++++++++++++++++++
 5 files changed, 1296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/hwmon/g762
 create mode 100644 drivers/hwmon/g762.c

-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
