From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 23 Apr 2013 22:05:43 +0000
Subject: [lm-sensors] [PATCHv1 0/3] hwmon: GMT G72/G763 PWM fan controller
Message-Id: <cover.1366753420.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
 <4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
 <20130419043555.GA14124@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>

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

The patch was developed for and tested against the GMT G762 fan
controller used in a Netgear ReadyNAS Duo v2 (kirkwood 88F6282-based
NAS). This is the main reason for the device tree bindings provided in
first patch. The patches are against current ARM tree; tell me if you
need me to rebase it against something else.

Patch 2 and 3 provides documentation for the driver and DT bindings, 
respectively.

I hope the comments provided on v0 have all been correctly taken into
account. A list of changes is provided below.

Comments welcome,

Cheers,

a+

Changes since v0:
    Removed forward declaration 
    Used bool for 'valid' field instead of bit field.
    Protected macro args
    Fixed typo in subject line
    Added mention for G763 support in Kconfig
    Fixed typo in driver name in Kconfig
    Do not use DRVNAME in i2c_device_id g762_id[] 
    Following discussions, kept DEVICE_ATTR (i.e. no switch to SENSOR_DEVICE_ATTR)
    Removed useless casts when flipping bit values
    Sanity check user input value (e.g. to prevent 256 to silenty become 0)
    Added extra lines for multiline comments when needed
    Removed various testing knobs
    Make removed knobs available via DT
    Passed checkpatch script on the patch
    Removed useless lock protection againt clk setting
    Moved all setter at the beginning of the file
    Removed bad (u16) casts in g762_write_value() calls
    Added config structure and helpers
    Provide specific helper to overload config from dts


Arnaud Ebalard (3):
  Add support for GMT G762/G763 PWM fan controller
  Add documentation for g762 driver
  Add DT documentation for g762 driver

 Documentation/devicetree/bindings/hwmon/g762.txt |   57 ++
 Documentation/hwmon/g762                         |   67 ++
 drivers/hwmon/Kconfig                            |   10 +
 drivers/hwmon/Makefile                           |    1 +
 drivers/hwmon/g762.c                             | 1058 ++++++++++++++++++++++
 5 files changed, 1193 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/hwmon/g762
 create mode 100644 drivers/hwmon/g762.c

-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
