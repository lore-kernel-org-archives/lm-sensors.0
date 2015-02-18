From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 18 Feb 2015 10:07:28 +0000
Subject: [lm-sensors] [PATCH v4 0/8] hwmon: thermal: Odroid U3: Provide support for Odroid U3 fan
Message-Id: <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Presented patches add support for Odroid's U3 optional CPU FAN, which uses PWM
subsystem for low level control.

After successful probe it registers itself as a cooling device for thermal
subsystem. To preserve the ability to use this fan as a PWM device stubs for
thermal_of_cooling_device_register() and thermal_cdev_update() have been added.

Additionally, devices without support for DTS are still supported.

To provide correct functionality, new properties to device tree description for 
Exynos4412 and in particular Odroid U3 have been added.

Those patches were tested on Exynos4412 - Odroid U3 board.

Patches were applied on:
linux-soc-thermal/next branch (Linux 3.19-rc5)
SHA1: 252454f5cbda2c6b40c5d36f58cac2938437b85d

Kamil Debski (1):
  ARM: dts: Add pwm-fan node to the Odroid-U3 board

Lukasz Majewski (7):
  thermal: Provide stub for thermal_of_cooling_device_register()
    function
  thermal: Provide stub for thermal_cdev_update() function
  Documentation: dts: Documentation entry to explain how to use PWM FAN
    as a cooling device
  ARM: dts: Add properties to use pwm-fan device as a cooling device in
    Odroid U3
  hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty
    cycle
  hwmon: pwm-fan: Read PWM FAN configuration from device tree
  hwmon: pwm-fan: Code for using PWM FAN as a cooling device

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  20 +++
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  44 ++++++
 drivers/hwmon/pwm-fan.c                            | 167 +++++++++++++++++++--
 include/linux/thermal.h                            |  22 ++-
 5 files changed, 236 insertions(+), 19 deletions(-)

-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
