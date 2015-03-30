From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 21:16:30 +0000
Subject: Re: [lm-sensors] [PATCH 03/15] hwmon: (it87) Introduce configuration field for chip suffix
Message-Id: <5519BD2E.1010505@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/30/2015 12:58 PM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 29 Mar 2015 23:33:43 -0700, Guenter Roeck wrote:
>> ITE chips may have 'E', 'F', or both 'E' and 'F' suffixes.
>> Introduce suffic configuration to the it87_devices structure
>> to simplify adding new chips.
>
> I like it, but I'm wondering if it wouldn't be even better to add the
> full "nice" chip name to each entry, so that you don't have to
> reconstruct it from chip_type? Granted, it would require a few more
> bytes of data, but it simplifies the code and would be more flexible
> too (imagine some future chip has an ID which no longer exactly match
> its name...) What do you think?
>
I though about it, but it would mean that I would have to introduce it8623
and it8726 as separate types. If we want to do that, we should probably
do it as separate patch(es).

>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/hwmon/it87.c | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
>> index 180750ef6156..bdd6b33a3b25 100644
>> --- a/drivers/hwmon/it87.c
>> +++ b/drivers/hwmon/it87.c
>> @@ -245,6 +245,7 @@ struct it87_devices {
>>   	u16 features;
>>   	u8 peci_mask;
>>   	u8 old_peci_mask;
>> +	const char * const suffix;
>
> I'd put it right after the name field, as they have the same type and
> are somewhat related. (name could be const-ified BTW, right?)
>
Makes sense. I'll do that.

Constifying name is possible. Separate patch, though, I would think.

[ ... ]

>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
Thanks!

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
