From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Aug 2015 17:12:24 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <55DCA1F8.3050008@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com> <20150825052513.GI1654@sirena.org.uk> <20150825145756.GA4066@schokonusskuchen.bad> <55DC8746.1060809@roeck-us.net> <20150825161850.GA8118@katana>
In-Reply-To: <20150825161850.GA8118@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Dustin Byford <dustin@cumulusnetworks.com>

On 08/25/2015 09:18 AM, Wolfram Sang wrote:
> On Tue, Aug 25, 2015 at 08:18:30AM -0700, Guenter Roeck wrote:
>> On 08/25/2015 07:57 AM, Wolfram Sang wrote:
>>> On Tue, Aug 25, 2015 at 06:25:13AM +0100, Mark Brown wrote:
>>>> On Mon, Aug 24, 2015 at 01:52:02PM +0300, Jarkko Nikula wrote:
>>>>> Commit 70762abb9f89 ("i2c: Use stable dev_name for ACPI enumerated I2C
>>>>> slaves") broke the lm-sensors which relies on I2C hwmon slave devices under
>>>>> /sys/bus/i2c/devices/ to be named as "x-00yz". However if those hwmon
>>>>> devices are ACPI 5 enumerated their name became "i2c-INTABCD:ij" and sysfs
>>>>> code in lm-sensors does not find them anymore:
>>>>
>>>> Acked-by: Mark Brown <broonie@kernel.org>
>>>
>>> Don't you think there will be regressions given that the new naming
>>> scheme was around for 18 months?
>>>
>>
>> acpi is pretty long term. New bindings don't show up quickly.
>
> The key is, there might be userspace applications that got used to our
> new "export" of ACPI bindings. The bindings were already existing, our
> "export" did change.
>
>> So I am not surprised that this only shows up now.
>
> I am, to be honest. It shows running lm-sensors with ACPI on a kernel
> newer than 18 months. Not a rare scenario, so I thought.
>
With i2c (sensor) devices enumerated in acpi ? Yes, I think that is quite rare.
This is not about the kernel, it is about such device bindings showing up
in acpi data.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
