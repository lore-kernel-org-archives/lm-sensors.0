From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Thu, 12 Nov 2009 07:44:25 +0000
Subject: [lm-sensors] [RFC PATCH 0/1] Driver for ami305 magnetometer
Message-Id: <1258011866-25972-1-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-input@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>

This patch provides driver for two sw compatible 3 axis magnetometer chips
(AMI305 / AK8974). 
Driver provides coordinates as polled input device.
Chip can provide interrupt when the measurement result is ready, but
this feature is not used. Instead, new measurement is started at polling
event frequency. This method allows more flexible measurement interval.
Activity level at kernel side is about the same in both interrupt and polling
based methods. Furhtermore, this eliminate need to use interrupt line at HW
level. 

Chip is powered on when the polled device is opened and powered down when the
device is closed. Axes can be remapped via platform data. 

sysfs interface:
selftest - Perform chip specific selftest as specified by manufacturer
active - returns chip power state: ON or OFF
fuzz - adjust input system "fuzziness" parameter

Patch is applicable to Dmitry Torokhov's input tree - next branch. 
This tree was selected since patch requires a change to polled
input device which is allready in that tree (open / close methods).

Samu Onkalo (1):
  AMI305 magnetometer driver

 drivers/misc/Kconfig       |   11 +
 drivers/misc/Makefile      |    1 +
 drivers/misc/ami305.c      |  644 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/ami305.h |   22 ++
 4 files changed, 678 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/ami305.c
 create mode 100644 include/linux/i2c/ami305.h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
