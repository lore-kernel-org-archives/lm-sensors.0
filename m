From: georges.giralt@free.fr (Georges Giralt)
Date: Mon, 05 Feb 2007 05:32:54 +0000
Subject: [lm-sensors] Inconsistents results
Message-Id: <45C6C186.70104@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C17E27.70603@free.fr>
In-Reply-To: <45C17E27.70603@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek a ?crit :
> Georges Giralt wrote:
>> Hi Rudolf !
> Hi,
> 
> Please always CC the list! So we have this for future generations ;)
> 
>>> Please can you provide the dsdt.bin file?
>>>
>>> cat /proc/acpi/dsdt > /tmp/dsdt.bin
>>>
>>> (this command will create it in the /tmp directory)
> 
> It reads temp1 (0x29)
> 
>     Method (RTMP, 0, NotSerialized)
> 
>     {
> 
>         Store (GBYT (0x29), Local0)
> 
>         FindSetLeftBit (Local0, Local1)
> 
>         If (LEqual (Local1, 0x08))
> 
>         {
> 	if highest bit set
> 
>             And (Local0, 0x7F, Local0)
> 
>             Multiply (Local0, 0x0A, Local0)
> 
> 	use the low 7 bits * 10
> 
>             Subtract (0x0AAC, Local0, Local0)
> 
> 
> 	substract 2732 because of kelvins and it suppose to be in tenth of kelvins
> 
>         }
> 
>         Else
> 
>         {
> 
>             Multiply (Local0, 0x0A, Local0)
> 
> 		*10
>             Add (0x0AAC, Local0, Local0)
> 
> 	Add 2732 if temp is positive
> 
>         }
> 
> 
> 
>         If (LEqual (SSHU, 0x01))
> 
>         {
> 
>             Return (0x0C3C)
> But your case is this. if variable called SSHU is set to 1, return always 40C
> So mystery is solved.
> 
>         }
> 
>         Else
> 
>         {
> 
>             Return (Local0)
> 
>         }
> 
>     }
> 
> And from asus ATK0110 ACPI device:
> 
>                        Store (TSR1, Local0)
> 
>                         Store (0x00, Local1)
> 
>                         While (LEqual (Local0, 0x80))
> 
>                         {
> 
>                             Store (TSR1, Local0)
> 
>                             If (LEqual (Local1, 0x000186A0))
> 
>                             {
> 
>                                 Break
> 
>                             }
> 
> 
> 
>                             Add (Local1, 0x01, Local1)
> 
>                         }
> 
> 
> 
>                         Multiply (Local0, 0x0A, Local0)
> 
>                         Return (Local0)
> 
> This is a bit strange code. It reads the temp, if the temp is 0x80 it re-reads
> the temp 100000 (186A0) times.
> 
>>>> #sensors
>>>> k8temp-pci-00c3
>>>> Adapter: PCI adapter
>>>> Core0 Temp:
>>>>               +13?C
>>>> Core1 Temp:
>>>>               +27?C
>>>>
>>>> it8716-isa-0290
>>>> Adapter: ISA adapter
>>>> VCore:     +1.02 V  (min =  +0.00 V, max =  +4.08 V)
>>>> VDDR:      +3.25 V  (min =  +0.00 V, max =  +4.08 V)
>>>> +3.3V:     +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
>>>> +5V:       +4.84 V  (min =  +0.00 V, max =  +6.85 V)
>>>> +12V:     +11.78 V  (min =  +0.00 V, max = +16.32 V)
>>>> in5:       +0.00 V  (min =  +0.00 V, max =  +4.08 V)   ALARM
>>>> in6:       +0.00 V  (min =  +0.00 V, max =  +3.82 V)   ALARM
>>>> 5VSB:      +4.68 V  (min =  +0.00 V, max =  +6.85 V)
>>>> VBat:      +2.91 V
>>>> fan1:     2860 RPM  (min =    0 RPM)
>>>> fan2:     1391 RPM  (min =    0 RPM)
>>>> fan3:        0 RPM  (min =    0 RPM)
>>>> temp1:       +18?C  (low  =    -1?C, high =  +127?C)   sensor = diode
>>>> temp2:       +28?C  (low  =    -1?C, high =  +127?C)   sensor >>>> thermistor
>>>> temp3:       +25?C  (low  =    -1?C, high =  +127?C)   sensor >>>> thermistor
>>>> vid:      +0.000 V
>>>> #
>>>> Two things bother me : First, the discrepancy between core0 temp and
>>>> core1 temp. As they are into the same package, they should even out,
>>>> should'nt they ? The second thing is that the spread ot temperature I
>>>> get : 13, 18, 25, 27, 28 and 40 ?C ...
>>> You mean when you try to raise the temperature - CPU usage?
>> No, no the discrepancies between the two core temps, and the temp seen
>> by the mobo regarding the CPU temp. it goes from 13 to 40 ?C depending
>> which way you use to find it...
> 
> Aha now I understand.
> 
> 13 - I think some calibration went wrong in this core
> 18 - it has same source as 13C it just use analog wire and diode.
> 
> 25C - this temp will never move because they put the resitor there instead of
> thermistor, so just forget about temp3
> 
> 27C looks OK
> 28C is motherboard temp
> 
> 40C is fake temperature for some reason.
> 
>> This is low regarding BIOS readings : When the CPU is at 28?C the mobo
>> is about 31 ?C for the BIOS. (BTW I've the latest BIOS :  Rev 0603)
> 
> Maybe it just get hotter in the BIOS. The asus APCI programming shows that temp1
> is CPU and temp2 is MB. Temp3 is not used at all - 25C means just some resistor
> is placed instead of thermistor.
> 
>> processor	: 0
>> vendor_id	: AuthenticAMD
>> cpu family	: 15
>> model		: 75
> 
> It seems you have revision F of the CPU, perhaps it has really just misplaced
> the thermal calibration.
> 
> I hope it helps,
> 
> Rudolf
> 
> 
Hi all !
So here it goes :
At cold boot up the readings are :
Core0 Temp:
               +9?C
Core1 Temp:
              +26?C
temp1:       +15?C  (low  =    -1?C, high =  +127?C)   sensor = diode
temp2:       +25?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
So pretty consistent with the internal CPU probe.
After a while the temps stabilize as follow :

Core0 Temp:
              +11?C
Core1 Temp:
              +28?C

temp1:       +17?C  (low  =    -1?C, high =  +127?C)   sensor = diode
temp2:       +27?C  (low  =    -1?C, high =  +127?C)   sensor = thermistor
It seems the MOBO gets warm during the initialization phase and then 
stick to the 25~30 ?C
And that the CPU slowly rise from the cold to the 17~27 ?C (when I let 
the CPU go idle it fall to 17 ?C so CPU freq scqlling is working ;-) )
Thanks a lot Rudolf for your help and advices !
-- 
Ce message est constitu? d'au moins 50 % d'?lectrons recycl?s.
S'il vous pla?t, aidez nous a` conserver nos ressources,
recyclez vos ?lectrons !

