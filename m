From: James <bjlockie@lockie.ca>
Date: Sun, 13 May 2012 02:03:25 +0000
Subject: Re: [lm-sensors] missing fan RPMS
Message-Id: <4FAF166D.6000001@lockie.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAED541.7080201@lockie.ca>
In-Reply-To: <4FAED541.7080201@lockie.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/12/12 21:53, Guenter Roeck wrote:
> On Sat, May 12, 2012 at 05:25:21PM -0400, James wrote:
>>
>> I bought a new motherboard (ASRock 970 Extreme3) and it doesn't report the fans.
>>
> Hi James,
> 
>> nct6776-isa-0290
>> Adapter: ISA adapter
>> Vcore:        +0.86 V  (min =  +0.00 V, max =  +1.74 V)
>> in1:          +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> AVCC:         +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> +3.3V:        +3.33 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> in4:          +1.58 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> in5:          +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> 3VSB:         +3.44 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> Vbat:         +3.34 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>> fan1:           0 RPM  (min =    0 RPM)  ALARM
>> fan2:           0 RPM  (min =    0 RPM)  ALARM
>> fan3:           0 RPM  (min =    0 RPM)  ALARM
>> fan4:           0 RPM  (min =    0 RPM)  ALARM
>> fan5:           0 RPM  (min =    0 RPM)  ALARM
> 
> Weird. We had a bug where fans where not recognized at all, but I have not seen
> zero RPM reported.
> 
> If you like, you can try my experimental new driver from https://github.com/groeck/nct6775.
> 
>> sensors also doesn't show +12V or +5V.
>>
> Those will be among in1, in4, and in5. The ADC is range of the NCT6776F limited,
> so the voltage passed to the chip is scaled. Question is which one is which.
> Have a look at http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling;
> maybe it helps you finding out.
> 
> Guenter
> 

I forgot to mention that the RPM of the fans is reported in the BIOS screen.

I will try the experimental driver.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
