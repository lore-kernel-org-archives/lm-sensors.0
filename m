From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.8.1
Message-Id: <20031116155700.4b231021.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> But when you try to ignore the way kernel development works, I don't
> have much sympathy.  Please read Documentation/SubmittingPatches for
> how to send patches into the kernel.  It states that you have to split
> them up.  Also read Documentation/CodingStyle and see that numerous
> drivers in the current cvs tree do not follow this basic style.  For
> that reason alone, the patch will be rejected.

As I had to modify a dozen drivers when building my patches, I can tell
you that many of them don't follow any rules. No C99 initializers, no
tabs used for alignement, improper module reference count (of course,
this is why I had to patch them) and more. And the *are* in the
2.4.22 kernel.

What's more, this kernel has i2c-2.6.1, which doesn't comply with any
rule either. 2.8.1 is in no way worse, it would even tend to be better.
Mind you, this is why we want it in.

> And the argument that this is a "resync" with an external CVS tree, or
> that thousands of users love the result doesn't fly either.  See the
> numerous posts by Linus on linux-kernel about how he does not accept
> big code dumps.  I'm not going to reiterate the reasons why here
> again.

Correct me if I'm wrong, but isn't it what happened for ACPI? It was
developped on a separate repository, and merged later. I doubt they
split it up into pieces. And ACPI is much more sensible than I2C.

> Also realize that you are trying to modify a very stable kernel tree,
> that is nearing it's end of life cycle.

What you say here is that we should *not* have been doing that interface
change in CVS. I now tend to think you are right. Still this was done
(and not by me) and I don't think any of us want to change back.

In these conditions, I would have appreciated not to be encouraged by
you and a few others to write that patch I have been working on. If
there is absolutely no chance it will be accepted as-is, and as I don't
have the time nor the knowledge to split two years of changes into
logical pieces, this basically means I worked for nothing.

Anyway, 2.4 isn't possibly in its end of life cycle. Last patch was over
5MB bz2'd. The three previous ones have been around 4MB bz2'd. Don't
call that a dying kernel.

> 2.6 will be shipping in distros in 6 months, and in it, the sensors
> code.

Remember what happened with 2.4. Yes, it shipped in distros starting
with 2.4.5, but did not become actually stable before 2.4.16. I wonder
if the distro makers and the users will do the same error again. My bet
is that most server maintainers will stick to 2.4 for another year or
so. And it happens that these are the folks who need sensors support the
most.

> Because of this it
> is going to be a very hard sell to do such a massive code dump, and
> api change in 2.4.  Now I'm not saying that the api change is not a
> good thing technically, just realize that you are very late to this
> tree, and so the ability to change things is harder and harder.

Again, I agree. Still you keep telling me what should have been done
for the two last years (that is, porting changes to the kernel every
month). This wasn't done and I wasn't even there.

What I'd like you to tell me instead is what I am supposed to do now.
Give it all up and leave the users helpless? Go on updating my patch
for every new kernel for the next two or three years?

(If you have not done so yet, I invite you to go and watch "Anything
Else" by Woody Allen. Great movie.)

> This is one of the main reasons I worked so hard to get the sensors
> code into 2.5, as that was the proper time to do it.  I also fixed the
> coding style issues, and logic issues and submitted patches in small,
> incremental chunks to introduce these changes.  In short, I followed
> the rules, and the patches were accepted.

This was a development kernel. You *could* slice your changes and have
them in a public kernel the day after you submit them. I believe this is
quite different for 2.4.

> Please don't be frustrated.

I could hardly be more. Yes, I know, my attitude etc etc.

> The rules are spelled out in very nice
> detail, don't be surprised at resistance when you try to ignore them.

Rules, as laws, are guidelines. Some follow them, some don't. Some get
caught and some don't. But more interestingly, some never follow them
and never get caught, while some eventually don't follow them and get
caught. But I agree I might be off-topic here.

I respect the spirit of the rules. I agree that's how things should be
done. The point is: now that things cannot (in the real world) be done
that way, what are we supposed to do?

> > Which side are you on, Greg?
> 
> I think I'll let my kernel work, done on my own time, speak for
> itself.

Admitedly my question lacked subtlety, please forgive me.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
