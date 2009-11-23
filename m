From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 23 Nov 2009 15:29:25 +0000
Subject: Re: [lm-sensors] [PATCH v3] k10temp: temperature sensor for AMD
Message-Id: <4B0AAA55.3040702@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de>	<4B06501B.8080509@ladisch.de>	<87ws1l5wcl.fsf@depni.sinp.msu.ru>	<4B0673D7.5010006@ladisch.de>	<20091120123016.19d98ab4@hyperion.delvare>	<4B068402.7020606@ladisch.de>	<20091120131855.7f8f8722@hyperion.delvare>	<4B0A3DB6.9090703@ladisch.de> <20091123145154.5b2b5735@hyperion.delvare>
In-Reply-To: <20091123145154.5b2b5735@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Mon, 23 Nov 2009 08:45:58 +0100, Clemens Ladisch wrote:
>>  Documentation/hwmon/k10temp |   57 ++++++++++++
>>  drivers/hwmon/k10temp.c     |  142 ++++++++++++++++++++++++++++++++
> 
> The name k10temp is a problem, as AMD insists that there is no such
> things as K10 and K11, but instead "family 10h" and "family 11h"
> processors.

K10 was AMD's internal code name, and is widely used in practice.
I'd like to keep this name since it is consistent with the older
k8temp driver.

What name would you propose instead?  "amdfam10temp"?

>> +  control cooling systems. Tctl is a non-physical temperature on an
>> +  arbitrary scale measured in degrees. It does _not_ represent an actual
>> +  physical temperature like die or case temperature. Instead, it specifies
>> +  the processor temperature relative to the point at which the system must
>> +  supply the maximum cooling for the processor's specified maximum case
>> +  temperature and maximum thermal power dissipation.
>> +
>> +The maximum value for Tctl is defined as 70 degrees, so, as a rule of thumb,
>> +this value should not exceed 60 degrees.
> 
> Now I am puzzled. If the temperature value is on an arbitrary scale,
> then the value returned by the driver is essentially fake?

Yes (and it's near enough the absolute value to look plausible).

> Don't we have additional information about the actual maximum Tcase
> value for the different supported models, as we have in coretemp?

For AMD, Tcase is the physical temperature.  Did you mean Tctl?

I'll add Tctl max (= "100% cooling, please") as temp1_max, and there's
a register that contains the Tctl value at which the processor starts
throttling, which could be exported as temp1_crit(_hyst), if I
understand the lm-sensors documentation correctly.

As for your other comments, I'll integrate them in the next version of
the patch.


> If not, then it might be the right time to introduce a new interface
> for relative temperature values. This needs some work, as we must first
> define the interface, then implement support in libsensors and sensors,
> and other monitoring applications, and then convert the affected
> drivers. But apparently we will have to, as major CPU makers are not
> able to implement something as simple as an absolute temperature
> sensor :(

There still is the built-in diode to be read by the motherboard, but the
internal sensor was never intended to be an absolute measurement but
just as a means for controlling the cooling.



Best regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
