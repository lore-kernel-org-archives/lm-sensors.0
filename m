From: Justin Maggard <jmaggard10@gmail.com>
Date: Wed, 05 Aug 2015 19:18:21 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (it87) Add support for IT8732F
Message-Id: <CAKgsxVTGpg_g7go9KpYwQcXbhGjO6ds7jUaE0GZZv4kaWjrcrg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 4, 2015 at 3:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/04/2015 02:48 PM, Justin Maggard wrote:
>>
>> Add support for the IT8732F.  This chip is pretty similar to IT8721F,
>> with the main difference being that the ADC LSB is 10.9 mV instead of
>> 12 mV.
>>
>> Signed-off-by: Justin Maggard <jmaggard@netgear.com>
>
>
> Hi Justin,
>
>> ---
>>   Documentation/hwmon/it87 | 35 ++++++++++++++++++++++-------------
>>   drivers/hwmon/it87.c     | 43
>> ++++++++++++++++++++++++++++++++++++-------
>
>
> I forgot earlier: Please also list the chip in drivers/hwmon/Kconfig.
>

OK, it'll be there in v3. :-)

> [ ... ]
>>
>>   static const struct it87_devices it87_devices[] = {
>>         [it87] = {
>> @@ -315,6 +319,15 @@ static const struct it87_devices it87_devices[] = {
>>                   | FEAT_IN7_INTERNAL,
>>                 .peci_mask = 0x07,
>>         },
>> +       [it8732] = {
>> +               .name = "it8732",
>> +               .suffix = "F",
>> +               .features = FEAT_NEWER_AUTOPWM | FEAT_16BIT_FANS
>> +                 | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI
>> +                 | FEAT_10_9MV_ADC | FEAT_IN7_INTERNAL,
>> +               .peci_mask = 0x07,
>> +               .old_peci_mask = 0x02,  /* Actually reports PCH */
>
>
> From the little information we have, I suspect that this may be wrong.
> The chip is probably closer to 8771/8772. Please check if the code path
> executed if has_temp_old_peci() is true is executed correctly,
> and that the registers used in that code path report what is expected.
> Most likely FEAT_TEMP_OLD_PECI and old_peci_mask should not be set.
>

I think I'm getting a little confused here.  Both IT8721 and IT8732
claim to use IT87_REG_TEMP_EXTRA bit 7 to enable PCH temperature
mapping to 0x2a.   IT87_REG_TEMP_ENABLE bits 7-6 match IT8772, and
bits 5-0 match IT8721.

-Justin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
