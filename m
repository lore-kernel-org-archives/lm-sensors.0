From: Alex Gonzalez <langabe@gmail.com>
Date: Fri, 27 Aug 2010 14:04:32 +0000
Subject: [lm-sensors] Platform device driver for PMIC and lm-sensors
Message-Id: <AANLkTikQ=TNW_mZawRjiQQd2=3=zym6zG2v5a=0DzGBp@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am using a Freescale power management chip (MC13892) and a platform
driver provided by them that exposes battery information through the
sysfs as follows:

/ # ls /sys/class/power_supply/
mc13892_bat      mc13892_charger
/ # ls /sys/class/power_supply/mc13892_bat/
charge_now   device       status       type         voltage_now
current_now  power        subsystem    uevent
/ # ls /sys/class/power_supply/mc13892_charger/
device     online     power      subsystem  type       uevent

Is this type of platform device something that lm-sensors supports?
Any other user space application that can be configured to use the
sysfs information?

Thanks a lot,
Alex

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
