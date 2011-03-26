From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 26 Mar 2011 07:55:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (f71882fg) Add support for the
Message-Id: <4D8D9BEE.1030105@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110325135049.7737bcb6@endymion.delvare>
In-Reply-To: <20110325135049.7737bcb6@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/25/2011 03:14 PM, Jean Delvare wrote:
> Hi Hans,
>
> On Fri, 25 Mar 2011 14:56:26 +0100, Hans de Goede wrote:
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>> ---
>>   Documentation/hwmon/f71882fg |    4 ++++
>>   drivers/hwmon/Kconfig        |    2 +-
>>   drivers/hwmon/f71882fg.c     |   24 ++++++++++++++++++------
>>   3 files changed, 23 insertions(+), 7 deletions(-)
>
> I'm curious... what was the rationale for using 3 different types for
> the 889FG, 889ED and 889A if they all behave exactly the same?
>

There are differences in the unused parts, such as the digital temp
sensor interface support (PECI & friends), which I hope to add support
for one day. I have an isadump of all registers of 1 board which
actually uses this functionality. But I'll need a significant sized
slot of free time to look into this.

>>
>> diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
>> index b802a22..df02245 100644
>> --- a/Documentation/hwmon/f71882fg
>> +++ b/Documentation/hwmon/f71882fg
>> @@ -30,6 +30,10 @@ Supported chips:
>>       Prefix: 'f71889ed'
>>       Addresses scanned: none, address read from Super I/O config space
>>       Datasheet: Should become available on the Fintek website soon
>> +  * Fintek F71889A
>> +    Prefix: 'f71889a'
>> +    Addresses scanned: none, address read from Super I/O config space
>> +    Datasheet: Should become available on the Fintek website soon
>>     * Fintek F8000
>>       Prefix: 'f8000'
>>       Addresses scanned: none, address read from Super I/O config space
>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>> index 504117c..065d01b 100644
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -327,7 +327,7 @@ config SENSORS_F71882FG
>>   	    F71869F/E
>>   	    F71882FG
>>   	    F71883FG
>> -	    F71889FG/ED
>> +	    F71889FG/ED/A
>>   	    F8000
>>   	    F81801U
>>   	    F81865F
>> diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
>> index 41248cd..ca07a32 100644
>> --- a/drivers/hwmon/f71882fg.c
>> +++ b/drivers/hwmon/f71882fg.c
>> @@ -54,6 +54,7 @@
>>   #define SIO_F71882_ID		0x0541	/* Chipset ID */
>>   #define SIO_F71889_ID		0x0723	/* Chipset ID */
>>   #define SIO_F71889E_ID		0x0909	/* Chipset ID */
>> +#define SIO_F71889A_ID		0x1005	/* Chipset ID */
>>   #define SIO_F8000_ID		0x0581	/* Chipset ID */
>>   #define SIO_F81865_ID		0x0704	/* Chipset ID */
>>
>> @@ -107,7 +108,7 @@ module_param(force_id, ushort, 0);
>>   MODULE_PARM_DESC(force_id, "Override the detected device ID");
>>
>>   enum chips { f71808e, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
>> -	     f71889ed, f8000, f81865f };
>> +	     f71889ed, f71889a, f8000, f81865f };
>>
>>   static const char *f71882fg_names[] = {
>>   	"f71808e",
>> @@ -117,11 +118,12 @@ static const char *f71882fg_names[] = {
>>   	"f71882fg",
>>   	"f71889fg", /* f81801u too, same id */
>>   	"f71889ed",
>> +	"f71889a",
>>   	"f8000",
>>   	"f81865f",
>>   };
>>
>> -static const char f71882fg_has_in[9][F71882FG_MAX_INS] = {
>> +static const char f71882fg_has_in[][F71882FG_MAX_INS] = {
>
> Ah, I was hesitant to drop the array size. If you are OK with this then
> I'll move the change into my first two patches. This will make all
> other patches smaller.

I was hesitant myself too, but after thinking about it I see no reason not
to, gcc will only warn if the array is smaller then our initializers need,
AFAIK gcc won't warn if we are missing an initializer. So I see no gain in
having an explicit size, where as using auto sizing makes future patches
for adding support for more models (such as the F71808A and F71869A)
smaller / easier to review.

>
>>   	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1 },
>>   	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
>>   	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
>
> Other than this, no objection, so I'll queue this patch. I plan to send
> all 5 patches to Linus later today, tomorrow at the latest.
>

Thanks!

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
