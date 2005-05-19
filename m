From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <E1C9Rxi-0007QE-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

By the way, why are there no shutdown options in sensord?

I've been using mondo 

  http://sourceforge.net/projects/mondo-daemon/

to monitor sensors and shutdown on fan failure or over temperature.
Unfortunately it doesn't work great with lm_sensors on 2.6 kernels
because the /sys/ stuff throws it for a loop.  I was able to 
hack a patch into mondo which passes in the right /sys
string for a single chip, but the S2468UGN has two such paths,
and so my hack doesn't work there.

sensord does pretty much everything mondo does except give
an option for shutdown.  Is this feature going to be added to
sensord anytime soon?

Failing that, what is the most common "shut down on over temperature"
script/program in use with lm_sensors on 2.6.x kernels?

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech
