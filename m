From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 09 Jan 2007 08:09:10 +0000
Subject: [lm-sensors] Call for 2.10.2
Message-Id: <20070109090910.68a43756.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061221224611.3c2746af.khali@linux-fr.org>
In-Reply-To: <20061221224611.3c2746af.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On Thu, 21 Dec 2006 22:46:11 +0100, Jean Delvare wrote:
> We should start planning the release of lm_sensors 2.10.2. I don't
> think I have anything pending myself, if others have things pending
> that should go in, please speak up. I guess we'll all be busy with
> end-of-year festivities in the next two weeks so it's probably better
> to wait for everyone to be back before we freeze the repository and
> do the release. I thus propose the following schedule:
> 
> January 7th, 2007: Freeze of the repository
> January 8th to 13th: Tests
> January 14th: Release of lm_sensors 2.10.2

OK, let's freeze the repository now, and devote the rest of the week to
testing. Only bug fixes and documentation updates should now be
committed to the repository until we release.

We need everyone's help! If you have some spare time, please download
the latest SVN snapshot, install it, and report anything that doesn't
work as expected:
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4287-20070109.tar.bz2

Areas that need particular testing:
* libsensors
* pwmconfig and fancontrol
* sensors-detect
* old kernels

I'll make an announcement on our main wiki page.

Thanks,
-- 
Jean Delvare

