From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <3E24AD02.7030609@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(Sorry to chime in kinda late on this, but I'm trying to digest it.)

Humm, I guess we are touching on three issues in regard to the CVS, 
2.4.x releases, and 2.5.x kernel sync ups:

- having some support for 2.4.x kernels, at least until 2.6.0 is released.

- submitting and receiving sync patches (Linus') to a rolling 2.5.x base

- continued easy development/maintenance (including alpha and beta 
quality stuff)


We should keep CVS, just for the sake of an already easy, established 
development platform.  I think we agree with that.

I don't like the idea of branching because it means there is more to 
worry about, *but* it may not be avoidable (at least for a while).  
Having 2.5 be HEAD and a secondary branch for 2.4.x kernels (which will 
go dormant eventually) is a good idea.  Is there a reason to branch i2c 
as well, or can we simply freeze the 2.4.x kernel version of it for 
simplicity? (if it helps)

What we are left with is how to deal with alpha or beta stuff which is 
written against HEAD but is not worthy/safe enough to submit in a patch 
to Linus.  It should be obvious and deliberate enough to safely keep 
questionable code in a place (or way?) which won't accidentially make it 
into the kernel before it's time.  In any case, I want to keep it easy, 
still, to have drivers which will be broken at any point to make the 
barrier to entry of new drivers (bus and chip) low.  Does this make sense?

Removing some stuff to make the project easier to maintain is a good 
idea (as we already decided about the 2.2 kernel stuff).  I wonder how 
long we will still need stuff like mkpatch, too?  If we can solve the 
long-term development problems by removing legacy utils, it could be 
helpful to make less to worry about.


Phil


Mark Studebaker wrote:

> I think you are right that there is no reason to release before 
> branching.
> We do need to test and then tag before branching.
> I'll try and test your i2c changes soon.
>
> I think also there is no reason to branch both i2c and sensors
> at the same time. sensors will obviously take longer.
>
> I suppose we would release 2.5 code as 3.0.0
> and 2.4 code as 2.8.0?
>
> I read up on CVS branching a little bit. I guess you are propsing
> that 2.5 becomes HEAD and 2.4 becomes something else.
> Then you use -r branchname to pick a branch.
>
> Phil, really need to hear opinions from you on this.
>
> mds
>
>
>
> Ky?sti M?lkki wrote:
>
>> On Sun, 12 Jan 2003, Mark Studebaker wrote:
>>
>>
>>> We have a vote from Ky?sti for branching.
>>> Albert suggested the same thing to me in an email.
>>> Pavel suggested abandoning CVS and doing everything in Linus' tree.
>>>
>>> I'm really reluctant to branch but it may be the only realistic way 
>>> to do it
>>> unless somebody volunteers to do patches manually (and perpetually).
>>
>>
>>
>> There was still a choice of what to branch. Choosing wisely, we can
>> limit commits between branches to one direction.
>>
>> I suggest we have main branch for 2.5 development,
>>
>> - Some day 2.5 results become main anyway.
>> - Patches to 2.4 are not likely to touch kernel interfaces
>>   -> merging 2.4->2.5 painless
>> - Patches to 2.5 are likely to touch kernel interfaces only
>>   -> little to none merges 2.5->2.4
>>
>> I see no reason to release 2.8.0 immediately. Just tag CVS before we
>> branch, then do 2.4<->2.5 cleanup and de release once there is something
>> new to offer.
>>
>
