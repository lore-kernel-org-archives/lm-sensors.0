From: Arnaud Ebalard <arno@natisbad.org>
Date: Sun, 02 Jun 2013 20:14:05 +0000
Subject: [lm-sensors] [PATCHv3 0/3] Add G762/G763 PWM fan controller
Message-Id: <cover.1370202835.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

Hi,

This series adds support for GMT G762/G763. This work is based on a
basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
NAS. Updates have been performed to run on recent kernels. Support has
been completed and additional features added: ability to configure
various characteristics from .dts file, better initialization, alarms
and error reporting support, gear mode, polarity, fan pulse per
revolution, fan startup voltage control. The following detailed
datasheet has been used as a basis for this work:

  http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf

The patch was developed for and tested against the GMT G762 fan
controller used in a Netgear ReadyNAS Duo v2 (kirkwood 88F6282-based
NAS). This is the main reason for the device tree bindings provided in
first patch. The driver also support init via board file. The patches
are against current ARM tree; tell me if you need me to rebase it
against something else. Patch 2 and 3 provides documentation for the
driver and DT bindings, respectively.

As discussed in a previous email:

 - A macro is defined to pass values of platform data structure in
   board setup files. If one has a better approach ...
 - This v3 still has support for pwm1 sysfs entry in closed-loop mode.
   Guenter, if you still think it is a bad idea, I will change that
   in v4.

note: this should not be an issue but this v3 is based on
      jcooper/mvebu/fixes branch. 

Comments welcome,

Cheers,

a+

Changes since v2:
    set ref_clk value to 32768 if not overloaded
    fixed multi-line comment format in g762.h
    add spaces between operators when missing
    check return value of i2c_smbus_{read,write}_byte_data()
    { } is not needed in single-statement conditionals
    introduced G762_ATTR_VAL() to allow sparse init of platform_data struct
    changed reference to linear mode for DC mode in doc

Changes since v1
    Changed author
    removed bad tabs
    Provide datasheet link w/o fud in g762 documentation
    removed documentation for removed fan_gear_mode sysfs entry
    removed tested-by from patch
    removed FSF address in header file
    removed useless include of <linux/slab.h>
    removed useless parenthesis against HZ in define
    use spaces around binary operators
    use i2c_smbus_{read,write}_byte_data() instead of g762_{read,write}_value()
    use return value of i2c_smbus_write_byte_data()
    use true for initializing boolean
    removed useless blank lines
    do not enforce single return point rule where less readable
    use dev_err() and dev_dbg() instead of dev_info() when it makes sense
    remove leading '&' for function passed as pointers
    allow passing parameter via platform_data struct for non-DT enabled boards
    set data->valid to false when config is modified
    s/linear/DC/ for mode (g762 datasheet uses linear)
    more tests on rpm_from_cnt() and cnt_from_rpm() formula
    dont overload     

Changes since v0
    removed forward declaration 
    use bool for valid field instead of bit field.
    protect macro args
    fixed typo in subject line
    Added mention for G763 support in Kconfig
    fixed typo in driver name in Kconfig
    do not use DRVNAME in i2c_device_id g762_id[] 
    Following discussions, kept DEVICE_ATTR (i.e. no switch to SENSOR_DEVICE_ATTR)
    removed useless casts when flipping bit values
    Sanity check user input value (e.g. to prevent 256 to silenty become 0)
    Added extra lines for multi line comments when needed
    removed various testing knobs
    make removed knobs available via DT
    passed checkpatch script on the patch
    removed useless lock protection againt clk setting
    moved all setter at the beginning of the file
    removed bad (u16) casts in g762_write_value() calls


Arnaud Ebalard (3):
  Add support for GMT G762/G763 PWM fan controller
  Add documentation for g762 driver
  Add DT bindings documentation for g762 driver

 Documentation/devicetree/bindings/hwmon/g762.txt |   58 ++
 Documentation/hwmon/g762                         |   64 ++
 drivers/hwmon/Kconfig                            |   10 +
 drivers/hwmon/Makefile                           |    1 +
 drivers/hwmon/g762.c                             | 1179 ++++++++++++++++++++++
 include/linux/platform_data/g762.h               |   51 +
 6 files changed, 1363 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
 create mode 100644 Documentation/hwmon/g762
 create mode 100644 drivers/hwmon/g762.c
 create mode 100644 include/linux/platform_data/g762.h

-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
