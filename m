From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 03:52:19 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc6 4/6 ] hwmon/pc87360 separate
Message-Id: <48C895F3.2060303@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C79568.60007@gmail.com>
In-Reply-To: <48C79568.60007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew Morton wrote:
> On Wed, 10 Sep 2008 03:37:44 -0600
> Jim Cromie <jim.cromie@gmail.com> wrote:
>
>   
>> Driver handles 3 logical devices in fixed length array.
>> Give this a define-d constant.
>>
>> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>> ---
>>  drivers/hwmon/pc87360.c |    5 +++--
>>  1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
>> index 6ffea41..ebb235b 100644
>> --- a/drivers/hwmon/pc87360.c
>> +++ b/drivers/hwmon/pc87360.c
>> @@ -75,7 +75,8 @@ MODULE_PARM_DESC(force_id, "Override the detected 
>> device ID");
>>  #define FSCM    0x09    /* Logical device: fans */
>>  #define VLM    0x0d    /* Logical device: voltages */
>>  #define TMS    0x0e    /* Logical device: temperatures */
>> -static const u8 logdev[3] = { FSCM, VLM, TMS };
>> +#define LDNI_MAX 3
>> +static const u8 logdev[LDNI_MAX] = { FSCM, VLM, TMS };
>>  
>>  #define LD_FAN        0
>>  #define LD_IN        1
>> @@ -1074,7 +1075,7 @@ static int __devinit pc87360_probe(struct 
>> platform_device *pdev)
>>      mutex_init(&data->update_lock);
>>      platform_set_drvdata(pdev, data);
>>  
>> -    for (i = 0; i < 3; i++) {
>> +    for (i = 0; i < LDNI_MAX; i++) {
>>          if (((data->address[i] = extra_isa[i]))
>>           && !request_region(extra_isa[i], PC87360_EXTENT,
>>                       pc87360_driver.driver.name)) {
>>     
>
> Is this better than doing
>
> static const u8 logdev[3] = { FSCM, VLM, TMS };
>
> 	for (i = 0; i < ARRAY_SIZE(logdev); i++) {
>
>
> ?
>
>   
No, not really.
Ive reworked the patch your way, minus the unnecessary '3'

And rebased the patchset.
Im pleased (but not really surprised) that re-rebasing on same -r6 
commit worked.

sending new patchset shortly.

thanks

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
