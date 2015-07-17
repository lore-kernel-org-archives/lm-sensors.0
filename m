From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 17 Jul 2015 19:11:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <20150717211103.66000d47@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
	<20150715230734.76347af2@endymion.delvare>
	<D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
	<55A93365.4000702@roeck-us.net>
	<D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com>
In-Reply-To: <D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Yu, Fenghua" <fenghua.yu@intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Fri, 17 Jul 2015 17:28:20 +0000, Odzioba, Lukasz wrote:
> From: Guenter Roeck [mailto:linux@roeck-us.net] 
> On Friday, July 17, 2015 6:55 PM Guenter Roeck wrote:
> 
> > You don't really explain why your approach would be better than
> > allocating an array of pointers to struct temp_data and increasing
> > its size using krealloc if needed.
> 
> Let's consider two cases of such implementation:
> a) we use array of pointers with O(n) access algorithm
> b) we use array of pointers with O(1) access algorithm
> 
> In both cases an array will have greater memory footprint unless
> we implement reallocation ourselves when cpus are disabled which will
> make code harder to maintain.

I see no reason to reallocate when CPUs are disabled. This is rare
enough that I very much doubt we care.

> Case b) does not handle huge core ids and sparse enumeration well -
> it is still to discuss whether we really need it since there is no
> such hardware yet.

If you don't have a use case, I see no reason to change anything.

If you have a use case, it would be nice to tell us what it is, so that
we can make better comments on your proposal.

> I am not saying that my solution is the best of possible ones.
> I am saying that "the best" can vary depending on which criteria do you
> choose from (time, memory, clean code...). Some may say that O(n) is
> fine unless we have thousands of cores and this code is not on hot path,
> others may be concerned more about memory on small/old devices.
> I don't see holy grail here, If you see one please let me know.

The problem is that the lookup algorithm is only one piece of the
puzzle. When a user runs "sensors" or any other monitoring tool, you'll
do the look-up once for each logical CPU, or even for every attribute
of every CPU. So we're not talking about n, we're talking about
5 * n^2. And that can happen every other second. So while you may not
call it a "hot path", this is still frequent enough so I am worried
about performance aka algorithmic complexity.

Switching from linear complexity to quadratic complexity "because n is
going to increase soon" is quite opposite to what I would expect.

> If you think that we don't have to care so much about memory,
> then I can create another patch which uses array instead of list.

I'm not so worried about memory. Did you actually check how many bytes
of memory were used per supported logical CPU?

We could just drop NUM_REAL_CORES and use CONFIG_NR_CPUS instead, I
would be fine with that. This lets people worried about memory
consumption control it.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
