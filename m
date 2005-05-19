From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Call for 2.9.0
Message-Id: <y3iACT1P.1102613420.6379080.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Strange order, huh?
>
> I thought I did exactly as we discussed on IRC a few weeks ago.
> You didn't want i2c-core changes at that time because you were working on
> 2.9.0.
> I said I'd work on the i2c-virtual code received from Brian.
> I checked it in to sensors for review and comment.
> I thought that's what we agreed to.

Hmm, that's possible. I have to say I have a very bad memory and I
don't remember exactly. I believe you :)

> > Irk! How exactly is i2c-core supposed to know i2c_virt_parent when it's
> > defined by lm_sensors? How is it even supposed to know about
> > CONFIG_I2C_VIRTUAL (and what is CONFIG_I2C_VIRTUAL_MODULE?)? Looks like
> > a circular dependency issue to me.
>
> i2c-core needs to include i2c-virtual.h to get the i2c_virt_parent()
> definition - but that wasn't in the patch I posted.

Getting the definition is only one part of the problem. Modules
dependencies is another, and subsystem design is yet a third one - this
is the part that gets me worried. What you propose needs either
duplicating the i2c-vitrual.h file, or making i2c's compilation
dependent on lm_sensors. Neither is acceptable IMHO. And the fact that
i2c-core will depend on i2c-virtual which is supposedly an algorithm is
strange too - it always has been the other way around so far.

The core should not need to know anything about who will be using it. The
core exports an interface, other drivers use it, this is how things have
worked to date and I see little reason this should change.

> What Brian discovered is that an i2c bus mux implementation requires a
> nolock version of some functions. Think about how the bootstrap works:
>  Bus gets added
>  Mux chip found
>  Sub busses get added (but can't because lock still held - hang)

I understand (although I did not dive deep enough into the code yet to
see why the lock is held for so long).

> So that's what the (first half of) i2c-core patch does. Get rid of the
> leading '__', rename to xxx_nolock, and export them so that the virtual
> driver can implement the bootstrap.

This sounds fundamentally wrong to me now that I see what it is. Sorry
for not noticing this before when we discussed it. Seems like I am
unable to see what's wrong until I read actual patches to the i2c-core
:(

> It's not a big change. Maybe there's a way to avoid it, though... I don't
> know.

It IS a big change. OK, it doesn't break the compatibility with Linux
2.4 (which is great since it really wouldn't have happened). However,
exporting functions that only a limited number of drivers should call
without the possibility to check that others actually don't is
potentially dangerous. Also, the locks were there for a reason and
bypassing them doesn't sound too good.

As I understand it, the reason why the "nolock" version are needed is
because the adapters' lock is still held while adding clients to the
new adapter. Why is that? I see no reason. The second deadlock is
obviously for the chips' lock and the reason why the lock is still held
is more obvious this time.

I really need to take a closer look at the current implementation and see
how Brian's model fits in (or doesn't). I feel that it is not correct
but my criticism and fear will be of no use if I do not understand the
whole picture before going on.

Just one thought though, the whole locking issue is related to the fact
that the pca954x chips would be handled as regular chip drivers with
detection and  auto-attach to all busses. Do we really want to do that?
Multiplexers are NOT standard chips, they are hard to detect, they
don't export anything to userspace and behave like bus drivers if I
understood correctly. Maybe we can get rid of the locking issue by
simply handling these chips in the different way they deserve (i.e.
implicitely load them *after* the bus driver has been loaded).

> It could have gone either place, what's the difference?

lm_sensors is supposedly a package for hardware monitoring drivers and
tools, i2c is for the i2c subsystem. That's quite different, although
both have been mixed so far with sometimes no apparent logic.

The idea is that lm_sensors builds on top of the i2c subsystem. The way
you are implementing things, someone who wants to do any kind of
multiplexing will have to get lm_sensors too for no obvious reason other
than randomly placed files.

> You were in the middle of i2c changes so I put it in sensors. Again, I
> thought this was what we agreed to - I wouldn't make any i2c changes.
> We can move i2c-virtual.c to i2c if you want.

I think we'll end up doing that, yes. Not yet though, since as you
noticed, releasing i2c 2.9.0 has higher priority.

What I agreed on was that you would hold up before committing the changes
to i2c. What I don't agree on now is the way you divided the code
between i2c and lm_sensors. This is different. Again, sorry for not
looking into brian's code before. I'm doing my best with the time I
have - we all do, right?

> pca954x.c can't move because it's a chip driver.

I don't see how this prevents it from being part of i2c. The fact that
we never did it before doesn't mean we cannot do it now. As said above,
these chips are nowhere similar to the other ones.

>Your other questions:
> - the implentation at the i2c-core level is simply the patch I posted
>   yesterday

But you said that there were a "second part". Simply some header
changes?

> - The code in sensors CVS _is_ the equivalent of i2c-amd756-4882. The
>   "real-world use case" is "modprobe i2c-amd756; modprobe i2c-virtual;
>   modprobe pca9556 [params]", where pca9556 looks alot like pca954x.

I really need to read the code in whole. I don't get how it works. At
any rate i2c-amd756-4882 is board-specific, while Brian's
implementation is generic, so it cannot be rigourosly similar.

> Recall from our IRC discussion that you would work on xxxx_4882 and submit
> the patches, I would work on Brian's implementation. Don't be 'suspicious'
> :)

Please don't take it bad or personnal or anything. I am not trying to
prevent you from including i2c-virtual nor am I trying to protect the
choice of implementation I made for the S4882 - I said from the very
beginning that this was not necessarily meant as a definitive solution.

I am trying to protect the i2c subsystem though, admittedly. Just
remember that I am the one who maintained the i2c-2.8.x compatibility
patches for maybe 8 months, prepared patches for Marcelo and saw them
rejected in bulk, and then very recently reverted all changes to i2c
that had been interrupted halfway (by KM) to get compatibility back with
Linux 2.4. Now that I am done with that, nobody is going to break i2c
again, believe me.

> My brief summary is that Brian's implementation separates the generic part
> of bus muxing into a bus algorithm driver (i2c-virtual) and puts the
> chip-specific part into a combination bus adapter driver and chip driver
> (pca954x).
> This parallels i2c-algo-bit and the numerous big-banging bus adapters,
> and fits well into our architecture.

My short experience shows that the chip-specific part is very thin and
that we are probably not saving much by doing that (especially since
every known board with multiplexing uses a different chip so far),
contrary to i2c-algo-bit (and the adapter and chip independency we have
too). That said the idea of a generic solution to the multiplexing cases
still sounds good - much better than having to manually add support for
each one, I guess.

> The code I got from Brian was for 2.4. So that's where I put it.
> Not sure what you are "insisting" - what's wrong with getting it working
> on 2.4 first before porting to 2.6?

What will you do when you port your implementation to 2.6 and Greg
rejects it, and you have to do it completely differently to get it
accepted? 2.6 is the future of the Linux kernel and it's much more
logical to get things working there first, then port them back to 2.4 on
the same model. 2.6 also receives much more review tahn what we do on
our own side for lm_sensors and i2c/CVS. Anyway this is a side issue.

> Anyway, happy to discuss further on IRC if you like, let me know.

Certainly, but not before I have had time to read Brian's code and
documentation in whole. I am probably not going to be useful at all
until I've done that.

Thanks,
--
Jean Delvare
