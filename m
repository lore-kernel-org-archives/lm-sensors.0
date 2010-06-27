From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 27 Jun 2010 22:53:29 +0000
Subject: [lm-sensors] hwmon sysfs API: power attributes and PMBus devices
Message-Id: <20100627225329.GA7261@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am currently trying to match PMBus power related capabilities with the sysfs API.
Unfortunately, the power attributes in the sysfs API don't follow the other attributes,
so there is some degree of mismatch.

PMBus supports the following power limit registers:

PMBUS_POUT_OP_FAULT_LIMIT	Output power fault limit
PMBUS_POUT_OP_WARN_LIMIT	Output power warning limit
PMBUS_PIN_OP_WARN_LIMIT		Input power warning limit

the following status bits:

PB_POUT_OP_WARNING		Output power high warning
PB_POUT_OP_FAULT		Output power fault
PB_PIN_OP_WARNING		Input power high warning

and power usage registers for both input and output (PMBUS_READ_PIN and PMBUS_READ_POUT).

The sysfs API currently provides the following power attributes.

Attribute			Matching PMBus register

powerX_input			PMBUS_READ_PIN, PMBUS_READ_POUT
powerX_cap			PMBUS_POUT_OP_WARN_LIMIT / PMBUS_PIN_OP_WARN_LIMIT ?
				Not an exact match, since the API specifically requires
				that "This file only appears if the cap is known
                                to be enforced by hardware".
powerX_alarm			PB_POUT_OP_WARNING / PB_PIN_OP_WARNING ?
				Again not an exact match, since the API again requires
				that "This file only appears if the cap is known
                                to be enforced by hardware".

There is currently no support for powerX_crit (to reflect PMBUS_POUT_OP_FAULT_LIMIT)
and powerX_fault (to reflect PB_POUT_OP_FAULT).

Questions: 
- Can we remove the limitations of powerX_cap and powerX_alarm, ie no longer require
  that the cap has to be enforced by hardware ?
- If not, can we remove the requirement for powerX_alarm, and introduce powerX_max
  to specify an alarm limit ?
  That would actually be more in line with other "_max" attributes, so it might be
  a better solution.
- Can we add new attributes powerX_crit and powerX_fault ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
