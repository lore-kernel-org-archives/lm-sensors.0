From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 07 May 2014 12:10:58 +0000
Subject: Re: [lm-sensors] coretemp.0 folder contents changed
Message-Id: <536A22D2.5070104@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5367C6A7.5020008@linux.intel.com>	<20140505173231.GA25644@roeck-us.net>	<20140506135558.3cafd062@endymion.delvare>	<5368E45F.30301@roeck-us.net> <20140507091308.227d8152@endymion.delvare>
In-Reply-To: <20140507091308.227d8152@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On 05/07/2014 12:13 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Tue, 06 May 2014 06:32:15 -0700, Guenter Roeck wrote:
>> Can we implement a similar approach to network devices and make hwmon
>> path names (ie the /sys/class/hwmon/XXX path name) configurable via udev ?
>> Might be worth exploring.
>
> This is one possibility indeed. The good thing is that libsensors makes
> no assumption on hwmon class device names, so we can change the names
> without breaking any application which uses libsensors. Scripts
> accessing sysfs directly may break though (pwmconfig would, for
> example.)
>
> We'll have to be careful when choosing the new names, and make sure
> there is no name space collision. Network interface renaming has caused
> a great deal of trouble out there.
>
Agreed. I'll try to find some time to play with it.

> Another approach, which I have in mind for quite some time already but
> could never find the time to implement, would be a small helper binary
> which would look-up hwmon devices by libsensors-like name (and the
> other way around too.) Scripts could use it to benefit from libsensors
> persistent names.
>
Still needs that binary, though.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
