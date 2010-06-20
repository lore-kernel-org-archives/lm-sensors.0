From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 20 Jun 2010 16:37:59 +0000
Subject: [lm-sensors] Adding critical/fault limits to hwmon sysfs API
Message-Id: <20100620163759.GA7077@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

Hi,

the current hwmon sysfs API does not specify critical or fault limits for voltage
and current readings.

Many recent power controller/monitoring chips have support for such limits in addition
to alarm limits. Typical action, when a the critical or fault limit is reached,
may be a board reset or power shutdown, or to report the fault condition.

Examples for chips supporting critical/fault limits are SMM665 and variants as well
as many PMBus devices, such as MAX8688, MAX16064, LTC2978, and others.

I think it would make sense to add critical/fault limits to the hwmon sysfs API,
to be able to report those limits if supported by a chip.

Any thoughts on this ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
