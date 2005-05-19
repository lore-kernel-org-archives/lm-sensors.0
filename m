From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <40E98134.50205@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First of all great job Rudolf for the research and the code.

I vote option #1 for 2.4.
Option #2 would force sensors users to upgrade to latest i2c.
Option #3 isn't worth the trouble, unless that's what we do for 2.6, then maybe.

I vote option #1 for 2.6, unless we get objections, then we do #3.
I don't see much in common with the code in i2c-sensor (#2).

Small comments on the code:
comment spelling familly -> family
return values 00 -> 0
coding style fixes (tabs)

Also, by returning 0, we require each module to pick its own
default: if(! vrm = which_vrm()) vrm = DEFAULT_VRM;
this is what we want, right, since different drivers may have different
ideas about what is the best default?



Jean Delvare wrote:
> Hi Greg,
> 
> 
>>What is your proposal for how to do it?  :)
> 
> 
> Summary of the previous episode:
> We recently found that VRM version could be deduced from CPUID info,
> instead of being arbitrarily or manually set. Ruik as been working on
> this and has working code, which he would like to integrate into our
> chip drivers framework.
> 
> Summary of amother previous episode:
> The only VID/VRM-related function so far is a (VRM, VID) -> VCore
> converter in i2c-vid.h, in the form of an inline function (vid_from_reg).
> 
> The point is that the new CPUID -> VRM converter and vid_from_reg belong
> to the same place, or at least one would naturally look for them in the
> same place. But the new function is a bit too big to be inlined IMHO,
> and I wonder if it is legitimate that vid_from_reg is since it's not
> slim either.
> 
> My three proposals:
> 
> 1* New function placed in i2c-vid.h, inlined. Nothing else needs being
> changed. Each function will only used once in each driver, so we may
> consider that the function size doesn't matter.
> 
> 2* New function placed in i2c-sensor.c, not inlined, with header in
> i2c-sensor.h. vid_from_reg may (2a) or may not (2b) be moved in here
> too. If it is, then i2c-vid.h is gone and inclusions of it need to be
> deleted.
> 
> 3* New function goes in new i2c-vid.c module, with vid_from_reg
> (un-inlined). New header file and inclusion need to be reworked.
> 
> All options sound feasable (which is why I propose them ;)) with little
> to no additional work. I don't much like inlining stuff, especially
> when there are no performance issues, so my preference would go to 2a.
> But I can certainly change my mind if someone comes in with good
> arguments and evidences I missed a point.
> 
> Thanks,
> Jean Delvare
> 
> 
