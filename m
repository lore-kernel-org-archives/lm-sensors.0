From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 10 Sep 2006 19:33:04 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060910213304.15c61bde.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:
> I think it's about time to release lm_sensors 2.10.1. The list of
> changes since our last release, 2.10.0, is getting quite long. The most
> important changes are probably:
> * Many fixes in libsensors
> * decode-dimms.pl completely reworked
> * Many cleanups and improvements to sensors-detect
> And of course support added for many new chips.
> 
> As far as I am concerned, the only thing I'd like to merge before this
> upcoming release is the set of changes needed to make the Linux 2.6
> vt1211 driver work properly. If you think of other things that need to
> be done before the release, please speak up.
> 
> Proposed schedule:
> September 5th: SVN freeze

A few days late, but we're there. The SVN repository is now considered
frozen. Only bugfixes and documentation updates are allowed until we
release.

> September 6th-20th: Testing
> September 21st: Release
> 
> Phil, will you continue taking care of the release? Our
> doc/developers/checklist probably needs some adjustements to reflect
> our move to SVN, amongst others.

Phil, you didn't answer to my question?

Thanks,
-- 
Jean Delvare

