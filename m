From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Winbond chips - design questions
Message-Id: <20031022204922.5a6be01f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031022022051.GB8764@earth.solarsys.private>
In-Reply-To: <20031022022051.GB8764@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK, new subject anyway...
> 
> What is the benefit of having all of the Winbond drivers in two files?

Benefit is obvious. It is because, hmmm... well... well you know, it's
obviously obvious ;)

> And related - what is the benefit of recycling feature tables etc.
> between all the Winbond types in lib/chips.c and prog/sensors/chips.c?

Almost as obvious as above ;)

> I can tell you the downside, for sure: I'm afraid to touch any of it
> for fear of breaking one of the other 5 chips that I *don't* have and
> *can't* test.  Sure it's free software and I don't have any
> obligation... but right now those particular bits are nigh
> unmaintainable.

I definitely agree with you on that point. Likewise, the adm1021 driver
has become a complete mess.

> I guess I'm asking for permission (and help!) in refactoring the
> Winbond drivers.  The NatSemi (lm??) drivers are closer to where I
> think we should go: two (or at most, three) related chips per file...
> and only if they are trivially different or one has a subset of
> features of the other, etc.

That's what I'd call a good objective. That's how I intend to make
things in drivers I wrote or maintain (lm83, lm90, adm1025).

> Also, what (kinds of) changes in libsensors will cause an ABI change? 
> Is it absolutely limited to the contents of lib/sensors.h?

Good question. Someone here, can't remember who, once said we would have
to change the library's version with each release. So I guess that the
ABI is likely to change that often. I don't quite understand what
exactly cause incompatibilities, nor what our numbering policy should
be. If someone is willing to explain that in details, that would be
welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
