From: Constantine Shulyupin <const@makelinux.com>
Date: Thu, 25 Jun 2015 17:10:36 +0000
Subject: Re: [lm-sensors] [PATCH] fix nct7802_temp_is_visible
Message-Id: <CAE7jHC95bpZfqDyFOsh-Do3vvrsVDcWVEpSicLx5arzS9c6qKg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1435186051-10196-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1435186051-10196-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Excerpt from datasheet:
7.2.32 Mode Selection Register
RTD3_MD : 00=Closed , 01=Reserved , 10=Thermistor mode , 11=Voltage sense

As I understand the datasheel value 11b is valid too and the resister
should be visible. It is legit to hide registers on 00=Closed and
optionally on 01=Reserved (RTD3_MD only).

I suppose condition RTD3_MD = 01b can be uncounted because is it reserved
should not be used. temp3_* registers should be visible when RTD3_MD is 10b
or 11b and hidden when RTD3_MD = 0 and optionally when RTD3_MD = 1

Therefore I propose to hide temp3_* when RTD3_MD != 0:
 if (index >= 18 && index < 27 && !(reg & 0x30)  /* RD3 */

or when RTD3_MD = 0 or RTD3_MD = 1:
 if (index >= 18 && index < 27 && (reg & 0x30) <= 0x10)  /* RD3 */

Do you agree?
What do you prefer?

Thanks
Constantine


On Thu, Jun 25, 2015 at 3:00 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Constantine,
>
>
> On 06/24/2015 03:47 PM, Constantine Shulyupin wrote:
>
>> From: const <const@makelinux.com>
>>
>> Fixed registers are invisible only when registers' mode is 0
>>
>> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
>> ---
>>   drivers/hwmon/nct7802.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
>> index ec56782..65e40c2 100644
>> --- a/drivers/hwmon/nct7802.c
>> +++ b/drivers/hwmon/nct7802.c
>> @@ -541,13 +541,11 @@ static umode_t nct7802_temp_is_visible(struct
>> kobject *kobj,
>>         if (err < 0)
>>                 return 0;
>>
>> -       if (index < 9 &&
>> -           (reg & 03) != 0x01 && (reg & 0x03) != 0x02)         /* RD1 */
>> +       if (index < 9 && !(reg & 0x03))                 /* RD1 */
>>                 return 0;
>> -       if (index >= 9 && index < 18 &&
>> -           (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)       /* RD2 */
>> +       if (index >= 9 && index < 18 && !(reg & 0x0c))  /* RD2 */
>>                 return 0;
>> -       if (index >= 18 && index < 27 && (reg & 0x30) != 0x10)  /* RD3 */
>> +       if (index >= 18 && index < 27 && !(reg & 0x30)) /* RD3 */
>>
>
> 11b sets a sensor to voltage sense mode, not temperature mode.
> This is what the inX attributes are for. We can not just display a
> random temperature value if a sensor is configured to measure a voltage.
>
> According to my datasheet, 01b (0x10 shifted) is reserved for RD3.
> So there is a bug, but it is
>
>         if (index >= 18 && index < 27 && (reg & 0x30) != 0x10)  /* RD3 */
> which should be
>         if (index >= 18 && index < 27 && (reg & 0x30) != 0x20)  /* RD3 */
>
> Can you send an updated patch ?
>
> Thanks,
> Guenter
>
>


-- 
Constantine Shulyupin
http://www.MakeLinux.com/
Embedded Linux Systems
and Device Drivers
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
