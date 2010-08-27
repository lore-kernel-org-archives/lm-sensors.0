From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Aug 2010 14:21:38 +0000
Subject: Re: [lm-sensors] Platform device driver for PMIC and lm-sensors
Message-Id: <20100827162138.2a987795@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikQ=TNW_mZawRjiQQd2=3=zym6zG2v5a=0DzGBp@mail.gmail.com>
In-Reply-To: <AANLkTikQ=TNW_mZawRjiQQd2=3=zym6zG2v5a=0DzGBp@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

On Fri, 27 Aug 2010 16:04:32 +0200, Alex Gonzalez wrote:
> I am using a Freescale power management chip (MC13892) and a platform
> driver provided by them that exposes battery information through the
> sysfs as follows:
> 
> / # ls /sys/class/power_supply/
> mc13892_bat      mc13892_charger
> / # ls /sys/class/power_supply/mc13892_bat/
> charge_now   device       status       type         voltage_now
> current_now  power        subsystem    uevent
> / # ls /sys/class/power_supply/mc13892_charger/
> device     online     power      subsystem  type       uevent
> 
> Is this type of platform device something that lm-sensors supports?

No. lm-sensors supports hwmon class devices, which implement the API
described in Documentation/hwmon/sysfs-interface. You driver apparently
doesn't implement this (unless it _also_ creates an hwmon class device,
check it...)

> Any other user space application that can be configured to use the
> sysfs information?

Not that I know of. If you want to monitor the values, best would be to
simply have an hwmon class device created for the device, either by the
driver itself, or through a generic power_supply -> hwmon bridge driver
if this makes sense.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
