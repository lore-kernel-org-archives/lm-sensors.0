From: Sanchayan Maity <maitysanchayan@gmail.com>
Date: Tue, 16 Feb 2016 05:12:52 +0000
Subject: [lm-sensors] [PATCH v3 0/3] Allow iio_hwmon to accept hypen in node names
Message-Id: <cover.1455597464.git.maitysanchayan@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, shawnguo@kernel.org
Cc: jdelvare@suse.com, stefan@agner.ch, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Sanchayan Maity <maitysanchayan@gmail.com>

Hello,

Initial versions of the patchset intended to introduce the use of
iio_hwmon for Vybrid SoC's. Currently the iio_hwmon driver has two
users and as per the binding documentation, the node names use the
underscore. Use of hypen in device tree node names is acceptable,
however currently the hwmon core code rejects it due to perhaps user
space not liking the hypen and getting confused.

As per Guenter Roeck's suggestion, the first patch looks for a hypen
and replaces it with a underscore in the probe call of iio_hwmon driver
before calling hwmon_device_register_with_groups for registration. Any
users of iio_hwmon driver can now use hypen in the node name.

As per Shawn's suggestion, the existing users have been changed to use
the hypen instead of the underscore and the iio-bindings document
updated. Third patch introduces the usage for Vybrid itself.

Patchset is based on top of shawn's for-next branch.

Feedbacks and comments most welcome. Thank you for feedbacks.

@Guenter
I hope I understood and implemented correctly what you had in mind.

Sample Output from Toradex Colibri VF50 module
root@colibri-vf:/sys/class/hwmon/hwmon0# ls
device       name         of_node      power        subsystem    temp1_input  temp2_input  uevent
root@colibri-vf:/sys/class/hwmon/hwmon0# cat name
iio_hwmon
root@colibri-vf:/sys/class/hwmon/hwmon0# uname -a
Linux colibri-vf 4.5.0-rc1-12868-g88b677c #48 SMP Tue Feb 16 10:05:28 IST 2016 armv7l GNU/Linux

v1:
https://lkml.org/lkml/2015/9/16/932

v2:
https://lkml.org/lkml/2016/2/12/168

Thanks & Regards,
Sanchayan Maity.

Sanchayan Maity (3):
  hwmon: iio_hwmon: Allow the driver to accept hypen in device tree node names
  ARM: dts: Change iio_hwmon nodes to use hypen in node names
  ARM: dts: vfxxx: Add iio_hwmon node for ADC temperature channel

 Documentation/devicetree/bindings/iio/iio-bindings.txt |  2 +-
 arch/arm/boot/dts/imx23.dtsi                           |  2 +-
 arch/arm/boot/dts/imx28.dtsi                           |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi                           |  5 +++++
 drivers/hwmon/iio_hwmon.c                              | 11 ++++++++++-
 5 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
