From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm83 driver ported to linux 2.6
Message-Id: <20031001205828.132b9eca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929213648.5ebc26bd.khali@linux-fr.org>
In-Reply-To: <20030929213648.5ebc26bd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Took a look, not sure how I am supposed to use it. Does it replace
> > device_create_file() calls, DEVICE_ATTR() "calls", or both? 
> 
> The device_create_file() calls.

So I think I won't use sysfs_create_group(). It would probably waste
more lines than save. My main concern was about the number of callback
functions, and this is obviously inherent to sysfs, so there's nothing I
can do against that.

> Tabs are ALWAYS set to 8 in Linux kernel code.  Please use tabs.

Discussing arbitrary decisions being pointless, I will obey.

However, I believe that alignments should *not* rely on a particular tab
size. Thus, I use tabs for indentation only. This makes code "portable"
between coders. One can switch curly braces positioning policies on the
fly, but changing tabs size and/or indentation policy requires editor
properties adjustement, which is painful to do repeatedly.

(And Larry Wall says that tabs are set to 4. I'd love to hear Larry and
Linus discuss about that for hours.)

> > > Ick, please put the '{' back up on the if line.  Read
> > > Documetation/CodingStyle for more info on this.

BTW, that document, which I read again one hour ago, is silly and
inconsitent. Saying that tabs=8 for clarity over compactness, and then
placing curly braces in favor of compactness over clarity, shows that
there is no scientific reason behind all this. It would have been much
clearer to plain pretend "do it this way or leave" than try to justify
oneself and convice others with unconvicing proofs.

> It really does matter.  As long as you are writing kernel code, follow
> the rules.  It matters to be consistant.  There is a lot of research
> that has been done on this in the past.  See my 2002 OLS paper about
> the topic for more details about why it matters, and in depth
> explainations for all of the written Documentation/CodingStyle rules,
> and for some details about some of the unwritten ones.

You don't have to convince me how important this is to be consistant, I
know that. But there's an equilibrium to be found between anarchy and
totalitarism. Coding is also a matter of creativity and a kind of art,
and an expression of our collective freedom. This isn't to be sacrificed
to the Coding Style Over All rule.

> > > You should probably initialize the chip before registering it with
> > > the i2c core as it can be queried right then before this call
> > > could be finished.
> > 
> > All drivers do things in that order, this is why I did so. Still
> > what you say sounds reasonable, so all drivers should probably
> > behave the way you suggest (although I don't think there is any real
> > danger here).
> 
> Hm, patches to fix up the other driver will be gladly accepted :)

Later maybe.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
