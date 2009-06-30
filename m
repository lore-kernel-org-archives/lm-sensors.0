From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Jun 2009 20:43:51 +0000
Subject: Re: [lm-sensors] How to un-ignore a sensor?
Message-Id: <20090630224351.61d3b377@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090629211323.32695.qmail@science.horizon.com>
In-Reply-To: <20090629211323.32695.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George,

On 30 Jun 2009 05:09:56 -0400, George Spelvin wrote:
> > No, it doesn't. The default sensors.conf file should not include any
> > ignore statement to start with. And actually it no longer does, so the
> > problem is already solved.
> 
> Um... okay.  Is that a universal solution?  Debian ships a larger config
> file that does include some "ignore" lines.  It does seem useful to
> have an overridable default.

Which version of lm-sensors do the ship? The change occurred in version
3.1.0.

> Are there plans for some more flexible include or conditional
> mechanism to allow segregating site-local edits?

This was implemented in lm-sensors 3.1.0 (and fixed in 3.1.1 for some
filesystems.)

> >> (On another note, would it be worth it to implement a basic hash table for
> >> the various symbol lists?)
> 
> > I doubt it. With the new default configuration file being much smaller
> > than it used to be, I do not think lists are a big problem from a
> > performance perspective. A hash table would probably require more
> > memory and I'd rather keep the memory footprint low.
> > 
> > That being said, if I am proven wrong, I have no objection to a change.
> > If you reimplement data storage in libsensors using hash tables and it
> > is much faster, doesn't need too much additional memory, and doesn't
> > make the code too complex either, they why not?
> 
> Okay, I'll poke at it if I'm motivated, but remember your priorities.
> It seems that there are a lot of duplicated strings ("temp3_max"), so
> if the overhead can be can be made small enough, interning them would
> save memory.

I fear I don't quite follow you here. Which strings are duplicated
exactly, and what do you mean by "interning"?

> > Patches are easier to review and try when submitted separately.
> 
> Sorry.
> 
> > The license of libsensors will change from GPL to LGPL on July 1st,
> > 2010. Before I apply your patches, please confirm that you have no
> > objection to your code being released under the LGPL.
> 
> Yes, of course.  These changes are all in the public domain.
> Do whatever you like with them (even evil things).

Great, thanks.

I'm out to kill kittens with your patches now ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
