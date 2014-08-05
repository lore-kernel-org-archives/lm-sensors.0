From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 05 Aug 2014 10:21:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (dme1737) Prevent overflow problem when writing large limits
Message-Id: <CAFRkauCu0eDb_7uUaSomSEb7UuNzdqysbRDtr6m=2Cra6BnQZA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406945687.12632.1.camel@phoenix>
In-Reply-To: <1406945687.12632.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-08-05 13:51 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
> On Mon, Aug 04, 2014 at 09:44:21AM -0700, Guenter Roeck wrote:
>> On Sat, Aug 02, 2014 at 10:14:47AM +0800, Axel Lin wrote:
>> > On platforms with sizeof(int) < sizeof(long), writing a temperature
>> > limit larger than MAXINT will result in unpredictable limit values
>> > written to the chip. Avoid auto-conversion from long to int to fix
>> > the problem.
>> >
>> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> > ---
>> >  drivers/hwmon/dme1737.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
>> > index 4ae3fff..e9cd1e2 100644
>> > --- a/drivers/hwmon/dme1737.c
>> > +++ b/drivers/hwmon/dme1737.c
>> > @@ -293,7 +293,7 @@ static inline int TEMP_FROM_REG(int reg, int res)
>> >     return (reg * 1000) >> (res - 8);
>> >  }
>> >
>> > -static inline int TEMP_TO_REG(int val)
>> > +static inline int TEMP_TO_REG(long val)
>> >  {
>> >     return clamp_val((val < 0 ? val - 500 : val + 500) / 1000, -128, 127);
>> >  }
>>
>> Hi Axel,
>>
>> the problem is not just limietd to temperatures. Voltage limits,
>> fan minimum speed, pwm frequency, pwm ramp rate, and possibly other
>> attributes have the same problem.
>>
> Hi Axel,
>
> as followup on this, here is a complete set of test script results for
> this driver. Problematic are the suspected overflows as well as the
> min > max error when writing vrm (which is because writing a long variable
> into an u8 is rarely a good idea). This is without applying your patch;
> with it the temperature overflows should be fixed.
>
> Please let me know if you want/can take care of the problems.
> Otherwise I'll have a look myself later this week.
Hi Guenter,
I'll send v2 tomorrow.

Thanks,
Axel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
