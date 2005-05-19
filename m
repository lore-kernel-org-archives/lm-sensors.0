From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: user/kernel bug and memory leak in i2c-dev
Message-Id: <20030806093614.39badfa1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030805211609.4a3a66d2.khali@linux-fr.org>
In-Reply-To: <20030805211609.4a3a66d2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > As you may have seen on LKML (and this list) we have a patch ready
> > to fix the two problems mentioned in topic. I will submit it for
> > inclusion into Linux 2.4 tomorrow. I think I need to CC: Marcelo for
> > it to work, right?
> 
> Yes.  I'd be glad to send it to him if you want me to (with your
> attribution of course.)

I think I'll do it for 2.4. The i2c subsystem in 2.4 is in sync with our
CVS (well, it *should* be) so it's "legitimate" (or say logical) that
the people maintaining i2c-CVS submit fixes for inclusion into the 2.4
kernel.

> I'm still looking at the patch you submitted, as it still seems
> strange to me why it's needed...   I'll write back to that in a bit.

I had a really hard time figuring this out too. This kernel memory vs.
user memory thing is tricky, to say the least. Sergey's post helped me a
lot understanding how it works:
  http://archives.andrew.net.au/lm-sensors/msg03874.html
And even now I'm not sure I understood it all, but at least I *accepted*
the idea the patch was good ;) I think it's all in the fact that
user-space memory areas can be unmapped at "any" time, and that they are
mapped again by read_{from,to}_user, but it only works on direct
kernel-space-pointer-to-user-space-memory access, not on more complex
accesses such as the one we had. All these obviously rely on some
obscure (to me at least) kernel magic, and if Robert and Sergey agree a
fix is needed, I have to believe them.

BTW, I find Sergey's fix much clearer than Robert's one.

And the memory leak fix and the various optimizations are unarguably
great.

> > I checked wether the fix should be applied somewhere else. It
> > doesn't apply to Linux 2.2 (there were no I2C subsystem there) but
> > it *does* apply to 2.6.0-test2. The proposed patch won't apply
> > cleanly because the code was reindented, but it *has* to be applied
> > though. What do you want me to do? Prepare and submit a patch to the
> > LKML and CC: Linus, as I plan to do for 2.4? Prepare the patch and
> > send it to you? Leave you handle the problem alone?
> 
> Hey, I don't want to handle anything alone here :)
> 
> If you send me a patch, I'll be glad to forward it on to Linus by
> putting it into a bk tree for him to pull from.

OK, will do so.
(working)
Here it is (warning: not even tested, but it's the same as 2.4's one,
which I tested).

Since you're our interface guy between i2c-CVS development and the 2.6
kernel, I think it's far better that you submit the patch to Linus. It's
probably easier for him if he has to deal with a single person
representing our group.

One note though: When I say this patch is needed for 2.6, I just mean
"the code in 2.6 is the same as the code in 2.4". Maybe the kernel magic
has changed and copy_{from,to}_user is better than before and can handle
this, how would I know. Still the optimizations, at least, will be
welcome, and the rest can't hurt.

> Sorry for the delay, "Real Life" (tm) issues been keeping me busy...

Don't be sorry, sometimes it's great to realize we still have a real
life :)

I just wanted to make sure you were OK with the patch (or at least were
aware of it) before I send it to Marcelo.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
