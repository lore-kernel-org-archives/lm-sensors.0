From: Harald Judt <h.judt@gmx.at>
Date: Fri, 26 Oct 2012 00:55:34 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <5089DF86.9050004@gmx.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am 26.10.2012 02:41, schrieb Guenter Roeck:
> On Thu, Oct 25, 2012 at 04:49:01PM -0700, Guenter Roeck wrote:
>> On Thu, Oct 25, 2012 at 09:07:36PM +0200, Jean Delvare wrote:
>>> On Thu, 25 Oct 2012 19:26:45 +0200, Harald Judt wrote:
>>>> Am 24.10.2012 21:23, schrieb Jean Delvare:
>>>>> To be really sure, it would be good if you could set arbitrary non-zero
>>>>> limits to in1, in4, in5 etc. otherwise we can't be sure these limits
>>>>> have been restored either.
>>>>
>>>> Good idea. Here is the corresponding part of my adjusted
>>>> /etc/sensors3.conf file:
>>>>
>>>> chip "w83627ehf-*" "w83627dhg-*" "w83667hg-*" "nct6775-*" "nct6776-*"
>>>>
>>>>       label in0 "Vcore"
>>>>       label in2 "AVCC"
>>>>       label in3 "+3.3V"
>>>>       label in7 "3VSB"
>>>>       label in8 "Vbat"
>>>>
>>>>       set in0_min  0.5 * 1.00
>>>>       set in0_max  2.0 * 1.00
>>>>       set in1_min  1.6 * 1.00
>>>>       set in1_max  1.95 * 1.00
>>>>       set in2_min  2.0 * 1.00
>>>>       set in2_max  3.5 * 1.00
>>>>       set in3_min  2.0 * 1.00
>>>>       set in3_max  3.5 * 1.00
>>>>       set in4_min  0.8 * 1.00
>>>>       set in4_max  1.2 * 1.00
>>>>       set in5_min  1.5 * 1.00
>>>>       set in5_max  1.95 * 1.00
>>>>       set in7_min  2.0 * 1.00
>>>>       set in7_max  3.5 * 1.00
>>>>       set in8_min  2.0 * 1.00
>>>>       set in8_max  3.5 * 1.00
>>>>
>>>> There are some limits for min/max values, e.g. in5_max will get reset to
>>>> 2.04 if you try to use a higher value. Therefore I've set it to 0.95 to
>>>> avoid any confusion.
>>>>
>>>> So, here are the results after sensors -s:
>>>>
>>>> nct6776-isa-0290
>>>> Adapter: ISA adapter
>>>> Vcore:         +0.96 V  (min =  +0.50 V, max =  +2.00 V)
>>>> in1:           +1.84 V  (min =  +1.60 V, max =  +1.95 V)
>>>> AVCC:          +3.34 V  (min =  +2.00 V, max =  +3.50 V)
>>>> +3.3V:         +3.34 V  (min =  +2.00 V, max =  +3.50 V)
>>>> in4:           +1.05 V  (min =  +0.80 V, max =  +1.20 V)
>>>> in5:           +1.68 V  (min =  +1.50 V, max =  +1.95 V)
>>>> 3VSB:          +3.47 V  (min =  +2.00 V, max =  +3.50 V)
>>>> Vbat:          +3.31 V  (min =  +2.00 V, max =  +3.50 V)
>>>>
>>>> And after resume:
>>>> nct6776-isa-0290
>>>> Adapter: ISA adapter
>>>> Vcore:         +0.96 V  (min =  +0.00 V, max =  +1.74 V)
>>>> in1:           +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> AVCC:          +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> +3.3V:         +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> in4:           +1.05 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> in5:           +1.68 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>>>> 3VSB:          +3.47 V  (min =  +2.00 V, max =  +3.50 V)
>>>> Vbat:          +3.31 V  (min =  +2.00 V, max =  +3.50 V)
>>>>
>>>> Apparently, in0-in5 do not get restored, only in7 and in8 do. There is
>>>> no in6 on this chip (verified by looking in /sys/class/hwmon).
>>>
>>> I don't get it. I have double checked my code and I don't see how this
>>> is possible. Plus Guenter's testing was successful...
>>>
>> Doesn't work for me either on NCT6776F. Some of the data is restored, which is
>> not the case if I use the "old" driver, so I must have used the correct driver.
>>
> Hi Jean,
>
> I found the problem. The NCT6776F has the wrong bank selected when resuming.
>
> It started working for me after adding
>
> 	data->bank = 0xff;
>
> to the beginning of the resume function. This forces the bank register to be
> updated when the first chip access is done. It might make sense to do this
> for all chips with bank registers.
>
> Guenter

Confirmed. After adding that command to the beginning of the resume 
function all values get properly restored.

Harald

-- 
`Experience is the best teacher.'

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
