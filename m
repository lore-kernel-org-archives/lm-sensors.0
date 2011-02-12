From: Andrew Lutomirski <luto@mit.edu>
Date: Sat, 12 Feb 2011 18:56:09 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/7] hwmon: (w83627ehf) Use 16 bit fan
Message-Id: <AANLkTi=55-90m29wGKCG=Nre1HaDA60dV8R4_6WbSoHK@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297444832-10874-8-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 12, 2011 at 12:55 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Sat, Feb 12, 2011 at 11:01:11AM -0500, Andrew Lutomirski wrote:
> [ ... ]
>
> Actually,
>
>> fan2_min = 200 (div = 64):
>> fan2_input = 138 (read at a different time, so may differ a little)
>>
>> [56013.556243] Reg 0029 = 99
>> [56013.556286] Reg 0630 = 0046
>> [56013.556453] Reg 0658 = 0089
>>
>> fan2_min = 502 (div = 32):
>> fan2_input = 0 (read at a different time, so may differ a little)
>>
>> [56085.471567] Reg 0029 = 00
>> [56085.471644] Reg 0632 = 0000
>> [56085.471804] Reg 0658 = 0000
>
> Must have been blind. So the RPM register returns 0 as well. Not good.
> Wonder what is going on.

So far, the highest number I've been able to get out of the counter
register is 0x2e8 by setting div = 16 and playing with the pwm.

If I set div = 8, then I can't get much above 0x10b.

I have no idea what's going on either.

I tried writing 0x80 to 0x508 (which is supposed to turn the whole
thing on), but the only bits that seem to stick are 0x7, so I have no
idea what's going on.

--Andy

>
> Guenter
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
