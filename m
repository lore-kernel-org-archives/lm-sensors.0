From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
Date: Thu, 01 Nov 2012 09:14:25 +0000
Subject: Re: [lm-sensors] coretemp.ko -- Sandy Bridge: temperature readings "biased" based on power consumpti
Message-Id: <50923D71.11396.6ECB01BF@Frantisek.Rysanek.post.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
In-Reply-To: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 31 Oct 2012 at 6:31, Phil Pokorny wrote:
> 
> On Tue, Oct 30, 2012 at 5:32 PM, Guenter Roeck <linux@roeck-us.net> wrote:
[...]
>    > I think that is pretty normal. Keep in mind this is the 
>    > temperature within the chip core, not at the external package.
> 
> And there is internal thermal paste inside the CPU package between the
> CPU die itself and the integrated heat spreader. That thermal material
> also explains why the silicon die temperature can jump so quickly. It
> has a higher deg C/W than the IHS and the heatsink on top of that.
> 
> Phil P.

Hmm. Okay - I should check my thermocoupling again.

The CPU that "jumps up 30*C in a second" (and jumps down
equally fast when I turn the load off) is actually a mobile/embedded 
version, i.e. it has no I.H.S. The chip is supposedly thermocoupled 
straight flat to the heatsink. This is a passive heatsink, and it's 
pretty massive, and I know that heatsinks tend to have quite some 
thermal inertia. Theoretically this should be the optimum style of 
thermocoupling in "passive cooled" computers.

The catch is, that this particular hardware setup had flawed 
thermocoupling between the CPU and the heatsink (ex works). The CPU 
had a pad of "thermocouple chewing gum" on it (likely Fuji Sarcon), 
approx. 1.1 mm thick. That way the CPU reported 80*C in the BIOS 
Setup a few dozen seconds after power-up :-)  = one core running in a 
tight loop, other cores asleep, heatsink at 20*C, with the whole 
computer consuming roughly 27 Watts. (Under Linux, when properly 
idling, consumption dropped to 12 Watts.)

I've tried to fix the problem by inserting a sheet of 1mm copper 
(about 4 by 4 cm) and by glueing it all toghether by Ceramique CMQ2 - 
I couldn't use the Coollaboratory liquid (Ga+In+Sn), because the 
heatsink is made of Aluminium... In a similar scenario, I used to get 
maybe 10*C of a temperature gradient between a Core2 Duo and the 
heatsink, and that was across a rather long aluminium "thermocouple 
bridge".
In the case at hand I was fairly satisfied with the way the CPU leans 
against my improvised heat spreader - I could feel it by the 
screwdriver, as I was tightening the mounting bolts. Also, the square 
of the SandyBridge chip is *big* compared to C2D Mobile = more heat 
transfer surface for a similar wattage. Unfortunately there's no way 
for me to inspect the gap with the heatsink mounted, so I'll probably 
have to trust the thermal sensor :-)

I still plan to keep an eye on the mobile SandyBridge CPU's whenever 
I get a chance, to get some "benchmark" / comparable readings on 
other hardware. I don't meet too many SandyBridge CPU's in our 
embedded computers - the boxes are dominated by the Atom and I have 
to agree that even mobile SandyBridge is thermally a bit of an 
overkill in those small boxes (just like the mobile C2D was). 
Besides, SandyBridge is stil a bit of a newcomer in the 
industrial/embedded hardware. There are some SandyBridge notebooks 
around - so I'll probably have to ask my boss to let me PXE-boot into 
Linux to run a comparison test on his gear...

I can see a similar jump (20-25*C) in a Core i5 Arrandale -based 
notebook, where I have reasons to believe that the thermocoupling is 
done right.

Hmm... interesting stuff :-)
Thanks for your insight - to everybody who responded.

Frank Rysanek


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
