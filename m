From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 04 Jul 2014 17:10:14 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm9240) Avoid forward declaration
Message-Id: <53B6DFF6.2090808@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395989.4895.12.camel@phoenix>
In-Reply-To: <1404395989.4895.12.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/04/2014 05:23 AM, Jean Delvare wrote:
> On Fri, 04 Jul 2014 00:36:10 -0700, Guenter Roeck wrote:
>> On 07/03/2014 10:39 PM, Grant Coady wrote:
>>> Hi Axel, others,
>>>
>>> Please note I no longer have the hardware to test this driver.
>>
>> Thanks to Jean we have a register dump and thus can do some module testing.
>
> Thanks to Grant actually, as I'm pretty sure I got that dump from him
> in the first place ;-)
>
>> Not as good as real hardware, but I found a number of day-1 bugs in various
>> drivers this way, so it is not that bad.
>
> Note that support for banked registers could be added if you think this
> would help.
>

Hi Jean,

That would be quite useful. How would you implement it, though ? You would have
to have a means to tell the driver "this is a bank register". Another module
parameter, maybe ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
