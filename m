From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Mon, 17 Aug 2015 08:00:12 +0000
Subject: Re: [lm-sensors] [RFC 0/1] i2c: acpi: revert setting a "stable" device name
Message-Id: <55D1948C.6080501@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com> <20150815151302.GA10020@roeck-us.net>
In-Reply-To: <20150815151302.GA10020@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jdelvare@suse.com, lm-sensors@lm-sensors.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

On 15.08.2015 18:13, Guenter Roeck wrote:
> On Fri, Aug 14, 2015 at 12:37:13PM -0700, Dustin Byford wrote:
>> 70762ab from 11/2014 (i2c: Use stable dev_name for ACPI enumerated I2C
>> slaves) modified the sysfs-visible dev_name() for ACPI enumerated I2C
>> devices.  With that change, /sys/bus/i2c/devices/i2c-0-004a, for
>> example, became /sys/bus/i2c/devices/i2c-PNPXXXX:xx
>>
>> That causes problems for userspace code such as 'sensors' which does
>> this:
>>
>> lib/sysfs.c:665:
>> if ((!subsys || !strcmp(subsys, "i2c")) &&
>>      sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
>>             &entry.chip.addr) = 2) {
>> ...
>>
>> Therefore, in theory, sensors that were previously visible by running
>> 'sensors' no longer show up.  On the other hand, there are probably few,
>> if any, cases of this because ACPI enumerated I2C hwmon devices are not
>> common.
>>
>> I'm not defending the 'sensors' code, I'm sure there are better ways to
>> discover a hwmon I2C device from userspace.  But, I'm also not sure
>
> Is it necessary to defend user space applications nowadays if a kernel change
> breaks a well established ABI ? WHat happened to "Thou Shalt Not Break
> Userspace" ?
>
> I absolutely agree that i2c bus renumbering across reboots is a problem.
> However, it seems to me that 70762ab doesn't solve that problem, it just
> paints it over. And, as you have noticed, it introduces new problems along
> the way.
>
This indeed is unwanted and needs to be fixed. Looking at the 
lib/sysfs.c also SPI chip detection breaks because of commit 
e13ac47bec20 ("spi: Use stable dev_name for ACPI enumerated SPI slaves").

However plain revert won't work as it breaks those ALSA SoC drivers that 
depend on this. Good thing is that matching there is purely kernel space 
and at quick look "git grep '"i2c-.*:[0-9]'" and "git grep 
'"spi-.*:[0-9]'" don't find other in-kernel users.

>> 70762ab achieved its stated goal in a meaningful way.  Won't
>> "i2c-<acpi_dev_name>" also vary with ACPI scan order, BIOS settings,
>> firmware upgrades, etc...?
>>
If I remember correctly ACPI ID should not ever change and instance id 
:xy after INTABCD:xy should also be visible and keep the order even if 
device is disabled or not plugged. But I'm not absolute sure about this.

At least on a test platform that allow disable devices will show those 
devices off-line (/sys/bus/acpi/devices/INTABCD:xy/status = 0).

-- 
Jarkko

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
