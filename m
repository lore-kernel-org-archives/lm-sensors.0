From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Oct 2008 15:53:04 +0000
Subject: Re: [lm-sensors] Problem with it87 module from Linux 2.6.26 onward
Message-Id: <20081019175304.15f36a0a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081018211807.1d1f17a5@hyperion.delvare>
In-Reply-To: <20081018211807.1d1f17a5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Johannes,

On Sun, 19 Oct 2008 17:02:26 +0200, Johannes Truschnigg wrote:
> Hope my above paragraph serves a bit better than my initial report - for sake 
> of completeness, when starting fancontrol, I now get:
> 
> ###snip###
> Enabling PWM on fans...
> /usr/sbin/fancontrol: line 232: hwmon1/device/pwm1: No such file or directory
> Error enabling PWM on /sys/class/hwmon/hwmon1/device/pwm1
> Aborting, restoring fans...
> /usr/sbin/fancontrol: line 189: hwmon1/device/pwm1: No such file or directory
> Verify fans have returned to full speed
> ###snip###

OK, I think I know what's going on. More likely the it87 driver is
behaving just fine but kernel 2.6.26 finds one more hwmon device on
your system (most likely an ACPI thermal zone) and this shifts the
hwmon class devices by one, i.e. your it87 device is now hwmon2 instead
of hwmon1. Just check under /sys/class/hwmon. You can read the "name"
attributes under each class device's parent directory to find out who
is who:

grep . /sys/class/hwmon/*/device/name /sys/class/hwmon/*/name 2>/dev/null

So most probably you can fix fancontrol by simply replacing all
occurrences of hwmon1 by hwmon2 in /etc/fancontrol. This is where it
would help if we could reference hwmon drivers by name rather than by
class device number, but we don't have support for this yet.

> Thank you very much for your kind and prompt reply! FOSS support actually 
> rocks :)

You're welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
