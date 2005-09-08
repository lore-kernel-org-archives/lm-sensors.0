From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 08 Sep 2005 22:25:38 +0000
Subject: [lm-sensors] ticket 2054 and ticket 2015
Message-Id: <E1EDSxA-0003ek-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

After posting ticket 2054 I found ticket 2015.  I applied the
changes mentioned in 2015 to sensors.conf (commenting out
the temp2 and temp3 lines) and then did sensors -s.  That
brought the CPU reading into line and ALSO restored memory
bandwidth.  The difference between what I saw (ticket 2054, slow
CPU) and what 2015 saw (system shutdown) is determined by the
BIOS setting Power -> CPU Thermal Option which can be either
"throttle" or "shutdown".  On my machine it was the former
setting and for the 2015 ticket it was almost certainly
the latter setting.

In any case, the issue is resolved.

Regards,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
