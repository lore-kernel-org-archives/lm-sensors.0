From: Aleksej Serdjukov <deletesoftware@yandex.ru>
Date: Thu, 07 Apr 2011 13:54:18 +0000
Subject: Re: [lm-sensors] testing "w83627ehf" and "k10temp" on ASRock E350M1
Message-Id: <4D9DC20A.1010501@yandex.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D9CA530.9030100@yandex.ru>
In-Reply-To: <4D9CA530.9030100@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011-04-07 16:24, Jean Delvare wrote:
> On Thu, 07 Apr 2011 13:11:44 +0400, Aleksej Serdjukov wrote:
>> (sorry, the CCs seem to have confused Thunderbird)
>> On 2011-04-07 11:26, Jean Delvare wrote:
>>   >  what is your problem exactly? Do you have an actual question?
>>
>> My problem is the noise the fan is making at full-on speed. I want it to
>> be reasonably quiet, but I don't know why it is following the speed
>> chosen (between 1 and 9) and not just trying to keep the chosen CPU
>> temperature; and why yesterday it suddenly got to maximum without me
>> changing the setting or the non-temp1 temperatures being ordinary.
>
> You should have explained this upfront!

Sorry, maybe it's because I don't know what the temperature should be.


>> Since k10temp shown 60-65°C, I set the fan speed to full and posted here.
>>
>> Also, the only clear statement about temperatures of E-350 I found is
>> that the maximum is 90. Reviews talk about 30 or 50. Where should I stop
>> with the quietness?
>
> Where did you get the maximum temperature from? The k10temp driver
> seems to disagree - it says 75°C max.

http://products.amd.com/%28X%281%29S%28q5r43t55n5rep1j4u3pjcf45%29%29/pages/desktopapudetail.aspx?id=1&f1=AMD+Dual-Core+Processor+E-350&f2=E-350+with+AMD+Radeon%E2%84%A2+HD+6310+Graphics&f300&f4=2&f5=FT1+BGA&f6+W&AspxAutoDetectCookieSupport=1

Maybe 75 is when UEFI would shut it down?


>> Settings in UEFI:
>> DRAM : 1.507
>> +1V  : 1.10
>> FCH  : 1.10
>> +1.8V: 1.85
>
> Err, sorry I messed up. DDR3 is definitely +1.5V, +1.8V was DDR2. Not
> sure what I was up to this morning. But anyway, in5 seems to match
> +1.8V in UEFI, whatever it is used for.
>
> Are these settings as in "you can decide the values"? Or measurements?
> It is strange that there is no match for DRAM, +1V nor FCH in the
> sensors output.

The former, I guess. The numbers are next to drop-down lists of values 
where "Auto" is selected.


>> == START COMPARISON #1 =======================>>
>> UEFI's H/W pane said:
>>
>> CPU Temp: 44  (got there from 40 since reboot)
>> M/B Temp: 44  (got there from 43 since reboot)
>>
>> Vcore: 1.304 V
>> +12 V: 12.196 V
>> +5.00: 4.992 V
>> +3.30: 3.328 V
>>
>> sensors after boot:
>>
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> temp1:       +57.5°C  (high = +70.0°C, crit = +75.0°C)
>>
>> nct6775-isa-0290
>> Adapter: ISA adapter
>> Vcore:       +1.13 V  (min =  +0.00 V, max =  +1.74 V)
>
> Does this value increase if you put much load on the CPU? It's quite
> different from the 1.304 V reported by UEFI.

In UEFI, Vcore is switching between 1.256 and 1.304.
In sensors (with fan auto control at 7 or 8, 48°), Vcore mostly stays at 
1.08, and under load at 1.30 V.


>> UEFI's H/W Monitor pane said:
>>
>> VCore: 1.304
>> +12  : 12.144
>
> Previous value printed for +12V was 12.196. 12.196 - 12.144 = 0.052.

12V is switching ("like" Vcore).

>>   >>>  in6:         +1.66 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
>>   >>
>>   >>  	This one might be 5V (*3)
>>
>> UEFI: +5.00: 4.992 V
>>
>> 4.992 / 3 = 1.664
>> 1.66 * 3 = 4.98
>
> This is one possibility, yes. It could be confirmed by capturing at
> least one other +5V value in UEFI.

+5 V seems to always be 4.992 (unless I miswrote 4.982 in #2)

>>   >>>  SYSTIN:      +51.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM
>> sensor =  thermistor
>>   >>>  CPUTIN:      +45.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor >> thermistor
>>   >
>>   >  These temperatures look reasonable to me. Find out which is the CPU
>>   >  temperature by putting some load on the CPU: the CPU temperature will
>>   >  raise faster and higher. You should also set appropriate limits for
>>   >  temp1 and write them to the chip with "sensors -s".
>>
>> CPUTIN and temp1 slowly increased (CPUTIN from 44-46 to 48-49, temp1
>> from 56 to 67-69).
>
> 69°C is dangerously close to the limits. Which is odd given the high
> fan speed.

That was with burnK7. Maybe I shouldn't have used that. But then (fan 
auto control at speed 7 or 8, 48°) p7zip gets it to 66 immediately and 
then to 68.

> Are you sure the case gets enough cooling from the outside /
> can get the hot air evacuated properly?

It is in 15-25 cm from walls, and in 30 cm from a heating pipe. Air 
temperature there is 22-24°C.

The case is IN WIN BQ656BL.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
