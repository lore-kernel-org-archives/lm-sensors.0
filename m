From: Hoan Tran <hoan@os.amperecomputing.com>
Date: Wed, 12 Aug 2020 22:13:33 +0000
Subject: Re: [PATCH v2] Add ISA ACPI sensor driver name support
Message-Id: <4bd9ce7f-99c5-0c80-53a7-e58d18e9d50f@os.amperecomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1596822872-23323-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1596822872-23323-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi,

On 8/11/20 2:38 AM, Ondřej Lysoněk wrote:
> Hi,
> 
> Thanks for the patch!
> 
> Hoan Tran <Hoan@os.amperecomputing.com> writes:
> 
>> From: Hoan Tran <hoan@os.amperecomputing.com>
>>
>> ACPI hwmon sensor driver name has a different format such as
>> 	APMC0D29:00
>> 	APMC0D29:01
> 
> Do you know where the number 00/01 comes from? I'm trying to determine
> if it's guaranteed to be stable across reboots.

I think it's based on the ACPI node order inside DSDT.

> 
>> compared with DTB. This patch supports this format and gives
>> the correct device address as below
>>
>> apm_xgene-isa-0000   => APMC0D29:00
>> Adapter: ISA adapter
>> SoC Temperature:  +35.0°C
>> CPU power:        11.00 W
>> IO power:         20.00 W
>>
>> apm_xgene-isa-0001   => APMC0D29:01
>> Adapter: ISA adapter
>> SoC Temperature:  +33.0°C
>> CPU power:        13.00 W
>> IO power:         23.83 W
>>
>> Signed-off-by: Hoan Tran <hoan@os.amperecomputing.com>
>> ---
>> v2:
>>    Filter A-Z for the name
>>
>>   lib/sysfs.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/sysfs.c b/lib/sysfs.c
>> index e63688b7..e9db55d4 100644
>> --- a/lib/sysfs.c
>> +++ b/lib/sysfs.c
>> @@ -663,7 +663,7 @@ static int classify_device(const char *dev_name,
>>   	if ((!subsys || !strcmp(subsys, "platform") ||
>>   			!strcmp(subsys, "of_platform"))) {
>>   		/* must be new ISA (platform driver) */
>> -		if (sscanf(dev_name, "%*[a-z0-9_].%d", &entry->chip.addr) != 1)
>> +		if (sscanf(dev_name, "%*[a-zA-Z0-9_]%*[.:]%d", &entry->chip.addr) != 1)
> 
> Nit: I think this should be "%*[a-zA-Z0-9_]%*1[.:]%d", so that only a
> single '.' or ':' character is matched.

Yes, it's true. I can fix it.

Regards
Hoan

> 
> Ondřej
> 
>>   			entry->chip.addr = 0;
>>   		entry->chip.bus.type = SENSORS_BUS_TYPE_ISA;
>>   		entry->chip.bus.nr = 0;
>> @@ -938,7 +938,7 @@ int sensors_read_sysfs_attr(const sensors_chip_name *name,
>>   		if (res = EOF) {
>>   			if (errno = EIO)
>>   				return -SENSORS_ERR_IO;
>> -			else
>> +			else
>>   				return -SENSORS_ERR_ACCESS_R;
>>   		}
>>   		*value /= get_type_scaling(subfeature->type);
>> @@ -972,7 +972,7 @@ int sensors_write_sysfs_attr(const sensors_chip_name *name,
>>   		if (res = EOF) {
>>   			if (errno = EIO)
>>   				return -SENSORS_ERR_IO;
>> -			else
>> +			else
>>   				return -SENSORS_ERR_ACCESS_W;
>>   		}
>>   	} else
>> -- 
>> 2.24.2
> 
