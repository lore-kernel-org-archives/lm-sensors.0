From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Jun 2014 14:38:46 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (w83l786ng) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53A98D76.5090406@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403609228.348.1.camel@phoenix>
In-Reply-To: <1403609228.348.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/24/2014 04:27 AM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> The 'sensors' command never worked with this driver, fixed with this conversion.
>
Hi Axel,

You'd have to be a bit more specific here. Why ? It is not obvious to me.
If you mean the 'name' attribute, that is created by the i2c subsystem.

The driver is buggy, though. It shows the current fan speed as minimum fan speed.
Typical bug that can happen easily with function macros. But that is a different
problem.

The driver could also benefit from some cleanup. It wastes code space by using
function macros instead of SENSOR_ATTR_2, and functions should be reordered
to get rid of forward declarations. Difficult to do without HW or at least
simulation, though. Jean, do you have a register dump, by any chance ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
