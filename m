From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 16 Aug 2013 07:03:09 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <520DCEAD.4070107@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dev, Kapil wrote:
> On Thu, Aug 15, 2013 at 3:55 AM, Clemens Ladisch wrote:
>> On 08/14/2013 09:16 PM, Dev, Kapil wrote:
>>> I got a little confused about the way temperature-computation is
>>> explained on page 393. The interpretation of D18F3xA4[31:21] seems to
>>> be different based on the D18F3xA4[17:16] bits.
>>
>> These two bits should always be 00; Linux never tries to write the
>> temperature value.
>
> I see. It means  that D18F3xA4[31:21] always denotes the Tctl
> temperature (control temperature). Where, Tctl <= Tmeasured <> Tctl+TmpMaxDiffUp.

All four fields in bits 0..12 can make the shown temperature value
slightly out of date.  This is intentional to smooth out the
measurements.

> The value of TmpMaxDiffUp is between 0 and 9C

No, it is between 0 and 9.

> depending on the value of two bits, D18F3xA4[6:5]. Should I check the
> value of these two bits

Over time, the average value should be accurate.

> I noticed, that the reported temperature was very erratic, changing
> anywhere between 3 C and 30C,

No, between 3 and 30.

> even when there was no workload running on the cpu.

When the CPU is mostly idle, even small wakeups for interrupts will
result in rather large relative changes in power consumption and,
therefore, power dissipation.

> If I understand it correctly, the implementation is such that it
> reports following values:
> 1) Highest temperature = 70

This is not the highest possible value; temp1_max is the highest value
during normal operation.  On AMD CPUs, this is the point at which the
CPU fan should run at 100 % (of TDP).

> 2) Critical temperature = mostly 70; [...] which kind of means that
> D18F3x64[22:16] is mostly fixed to 36?

This register has whatever value the BIOS has written into it.

> 3)  Hysteresis value: [...] Is the value of D18F3x64[22:16] fixed or
> it changes based on some condition?

It changes when the BIOS (or somebody else) writes to it.

> I am trying to compute the temperature values as accurately as
> possible because my project involves calibrating the die-temperature
> values against other measurements

Did you read section 2.11.1?  It says:
| Tctl does not represent a temperature which could be measured on the
| die or the case of the processor. Instead, it specifies the processor
| temperature relative to the maximum operating temperature

The maximum operating temperature is defined as 70, but does not
correspond to a known absolute temperature.

This temperature sensor is designed to control the CPU fan; it is _not_
intended to result in a value that can be shown to the user in a way
that makes much sense.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
