From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 23 Aug 2006 15:23:59 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060823172359.ea597600.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony, Mark,

> * Calabro, Anthony <anthony.calabro at lmco.com> [2006-08-22 16:19:55 -0400]:
> > I guess Im going to try to start over with this thread.  I have solved
> > the Flex Scanner Jammed problem by going back to sensors version 2.9.0.
> > When using 2.10.0 the best I could do is get label lines to parse
> > correctly, but I never had any luck with the compute lines.  I also
> 
> Did you install 2.9.0 from source?  Looking back at the archives, you
> actually started with 2.8.7 - it probably came with the distro.
> 
> If you were able to install 2.9.0 from source, but not 2.10.0... well
> that is very strange.  The scanner didn't change between those versions.
> 
> Anyway, if you're still interested in trying to debug the scanner error:
> please add the flag '-d' to the last line of the Makefile.  It should
> look like this:
> 
>  	$(FLEX) -Psensors_yy -t -d $< > $@
> 
> Then 'make clean' && 'make' && 'make install'.  That flag will cause the
> scanner to make a lot of noise about what it's doing.  Send some results
> back to this list and I'll have a look.

Another approach would be to perform a bisection. If 2.9.0 actually
works, and 2.10.0 doesn't, then a change must have broken it - even
though I just can't think of any. 2.9.0 is r2809, 2.10.0 is r3256. You
will converge after 11 iterations, should be fast enough.

> > upgraded my linux kernel from 2.6.9-34 to 2.6.9-42.  In this new version
> > there is an i2c sensors update.

What update is this?

-- 
Jean Delvare

