From: Curt.Blank@curtronics.com (Curt Blank)
Date: Fri, 23 Mar 2007 14:34:56 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use	w83627ehf
Message-Id: <4603E590.9090202@curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan,

den_tichel at zonnet.nl wrote:
> Hi Curt,
> 
> Based on the schematics I've sent you, it seems that there is some 
> miscomputation.
> 
>> So, based on your feedback of voltage levels, and with the schematics of the
>> MSI K9N4 SLI-F and the pre-set definitions of the W83627EHF calculations I
>> could suggest for sensors.conf:
>>
>> chip "w83627dhg-*"
>>
>> labels:
>> label in0 "VCore"
>> label in1 "+12V"
>> label in2 "5V"
>> label in3 "-12V"
>> label in5 "AVCC"
>> label in7 "VSB"
>> label in8 "VBAT"
>>
>> computations:
>> compute in1 @*(1+(56/10)), @/(1+(56/10))
>> compute in2 @*(1+(22/10)), @/(1+(22/10))
>> compute in3 -@*(1+(56/10)), -@/(1+(56/10))
>>
>> Let me know if this gives you the correct readings. If
>> it's not, I'll try and get the values for Rin and Rf.
>>
>> Here's the results of plugging in your equations:
>>
>> w83627dhg-isa-0a10
>> Adapter: ISA adapter
>> VCore:     +1.23 V  (min =  +0.00 V, max =  +1.74 V)
>> +12V:     +12.30 V  (min =  +6.97 V, max =  +5.23 V)
>> 5V:       +10.44 V  (min =  +7.48 V, max = +10.75 V)
>> -12V:     -21.54 V  (min =  -5.91 V, max = -18.27 V)
>> in4:       +1.54 V  (min =  +1.23 V, max =  +0.02 V)
>> AVCC:      +1.46 V  (min =  +0.24 V, max =  +0.78 V)
>> in6:       +1.61 V  (min =  +0.17 V, max =  +0.53 V)
>> VSB:       +3.26 V  (min =  +2.18 V, max =  +2.26 V)
>> VBAT:      +2.99 V  (min =  +2.08 V, max =  +0.86 V)
>>
>> -Curt
>>
> 
> So right now I could suggest a different computation for:
> 
> compute in3 -@*(1+(232/10)), -@/(1+(232/10))
> 
> The calculation for the 5V is OK, but then again... in2 is not 5V. So 
> now I'm guessing in6 is 5V, so change your in2 labels and computation 
> to in6.
> 
> As a last challenge:
> How are your system temps displayed? After all, they are connected 
> through thermal resistors on SYS_TMP and CPU_TMP.
> 
> Kind regards,
> 
> Jan van Tiggelen

I see what you mean on the schematic, but one question, that schematic 
is for an EHG, this is a DHG. The only reason I mention that is because 
I put the new computation in and it made it worse:

w83627dhg-isa-0a10
Adapter: ISA adapter
VCore:     +1.23 V  (min =  +0.00 V, max =  +1.74 V)
+12V:     +12.30 V  (min =  +6.97 V, max =  +5.23 V)
in2:       +3.26 V  (min =  +2.34 V, max =  +3.36 V)
-12V:     -78.99 V  (min = -21.68 V, max = -66.99 V)
in4:       +1.54 V  (min =  +1.23 V, max =  +0.02 V)
AVCC:      +1.46 V  (min =  +0.24 V, max =  +0.78 V)
5V:        +5.15 V  (min =  +0.54 V, max =  +1.69 V)
VSB:       +3.26 V  (min =  +2.18 V, max =  +2.26 V)
VBAT:      +2.99 V  (min =  +2.08 V, max =  +0.86 V)
Case Fan: 5113 RPM  (min = 1205 RPM, div = 8)
CPU Fan:  2909 RPM  (min = 1004 RPM, div = 8)
NB Fan :  6887 RPM  (min = 2008 RPM, div = 4)
Sys Temp:    +41?C  (high =   +55?C, hyst =   +40?C)
CPU Temp:  +33.5?C  (high = +75.0?C, hyst = +40.0?C)

And the Sys Temp seems to be fine, but the CPU Temp is reading low when 
sensors says 34?C the BIOS says 38?C.

And this is what k8temp is showing at the same time as above:

k8temp-pci-00c3
Adapter: PCI adapter
Core1 Temp:
              +43?C
Core2 Temp:
              +46?C

I guessed that the temp1 and temp3 were the two cores, if not, what 
would they be? temp2 and temp4 show nothing.

-Curt


