From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c cvs repository status
Message-Id: <3FE49488.9020901@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031220120151.27b9db49.khali@linux-fr.org>
In-Reply-To: <20031220120151.27b9db49.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
>>I understand.
>>I didn't expect it to be included in the 2.4 patch;
>>you're working off of the 2.8.2 release, right?
> 
> 
> Not really. I am working off of CVS since 2.8.0. It was useful because I
> sometimes need to make a few adjustments to CVS so that the patches I
> send look better. Now I'll have to change the way I work. I'll keep my
> local copy of the CVS apart and won't update it, still I will commit my
> changes to the CVS. Hopefully there won't be too many conflicts, or this
> method will fail badly.
> 
> 

Shouldn't you work off of the tagged 2.8.2? Then when you
submit patches, you say, 'this patch brings the 2.4 kernel up to
our 2.8.2 release'. The release is what's widely used and tested.

I don't see why i2c CVS now should be exclusively for your use.
I appreciate how much work it is to generate the patches for 2.4.
Let's figure out another way to make it easy on you. Either with
a local copy as you describe, or perhaps a CVS branch.

Sorry for the misunderstanding. I certainly didn't realize you
considered i2c CVS off-limits.



>>The 'big idea' is to get some testing of the patch
>>in the 2.4 world, then submit a 2.6 version of the patch to Greg.
>>The patch came in to us against 2.4 so it's much easier
>>to do it this way.
> 
> 
> Isn't it strange to use 2.4 for testing? I wouldn't think people will
> write drivers needing new protocols for the 2.4 kernel. New drivers
> should go to 2.6.
> 
> Once Linux 2.7 starts its life, I'll invite you to move any development
> effort there, and keep the 2.4 CVS repository for bugfixes only. Idealy
> the CVS repository would even disappear and the bugfixes committed to
> 2.4 itself, but since it's unlikely that all of the CVS will be merged
> into 2.4, I guess we'll have to keep the repository forever.
> 

Here's a few reasons.

I'm running a mix of 2.4 and 2.6 machines. Isn't that true of most
people on this list?

Somethings are easier to test on one side, some on the other. 
If I need a driver for testing that
isn't ported to 2.6 yet, it gets really hard :)

The guy that submitted the emulation patch was obviously running 2.4,
how can he test my checkin and mods of his patch unless I do it on 2.4?
