From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 Oct 2009 14:24:12 +0000
Subject: Re: [lm-sensors] How do you make lm_sensors see a hwmon device?
Message-Id: <20091011162412.58774b20@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AD1E14B.90604@shikadi.net>
In-Reply-To: <4AD1E14B.90604@shikadi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adam,

On Sun, 11 Oct 2009 23:44:43 +1000, Adam Nielsen wrote:
> I've written a driver for a USB device that has a number of sensors on it
> (it's a PC power supply with a USB cable for voltage/current monitoring) and
> the device appears in the hwmon class.
> 
> Unfortunately I can't figure out how to make lm_sensors "see" it (when I run
> "sensors" it isn't displayed, and programs like gkrellm that use lm_sensors
> don't see the device or its sensors.)  The files all seem to be in the same
> place as other devices which work, and I'm running a fairly recent version of
> lm_sensors (3.0.3.)
> 
> Any ideas how to make my device appear to lm_sensors?
> 
> $ ls /sys/class/hwmon/hwmon[45]/device/name
> -r--r--r-- 1 root root 4.0K 2009-10-11 22:55 /sys/class/hwmon/hwmon4/device/name
> -r--r--r-- 1 root root 4.0K 2009-10-11 23:24 /sys/class/hwmon/hwmon5/device/name
> 
> $ cat /sys/class/hwmon/hwmon[45]/device/name
> coretemp
> odin
> 
> $ cat /sys/class/hwmon/hwmon[45]/device/temp1_input
> 50000
> 39000

Looks good so far. What are the underlying device types for your
devices (what does their "subsystem" link point to)? libsensors names
devices uniquely, partly based on the device type. If it doesn't know
the type, it ignores the device. In particular we don't have support
for USB yet... that could be the problem.

It might be difficult to come up with a device numbering convention for
USB devices that will fit in what libsensors expectes, given to the
unlimited nature of USB daisy-chaining. But hopefully we can come up
with something good enough for the most common cases.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
