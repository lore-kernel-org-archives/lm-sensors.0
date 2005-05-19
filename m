From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <3E2607EE.5030507@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

so, tell me if this is a good plan, or if this is what you said...
(sorry if I am still a little confused...) 

You are going to submit i2c changes (including refcount changes),
based on lk2-4, for inclusion in 2.4.21?

And then our i2c 2.8.0 release would be only for kernels 2.4.21+.
Our i2c 3.0.0 release (from HEAD) would be only for kernels 2.5.54+.
And our 2.7.0 release would be the last for kernels 2.2 - 2.4.20.

If and only if we wanted to make another i2c release that was compatible for
kernels 2 4.9 - 2.4.20 (hopefullly not) would we branch again, at the
tag POST-2-4-9-KERNELS, and generate a release from that branch.

For sensors we would do something similar, following your 
instructions below...

mds



Ky?sti M?lkki wrote:
> On Tue, 14 Jan 2003, Philip Edelbrock wrote:
> 
>>(Sorry to chime in kinda late on this, but I'm trying to digest it.)
>>
>>Humm, I guess we are touching on three issues in regard to the CVS,
>>2.4.x releases, and 2.5.x kernel sync ups:
>>
>>- having some support for 2.4.x kernels, at least until 2.6.0 is released.
> 
> 
> As I wrote to log, we used 2.2 style module counting in 2.4. As 2.4 and
> 2.5 have only little difference there, this is not a strong argument to
> branch for 2.4.
> 
> 
>>- submitting and receiving sync patches (Linus') to a rolling 2.5.x base
> 
> 
> This is strong argument for branch, module refcounting and other patches
> went past the CVS to 2.5. And 2.5 did not have the latest of CVS before
> this happened so merging was not that painless.
> 
> 
>>- continued easy development/maintenance (including alpha and beta
>>quality stuff)
> 
> 
> See above. It is possible to branch a single file for very beta stuff
> one wishes to distribute for testing.
> 
> 
>>We should keep CVS, just for the sake of an already easy, established
>>development platform.  I think we agree with that.
>>
>>I don't like the idea of branching because it means there is more to
>>worry about, *but* it may not be avoidable (at least for a while).
>>Having 2.5 be HEAD and a secondary branch for 2.4.x kernels (which will
>>go dormant eventually) is a good idea.  Is there a reason to branch i2c
>>as well, or can we simply freeze the 2.4.x kernel version of it for
>>simplicity? (if it helps)
> 
> 
> Expect some changes to i2c api during 2.5 cycle, once they are in,
> port them back to 2.4. After that, we could consider merging 2.4 back to
> main.
> 
> 
>>What we are left with is how to deal with alpha or beta stuff which is
>>written against HEAD but is not worthy/safe enough to submit in a patch
>>to Linus.  It should be obvious and deliberate enough to safely keep
>>questionable code in a place (or way?) which won't accidentially make it
>>into the kernel before it's time.  In any case, I want to keep it easy,
>>still, to have drivers which will be broken at any point to make the
>>barrier to entry of new drivers (bus and chip) low.  Does this make sense?
>>
>>Removing some stuff to make the project easier to maintain is a good
>>idea (as we already decided about the 2.2 kernel stuff).  I wonder how
>>long we will still need stuff like mkpatch, too?  If we can solve the
>>long-term development problems by removing legacy utils, it could be
>>helpful to make less to worry about.
> 
> 
> We still need mkpatch -like utility to fix include files. As is today,
> some drivers are not patched.
> 
> 
> As for sensors compatibility, due the changes in module refcounting for
> 2.4, compile with lk2-4 will not work. Use POST-2-4-9-KERNELS instead.
> 
> To fix this, in sensors CVS I would do:
> 
>  - cvs up
>  - tag LAST-PRE-2-4-X-KERNEL
>  - drop < 2-4-X support
>  - tag POST-2-4-X-KERNEL
>  - tag LAST-PRE-2-8-0-I2C
>  - fix module refcounting to use .owner
>  - tag POST-2-8-0-I2C
>  - consider PCI changes 2.4<->2.5, branch if necessary
> 
