From: georges.giralt@free.fr (Georges Giralt)
Date: Wed, 07 Feb 2007 17:39:49 +0000
Subject: [lm-sensors] Inconsistents results
Message-Id: <45CA0EE5.9090809@free.fr>
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
Hi !
May I add the response from AMD regarding the difference between the 
Core 0 temp and Core 1 temp ?
I quote :
==================================
En ce qui concerne la diff?rence de temp?rature entre les deux core, il
semblerait que lors du test, un seul des core soit actif car la charge
de travail ne devait pas n?cessiter l activation du deuxieme core. En
effet 17? correspond a peu pres a la temperature de l environement ou` le
PC est plac?.

En ce qui concerne la difference de temperature annonc? part la carte
mere, il est normal qu elle soit legerement differente car moins
precise. En effet la capteur de temperature du processeur est in?gr? a
celui ci donc plus fiable.
==================================As it is in French, I translate it roughly as : "the cause of the 
difference is that the second core is not used at all because the 
workload is too low. The core 1 temp is about the ambient temp.
Regarding the difference between the temp of the core0  as seen by the 
AMD 64 sensor and the Mobo the cause is a difference in precision, the 
mobo being less precise/accurate thand the in CPU sensor."

So my conclusion is that the Fedora Kernel scheduler only use one core 
unless the load is high. (I'm trying to prove it doing huge compilations 
whith optimisation turned on)
Thanks to all who helped so far !
-- 
Ce message est constitu? d'au moins 50 % d'?lectrons recycl?s.
S'il vous pla?t, aidez nous a` conserver nos ressources,
recyclez vos ?lectrons !

