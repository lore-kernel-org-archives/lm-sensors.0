From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 13 Jul 2014 19:08:38 +0000
Subject: Re: [lm-sensors] lm-sensors: which temperature sensor is lying ?
Message-Id: <53C2D936.7040905@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
In-Reply-To: <20140712145751.GA14562@faui40p.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/13/2014 11:34 AM, Toerless Eckert wrote:
> Is there a way to figure out whether the temperatures
> from "coretemp-isa-0000, Adapter: ISA adapter" are coming from PECI
> or not ?
>
> Eg: Is there a way to ask the CPU itself for these temperature sensor
> data without using those PECI pins ?
>

That is exactly what coretemp is doing; it reads the temperature directly
from CPU registers. The SuperIO chip gets the data through PECI. It is
exactly the same data, though, ie the underlying sensor in the CPU is the same.
See [1] and [2] for some more details.

Neither PECI nor the internal sensor provide absolute temperatures,
but only a difference to the maximum permitted temperature or TjMax.

Both coretemp and the SuperIO chip driver have to be configured for the
maximum temperature in order to be able to calculate and report the temperature
in degrees C. On top of that, the reported value is known to be inaccurate
for lower temperatures. This means it can only really be relied on for high
temperatures, and the value reported for low temperatures can be highly
inaccurate (it can easily be 30 degrees C off for Atom CPUs, for example).
More recent Intel CPUs have a register to read Tjmax, but older CPUs
like yours don't, and there is always a guessing game what the correct
TjMax value for a given CPU may be. This becomes even more complicated
if different CPU revisions have different values for TjMax, as seems to be
the case for your dual core CPU. All one can hope for is that the BIOS programs
the SuperIO chip correctly, though it is quite common that this is not the case,
especially with older CPUs where the value of TjMax can not be read from the CPU
itself. Since SuperIO chips depend on the absolute temperature for automatic
fan speed control, this can cause problems with fan control, especially if the
CPU runs hotter than the SuperIO chip believes. I _suspect_ this may be what is
happening in your case with the quad core CPU, but obviously that is difficult
to confirm since we don't know any details about it.

Guenter

---
[1] http://en.wikipedia.org/wiki/Platform_Environment_Control_Interface
[2] http://www.intel.com/content/dam/www/public/us/en/documents/white-papers/cpu-monitoring-dts-peci-paper.pdf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
