From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Date: Fri, 17 Jul 2015 17:28:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <D6EDEBF1F91015459DB866AC4EE162CCF76BDA@IRSMSX103.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
 <20150715230734.76347af2@endymion.delvare>
 <D6EDEBF1F91015459DB866AC4EE162CCF766C8@IRSMSX103.ger.corp.intel.com>
 <55A93365.4000702@roeck-us.net>
In-Reply-To: <55A93365.4000702@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Guenter Roeck [mailto:linux@roeck-us.net] 
On Friday, July 17, 2015 6:55 PM Guenter Roeck wrote:

> You don't really explain why your approach would be better than
> allocating an array of pointers to struct temp_data and increasing
> its size using krealloc if needed.

Let's consider two cases of such implementation:
a) we use array of pointers with O(n) access algorithm
b) we use array of pointers with O(1) access algorithm

In both cases an array will have greater memory footprint unless
we implement reallocation ourselves when cpus are disabled which will
make code harder to maintain.
Case b) does not handle huge core ids and sparse enumeration well -
it is still to discuss whether we really need it since there is no
such hardware yet.

I am not saying that my solution is the best of possible ones.
I am saying that "the best" can vary depending on which criteria do you
choose from (time, memory, clean code...). Some may say that O(n) is
fine unless we have thousands of cores and this code is not on hot path,
others may be concerned more about memory on small/old devices.
I don't see holy grail here, If you see one please let me know.

If you think that we don't have to care so much about memory,
then I can create another patch which uses array instead of list.

Thanks,
Lukas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
