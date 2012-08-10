From: Bitan Biswas <bbiswas@nvidia.com>
Date: Fri, 10 Aug 2012 14:30:14 +0000
Subject: [lm-sensors] hwmon : raw reading -> temperature conversion
Message-Id: <50251826.9020303@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org, guenter.roeck@ericsson.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Stephen Warren <swarren@nvidia.com>

Hi,

I have a question related to hwmon driver and need suggestions.

I am working on a temperature sensor driver that is hwmon driver.
- The temperature is calculated from raw sensor reading and
certain initialization parameters.
- Raw reading obtained from 2 different sensor instances under
same conditions can differ. Further, initialization parameters
are specific to each hardware instance.
- Expressions with floating point operands are used to compute
the temperature value.

In our platform there are multiple kernel level clients to the
temperature sensor driver.
Hence I am planning to present temperature to these clients
from kernel driver itself.

But looking at the hwmon linux documentation, seems the sensor
kernel drivers should report only raw readings.
The raw readings can be converted into required output,
e.g. temperature in this case, by respective user space implementation.

However because of my driver clients being in kernel space, I am
thinking of doing fixed point calculations in the sensor driver
and get the temperature corresponding to raw sensor readings.

Please let me know if this a correct approach?

If there is a better way, please suggest.

-regards,
Bitan



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
