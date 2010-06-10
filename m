From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Jun 2010 08:35:31 +0000
Subject: Re: [lm-sensors] control f71889fg pwm on 2.6.34
Message-Id: <20100610103531.45729e3c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimzIutXVn2W2ZE1LQ-dXbNEMfuUfJ4G1733cFsM@mail.gmail.com>
In-Reply-To: <AANLkTimzIutXVn2W2ZE1LQ-dXbNEMfuUfJ4G1733cFsM@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roman,

On Wed, 2 Jun 2010 20:57:15 +0400, Roman Evstifeev wrote:
> Hi. I have Mainboard* with F71889FG-based controller.
> * - MSI P41T-C31 (
> http://www.msi.com/index.php?func=proddesc&maincat_no=1&prod_no92 )
> 
> After f71882fg module loaded - it creates bunch of the sysfs entries, and i
> can succesfully read temperature and fan speed values from it. But i can't
> control the pwm with it.
> I tried pwmconfig utility as well as writing to sysfs files directly. sysfs
> values get changed, but actual fan speed does not.
> (...)

Does the vendor advertise any form of fan speed (or noise) control on
this board? In the manual or in the BIOS? The PWM outputs of your chip
may simply not be wired on your board. It's not listed in SpeedFan's
database as being fan-control-capable:
http://www.almico.com/forummotherboards.php?man&9

So unless you have a good reason to believe that fan control should
work on your board, I am inclined to believe this is a hardware
limitation and not a driver bug.

> **************** trying manual control ************
> linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3_enable
> 1
> linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3
> 255
> linux-md9k:/sys/class/hwmon # echo 140 > hwmon2/device/pwm3
> linux-md9k:/sys/class/hwmon # echo 0 > hwmon2/device/pwm3
> linux-md9k:/sys/class/hwmon # cat hwmon2/device/pwm3
> 0
> *********************************************************

Have you tried pwm1 and pwm2? On many boards, only one fan can be
controlled, so only one PWM output is working.

You should try our "pwmconfig" script to automatically test all PWM
outputs.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
