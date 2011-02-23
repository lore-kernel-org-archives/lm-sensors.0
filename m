From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Feb 2011 03:54:14 +0000
Subject: [lm-sensors] New sysfs attribute for fan control: fan pulses per
Message-Id: <20110223035414.GA18074@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

while working on NCT6776F support, I realized that there is a fan control
attribute which is not currently supported by the syfs ABI: The number of
fan pulses per revolution. On the NCT6776F, this can be configured in Bank 6,
registers 0x44 to 0x46. Possible values are 0..3 for 4, 1, 2, or 3 pulses 
per revolution.

I encountered the same parameter when working on PMBus devices. At the time,
I thought this was a variant of a fan divisor (ie a divisor of 1, 2, 3, or 4),
but apparently it is different and independent of the fan divisor.

Question is if it would make sense to merge support for this attribute into fan[1-*]_div,
or if we should define a new attribute specifically for fan pulses per revolution.

Merging it into fan[1-*]_div would mean we would have to permit new values for it,
and we would need a more complex description. Changing the value could be ambiguous
if there is ever a chip which supports both fan divisor and pulse/revolution
configuration registers (NCT6776F and PMBus devices don't, so we would be safe there).

A new attribute (fanX_pulses ? fanX_ppr ?) would be more straightforward,
but ... it would be a new attribute.

Any thoughts ?

Thanks,
Guenter
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
