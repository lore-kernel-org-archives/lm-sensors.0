From: Il Han <corone.il.han@gmail.com>
Date: Mon, 29 Jun 2015 10:33:45 +0000
Subject: Re: [lm-sensors] Does anyone have a driver for the MAX31790?
Message-Id: <CADrkgW+FkR+GtQcd3McYrz+vKMD+71udhuafAY-8rT7p=znVbQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADrkgWK9en4v3QpobCVDeY0GqCMach-nPPJ1fiNk6uXv-4EHYA@mail.gmail.com>
In-Reply-To: <CADrkgWK9en4v3QpobCVDeY0GqCMach-nPPJ1fiNk6uXv-4EHYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you very much for your answer.

Isn't there any similar chip to MAX31790?
There are drivers for max1111, max16065, max1619, max1668, max197, max6636,
max6642, max6650, max6697 in the Linux Kernel Archives.
What is the most similar chip of these?

Is the MAX31790 a completely new chip?

Thank you.

--
Il Han


2015-06-29 17:31 GMT+09:00 Guenter Roeck <linux@roeck-us.net>:

> On 06/29/2015 12:01 AM, Il Han wrote:
>
>> Hello,
>>
>> I have a machine with a chip, MAX31790.
>> It would monitor and control fans on the machine.
>>
>> But I couldn't find any drivers for the MAX31790 in the Linux Kernel
>> Archives.
>> Does anyone have a driver for it?
>>
>
> I don't think that a Linux driver for this chip exists.
>
>  Or can I use the other driver instead, such as MAX1111, MAX1619, MAX6650,
>> etc. for the MAX31790?
>>
>>
> No, those are completely different chips.
>
> Guenter
>
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
