From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Feb 2013 07:50:56 +0000
Subject: Re: [lm-sensors] [Patch] ADT7411: Added attribute to the driver to set the power-down bit
Message-Id: <20130225085056.39720cef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

Please send patches to the lm-sensors mailing list. Any patch sent to
me only is likely to get lost.

On Sat, 23 Feb 2013 17:33:05 +0100, Michael Arndt wrote:
> I am using Analog ADT7411 in an embedded project, where I mainly
> use the internal temperature sensor.
> 
> Now the internal temperature readings get pretty bad if the sensor
> is powered for a couple of minutes, as it will heat itself up with
> about 10mW of power.
> 
> When the chip is powered down, it can do with about ~33uW of power, thus
> reducing the heat-up. Entering the power-down mode automatically would
> probably be the best thing, but we would need heuristics to decide when
> to power down, so this patch just adds a new attribute, so the chip
> can be manually powered down from sysfs.
> 
> In my case it really helps to keep the chip cool.

Please do not add a custom sysfs attribute for that. There is a nice
standard power management framework, please use it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
