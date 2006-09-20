From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 20 Sep 2006 08:47:55 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060920104755.09f58b30.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:
> > Proposed schedule:
> > September 5th: SVN freeze
> 
> A few days late, but we're there. The SVN repository is now considered
> frozen. Only bugfixes and documentation updates are allowed until we
> release.
> 
> > September 6th-20th: Testing
> > September 21st: Release

There's some sliding in the schedule, and the estimated release date is
now September 24th (next Sunday.) Everyone please give good testing to
the current SVN version by then. Areas which specifically need testing
are:
* Proper support of older kernels (both 2.4 and early 2.6)
* sensors-detect
* decode-dimms.pl
But really any kind of testing is welcome anyway.

Thanks,
-- 
Jean Delvare

