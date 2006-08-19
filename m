From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 19 Aug 2006 08:54:54 +0000
Subject: [lm-sensors] Call for 2.10.1
Message-Id: <20060819105454.c6c438ed.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I think it's about time to release lm_sensors 2.10.1. The list of
changes since our last release, 2.10.0, is getting quite long. The most
important changes are probably:
* Many fixes in libsensors
* decode-dimms.pl completely reworked
* Many cleanups and improvements to sensors-detect
And of course support added for many new chips.

As far as I am concerned, the only thing I'd like to merge before this
upcoming release is the set of changes needed to make the Linux 2.6
vt1211 driver work properly. If you think of other things that need to
be done before the release, please speak up.

Proposed schedule:
September 5th: SVN freeze
September 6th-20th: Testing
September 21st: Release

Phil, will you continue taking care of the release? Our
doc/developers/checklist probably needs some adjustements to reflect
our move to SVN, amongst others.

Thanks,
-- 
Jean Delvare

