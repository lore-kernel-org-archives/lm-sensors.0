From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 28 May 2011 18:41:40 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon/sch5627: Factor our some code to
Message-Id: <4DE141E4.1000903@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110528143829.54e34869@endymion.delvare>
In-Reply-To: <20110528143829.54e34869@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

On 05/28/2011 02:38 PM, Jean Delvare wrote:
> On Sat, 28 May 2011 09:21:23 +0200, Hans de Goede wrote:
>> This patch adds a new sch56xx-common.ko which contains code which will also
>> be used in the new sch5636 driver.
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> ---
>>   drivers/hwmon/Kconfig          |    5 +
>>   drivers/hwmon/Makefile         |    1 +
>>   drivers/hwmon/sch5627.c        |  334 +++------------------------------------
>>   drivers/hwmon/sch56xx-common.c |  336 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/hwmon/sch56xx-common.h |   24 +++
>>   5 files changed, 390 insertions(+), 310 deletions(-)
>>   create mode 100644 drivers/hwmon/sch56xx-common.c
>>   create mode 100644 drivers/hwmon/sch56xx-common.h
>> (...)
>> --- /dev/null
>> +++ b/drivers/hwmon/sch56xx-common.c
>> (...)
>> +#define SIO_SCH56XX_LD_EM	0x0C	/* Embedded ųController Logical Dev */
>
> A regular "u" will do... I don't know you used but that wasn't even a
> Greek mu.

Oh, oops wrong compose sequence. I know the right one now, giving:
µController, or I can just use a regular u if you prefer :)

So do you want me to resend, with this fixed, or will you fix this in
your tree?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
