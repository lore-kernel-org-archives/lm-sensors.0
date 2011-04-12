From: Philip Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 12 Apr 2011 15:52:13 +0000
Subject: Re: [lm-sensors] System instability with Supermicro X8DTi-F and
Message-Id: <9008CCA0-2FA1-4AFA-A740-D43BD4B3C5A6@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DA43970.6040605@brakkee.org>
In-Reply-To: <4DA43970.6040605@brakkee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your own experience says that fancontrol, lmsensors and a BMC do not  
have a way to coordinate actions which leads to errors and faults.

And as Jean has said, the Winbond chip has a paged register set that  
requires coordination to access.  The BMC code has now way to  
coordinate access with the OS.

Jean mentions thermal trip points. I believe that the winbond chip  
includes it's own autonomous fan speed control seperate from the BMC  
monitoring. What if you just reprogram the fan control curves in the  
Winbond chip once at boot if you don't like the ES BIOS fan control  
curve?

Otherwise, no I don't think what you want is possible.

How hot were the CPU under full load with the ES fan curve that you  
felt they needed to be colder?

Phil P.

-- 
Philip Pokorny, RHCE
Chief Hardware Architect
PENGUIN COMPUTING, Inc
www.penguincomputing.com

On Apr 12, 2011, at 8:33 AM, Erik Brakkee <erik@brakkee.org> wrote:

> Philip Pokorny wrote:
>> Your motherboard BIOS includes fan speed control and a BMC for  
>> sensor monitoring
>>
>> Use ipmitool and perhaps bmcsensors module to monitor sensors.
>>
>> Go into the bios and under hardware monitoring arrow down to see  
>> fan speeds and then select the ES fan profile (lowest) rather than  
>> Off, performance, balanced. That should make the fan speeds much  
>> slower and quieter
> These are the steps that I already took.  But I would like to use  
> fancontrol because then I can make it really quiet most of the time,  
> yet keep the server relatively cool when under high load. Are you  
> saying that it is not possible to use fancontrol in combination with  
> my motherboard?
>>
>> Phil P.
>>
> Nonsense and other useful things: http://brakkee.org
> MountainHoppers: http://mountainhoppers.nl
> Track Detective: http://trackdetective.com
> Twitter: http://twitter.com/ErikBrakkee
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
