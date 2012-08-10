From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 10 Aug 2012 18:43:26 +0000
Subject: Re: [lm-sensors] hwmon : raw reading -> temperature conversion
Message-Id: <20120810184326.GA4625@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50251826.9020303@nvidia.com>
In-Reply-To: <50251826.9020303@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bitan Biswas <bbiswas@nvidia.com>
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Stephen Warren <swarren@nvidia.com>

On Fri, Aug 10, 2012 at 07:48:14PM +0530, Bitan Biswas wrote:
> Hi,
> 
> I have a question related to hwmon driver and need suggestions.
> 
> I am working on a temperature sensor driver that is hwmon driver.
> - The temperature is calculated from raw sensor reading and
> certain initialization parameters.
> - Raw reading obtained from 2 different sensor instances under
> same conditions can differ. Further, initialization parameters
> are specific to each hardware instance.
> - Expressions with floating point operands are used to compute
> the temperature value.
> 
> In our platform there are multiple kernel level clients to the
> temperature sensor driver.
> Hence I am planning to present temperature to these clients
> from kernel driver itself.
> 
> But looking at the hwmon linux documentation, seems the sensor
> kernel drivers should report only raw readings.
> The raw readings can be converted into required output,
> e.g. temperature in this case, by respective user space implementation.
> 
"raw" means the value as reported to the sensor. For example, for an ADC, the
raw value means the voltage in mV as seen on the sensor's input pins. This
voltage is the voltage to be reported. Converting it to a "real" voltage as,
typically, determined by a set of voltage divider resistors should be done in
user space.

For temperature sensors this is a bit more tricky. Presumably you get readings
from a thermistor or similar. The hwmon subsystem includes a driver for NTC
thermistors; maybe you can get some ideas from it. Maybe you can even use
it and/or extend it to support your hardware.

> However because of my driver clients being in kernel space, I am
> thinking of doing fixed point calculations in the sensor driver
> and get the temperature corresponding to raw sensor readings.
> 
> Please let me know if this a correct approach?
> 
Question is really what chip you are using, and how exactly your hardware looks
like. Do you use a generic ADC ? If so, is it already supported in the kernel ?
How are the thermistor readings converted and reported to SW ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
