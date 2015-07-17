From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Date: Fri, 17 Jul 2015 19:23:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <D6EDEBF1F91015459DB866AC4EE162CCF76C3A@IRSMSX103.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
 <20150715230734.76347af2@endymion.delvare>
 <D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
 <55A93365.4000702@roeck-us.net>
 <D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com>
 <55A94303.5040805@roeck-us.net>
In-Reply-To: <55A94303.5040805@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Friday, July 17, 2015 8:02 PM Guenter Roeck wrote:
> Please explain why krealloc() won't work, why using krealloc(() would
> result in a larger memory footprint than using lists, and why disabling
> CPUs would require any action in the first place.

It will work, but it can use more memory for cpus with many cores.
If you have just one core visible to the kernel with id 59 
(i.e. the rest are disabled by hardware) out of 60-core cpu then you
have to allocate an array of 60 pointers instead of just one element of
the list. Of course you can say that for cpu with just one core list will
use 3x the memory needed by array and that's true. I see no point in 
arguing which case is more important, let's move on.

> "yet" is a key term here. Presumably you have insider information.

No I don't have such information.

> Unless you can share this information, I don't see the point of replacing
> an O(1) algorithm with O(n), especially since there is a relatively simple
> alternative available to support more CPUs.

Ok I understand that, and somewhat agree with that.

> Unless you clarify that Intel will introduce CPU IDs which cannot be used
> as array index because they are too sparse, I don't really see how the list 
> solution would consume less memory than an array of pointers, even if the 
> array is somewhat sparse. After all, a list consumes at least two pointers 
> per entry.

Ok maybe I should state that clearer, my bad. For my purposes removing limit
of supported cores or bumping it is all I need. Removing limit of maxid is 
just nice to have - nothing really practical any soon I guess.

I based this patch on Kirill's which used lists and then you guys did not
say that this is a bad idea, so I tried to solve problems reported earlier
- deadlocks and race conditions and submitted another version.

Maybe if I would start from scratch I would not ran into all this.
In general it is good that you found the weak point of it.

Thanks,
Lukas


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
