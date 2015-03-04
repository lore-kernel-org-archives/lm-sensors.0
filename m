From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 04 Mar 2015 12:03:38 +0000
Subject: [lm-sensors] [PATCH RESEND RESEND v6 0/6] hwmon: thermal: Odroid U3: Provide support for Odroid U3 f
Message-Id: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
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
subsystem.

This driver also supports devices without DTS specified.

To provide correct functionality, new properties to device tree description for
Exynos4412 and in particular Odroid U3 have been added.

Those patches were tested at Exynos4412 - Odroid U3 board.

Patches were applied on:
linux-soc-thermal/fixes branch (Linux v4.0-rc2)
SHA1: ad83a2d87bff355750a17dd00aec563eb9f9d388


Kamil Debski (1):
  ARM: dts: Add pwm-fan node to the Odroid-U3 board

Lukasz Majewski (5):
  Documentation: dts: Documentation entry to explain how to use PWM FAN
    as a cooling device
  ARM: dts: Add properties to use pwm-fan device as a cooling device in
    Odroid U3
  hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty
    cycle
  hwmon: pwm-fan: Read PWM FAN configuration from device tree
  hwmon: pwm-fan: Code for using PWM FAN as a cooling device

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  29 +++-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  43 ++++++
 drivers/hwmon/pwm-fan.c                            | 172 +++++++++++++++++++--
 4 files changed, 229 insertions(+), 17 deletions(-)

-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
