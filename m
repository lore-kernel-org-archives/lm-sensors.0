From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.8.1
Message-Id: <20031114225516.33dc1b00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > Is it split up into small, incremental patches, each patch only
> > > doing one thing?  That is what is going to be required if it will
> > > be accepted into the kernel tree.
> > 
> > Basically, it's all or nothing.
> 
> Hm, with that attitude, your patch will go nowhere, sorry.

Interesting. Sleepless nights building these patches to drivers I mostly
don't use, writing an installation guide, setting a place up for
download, answering questions and fixing bugs. Highly questionable
attitude indeed.

> Again, you are going to _have_ to build up a series of patches, each
> only doing one thing, in order to try to get these changes into the
> kernel.

The i2c subsystem as we know it was first introduced in the 2.3.34
kernel back in November 1999 (it was version i2c-2.4.4). In kernel
2.4.13 it was updated to i2c-2.6.1. No trace of that on the LKML, so I
can't say how this happened. This was more than two years ago. Albert
Cranford since tried to have it updated. He sent split patches to the
LKML and did not have any (public) answer, not even one. The patches
were rejected (so I guess, since kernel 2.4.22 still has i2c-2.6.1).

http://marc.theaimsgroup.com/?w=2&r=1&s=2.4.20-pre5+i2c+patch&q=t

The idea is that i2c is developped on a separate CVS repository, and is
periodically integrated to the kernel. Don't ask me why, I don't know.
What I wan't you to understand is that it doesn't make sense to split
patches in these conditions. It would if we were sending updates every
few weeks or months. Changes could be discussed in real time, things
that wouldn't be accepted in the kernel would be changed in the CVS
repository. But this hasn't been done for 26 months. I let you imagine
how much has been done during this time. I also let you imagine that
many changes depend on others. And you must realize that none of us can
remember everything that was changed during that long period. What's
more, people that were working on the project back in 2001 (Frodo
Looijaard, Ky?sti M?lkki, Simon Vigl) have left by now, sometimes with
changes half done.

After structure changes occured as we released i2c-2.8.0 and we became
incompatible with what can be found in Linux 2.4, we felt we would have
to submit a patch to the LKML to synchronize with 2.4's i2c subsystem
again. Being jobless, I had enough spare time and volunteered to build
such a patch. This was a rather hard work and I wonder if anyone would
have done this, if not me. I had some difficulties building the
i2c-2.8.0 patch in time to submit it to the LKML for inclusion into
Linux 2.4.22, and again I was late with the i2c-2.8.1 patch for Linux
2.4.23. I have been working almost alone on this.

Splitting this patch before submitting it makes no sense to me. First
because building subpatches that could really be accepted or rejected
independently and still lead to a working subsystem is unlikely after
two years of changes. If someone were able to to this, I'm not
that someone. Second because rejecting part of the patch isn't really an
option for the kernel folks. Whatever will be in the Linux 2.4 kernel
tree has to match what we have in our CVS repository. Nobody wants to
(not has the time to) keep these two places in sync forever.

Don't misunderstand me, I don't pretend that the kernel folks just have
to take my patch without a question, with no chance to discuss specific
points. I mean that if parts of the patch are not OK, we'll update the
our CVS repository accordingly, so that in the end we have exactly the
same thing in linux 2.4 and our CVS repository. We can't remember
forever that some specific portion of code shouldn't make it to the
Linux kernel and still keep it in our CVS version. This would be plain
unmaintainable.

It's not like posting something totally new to the LKML and expect
everyone to trust me when I say my code is great. This code has been
over-tested. Look at our rank at Freshmeat. And the patch itself has
been downloaded around 2000 times, with enough feedback to believe it
has been well tested, and few enough bug reports to believe it worked
out of the box for almost everyone.

> The fact that you are going to be changing an existing api,
> and breaking working drivers, in a stable kernel series so late in the
> development process, is going to be a big problem in getting your
> patches accepted.

I'm not the one that decided we would break the existing API. I did my
best to provide the needed patch, no more, no less. That said, the
change isn't a big one as far as I can tell (take a look at what it
takes to convert an existing driver, it's straightforward). What's more,
it lets drivers clean their module usage count method to follow what the
kernel folks pretend is the right way to do (if I understood it well).
Third point, it matches what was made in Linux 2.5/2.6 (if you don't
know that, who does?) so 1* it can't be fundamentally broken and 2* it
helps third-party driver developers (having the same driver working in
both Linux 2.4 and 2.6).

>You better do them in the least obtrusive manner possible.

I can't think of something better than "here is a patch that brings the
i2c subsystem to 2.8.1". I'd have expected the kernel guys to be aware
of our work, and to trust us. I've tried to send very simple,
preliminary patches. See:

http://marc.theaimsgroup.com/?t6831100400004&r=1&w=2
http://marc.theaimsgroup.com/?t6849321700002&r=1&w=2
http://marc.theaimsgroup.com/?t6849321900001&r=1&w=2

I had no answer, and as far as I can see, the patches I've sent have
been silently ignored and dropped, although these were really simple and
could have been obviously applied directly without a risk. As long as I
have no guarantee that my work won't be more considered than that, I
have no reason to spend more time on this. I now have a job and less
time for this kind of time-consuming activities. I also have a
girlfriend who would like me to spend a little more time with her and a
little less with you all.

And yes, I have read the LKML FAQ. I know that the kernel folks are more
important than I am, have less free time than I have and must have
better things to do than listening to me. But what's the point in a
mailing-list in this case? And what's the point in open-source software
in these conditions?

> Good luck,

I don't need luck. I don't truly believe in luck anyway.

What I need is assistance. I obviously can't succeed if I'm the only
one struggling against invisible forces. I have been mostly working
alone so far. If I can't get my voice heard on the LKML, someone
else will have to replace me, but actually I doubt anyone is interested
in my place.

What I want you to understand is that I won't have time to do the things
the way you pretend I should do them (nor do I think the things should
be done that way; again, our CVS has hundreds, if not thousands, of
fellow testers that have been fairly happy for the past two years). And
if I don't do it, I don't expect anyone to do it. If the kernel guys
don't want of my patch, our CVS branch will be forever incompatible with
Linux 2.4. Since I won't update my patch forever, this could also mean
the end of our CVS development and the death of the lm_sensors project
as we know it, with over a year of work almost lost.

Or we could get some help from people involved in kernel development,
with enough influence to convince a kernel maintainer that our i2c
subsystem is well tested and stable enough to be integrated into the
kernel. This would eventually put an end to the nightmare we're into.
After all, the i2c subsystem isn't a really sensible one, and I can't
understand why so much trouble would be required just to get it updated.

Which side are you on, Greg?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
