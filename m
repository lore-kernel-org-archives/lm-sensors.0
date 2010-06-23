From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Jun 2010 12:43:46 +0000
Subject: Re: [lm-sensors] Adding critical/fault limits to hwmon sysfs API
Message-Id: <20100623144346.10acd898@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100620163759.GA7077@ericsson.com>
In-Reply-To: <20100620163759.GA7077@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Guenter,

On Sun, 20 Jun 2010 09:37:59 -0700, Guenter Roeck wrote:
> the current hwmon sysfs API does not specify critical or fault limits for voltage
> and current readings.
> 
> Many recent power controller/monitoring chips have support for such limits in addition
> to alarm limits. Typical action, when a the critical or fault limit is reached,
> may be a board reset or power shutdown, or to report the fault condition.
> 
> Examples for chips supporting critical/fault limits are SMM665 and variants as well
> as many PMBus devices, such as MAX8688, MAX16064, LTC2978, and others.
> 
> I think it would make sense to add critical/fault limits to the hwmon sysfs API,
> to be able to report those limits if supported by a chip.
> 
> Any thoughts on this ?

I agree it would be good to have standard names (and libsensors
support) if these features are popular. It might be a little difficult
to come up with the right attribute names though.

For temperatures, we have temp[1-*]_crit, for the critical limit on the
high end. We don't have a name for the critical limit on the low end,
because no chip ever implemented that. The name we chose doesn't offer
much possibilities for a nice name while staying consistent. Maybe
"lcrit" would be acceptable for the low end critical limit, and we keep
"crit" for the high end critical limit?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
