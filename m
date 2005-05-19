From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: i2c cvs repository status
Message-Id: <20031220225941.7fc63a0c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031220120151.27b9db49.khali@linux-fr.org>
In-Reply-To: <20031220120151.27b9db49.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Shouldn't you work off of the tagged 2.8.2? Then when you
> submit patches, you say, 'this patch brings the 2.4 kernel up to
> our 2.8.2 release'. The release is what's widely used and tested.

That's more or less the same. CVS was 2.8.2 plus the few changes I made
to remove some noise in the patches. Functionnaly speaking they were the
same.

> I don't see why i2c CVS now should be exclusively for your use.

That's now how I see it. My point was that the i2c CVS was meant for
inclusion into Linux 2.4, and as such wasn't the place for new features,
only bug fixes and cleanups, and not from me only. But it looks like you
have other views, and I'm not going to argue.

> Let's figure out another way to make it easy on you. Either with
> a local copy as you describe, or perhaps a CVS branch.

The local copy is easier since I'm the only one interested in it, I
guess. I admit that branching would be technically better, but we have
had bad experience with CVS branching, and I don't think any of us is
easy enough with cvs to take a real benefit of branching.

> Sorry for the misunderstanding. I certainly didn't realize you
> considered i2c CVS off-limits.

If anyone has opinions on how things should be done, I welcome comments
and criticisms. Especially, I'd like to hear Greg about this.

Greg, how do you think future developments should take place now that
Linux 2.6.0 is out? I certainly have a few ideas about the topic but
these are not shared by everyone, as you can see ;)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
