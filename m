From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 27 May 2013 22:02:29 +0000
Subject: [lm-sensors] [PATCHv2 0/3] Add G762/G763 PWM fan controller
Message-Id: <cover.1369687670.git.arno@natisbad.org>
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

I think most of the comments provided on v0 and v1 have been taken into
account. A detailed list of changes is provided below.

Nonetheless, some remarks made during previous review need some specific
feedback:

 Full speed mode: I started looking how I could emulate full speed mode
 (i.e. sysfs value 0 for "pwm_enable") but I found no easy way to do it
 w/o making things quite complex because the feature is orthogonal to
 fan loop mode (closed or open). This would imply setting *both*
 G762_REG_SET_CNT and G762_REG_SET_OUT registers (respectively for
 closed-loop and open-loop) to their max value (so that a loop mode
 change does not reset full speed), and also keep an internal flag to
 record the fact we are in full speed mode instead of reading current
 mode (PWM or DC) from the device register value. I took a look at some
 other drivers (w83793.c, w83l786ng.c, etc) to see how those emulate the
 feature and they just do not. What do you think?

 Support for board init code: in order to support setting hardware
 characteristics via board init file, I provided a (static const)
 init structure with all the fields of struct g762_platform_data set to
 a specific value (G762_DEFAULT_NO_OVERLOAD). The structure can be used in
 a board init file to initialize a local structure for which specific
 fields can then be given meaningful values. Those which are not
 overloaded will not be pushed to the chip. This is in sync with the
 common policy for hwmon drivers not to change the device configuration
 by default. If you see a more proper way to do it - other than the
 static const struct - I'd be happy to make the change.
 
 Setting mode before fan target value: Guenter, you made a remark about
 the undesirable context to have to set the mode (closed-loop) before 
 setting the fan target. I can change the code and accept the fan target
 value in all cases but this will have no impact before the mode is
 set to closed-loop. At the moment, the user gets a feedback it should
 set the mode before using fan1_target (i.e. invalid value). What do you
 think?

Comments welcome,

Cheers,

a+

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

 Documentation/devicetree/bindings/hwmon/g762.txt |   57 ++
 Documentation/hwmon/g762                         |   64 ++
 drivers/hwmon/Kconfig                            |   10 +
 drivers/hwmon/Makefile                           |    1 +
 drivers/hwmon/g762.c                             | 1012 ++++++++++++++++++++++
 include/linux/platform_data/g762.h               |   54 ++
 6 files changed, 1198 insertions(+)
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
