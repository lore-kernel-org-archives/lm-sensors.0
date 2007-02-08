From: georges.giralt@free.fr (Georges Giralt)
Date: Thu, 08 Feb 2007 20:21:57 +0000
Subject: [lm-sensors] Inconsistents results
Message-Id: <45CB8665.202@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <45C17E27.70603@free.fr>
In-Reply-To: <45C17E27.70603@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek a ?crit :
> Hello again,
>> Hi !
>> May I add the response from AMD regarding the difference between the 
>> Core 0 temp and Core 1 temp ?
>> I quote :
>> ==================================
>> En ce qui concerne la diff?rence de temp?rature entre les deux core, il
>> semblerait que lors du test, un seul des core soit actif car la charge
>> de travail ne devait pas n?cessiter l activation du deuxieme core. En
>> effet 17? correspond a peu pres a la temperature de l environement ou` le
>> PC est plac?.
>>
>> En ce qui concerne la difference de temperature annonc? part la carte
>> mere, il est normal qu elle soit legerement differente car moins
>> precise. En effet la capteur de temperature du processeur est in?gr? a
>> celui ci donc plus fiable.
>> ==================================>> As it is in French, I translate it roughly as : "the cause of the 
>> difference is that the second core is not used at all because the 
>> workload is too low. The core 1 temp is about the ambient temp.
>> Regarding the difference between the temp of the core0  as seen by the 
>> AMD 64 sensor and the Mobo the cause is a difference in precision, the 
>> mobo being less precise/accurate thand the in CPU sensor."
> 
> Well is the 18C possible? Have you some heatpipes CPU?
> 
> You may for example load both CPUs running following command 2 times:
> 
> dd if=/dev/urandom of=/dev/null
> dd if=/dev/urandom of=/dev/null
> 
> And see what happens. (Of course you need to have the SMP kernel)
> 
> Rudolf
> 
> 
> 
Hi Rudolf !
The 18?C is quite true.
This is the temp a few seconds after boot up on a quite cold room.
The PC box is a Textrom with really ggod cooling properties and the CPU 
is one of the latest AMD one, with rather low power disspiation (I think 
it has the cooper wires inside).
i've tried, yesterday, to load the 2 core by compiling a big piece of 
code with -g 3 flag. Unfortunatelly, I missed some required dependencies 
so compilation aborted pretty soon, but the temp raised a bit.
Using the 2 dd above for 5 minutes raised temp like this :
8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
              +33?C
Core1 Temp:
              +44?C

The 44 ?C is the highest record I've seen since I own this CPU ! Stop 
Global warming !
The core 0 is raising slowly but I doubt it will reach the core 1 temp.
Regarding the SMP kernel, on Fedora bxes all kernels are SMP, so I'm 
confident on this one.
Last but not least, I run X86-64 version of kernel (and OS, of course) I 
wonder if this helps or not..
So all this to say I'm quite impressed by the AMD and the mobo. My 
previous old Athlon 1700+ (0.18 ? ) was running hot (I should say 
melting hot, regarding the figures I get with this one) So the gap is 
quite huge...
Thanks for all your help, folks !

-- 
Ce message est constitu? d'au moins 50 % d'?lectrons recycl?s.
S'il vous pla?t, aidez nous a` conserver nos ressources,
recyclez vos ?lectrons !

