From: Dean Nelson <dnelson@redhat.com>
Date: Tue, 26 Jul 2011 14:35:35 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (KConfig) avoid building drivers
Message-Id: <4E2ED0B7.6050000@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110725195206.4097.45688.email-sent-by-dnelson@localhost6.localdomain6>
In-Reply-To: <20110725195206.4097.45688.email-sent-by-dnelson@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/26/2011 04:25 AM, Jean Delvare wrote:
> Hi Dean,
>
> On Mon, 25 Jul 2011 15:52:07 -0400, Dean Nelson wrote:
>> A modprobe of hwmon drivers that read/write ISA addresses on a powerpc results
>> in a kernel Oops. These read/writes are being done via the inb()/in_8() and
>> outb()/out_8() macros.
>>
>> This patch prevents these drivers from being built for powerpc.
>
> Looks good overall, adjustments suggested below.
>
>>
>> Signed-off-by: Dean Nelson<dnelson@redhat.com>
>> Cc: stable@kernel.org
>
> Not sure about stable. You shouldn't load random drivers in the first
> place, so nobody should hit the oopses in practice.

Okay, I'll drop the Cc. Thanks.

>> ---
>>   drivers/hwmon/Kconfig |   15 ++++++++++++---
>>   1 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 5f888f7..f2e8126 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
<snip>
>> @@ -933,7 +938,7 @@ config SENSORS_S3C_RAW
>>
>>   config SENSORS_SIS5595
>>   	tristate "Silicon Integrated Systems Corp. SiS5595"
>> -	depends on PCI
>> +	depends on PCI&&  !PPC
>>   	help
>>   	  If you say yes here you get support for the integrated sensors in
>>   	  SiS5595 South Bridges.
>
> This one is a PCI driver, it doesn't do random I/O, so it should be
> left as is. You did not experience a crash on PowerPC by loading this
> driver, did you?

Okay. Thanks. And no, I didn't experience an Oops.

When sm_sis5595_init() gets called at module load time, it calls
pci_register_driver() to register sis5595_pci_probe(), which never
gets called.

Had sis5595_pci_probe() been called, it could have called
platform_driver_register() to register sis5595_probe(), which is
where we could potentially read/write the ISA address.

I'd added the " && !PPC" to this driver because it was in the list
of drivers you mentioned that I hadn't, when I first introduced this
issue. Sorry for misunderstanding. It's been removed from v2 of this
patch.


<snip>
>> @@ -1033,7 +1039,7 @@ config SENSORS_SMSC47M192
>>
>>   config SENSORS_SMSC47B397
>>   	tristate "SMSC LPC47B397-NC"
>> -	depends on EXPERIMENTAL
>> +	depends on EXPERIMENTAL&&  !PPC
>>   	help
>>   	  If you say yes here you get support for the SMSC LPC47B397-NC
>>   	  sensor chip.
>
> You want to add the more recent SMSC SCH5627 and SMSC SCH5636 entries
> to the list, too.

Added to v2.

Thank you for the review.

Dean


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
