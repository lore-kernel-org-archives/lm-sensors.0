From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 07 Jul 2007 13:26:09 +0000
Subject: Re: [lm-sensors] initial fintek f71882fg driver, test please
Message-Id: <468F9471.8030200@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4676A4D8.5020706@hhs.nl>
In-Reply-To: <4676A4D8.5020706@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Walt H wrote:
> Goede, J.W.R. de wrote:
>> On Wed, 20 Jun 2007 18:28:49 -0500
>>  Walt H <walt_h@lorettotel.net> wrote:
>>> This was tested on an MSI P965 Platinum MB.  I installed
>>> the svn checkout of libsensors3 and copied the section
>>> from the f71805 to modify for this chip.  The set
>>> statements for the chip fail, so I'm not able to set
>>> hysteresis or critical values on temperatures yet.  Also,
>>> on my MB, the BIOS hardware monitor only shows the CPU
>>> Vcore, +5 VSB, +5, +12, NB and DRAM voltage, so I can't
>>> vouch for the other inputs.
>> Well, the 3.3V, 3.3VSB and Vbat inputs are all internally
>> connected in the chip, so they should be fine. That still
>> leaves us one voltage short though.
>>
>>
>>   The comments from the f71805
>>> indicate that in0 (+3.3) should be internally scaled and
>>> need no adjustment, however, if that input is correct it
>>> appears to be scaled in half by default, so I multiplied
>>> it by 2.
>> Ahha, if you would have looken at the epox sensors.conf I
>> attched and am using for tested you would have seen that
>> I'm scaling in0 there by a factor of 2, and a comment not
>> to change this as its internally scaled. I guess the f71805
>> driver is doing the scaling in the driver already. Which
>> makes sense. I'll modify my driver todo the same for in0
>> and in6 and in7.
>>
> Sorry, missed that.... Figured F71805 would be close.
> 
>> Also Vcore is most likely connected to in1, as in1 is the
>> only one which can cause voltage alarms.
> 
> Makes sense.
>> I think using the config below should yield better results,
>> can you try this please? ALso please write down your BIOS
>> readings till the last diget, assuming you have a decent
>> powersupply the readings should be pretty stable, so maybe
>> we can compare the last digits to find out exactly whats
>> what. Because currently in2, in3 and in4 are all reading
>> about 1V unscaled, which when using normal scaling factors
>> could be any of: 1V 2V or 5.2V when scaled, so the lables
>> currently apointed to them below are somewhat random ATM.
>>
>> chip "f71882fg-*"
>>
>> # Temperature
>>     label temp1 "CPU"
>>     label temp2 "System"
>>     ignore temp3
>>     ignore temp4
>>
>> # Fans
>>     label fan1 "CPU"
>>     label fan2 "System"
>>     ignore fan3
>>     ignore fan4
>>
>> # Voltage
>>     label in0 "3.3V"
>>     label in1 "Vcore"
>>     label in2 "Vram"
>>     label in3 "5VSB"
>>     label in4 "+5V"
>>     label in5 "12V"
>>     label in6 "??"
>>     label in7 "3VSB"
>>     label in8 "Batery"
>>
>> # never change the in0, in7 and in8 compute, these are
>> hardwired in the chip!
>>     compute in0 (@ * 2), (@ / 2)
>>     compute in2 (@ * 2), (@ / 2)
>>     compute in3  @*(1+200/47),  @/(1+200/47)
>>     compute in4  @*(1+200/47),  @/(1+200/47)
>>     compute in5  @*(1+200/20),  @/(1+200/20)
>>     compute in7 (@ * 2), (@ / 2)
>>     compute in8 (@ * 2), (@ / 2)
>>
>> Regards,
>>
>> Hans
>>
>>
> This looks good Hans.  The Vcore is seems to be spot on now.  It does
> range, as expected due to freq. scaling, but it matches up with what
> I've seen in the BIOS.  All the rest look good as well.  The ?? (in6) 
> sensor appears to be NB as that is what is set in the bios under the
> "overclocking" menu. 
> 
> Also, tried booting without pnpacpi turned off and it worked just fine. 
> Current output is as follows:
> 
> f71882fg-isa-0a10
> Adapter: ISA adapter
> 3.3V:            +3.31 V
> Vcore:           +1.14 V
> Vram:            +1.98 V
> 5VSB:            +5.05 V
> +5V:             +5.00 V
> 12V:            +12.23 V
> ??:              +1.26 V
> 3VSB:            +3.31 V
> Batery:          +3.17 V                       *** (spelling: S/B  Battery)
> CPU Fan:        1066 RPM
> System Fan:     1469 RPM
> CPU:             +39.0 C  (high = +85.0 C, hyst =  +4.0 C)  sensor > transistor
> temp1_crit:     +100.0 C  (hyst =  +4.0 C)
> System:          +34.0 C  (high = +85.0 C, hyst =  +4.0 C)  sensor > transistor
> temp2_crit:     +100.0 C  (hyst =  +4.0 C)
> 

Thanks for testing,

I've added this config for the MSI P965 Platinum to the wiki, see:
http://www.lm-sensors.org/wiki/Configurations/MSI/P965-Platinum

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
