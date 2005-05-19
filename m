From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] 1/4 WIP I2C kernel patches-config
Message-Id: <3CE2F9E7.1FA25C5C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CE20AD5.5554A03@bellsouth.net>
In-Reply-To: <3CE20AD5.5554A03@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Albert,
thanks again for doing this.
Here's my comments for all 4.

- Don't submit patches for anything not patched by mkpatch,
  that is, anything not in mkpatch/FILES. This includes *8xx* and
  *405*. The 405 stuff, I have a monster patch I got a month and
  a half ago, the only reason I haven't put it in yet is that it
  renames all the files. But anyway, if it isn't in mkpatch/FILES
  there's some reason. i2c-pcf-epp is really new. 8xx status unclear.

- After this patch set, the next is probably sensors. There's nothing
  from 2.6.4 that's really ready, except for the i2c.h stuff.
  The PEC stuff in i2c-core is only half done.

- Be careful not to undo changes made by others in kernel 2.5. The one I
saw
  is in i2c-proc at about line 125 (the kmalloc return code check).
  I put that in CVS already. The other changes (the ones I know about
  I've listed at the top of TODO in CVS, be sure and look at that
document)
  are not compatible with 2.2 / 2.4 kernels so I can't put them as-is
  into CVS. I didn't check your patches carefully to see if you
  did any other undo's.

- Remember the only synchronization we can do with CVS is on the changes
  that are compatible with 2.2 / 2.4, unless we do #ifdef kernel > 2.5
  type of stuff. Or something more innovative. Suggestions anyone?
  I don't know how we are going to easily maintain multi-kernel support.
  Maybe we need to start a new CVS tree (yuck)?

- Can you submit a patch for Config.help (if necessary)? 
  This one is patched in-line
  by mkpatch.pl, it isn't listed in FILES. I guess Config.help is now
  split into many separate files...


Albert Cranford wrote:
> 
> Hello All,
> I'm Albert Cranford and I'm working to get I2C ready for
> submission to Linus for inclusion into the 2.5 kernel.
> 
> My current base is i2c-2.6.3.  I've split the patches into
> Linus sizes with:
> 1/4 being Config module.
> 2/4 being the core modules.
> 3/4 being driver modules.
> 4/4 being fixes needed to compile inline or modules.
> 
> I would like to get some feedback/synchronization of my
> suggested changes into CVS 2.6.4.  My comments will be
> followed by each patch.  Fell free to reply.
> After this patch set is in the kernel, I will submit
> i2c-2.6.4 changes.
