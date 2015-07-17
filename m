From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 17 Jul 2015 19:36:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <55A95942.4060605@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>	<20150715230734.76347af2@endymion.delvare>	<D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>	<55A93365.4000702@roeck-us.net>	<D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com> <20150717211103.66000d47@endymion.delvare>
In-Reply-To: <20150717211103.66000d47@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Jean,

On 07/17/2015 12:11 PM, Jean Delvare wrote:

>
> We could just drop NUM_REAL_CORES and use CONFIG_NR_CPUS instead, I
> would be fine with that. This lets people worried about memory
> consumption control it.
>
Unfortunately this won't work because the CPU ID is non-linear;
an 8-core system may have a CPI ID larger than 7.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
