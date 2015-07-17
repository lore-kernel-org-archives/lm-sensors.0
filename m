From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 17 Jul 2015 21:25:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <20150717232507.1839182e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
	<20150715230734.76347af2@endymion.delvare>
	<D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
	<55A93365.4000702@roeck-us.net>
	<D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com>
	<20150717211103.66000d47@endymion.delvare>
	<55A95942.4060605@roeck-us.net>
In-Reply-To: <55A95942.4060605@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, 17 Jul 2015 12:36:34 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On 07/17/2015 12:11 PM, Jean Delvare wrote:
> 
> >
> > We could just drop NUM_REAL_CORES and use CONFIG_NR_CPUS instead, I
> > would be fine with that. This lets people worried about memory
> > consumption control it.
>
> Unfortunately this won't work because the CPU ID is non-linear;
> an 8-core system may have a CPU ID larger than 7.

Oh right, I forgot about that. Brilliant hardware/firmware engineers...

Well that does not prevent us from using CONFIG_NR_CPUS, "just" the
code would need to be modified to remove the assumption that the array
index matches the logical CPU ID.

BTW I wonder how the rest of the kernel handles the situation.
CONFIG_NR_CPUS is used where relevant so there certainly _is_ a linear
numbering which is independent from the CPU ID.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
