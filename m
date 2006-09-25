From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Sep 2006 21:31:33 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060925233133.0e05663e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060819105454.c6c438ed.khali@linux-fr.org>
In-Reply-To: <20060819105454.c6c438ed.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

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
> September 6th-20th: Testing
> September 21st: Release

Almost in time... The 2.10.1 release is there, ready for download!
Thanks to Philip Edelbrock for taking care of this release, and to both
Axel Thimm and Philip for the migration to Axel's server. Not
everything's perfect yet, but we appear to be able to address most
problems quickly so I have good hope things will only improve over time.

I would like the next release to happen "soon". There were more than 7
months between 2.10.0 and 2.10.1, which was too much IMHO. I know that
the move to a the server didn't help in that respect, but now that this
is done we should be able to release more often. As long as libsensors
needs specific code for every new chip we add support for in the Linux
2.6 kernel tree, we should try to match the kernel releases to make
sure people with the latest released kernel can use the latest released
lm_sensors and expect things to just work. This means a release every 3
months or so, which sounds reasonable to me.

Of course, once we have a completely chip-independent libsensors, we
can again leave more time between releases. But we're not there yet.

I'll do the Freshmeat announcement tomorrow.

-- 
Jean Delvare

