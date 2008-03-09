From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Mar 2008 13:22:20 +0000
Subject: Re: [lm-sensors] Smart Fan etc
Message-Id: <20080309142220.747b70df@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1204878393.5849.3.camel@montecristo>
In-Reply-To: <1204878393.5849.3.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Joakim,

On Fri, 07 Mar 2008 09:26:33 +0100, Joakim Larsson wrote:
> I try understand how lm-sensors works and have a few questions:
> 
> - Should I turn off the Smart Fan feature in BIOS?

See my reply to your previous post.

> - Is lm-sensor superiour to aht Smart Fan does?

The BIOS "Smart Fan" feature can be implemented in different ways
depending on the board. Sometimes it is implemented by the hardware
monitoring chip itself and the BIOS is merely writing a few
configuration bits to the chip. In this case it is usually compatible
with lm-sensors, although not all drivers might expose the advanced
features configuration interface. In your case, the w83627ehf driver
exposes a lot of features so that shouldn't be a problem.

But sometimes it is implemented in software as ACPI or even SMM code.
In this case it will possibly conflict with lm-sensors, and you really
want to disable the feature in the BIOS if you are going to use
lm-sensors.

So I can't tell whether lm-sensors is better than what the BIOS does on
your particular board. Maybe both do exactly the same, maybe not.

You can tell in which case you are by checking the
files /sys/class/hwmon/hwmon0/device/pwm*_enable. The files read 1 for
manual mode and 2 for automatic fan speed mode. If changing the BIOS
option changes this value for at least one PWM channel, then you are
certainly in case #1 above, i.e. the BIOS merely changes the chip
configuration and the regulation is done all in hardware. If the files
read 1 all the time, then you are most likely in case #2.

> - Is having multiple brands of harddisks in a system a problem, do they
> have built in sensors?

lm-sensors doesn't support hard-disk drive temperature sensors at all
at the moment.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
