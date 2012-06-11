From: kernel@noltedennis.de
Date: Mon, 11 Jun 2012 07:55:07 +0000
Subject: Re: [lm-sensors] VIA Epia ML6000EAG vt1211 CPU temperature wrong value
Message-Id: <14fd3c31ad9a22c658dd99c58eec930a.squirrel@www.sexychickz.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7590e64826c8ddac9804d2bc428f9c9.squirrel@www.sexychickz.net>
In-Reply-To: <f7590e64826c8ddac9804d2bc428f9c9.squirrel@www.sexychickz.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello and thank you for helping.

The raw readings on following config settings:

compute temp1 (@ - 83.869) / 0.9528, (@ * 0.9528) +83.869

# cat /sys/devices/platform/vt1211.24576/temp1_input
99000
# cat /sys/devices/platform/vt1211.24576/temp2_input
41000

for comparison the sensor output:
#sensors
...                                                                       
 fan1:    0 RPM  (min =    0 RPM, div = 2)
fan2:          0 RPM  (min =    0 RPM, div = 2)
temp1:       +15.9 C  (high = +179.6 C, hyst = -88.0 C)
SIO Temp:    +41.0 C  (high = +204.0 C, hyst =  +0.0 C)
cpu0_vid:   +1.750 V


without the compute line the hyst value seems to be ok, but the temp is
pretty high.

temp1:      +102.0 C  (high = +255.0 C, hyst =  +0.0 C)
Raw value: 104000

The BIOS of this device does not have an option to check temperature
directly so i cannot confirm/deny the temp.

Anything else i can try?

With regards

Dennis Nolte




> On Wed, 2012-06-06 at 09:51 -0400, kernel@noltedennis.de wrote:
>> Hello everyone,
>>
>> It seems the cpu temperature of the VIA EPIA ML6000EAG chip vt1211
>> seems to be a bit off in
>> sensors version 3.1.2 with libsensors version 3.3.2.
>>
>> The CPU is a VIA Nehemiah with a passive cooling setup.
>>
>> All tests happend at approx. 20 degree celsius with no active cooling
>> inside the case.
>>
>>
>> Here is some hopefully relevant data:
>>
>>
>> /etc/sensors3.conf
>> snipped:
>>
>> chip "vt1211-*"
>>
>>     label in5 "+3.3V"
>>
>>     label temp2 "SIO Temp"
>>    #compute temp1 (@*@*0.0046) - (@*0.088) - 0.748, (@*0.9686) + 65
>>    #compute temp1 (@ - 65) / 0.9686, (@ * 0.9686) + 65
>>    #kernel.org on C3 Ezra
>>     compute temp1 (@ - 83.869) / 0.9528, (@ * 0.9528) +83.869
>>
>>
>>
>> # sensors
>> vt1211-isa-6000
>> Adapter: ISA adapter
>> in0:         +1.95 V  (min =  +0.00 V, max =  +2.63 V)
>> in1:         +1.99 V  (min =  +0.00 V, max =  +2.63 V)
>> in2:         +1.03 V  (min =  +0.00 V, max =  +2.63 V)
>> in3:         +1.97 V  (min =  +0.00 V, max =  +2.63 V)
>> in4:         +2.12 V  (min =  +0.00 V, max =  +2.63 V)
>> +3.3V:       +3.33 V  (min =  +0.00 V, max =  +4.18 V)
>> fan1:          0 RPM  (min =    0 RPM, div = 2)
>> fan2:          0 RPM  (min =    0 RPM, div = 2)
>> temp1:       +34.8 C  (high = +179.6 C, hyst = -88.0 C)
>> SIO Temp:    +56.0 C  (high = +204.0 C, hyst =  +0.0 C)
>> cpu0_vid:   +1.750 V
>>
>> this output is generated with the above compute value.
>>
>> the raw value for the temperature are as followed:
>>
>> # cat /sys/devices/platform/vt1211.24576/temp*_input
>> 117000
>> 56000
>>
>> this is with a cpu load of <5 percent.
>>
>> with approx. 100 % cpu load the temp1 value increases slightly to
>> 121000.
>>
>>
>> I did try to find additional info for the modul , settings for the
>> sensors3.conf and came up with the 3 above mentioned compute values.
>>
>> As they seem to be for a different processor im not sure if those values
>> are correct for my system at all.
>>
>>
>> #cat /proc/cpuinfo
>> processor       : 0
>> vendor_id       : CentaurHauls
>> cpu family      : 6
>> model           : 9
>> model name      : VIA Nehemiah
>> stepping        : 8
>> cpu MHz         : 666.644
>> cache size      : 64 KB
>> fdiv_bug        : no
>> hlt_bug         : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 1
>> wp              : yes
>> flags           : fpu vme de pse tsc msr cx8 sep mtrr pge cmov pat mmx
>> fxsr sse rng rng_en ace ace_en
>> bogomips        : 1333.28
>> clflush size    : 32
>> cache_alignment : 32
>> address sizes   : 32 bits physical, 32 bits virtual
>> power management:
>>
>> please let me know if i can give additional information to help solving
>> this "problem".
>>
> The driver code says "temp1 is an intel thermal diode which is scaled in
> user space". That means the reading depends on the board (ie how the
> sensor is connected) and on the CPU type. So anything you can come up
> with is as "correct" as it can be. Best would be, if that is possible,
> to compare readings with values reported by the BIOS and try to get a
> match.
>
> temp1_hyst looks wrong, though. It should not be negative. I don't know
> the driver or the chip, and the data sheet is only available under NDA,
> so I can not verify it. What is its raw reading ?
>
> Thanks,
> Guenter
>
>
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
