From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 17 Jul 2015 16:55:01 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <55A93365.4000702@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com> <20150715230734.76347af2@endymion.delvare> <D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
In-Reply-To: <D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>, Jean Delvare <jdelvare@suse.de>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 07/16/2015 06:17 AM, Odzioba, Lukasz wrote:
> On  Wednesday, July 15, 2015 11:08 PM Jean Delvare wrote:
>> I see the benefit of removing the arbitrary limit, but why use a list
>> instead of a dynamically allocated array? This is turning a O(1)
>> algorithm into a O(n) algorithm. I know n isn't too large in this case
>> but I still consider it bad practice if it can be avoided.
>
> This patch tries to solve two problems which are present on current hardware:
> -cpus with more than 32 cores
> -core id is greater than NUM_REAL_CORES
>
> In both cases it ends up with the following error in dmesg:
> coretemp coretemp.0: Adding Core XXX failed
>
> We could just bump NUM_REAL_CORES to 128 like we did in 2012 and call it
> solved, but the problem will come back eventually and it is waste of
> memory for cpus with handful of cores.
>
> If there is way to obtain maximum core id during module initialization,
> then we can allocate array and keep O(1) access. If we can't figure out
> maximum core id then we can increase size of the array when new cores are
> added. The problem with this is that core id enumeration can be sparse so
> again we have waste of memory.
>
>> Do you expect core IDs to become arbitrarily large?
>> Significantly larger than the core count?
>
> The question is what does significantly mean.
> According to Documentation/cputopology.txt:
> ---
> 2) /sys/devices/system/cpu/cpuX/topology/core_id:
>
> 	the CPU core ID of cpuX. Typically it is the hardware platform's
> 	identifier (rather than the kernel's).  The actual value is
> 	architecture and platform dependent.
> ---
>
> Even now we can have one core present with id like 60 (think of Xeon Phi).
> I haven't seen in the wild insane core ids like thousands, but I don't see
> a reason why we shouldn't handle it in a proper manner.
>
> Current patch does not use more memory than it is needed, but the pitfall is
> that it increased access complexity from O(1) to O(n). We could slide another
> patch on top of this one to reduce access complexity from O(n) to O(logn)
> by using i.e. radix tree. I preferred to send functional fix in the first
> place, and then work on optimization if there is a concern about it.
> Forgive me if it is not appropriate.
>

You don't really explain why your approach would be better than allocating
an array of pointers to struct temp_data and increasing its size using
krealloc if needed.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
