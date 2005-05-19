From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: testers wanted
Message-Id: <1072260234.3fe9648a1c8f4@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031222231810.53439aaf.khali@linux-fr.org>
In-Reply-To: <20031222231810.53439aaf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 1* What is the reason for disabling i2c_get_client? Is it in any
> > way related to locks? To me it belongs to a different patch.
> 
> Yes, it is missing locks. I'll add the locks instead.

OK, please do. That said, this function doesn't seem to be used much, if
ever.

> > 2* Your patch includes a large rewrite of i2cproc_bus_read. How
> > tightly is it related to locks? I see that the new version uses
> > locks, but it also looks like this isn't the reason why the
> > function was rewritten. If possible, we'd better split the patch
> > in two pieces, one for the locks, and one for the rewrite.
> 
> The inode will match only one adapter. This patch moves the real
> work outside the loop, after the correct adapter is found. Changed
> indent makes it look like a rewrite but it is not.

Yes, I could see that most of the code is the same indeed, shifted.

Still this doesn't fit into the "handle locks differently" goal of the
patch, so I'll leave it apart from now. I understand that the function
involves locks, but they are currently missing from the kernel's
version so there is no regression here.

> > 3* The argument name change in i2c_smbus_xfer doesn't belong to
> > this patch either. Is it OK to move it apart, or am I missing
> > something?
> 
> Well, it is down(&adap->bus) in 2.8.2. That's why.

So it'll be down(&adapter->bus) for now ;)

Now I add another point:

4* What's the point in moving the "adapter->clients[i] = NULL" loop from
top to bottom of function i2c_detach_client? This too makes much noise
for nothing. If there is no special reason for doing so, let's reverse
that change. If there is, this doesn't belong to this patch either.

Keep in mind that there's no problem submitting patches that do not fix
everything related to a topic (here, locking) as long as what remains
broken was still broken before (which is the case here).

With these four points moved apart, the patch is smaller and much more
readable. We could merge everything that was left over, and possibly
more, in a "general i2c-core cleanup" patch to be included in the next
wave.

> More patches on Saturday. These will include:
> 
> Fix i2c_get_client.

Not a priority as far as I can tell. Who uses this?

> Fix module reference counting to use try_inc_mod_count in place of
> __MOD_INC_USE_COUNT, and have i2c_inc_use_client return int. While
> this is an API change, the return code is just silently ignored. Fix
> i2c_use_client to study the mentioned return code.
> 
> Fix reference counting in i2c-dev open/close.

I'm not sure I get you here. Are these things already in CVS and to be
ported to Linux 2.4, or the particular points that are broken in CVS
which should be fixed before we can submit a clean patch for Linux 2.4?
I really want the remaining CVS issues to be fixed and tested before we
even think of backporting reference counting changes to Linux 2.4.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
