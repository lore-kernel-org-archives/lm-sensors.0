From: Erik Brakkee <erik@brakkee.org>
Date: Tue, 12 Apr 2011 17:09:32 +0000
Subject: Re: [lm-sensors] System instability with Supermicro X8DTi-F and
Message-Id: <4DA4874C.7090403@brakkee.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DA43970.6040605@brakkee.org>
In-Reply-To: <4DA43970.6040605@brakkee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Philip Pokorny wrote:
> Your own experience says that fancontrol, lmsensors and a BMC do not 
> have a way to coordinate actions which leads to errors and faults.
>
> And as Jean has said, the Winbond chip has a paged register set that 
> requires coordination to access.  The BMC code has now way to 
> coordinate access with the OS.
>
> Jean mentions thermal trip points. I believe that the winbond chip 
> includes it's own autonomous fan speed control seperate from the BMC 
> monitoring. What if you just reprogram the fan control curves in the 
> Winbond chip once at boot if you don't like the ES BIOS fan control 
> curve?
I am probably not going to do that because it sounds risky.
>
> Otherwise, no I don't think what you want is possible.
So that's clear now. The solution I have now is also acceptable. (Also, 
I did not receive Jean's mail).
>
> How hot were the CPU under full load with the ES fan curve that you 
> felt they needed to be colder?
Under full CPU load for a longer time, it can get up to 85-90 degrees 
Celsius when I use the lowest setting in the motherboard. With maximum 
cooling it gets to 72 degrees in such a case. When I use fancontrol I 
can make it such that it is around 59 degrees while idle and at most 75 
degrees when fully loaded. A temperature of 59 degrees is the 
temperature just after it starts up so the minimum temperature. Right  
now I am just using a setting which is one higher than the lowest in the 
motherboard and that is acceptable, but it will be a bit louder under 
idle conditions. Under full load it will get approximately 80 degrees.
>
>
> Phil P.
>


-- 

Nonsense and other useful things: http://brakkee.org
MountainHoppers: http://mountainhoppers.nl
Track Detective: http://trackdetective.com
Twitter: http://twitter.com/ErikBrakkee




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
