From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 14 Mar 2011 08:37:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: New driver for SMSC SCH5627 hwmon
Message-Id: <4D7DD3BB.7020506@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1299871683-3945-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/13/2011 04:27 PM, Jean Delvare wrote:
> Hi Hans,
>
> On Sun, 13 Mar 2011 13:43:24 +0100, Hans de Goede wrote:
>> SMSC SCH5627 Super I/O chips include complete hardware monitoring
>> capabilities. They can monitor up to 5 voltages, 4 fans and 8 temperatures.
>>
>> The hardware monitoring part of the SMSC SCH5627 is accessed by talking
>> through an embedded microcontroller. An application note describing the
>> protocol for communicating with the microcontroller is available upon
>> request. Please mail me if you want a copy.
>>
>> Changes since version 1:
>> * Properly format multi line comments
>> * Avoid a potential divide by 0
>> * Use pr_err / pr_warn / pr_err instead of printk
>>
>> Changes since version 2:
>> * Various cleanups as result of a thorough review by Jean Delvare
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> ---
>>   Documentation/hwmon/sch5627 |   22 ++
>>   MAINTAINERS                 |    7 +
>>   drivers/hwmon/Kconfig       |    9 +
>>   drivers/hwmon/Makefile      |    1 +
>>   drivers/hwmon/sch5627.c     |  855 +++++++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 894 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/hwmon/sch5627
>>   create mode 100644 drivers/hwmon/sch5627.c
>
> This version looks very good to me, with only one minor comment left
> from me:
>
>> (...)
>> +static int sch5627_read_limits(struct sch5627_data *data)
>
> Only called from a __devinit function, so it could be __devinit.
>

Fixed in v4, together with the reporting of 0 rpm instead of 82 for a
fan register with a value of 0xffff.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
