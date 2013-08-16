From: Kapil Dev <kapil_dev@brown.edu>
Date: Fri, 16 Aug 2013 08:57:14 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <B7DFC887-EE5B-4C87-A311-05F696365254@brown.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Aug 16, 2013, at 3:03 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
Thanks Clemens!

Seems like, there is big gap in my understanding.

> Dev, Kapil wrote:
>> On Thu, Aug 15, 2013 at 3:55 AM, Clemens Ladisch wrote:
>>> On 08/14/2013 09:16 PM, Dev, Kapil wrote:
>>>> I got a little confused about the way temperature-computation is
>>>> explained on page 393. The interpretation of D18F3xA4[31:21] seems to
>>>> be different based on the D18F3xA4[17:16] bits.
>>> 
>>> These two bits should always be 00; Linux never tries to write the
>>> temperature value.
>> 
>> I see. It means  that D18F3xA4[31:21] always denotes the Tctl
>> temperature (control temperature). Where, Tctl <= Tmeasured <>> Tctl+TmpMaxDiffUp.
> 
> All four fields in bits 0..12 can make the shown temperature value
> slightly out of date.  This is intentional to smooth out the
> measurements.
> 
>> The value of TmpMaxDiffUp is between 0 and 9C
> 
> No, it is between 0 and 9.
> 
>> depending on the value of two bits, D18F3xA4[6:5]. Should I check the
>> value of these two bits
> 
> Over time, the average value should be accurate.
> 
>> I noticed, that the reported temperature was very erratic, changing
>> anywhere between 3 C and 30C,
> 
> No, between 3 and 30.
> 
>> even when there was no workload running on the cpu.
> 
> When the CPU is mostly idle, even small wakeups for interrupts will
> result in rather large relative changes in power consumption and,
> therefore, power dissipation.
> 
>> If I understand it correctly, the implementation is such that it
>> reports following values:
>> 1) Highest temperature = 70
> 
> This is not the highest possible value; temp1_max is the highest value
> during normal operation.  On AMD CPUs, this is the point at which the
> CPU fan should run at 100 % (of TDP).
> 
>> 2) Critical temperature = mostly 70; [...] which kind of means that
>> D18F3x64[22:16] is mostly fixed to 36?
> 
> This register has whatever value the BIOS has written into it.
> 
>> 3)  Hysteresis value: [...] Is the value of D18F3x64[22:16] fixed or
>> it changes based on some condition?
> 
> It changes when the BIOS (or somebody else) writes to it.
> 
>> I am trying to compute the temperature values as accurately as
>> possible because my project involves calibrating the die-temperature
>> values against other measurements
> 
> Did you read section 2.11.1?  It says:
> | Tctl does not represent a temperature which could be measured on the
> | die or the case of the processor. Instead, it specifies the processor
> | temperature relative to the maximum operating temperature
> 
> The maximum operating temperature is defined as 70, but does not
> correspond to a known absolute temperature.
> 
> This temperature sensor is designed to control the CPU fan; it is _not_
> intended to result in a value that can be shown to the user in a way
> that makes much sense.
> 

Yes, I read it and I understood it in a way that Tctl is changed dynamically to track Tmeasured. Although, the scale of Tctl is weird, but I still thought these final values were still in degree C. I think that you are saying that the units of final reported values are not deg-C. I will read the document again, more carefully this time. 

I had following understanding:
Based on page 220, fig-14, max operating T and Tctl_max are the same. Also, the temperature of the part is [Tctl_max - Tctl] below the max operating T, which is the same as Tctl_max. So, it kind of means that Tctl itself is the temperature of the part (without the slew-rate control). Thats why I assumed that TmpMaxDiffUp was between 0C and 9C because I assumed that Tctl had units of degree C. I thought that when they say the temperature of the part or measured temperature, they mean the die-tmperature coming through temperature calculation circuit (TCC). But, it seems like thats the wrong understanding.

Little bit detail of what I intend to do:
I have a high-end IR camera which I use to take real-time high resolution image of the processor. Unfortunately, I need to calibrate the camera itself against true temperature. I need two temperature-points at which the temperature reported by the sensor is correct; using those two points, I might be able to calibrate the camera in the entire range and could potentially figure out the discrepancy in reported temperature at every other temperature reading. I am not sure if I am clear; if not, please let me know. 

Also, I have come to know that these sensors are more accurate at higher temperature; but, this information is not sufficient enough. I am looking for those temperature values at which the reported value is the same as the absolute temperature of the die. I thought this value is 70C for AMD processor. If those values are high, I could achieve them by controlling the cooling of the processor. In my experiments, I remove the fan and use liquid cooling with controlled fluid-temperature.

Regards,
Kapil

> 
> Regards,
> Clemens


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
