From: "Jean-Marc Spaggiari" <jean-marc@spaggiari.org>
Date: Wed, 22 Oct 2008 13:22:46 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] libsensors: Add support for current
Message-Id: <79c9d4530810220622m383ffecbo144f139be75b7c0d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022135759.6ed045c0@hyperion.delvare>
In-Reply-To: <20081022135759.6ed045c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2008/10/22 Hans de Goede <j.w.r.degoede@hhs.nl>:
> Jean Delvare wrote:
>> Add support for current sensors.
>> ---
>> The code for function print_chip_curr() is duplicated directly from
>> print_chip_in() with IN subfeature names replaced by their CURR
>> counterparts and V changed to A.
>>
>> Applies on top of the previous patch. I'd appreciate review and testing
>> of this patch. Vincent, this should show you the current values you
>> were missing so far.
>>
>>  doc/libsensors-API.txt |    9 ++++++
>>  lib/sensors.h          |    9 ++++++
>>  lib/sysfs.c            |   16 ++++++++++-
>>  prog/sensors/chips.c   |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 102 insertions(+), 1 deletion(-)
>>
>
> I've reviewed this and it looks good.
>
> Regards,
>
> Hans
>

Hi,

I compiled and installed successfuly path 1/2 and patch 2/2 on my
system (2.6.27.2). Seems to be working fine. Don't see the difference
with the previous version.

JM

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
