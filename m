From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 17 Jul 2015 21:33:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <20150717233338.0ae52805@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
	<20150715230734.76347af2@endymion.delvare>
	<D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
	<55A93365.4000702@roeck-us.net>
	<D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com>
	<55A94303.5040805@roeck-us.net>
	<D6EDEBF1F91015459DB866AC4EE162CCF76C3A@IRSMSX103.ger.corp.intel.com>
In-Reply-To: <D6EDEBF1F91015459DB866AC4EE162CCF76C3A@IRSMSX103.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Yu, Fenghua" <fenghua.yu@intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Lukasz,

On Fri, 17 Jul 2015 19:23:44 +0000, Odzioba, Lukasz wrote:
> On Friday, July 17, 2015 8:02 PM Guenter Roeck wrote:
> > Please explain why krealloc() won't work, why using krealloc(() would
> > result in a larger memory footprint than using lists, and why disabling
> > CPUs would require any action in the first place.
> 
> It will work, but it can use more memory for cpus with many cores.
> If you have just one core visible to the kernel with id 59 
> (i.e. the rest are disabled by hardware) out of 60-core cpu then you
> have to allocate an array of 60 pointers instead of just one element of

Arrays of pointers are cheap. You can fit 512 pointers in a single
memory page.

> the list. Of course you can say that for cpu with just one core list will
> use 3x the memory needed by array and that's true. I see no point in 
> arguing which case is more important, let's move on.

I see the point in arguing: the example above is just silly and does
not match any real-world application. Nobody buys a 60-core CPU to run
it with a single core enabled.

When you have two or more alternative implementations possible,
thinking in terms of the most common cases is a key to make the right
decision. Thinking about servers with a lots of CPU cores versus
embedded devices with few cores and tight memory constraints, that is
useful. Making up corner cases is not.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
